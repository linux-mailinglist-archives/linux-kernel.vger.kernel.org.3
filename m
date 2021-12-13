Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C082A4732BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhLMRNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:13:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhLMRNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:13:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83A6BB8119C;
        Mon, 13 Dec 2021 17:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF93AC34600;
        Mon, 13 Dec 2021 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639415601;
        bh=0MhvB6hXQ6bvGav+d+NgjwfxsTR88324BQ8HpSPd4BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+ACJjwwAEJ405PsHqCac9HHZ0Y81laKED9zO3C1jjkjo3q6v3HqrDEbs6QYJMqwg
         Spcc1RuxctXnT8PglNjHxrLL0AbDy0w92zsGAbyzvF4oDwg3Ff0ZLkr4+EM6vjIquo
         +rdRdLaYkA81vF0neglFc7uPVFIIwg278Y2/0sodl477AmiXJmZSV8I61n+IBUtCq+
         0V0cTfRcYziNljEBv0NNCUZ9Nc396XjVEM1POAGOpzpYAmrSPiSbEtv1dIHS7kuLUJ
         Qtl6hz8bReIpBZsKb5m+i6RQrRuL7XILAmFWnX6KWYUy/f6FBw3KpBbL2RJkhcCUzK
         JNl80ZpE6zbwQ==
Date:   Mon, 13 Dec 2021 10:13:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: Makefile: Remove "ifdef need-compiler" for
 Kbuild.platforms
Message-ID: <Ybd/LZNfnHOPmn+9@archlinux-ax161>
References: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn>
 <1639389477-17586-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639389477-17586-3-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 05:57:57PM +0800, Tiezhu Yang wrote:
> After commit 13ceb48bc19c ("MIPS: Loongson2ef: Remove unnecessary
> {as,cc}-option calls"), no need to use "ifdef need-compiler" for
> Kbuild.platforms, because the cause of the build issue mentioned
> in commit 0706f74f719e ("MIPS: fix *-pkg builds for loongson2ef
> platform") has been disappeared, so just remove it.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
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
