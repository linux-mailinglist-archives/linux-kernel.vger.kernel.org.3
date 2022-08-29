Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706A5A4516
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiH2IcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH2Ib4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:31:56 -0400
X-Greylist: delayed 152617 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Aug 2022 01:31:54 PDT
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F19A578A2;
        Mon, 29 Aug 2022 01:31:54 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 27T8VQAf031749;
        Mon, 29 Aug 2022 17:31:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 27T8VQAf031749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661761886;
        bh=jM2GfWj0FdGrXTHGuEWcFJbYLhnDvtm2N6670C3hXuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z/rQq1fGXv/Wkc/66aeZM3GS06eTxP6v+3RwdXeNvpdyyFlwPdYcsg4yVq1wKIV36
         U20bz5d3JYXVBcwShBsUoJsrhqB8n0xrDdDStzHVmRaCzBJ7nQNiblVY+CE7IEzpSK
         Ua7IZiMsdGHOVTRegjb7j4Cv7/0lAghMN4imoNrILUhWuFmcZf4GaWWNmFqmP7Tnhv
         rib9geJcQmtvRKqp3JenlMbxQ3NZD3n1UxE8MXNtycljQvGwyRO+AhLfE+bKUjRvBB
         YKWRb+C8Rn4X3XVyvc0KbRy58tm4J//fxh5igSji8zQDWcTQ0zzkKlL6ZM3IeSLyJ7
         VJD8iFYIomTQg==
X-Nifty-SrcIP: [209.85.210.43]
Received: by mail-ot1-f43.google.com with SMTP id v2-20020a056830090200b006397457afecso4753728ott.13;
        Mon, 29 Aug 2022 01:31:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo2mUMHDhDOhXQJKIPzyETdpbyaT+mKTPubmZxCdpUsIc7xTWTZZ
        Ugymz09LqwBWohjssKIP5hC5rwM1dnU9bBHG99I=
X-Google-Smtp-Source: AA6agR4Jk7pSX33ZfGLaJm23afhMJutz94PMIODqagwuZ5cSLveuwlw9UpXXXDz/3Hmv1zZA7JSjvkKHg2htYx6/8Fc=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr6254060otf.225.1661761885384; Mon, 29
 Aug 2022 01:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220825091517.30842-1-lukas.bulwahn@gmail.com>
 <CAKwvOdkY=ye4PKi8KwP-ux73pwZs+J_Oq3wR7ep8S81=aCWtqA@mail.gmail.com> <384c1908-6602-1a07-875f-0b2e56a06707@kernel.org>
In-Reply-To: <384c1908-6602-1a07-875f-0b2e56a06707@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 29 Aug 2022 17:30:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQSYHseN5n-WYKtBYHJCUJUquSbkq34WnuUO9q1geEDYQ@mail.gmail.com>
Message-ID: <CAK7LNAQSYHseN5n-WYKtBYHJCUJUquSbkq34WnuUO9q1geEDYQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: remove obsolete gcc-ld script
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Liska <martin.liska@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 4:08 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 25. 08. 22, 19:19, Nick Desaulniers wrote:
> > + Jiri in case this needs to be carried downstream.
>
> Thanks.
>
> > On Thu, Aug 25, 2022 at 2:15 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >>
> >> Since commit 8564ed2b3888 ("Kbuild, lto: Add a gcc-ld script to let run gcc
> >> as ld") in 2014, there was not specific work on this the gcc-ld script
> >> other than treewide clean-ups.
> >>
> >> There are no users within the kernel tree, and probably no out-of-tree
> >> users either, and there is no dedicated maintainer in MAINTAINERS.
>
> There are out-of-tree users.
>
> >> Delete this obsolete gcc-ld script.
> >>
> >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > No callers in-tree; happy to bring it back though should there later
> > be. Thanks for the patch.
>
> I agree to have this downstream-only for the time being. We have updates
> for it queued, so we'd only start tracking the full content now...
>
> BTW the script is not nice at all. How do the clang people cope with the
> issue? (Running gcc-ld instead of ld with proper arguments when linking
> using (full) LTO. For example "-z now" -> "-Wl,-z,now".)



This comes from the difference in which layer LTO is implemented.



GCC LTO is a feature of the GCC compiler.
GNU binutils is agnostic about LTO.
So, you need to use $(CC) as the linker driver.
scripts/gcc-ld adds the '-Wl,' prefix to linker options.




Clang LTO works in cooperation with the LLD linker.
So, the direct use of $(LD) works.
scripts/gcc-ld is unneeded.







-- 
Best Regards
Masahiro Yamada
