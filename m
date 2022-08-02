Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943D8587E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiHBOdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiHBOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:33:30 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D70DF61;
        Tue,  2 Aug 2022 07:33:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p81so10772183iod.2;
        Tue, 02 Aug 2022 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz9fus9lrSQDAS1U8Tb64LEn0dK4Donl11P+BY3Mdeo=;
        b=TBP+yhxN5i+Hw7aLxNIPbdNlxMA2rk8yRqpyrbrX+skxsEtXzfb/XD+45TFgG8ntnD
         omYYJqy0aYpzHgMSXcu4SIvsy2kEa4PK7HYRKHV1t19z0a+YQapWbgC/OW7CC4BqQTIJ
         O7vlHe4++1YIiJSnQYX6fAHnJR9wctJptp5v+Kxb6pHfaU2T75CQPdH+KmyEw+Ep23Pi
         yu8b20m5adZoZpr9eh04QDO0PJCFbzJULyj0RfUVQeKw9FuS98G4KIws23NEqAXepzbA
         NWhp47LYiUxSWMFACU37mFMWxd9ExolA7MDi0JWv1JGbU3diIsYar37/PW/05EwMO9TM
         Ukng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz9fus9lrSQDAS1U8Tb64LEn0dK4Donl11P+BY3Mdeo=;
        b=V/fltXL3huRpJ7LF3GR/uTCVbOej/8GG896JLt/9quTObhl+GamSyz3YCNUPgz0p+a
         f/MZ1hRtYAvyEHVw0XpuVTkr0ZNO0b+DMG7WEAoNhfTWNbJCrDbs+5sFN4/6WITHrja+
         uZE+LwuhVo3SmNdmOJqTlx2SqXDhuyQB0lrz2BQayck1DO2CvyaMqPyiik5I4Rhe7xfK
         IOBl8al7ie76H8oGJASVvFzig4bZshnfkkP/Y5ech1iqDjbghA4b308aGz5276C7ITrQ
         ZfWbZpcm0IlbYirffD/q5Ma7/VZ4uhsyrQlkfmgL+YPG2DPuHJ1C4+2YCJG7U/7dlWW8
         VkaQ==
X-Gm-Message-State: AJIora/nC1TPw80PP3GNnq09N+q0CvT6F44DRwZBTgoETpAzUaL/pPYn
        KI7gT7e2V8dTMU7TN6qDx1f9BaHRf8gT3EO1MJ/bwJR7hQE=
X-Google-Smtp-Source: AGRyM1uroBJEQvRkh9HWrKQhL69AZkVs9jnA3iFvOOwFuS8sb814FNR/T8biWLH9jDLLbL9fjF3j1YzsGQiaI4sR7L0=
X-Received: by 2002:a05:6638:25cb:b0:341:6546:1534 with SMTP id
 u11-20020a05663825cb00b0034165461534mr8220829jat.308.1659450808749; Tue, 02
 Aug 2022 07:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-18-ojeda@kernel.org>
 <Yukn3vNJ8iGuXgiz@kroah.com>
In-Reply-To: <Yukn3vNJ8iGuXgiz@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 16:33:17 +0200
Message-ID: <CANiq72kzoVcMNeJgDc+rQ_0S+5u2RB9UkCx-SZUAxm=Km=gjrQ@mail.gmail.com>
Subject: Re: [PATCH v8 17/31] rust: add `kernel` crate
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?UTF-8?Q?L=C3=A9o_Lanteri_Thauvin?= <leseulartichaut@gmail.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        =?UTF-8?B?TsOhbmRvciBJc3R2w6FuIEtyw6Fjc2Vy?= <bonifaido@gmail.com>,
        David Gow <davidgow@google.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Aug 2, 2022 at 3:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is huge for a single commit, and pretty much impossible to review
> as-is.
>
> Any chance you can turn this into a series of commits, that starts with
> the basics and builds on top of that?  Right now you are mixing many
> many different subsystems all at once into one commit, guaranteeing that
> no one can review the whole thing properly :(

Yeah, of course, I am happy to do that -- I did it for the `sync`
module, but stopped splitting further since I understood you wanted it
this way from what you told me on February.

Cheers,
Miguel
