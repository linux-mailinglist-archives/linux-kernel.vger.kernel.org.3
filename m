Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD984C30FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiBXQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiBXQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:08:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB5194AA7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:08:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1C66174D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA22CC340E9;
        Thu, 24 Feb 2022 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645718847;
        bh=Z3+x1SIV9VOetp2p+0THAAyY/l8As1yQ1l0nOvyh4Z8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HTqylMlxNFaTe6EnEmYyjQUVi05GaviKofzAWOsskUtS0bDU6vhKnG1YPX4gV58d8
         6tsqZgEDoSELSkQVlI2XCjDJgjbJcSjg9En8hYEDwp1+pgxYWbta+cchr0+DYENBH3
         zKIUetZPB5kQ/j4CdBHCuZH4wOtU0MAlEDmFd7vwQ6dlrPIqOQBHipsHoExCFOgYi5
         vE/9zMEsUJuE4oyI/hC6aDuZ0oh/OSOf6cGTJtkRZEsUiwV8fAPUG2GOaxuAXVmVgf
         QPhUR9qheftZxEE09uINE/qvbLjg9hHpEblFzDwG2nPzwG7ZmX/OBCG1BBfEnapMQd
         NeyMVRLLfXKeQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Carl Huang <quic_cjhuang@quicinc.com>, kbuild-all@lists.01.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>, ath11k@lists.infradead.org
Subject: Re: [kvalo-ath:pending 37/42] drivers/net/wireless/ath/ath11k/wow.c:467:5: error: redefinition of 'ath11k_wow_init'
References: <202202230812.uOGgSw5k-lkp@intel.com>
Date:   Thu, 24 Feb 2022 18:07:21 +0200
In-Reply-To: <202202230812.uOGgSw5k-lkp@intel.com> (kernel test robot's
        message of "Wed, 23 Feb 2022 08:52:44 +0800")
Message-ID: <87zgmgtfie.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
> head:   4136ddcfda28450e2d01173e37300b95c8687d9b
> commit: cae84a492cacd9b4eecaafd5dab33f5beba8806e [37/42] ath11k: Add basic WoW functionalities
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202230812.uOGgSw5k-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=cae84a492cacd9b4eecaafd5dab33f5beba8806e
>         git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
>         git fetch --no-tags kvalo-ath pending
>         git checkout cae84a492cacd9b4eecaafd5dab33f5beba8806e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/net/wireless/ath/ath11k/wow.c:357:5: warning: no previous prototype for 'ath11k_wow_op_suspend' [-Wmissing-prototypes]
>      357 | int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
>          |     ^~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/wow.c:416:6: warning: no previous
> prototype for 'ath11k_wow_op_set_wakeup' [-Wmissing-prototypes]
>      416 | void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/wow.c:425:5: warning: no previous
> prototype for 'ath11k_wow_op_resume' [-Wmissing-prototypes]
>      425 | int ath11k_wow_op_resume(struct ieee80211_hw *hw)
>          |     ^~~~~~~~~~~~~~~~~~~~
>>> drivers/net/wireless/ath/ath11k/wow.c:467:5: error: redefinition of
>>> 'ath11k_wow_init'
>      467 | int ath11k_wow_init(struct ath11k *ar)
>          |     ^~~~~~~~~~~~~~~
>    In file included from drivers/net/wireless/ath/ath11k/core.h:26,
>                     from drivers/net/wireless/ath/ath11k/wow.c:11:
>    drivers/net/wireless/ath/ath11k/wow.h:40:19: note: previous definition of 'ath11k_wow_init' with type 'int(struct ath11k *)'
>       40 | static inline int ath11k_wow_init(struct ath11k *ar)
>          |                   ^~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/wow.c: In function 'ath11k_wow_init':
>>> drivers/net/wireless/ath/ath11k/wow.c:482:22: error: 'struct wiphy'
>>> has no member named 'wowlan'
>      482 |         ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;
>          |                      ^~

I was able to reproduce the errors by disabling CONFIG_PM. I fixed them
and pushed the new patch to the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=624c999c214f02004c2f996aa6ce3a17dfbebd18

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
