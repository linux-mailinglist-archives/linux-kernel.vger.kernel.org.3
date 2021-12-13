Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57DC471F04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 01:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhLMApC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 19:45:02 -0500
Received: from mail002.nap.gsic.titech.ac.jp ([131.112.13.102]:35260 "HELO
        mail002.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229450AbhLMApA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 19:45:00 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 19:44:59 EST
Received: from 172.22.40.204
        by mail002.nap.gsic.titech.ac.jp with Mail2000 ESMTP Server V7.00(2685:0:AUTH_RELAY)
        (envelope-from <matsumoto.r.aa@m.titech.ac.jp>); Mon, 13 Dec 2021 09:35:21 +0900 (JST)
Received: from mail001.nap.gsic.titech.ac.jp (mail001.nap.gsic.titech.ac.jp [131.112.13.101])
        by drweb07.nap.gsic.titech.ac.jp (Postfix) with SMTP id 5B55E19024;
        Mon, 13 Dec 2021 09:35:21 +0900 (JST)
Received: from 114.150.218.139
        by mail001.nap.gsic.titech.ac.jp with Mail2000 ESMTPA Server V7.00(21089:0:AUTH_LOGIN)
        (envelope-from <matsumoto.r.aa@m.titech.ac.jp>); Mon, 13 Dec 2021 09:35:20 +0900 (JST)
Date:   Mon, 13 Dec 2021 09:35:20 +0900 (JST)
Message-Id: <20211213.093520.538389512409174784.ryutaroh@ict.e.titech.ac.jp>
To:     masahiroy@kernel.org
Cc:     nathan@kernel.org, yangtiezhu@loongson.cn,
        tsbogend@alpha.franken.de, jason@bluehome.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for
 Kbuild.platforms
From:   Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
In-Reply-To: <CAK7LNAS7=qYs7NdDRY+4Dz5Zt0tLDo-W-EMcx+9TaNazNVcX=Q@mail.gmail.com>
References: <1639109105-1545-1-git-send-email-yangtiezhu@loongson.cn>
        <YbN+0NrHmsFKfNWP@archlinux-ax161>
        <CAK7LNAS7=qYs7NdDRY+4Dz5Zt0tLDo-W-EMcx+9TaNazNVcX=Q@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
Date: Sat, 11 Dec 2021 01:39:10 +0900
> Nathan's patch cleaned up  arch/mips/loognson2ef/Platform,
> but I still see similar code in arch/mips/sgi-ip22/Platform.
> 
> 
> ifdef CONFIG_SGI_IP28
>   ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
>       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
>   endif
> endif
> 
> 
> Doesn't this cause a failure of *-pkg builds for sgi-ip22 platform?

Yes, it does, as reported at
https://github.com/ClangBuiltLinux/linux/issues/1543

Best regards, Ryutaroh Matsumo
