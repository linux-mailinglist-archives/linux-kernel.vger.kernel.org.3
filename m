Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EBA55C283
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiF0HJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiF0HJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:09:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BE267E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E95B80ED6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38FCC341C8;
        Mon, 27 Jun 2022 07:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656313767;
        bh=HQWy+ZcbYsga3egfveuhTsMFNg3CDz1LdwyKcg2cAtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctUtGF52BnLmiQCzRDzievl5iphkktdj44Vc1iMFio6p/XvNVD2aERRBjwA0ZgJNX
         lEeCTBE6xufQ4S6ghhqzcXQ1H2iAOPjPHDeRJfchBaJKdA/rHeGt96FZArvswYInpN
         yKoEn4vX6nMh2LQhdl5537lb+PaalMrShrc9MC5NTvUbNnwh0VAZF0zvKwGvSmmy1e
         aqs4tqHVFDUETnLk2g9niZHH5OQch+XdEzN6mcE0YF82vggZlBV5HBg5ugGKACoXuL
         BTjUbCx4h9bdiiOdMNXu7YNwk4Flxq1lzWkMP/YTIkEPU6kxaEwqK95G8flIpd7I0U
         KlxvSQuHClFWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o5is8-0007ke-Fa; Mon, 27 Jun 2022 09:09:24 +0200
Date:   Mon, 27 Jun 2022 09:09:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: Error: arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi:23.19-20
 syntax error
Message-ID: <YrlXpKQN6fOrwlcp@hovoldconsulting.com>
References: <202206250721.5muaVLMF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206250721.5muaVLMF-lkp@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 10:59:46AM +0800, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220622-213010/Bjorn-Andersson/arm64-dts-qcom-Introduce-SC8280XP/20220622-121246
> head:   f75e13dde1b5cbb2f301d0f368bcedfd12037eaf
> commit: f75e13dde1b5cbb2f301d0f368bcedfd12037eaf arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree
> date:   2 days ago
> config: arm64-randconfig-r012-20220624
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6fa9120080c35a5ff851c3fc3358692c4ef7ce0d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/f75e13dde1b5cbb2f301d0f368bcedfd12037eaf
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review UPDATE-20220622-213010/Bjorn-Andersson/arm64-dts-qcom-Introduce-SC8280XP/20220622-121246
>         git checkout f75e13dde1b5cbb2f301d0f368bcedfd12037eaf
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi:23.19-20 syntax error
>    FATAL ERROR: Unable to parse input tree

This is expected since v3 of this patch depends on a change being made
to the preparatory part of the series (as mentioned in the changelog) by
adding a missing include to sc8280xp-pmics.dtsi.

Johan
