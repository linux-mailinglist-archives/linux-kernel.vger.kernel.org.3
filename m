Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA547D4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhLVQAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:00:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43506 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbhLVP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:59:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA5E61AF6;
        Wed, 22 Dec 2021 15:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BC4C36AE8;
        Wed, 22 Dec 2021 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640188768;
        bh=wcF94Vvx7mswWHCCcLjW+w1dxVtZdoTjv8ZSx4Ym5ow=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ht++lMuXT2hv7MXFLG74H2PdC/ZqAl4tqEbhkJKJj9PF7V+qb3luq2k14I+ifFhAZ
         U2ZbZm2J46BaYqYLBLjqLcXDn0PMDM5JYOzrVa2oaujwnGRtTWJ2D4SEK21up+JiN/
         mYs0x7X7kYCAGD1uUAenl7vtuExJKuTzUuneLgXT2FwJwZ72PgH4VudDHEExiAgami
         34s/VpIwM5MrS/vKZAR2EPmHobQYkXEjUODYJOk2gR/OnI/0yTc0XhXbm4NEWKDzUT
         WjsCB2aZZQmRlt0uNy/WfE47L1ZCXPTVgmmTVUZF8K4W8WMv523USaj+M4A3qV09RJ
         Zc5Ks1ejc+nkQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning: variable 'retval' set but not used
References: <202112222102.0Qk7vOl2-lkp@intel.com>
Date:   Wed, 22 Dec 2021 17:59:24 +0200
In-Reply-To: <202112222102.0Qk7vOl2-lkp@intel.com> (kernel test robot's
        message of "Wed, 22 Dec 2021 21:30:56 +0800")
Message-ID: <87lf0cy6jn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> Hi Jonas,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
> commit: 8e3e59c31fea5de95ffc52c46f0c562c39f20c59 mwifiex: Try waking the firmware until we get an interrupt
> date:   9 weeks ago
> config: powerpc64-buildonly-randconfig-r005-20211222 (https://download.01.org/0day-ci/archive/20211222/202112222102.0Qk7vOl2-lkp@intel.com/config)
> compiler: powerpc64le-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e3e59c31fea5de95ffc52c46f0c562c39f20c59
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8e3e59c31fea5de95ffc52c46f0c562c39f20c59
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/wireless/marvell/mwifiex/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/net/wireless/marvell/mwifiex/pcie.c: In function 'mwifiex_pm_wakeup_card':
>>> drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
>      659 |         int retval;

Jonas, please send a patch fixing this. We are trying to get all W=1
warnings fixed in drivers/net/wireless.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
