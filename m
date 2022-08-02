Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A4587E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiHBOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiHBOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:53:31 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52142BB26;
        Tue,  2 Aug 2022 07:53:29 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r6so7100415ilc.12;
        Tue, 02 Aug 2022 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kr0erF82eMx5sQ3y+UPadm0ooU5+bmbNqPEA8Dxg0yc=;
        b=TZIuCaEJzXkqwqg0DQ7bkysqr7kyCQ4kkZefX9YM2D6GwlkGtiuO5CzICKKa6p3Num
         s6wUsPnpdBEnrt0+E/7jADM+SOtO5lY5ZETBcx0IrS43/FIfQsq/wUlJNOXmy/OZWLUK
         Ghl3Tjcv6z5frVe7xAxYNGznlc75gy/QZ/WqRUOtdcwdJrnVWGOpympgvJolxgdrnF05
         B0OqeM6iEBxP6M48LjfMGPrzgFxaL6YNGJux8rWvVNadOiXc8HxAFsbdLAp7YID0ZkDe
         BQV2QXJCyhQ7uSgMec/FvGqPO1ZvwL4qRK4K0Bn7DAfKzmTXkhCqd8qV2SljwuQZmEiC
         vqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kr0erF82eMx5sQ3y+UPadm0ooU5+bmbNqPEA8Dxg0yc=;
        b=HXhFGVPqFRDZVSujiZRUTuv6DHE5erlcNb7M13MBCr1boNsR/hRIBltmtRtGINTBiS
         A4AVhKopOvsCnc1IJOlfvrNNuLzVvg2XAzShi8N9CEZGWnWNn2PwwzS0iN5hw6UOwCmd
         jf4HiyUIR3y0ojAQtnVF7hTghfRFz6sv1OhYqSKE9AiCkFcny5JqIQyEWX+ksWjWrSj6
         CGZmiDpa1AP3Hqx/ZKY/iN75JVbujCVOYIlUyrbZ4+hqicujJsqCtgDZQlrnIx418zgr
         hI2vlz1e8bIFnUTffWHLR+EwdeORqYx34uMbYxdzSKDiu0RNPd3mAhlx220m8OMZfMTD
         Kf5g==
X-Gm-Message-State: AJIora+cozhDKZjLds+N1IPTVScsE29DMPoptDgIRJgpoMj81PfyzJB5
        dtXIVl/i9CfaieXBcHQaqOwyYh9EeWEL/MjlQk4=
X-Google-Smtp-Source: AGRyM1uqzVuaPLmArIrBnOe+mGUto05TKZb5HBLD9YcDxXhgnTgAmYdCQzvgXJGktPn9EW/ZmTZ9jciRQqeHWUJkKOo=
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id
 m3-20020a056e021c2300b002dce4978b12mr8473901ilh.151.1659452009118; Tue, 02
 Aug 2022 07:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-18-ojeda@kernel.org>
 <Yukn3vNJ8iGuXgiz@kroah.com> <CANiq72kzoVcMNeJgDc+rQ_0S+5u2RB9UkCx-SZUAxm=Km=gjrQ@mail.gmail.com>
 <Yuk2aSxydi37eRXq@kroah.com>
In-Reply-To: <Yuk2aSxydi37eRXq@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 16:53:17 +0200
Message-ID: <CANiq72=24xycLU0UU1oxn-7=Vk4hZBvZYh_RsnXFP1c5FyyxhQ@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 4:36 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I did?  Maybe I didn't realize we would end up with 15k lines of code
> from different parts of the kernel like amba bus and filesystem apis all
> in a single commit.  If so, my fault, but as other parts of this
> discussion show, it is going to be required to get the subsystem
> maintainers to be able to review the interfaces to their code in order
> to get any further.

No worries at all! Probably a misunderstanding on my side too.

I am more than happy to spit it into quite a few patches, and it will
also help with the C-d-b's.

As for reviewing -- since we keep adding abstractions and new features
to show how things may work, we would be chasing new reviews all the
time. Would it be better to drop some of those for the moment and get
the "core" in first?

That way we can merge each subsystem part by part later, send it to
the proper MLs as smaller patches, get maintainers on board, etc.
etc., and it would be more manageable for everyone.

Cheers,
Miguel
