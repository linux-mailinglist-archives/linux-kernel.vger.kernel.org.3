Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B125470588
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhLJQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:26:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41240 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhLJQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7303B82885;
        Fri, 10 Dec 2021 16:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A68C341C5;
        Fri, 10 Dec 2021 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639153365;
        bh=PbLCcPA38TnLub5MYZK5kD4lVEh3c4nd65q06WYr6+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kn+QbjeRay1QTZL2AK4BPYDnFHI5WDsUIR106opn8rfVa4HL0YfkR2eG/a6Nheoc8
         kNAvua1Ms/yDn8swaKsBgonkL2XpKp5q0JdwDqM8ZXCMJr/bzOojTicuwVItWKnH8f
         TpDBuVweT8Vk+ciombgzuV7HOoQvEGb0ZlO4bawPa7DsmHkJN0u7Ha1oIb36IYKtJK
         KOAy5aHM0t373nv8dPxXzI775xMvSXd6eYAYJWHY1xZjHW2/B3drGrgJ4ygHnBPpju
         Sr6y2ApCz0uagUyKw8uJP+d5mym4+OF/Ehxr9jyw1jkS1+uFixe8sJOC1YsfF1Ze8W
         sytjOEjlj/QJw==
Date:   Fri, 10 Dec 2021 09:22:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for
 Kbuild.platforms
Message-ID: <YbN+0NrHmsFKfNWP@archlinux-ax161>
References: <1639109105-1545-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639109105-1545-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:05:05PM +0800, Tiezhu Yang wrote:
> After commit 13ceb48bc19c ("MIPS: Loongson2ef: Remove unnecessary
> {as,cc}-option calls"), no need to use "ifdef need-compiler" for
> Kbuild.platforms, because the cause of the build issue mentioned
> in commit 0706f74f719e ("MIPS: fix *-pkg builds for loongson2ef
> platform") has been disappeared, so just remove it.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> v2: fix the typo "casue" --> "cause" in the commit message,
>     sorry for that.
> 
>  arch/mips/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index ace7f03..e036fc0 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -253,9 +253,7 @@ endif
>  #
>  # Board-dependent options and extra files
>  #
> -ifdef need-compiler
>  include $(srctree)/arch/mips/Kbuild.platforms
> -endif
>  
>  ifdef CONFIG_PHYSICAL_START
>  load-y					= $(CONFIG_PHYSICAL_START)
> -- 
> 2.1.0
> 
