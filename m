Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB94E751F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359065AbiCYOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiCYOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:36:38 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C854699;
        Fri, 25 Mar 2022 07:35:03 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 22PEYoDA001738;
        Fri, 25 Mar 2022 23:34:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 22PEYoDA001738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648218891;
        bh=sosyWOYABfHivmikVkrJxLdgAyG42ZrPiILrb7k3JpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=em2XlG/P0VJO+1mbSUGT9EzZ2/uvnEGuqK3OC3D+nwoGPp5VOoBWGNeN6rXwxwdOJ
         eDAwgr/awPNiv06C43YC40W88RgdWK7ivQRITlzCXAebwLNhuNs4Ics8H+8t4TZ1op
         /Mn4WZo2p6bMekAc8Vc/CLh5RRYEjTeLcsZkm5lihKqfn0Cds7Ba0hhScfZSxfvP9F
         1bkP5MM+0GiMnFHbMRrKGuJ9odkQbSOuzKBSYGB9L7i+3xYQvZstmiY/qFqOjBKZVS
         NVg21tLYrsjAeczPT7VNQYpnc0vPQ7fX0kXnap1bTcHfVz267QyNGqFvgEPPsBFqSX
         gVGreE6PTBUYQ==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id jx9so7720027pjb.5;
        Fri, 25 Mar 2022 07:34:51 -0700 (PDT)
X-Gm-Message-State: AOAM5304PJgUcmIHKfZu6xwvCBPFfu4tU9ScgJcX1DzFuxX7XYi/e4Az
        ZtcpLMFY7mhBVP56G+0pLCmM0MmjqUevQViYt3o=
X-Google-Smtp-Source: ABdhPJyJUFYzEdsl9QhQ2x/nN4ufj79OsmqAlSSTs1D9dGQn6408BAISmYDdWCOxYhCRERIM8jPdkO016xH3xxBs2HM=
X-Received: by 2002:a17:902:b68c:b0:153:bd06:85ad with SMTP id
 c12-20020a170902b68c00b00153bd0685admr11951253pls.99.1648218890237; Fri, 25
 Mar 2022 07:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Mar 2022 23:34:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9HS7LK5D-07i8_tFcwd=uiHEFu05n0t_UuFZExcfBpw@mail.gmail.com>
Message-ID: <CAK7LNAR9HS7LK5D-07i8_tFcwd=uiHEFu05n0t_UuFZExcfBpw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra
 warnings are enabled
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:13 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When `make W=1 ...` is executed the level 1 warnings become errors,
> due to recent change in some of the defconfigs, and fail the build.
> Since there are a lot of warnings on the level 1 are still present
> in the defconfigs at least for x86, let disable -Werror in such case.


commit b339ec9c229aaf399296a120d7be0e34fbc355ca
made WERROR default to COMPILE_TEST.

WERROR should not be enabled for regular builds.

b9080ba4a6ec should be reverted.





> Fixes: b9080ba4a6ec ("x86/defconfig: Enable WERROR")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  scripts/Makefile.extrawarn | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 650d0b8ceec3..c81d74ef6c90 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -94,3 +94,10 @@ KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
>  KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
>
>  endif
> +
> +#
> +# Turn off -Werror when extra warnings are enabled
> +#
> +ifneq ($(KBUILD_EXTRA_WARN),)
> +       KBUILD_CFLAGS += -Wno-error
> +endif
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
