Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE80E4DAC42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354441AbiCPIOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354430AbiCPIOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:14:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B325C8;
        Wed, 16 Mar 2022 01:13:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v35so2963969ybi.10;
        Wed, 16 Mar 2022 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeV6RUw+DNsdu8AvRyuJcTYqLVcyGU4+g4ue41Pfh1k=;
        b=DWvxgRTwX2slFxXNq5JIefab+rLZkZHD/EcVvkIu6p4ryFP2B1Bd9c3y1ZrtCgcPq8
         yoscRXE9C5tNj1ffr2YHgCnVdaoRAT3zCTEwo8ggHylgGOKkmpf/VyesheXkeXssle35
         IjViWrhdHO/OC8A4gnjMRDizEqK/dgGt655iINkV45bfDlSCafpG5Nft5Eg/R/SAJ8IE
         kDtJiG8lBruDynHbq6k7mK/bWmEi7NCFZnbXeGzD5J3dUq0OZGUQCh/Hy0VCakKkjxeF
         +2tFGwyEtpGqkeG3fzfyzvDa2EVXZhkSV3yJnR505PjVEsX/9vhslej45czNmEBp7djc
         GNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeV6RUw+DNsdu8AvRyuJcTYqLVcyGU4+g4ue41Pfh1k=;
        b=inSFqFkabWiuMiE6RlcfVDv/Ff9phQH85CbT1p1P6uuXG0TwUyzgPSEyHH6f2VUISS
         hDgQUMpFMu+qMeYYBOJdxrrlXQJ+qmKyK+JcAtOOcXytb9jnaYBBSbZUCjb3mOnqhgvK
         EmbjUgT0TNJ7hSu2kmI/hjpNCaWBU66OpbCZtcW8UYTQ57LKWoTAjrRSzK/3w/Bp1jRT
         RckZlq7GZvCUnZ+eWmgM1+X0bGy2wowHJ7ejiQp5/OAKEcTxKIMtaHaD6RuX9Ig6OtPp
         QY4TAG3WxDRCmydq/j6FVZKaYVtD9RTRAAM9rUSS/zmqRYledr/qwDVsZHTOg+K1Z0gu
         8a6g==
X-Gm-Message-State: AOAM533PMduRrrWEFRVgIEdnLFyO0rVNj2xssklHeNDgNFXj3d+KHV7y
        uVH2850S/+LQDUO3Hn8ZsqUbJxaQBkIbt0apxkEZfRnP
X-Google-Smtp-Source: ABdhPJxr/Z5kzjkSPtuhJ2saAhxlgEZoX1YZ6szgngBQrmgZAcyScJplyOZJwLuaVoz2JDhvgt2wHMYUd8RidOSECsU=
X-Received: by 2002:a5b:20f:0:b0:628:6a2b:ee2c with SMTP id
 z15-20020a5b020f000000b006286a2bee2cmr28076249ybl.175.1647418385568; Wed, 16
 Mar 2022 01:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220316050828.17255-1-lukas.bulwahn@gmail.com> <YjGWPh6MSLqeL47e@zn.tnic>
In-Reply-To: <YjGWPh6MSLqeL47e@zn.tnic>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 16 Mar 2022 09:12:54 +0100
Message-ID: <CAKXUXMzcAFv2FmU7L8HHA4Sp9uehqW_gfez7qVfsf1O6PsnwtA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop entry to removed file in EXEC & BINFMT API
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 8:50 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 16, 2022 at 06:08:28AM +0100, Lukas Bulwahn wrote:
> > Commit f9444ea5e208 ("x86: Remove a.out support") removes
> > arch/x86/ia32/ia32_aout.c, but misses a reference to that file in
> > MAINTAINERS.
>
> It seems we're keeping a.out after all:
>
> https://lore.kernel.org/r/4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com
>

I guess then you can squash my one-line patch into your patch, and
then we put all this into the closet and wait for another day where
this feature can be removed.

Thanks, Boris.

Lukas

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
