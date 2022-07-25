Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226357FBC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiGYIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiGYIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:52:44 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F109140E4;
        Mon, 25 Jul 2022 01:52:44 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id l24so8259490ion.13;
        Mon, 25 Jul 2022 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63aMbMd225HyHDRweTzRK/cD4NhWMDCNRD/2yux7vnI=;
        b=YIb9XU1nxRKDscGtjt6eFZ294G8xceeXfgZil/fpz3cdJodDWcJROOBYE9AVKU3sTs
         qbTowhHuuru1dUgRcUjQacbruNICwHVS09brD0Ibr9+Nbz/abpgZq6Y2X7CCLsXNdROD
         3/2m/0SZ4qV0E8tbZae9dN4LgGRR/MpDO6/Cu4/EgUzDug7lCVP/aAyq8OKDEcJo2Jua
         PIcpK2aBGSREJZ4JdkOrOTG2EN3bguci9CF+hKMQuqrq1nGEHaGERnNdYvM6d8mAkanN
         GUnjJghLQtg+JFWwoKeRQ3UegaAojzgjFKjWO72HXW50Ivyn9nXuLKI6iQIt2B8IplOf
         Q+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63aMbMd225HyHDRweTzRK/cD4NhWMDCNRD/2yux7vnI=;
        b=xys5QFvZkzwtPDeBYgU4VbLziWXZBWTIRV5mui0H1QPolkdnuG7VnsWjnSWmHeJudt
         Z0AX7VaVHSEA382kXB2j5lszZEemX3pjieeSbX9e6/6t6GZVB3p3VrV2VJTfhI7vJyQU
         EwlzcxLO5BaHZzt+veaE64ty+goEg6ko1ltWqrVFKha4xZ2NzOFjKpIC94JIlEwktqAz
         awhZvT5yPSsKViE8c/5shk89yKNTLfeBEHlPKvA5eaGWGUVhNDZp8W8gYwhSJotyWav7
         6jY36Xqwq8IsFetRSAmfE83okUqgLGYRJuc+ozv9mokNqPl9ucstO2v9DX3nd0CrPuGP
         YDnA==
X-Gm-Message-State: AJIora8pftjDBqYrA3r2kxNwkdTWYi0shVpVKPIoZS5k3jFS6pnAa5mu
        0MXP4vmOt5boYgZsK3Zvck+cYg1/OJo6mnooaYw=
X-Google-Smtp-Source: AGRyM1t0NsIDgIDJqiW/DelVdsZX7b19NC10o7F1KxHnWXLjsUtcNvO0KJ7lREl+OVq9bDAMlPHEy2wk5prU5VtmKOg=
X-Received: by 2002:a05:6638:4514:b0:33f:45cb:2f35 with SMTP id
 bs20-20020a056638451400b0033f45cb2f35mr4796201jab.256.1658739163879; Mon, 25
 Jul 2022 01:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220725184107.429e33bf@canb.auug.org.au>
In-Reply-To: <20220725184107.429e33bf@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 25 Jul 2022 10:52:33 +0200
Message-ID: <CANiq72mH=TiKFwZnyo0Y6Fa_5iDgxsciAvVRwfq1Djik_ftM1A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Mon, Jul 25, 2022 at 10:41 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>
>   arch/x86/Makefile

Looks fine to me (I did it a bit differently on my side, but it does
not matter).

Thanks!

Cheers,
Miguel
