Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF924E3A56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiCVIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCVIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:16:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0251E6C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F03B81C17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B65C340ED;
        Tue, 22 Mar 2022 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647936910;
        bh=BNEnkH2T434Y5htXpdrVyq0X0dPzkYPq5kf49Gka0Is=;
        h=Date:From:To:Cc:Subject:From;
        b=EsqnHzYZ+vX3WnFZtUrcml/KrhMth/rbDnrGuUQCH+ydTX5qXWYeb63cHCGLkIMBm
         N2B5LSHxBR2viUf/H2NTPtSUPRxrtZOno+nBwszGepSlpCMRI4sWCng1eqhQ5Evtvz
         VLwnCbrQnFEN6JKUA5gnyyluWqT+e8qb2Y3BBVZIIqHblQYxtA7kWFQ102FLDSD/5u
         gDTTAFKcYEQmW2sIpKv4cHN+FICPHzc4PtM8Ndcqy2arHcX5JDi6ZuHb4lqYyNheLA
         AxGMeLn5oDcPcnHGEeQmeoOjqV1H87qqLsHRZaF5KHhK+txCkv2XkLPGoVUtkM8owK
         8+jsR7G8QydJw==
Date:   Tue, 22 Mar 2022 10:16:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [jarkko-tpmdd:master 27/27]
Message-ID: <YjmFy/G/YSHQuwW1@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:41:43PM +0800, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git master
> head:   a536629ef32d127d26f3886f1fd480708fd5ac20
> commit: a536629ef32d127d26f3886f1fd480708fd5ac20 [27/27] tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops
> config: csky-randconfig-s032-20220321 (https://download.01.org/0day-ci/archive/20220322/202203221451.saNVXUZx-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a536629ef32d127d26f3886f1fd480708fd5ac20
>         git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>         git fetch --no-tags jarkko-tpmdd master
>         git checkout a536629ef32d127d26f3886f1fd480708fd5ac20
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/char/tpm/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
>    drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     expected unsigned char [usertype] value
>    drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     got unsigned char const [usertype] *
>    drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
>    drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     expected unsigned char [usertype] value
>    drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     got unsigned char const [usertype] *
>    drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
>    drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     expected unsigned char [usertype] value
>    drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     got unsigned char const [usertype] *
>    drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
>    drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     expected unsigned char [usertype] value
>    drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     got unsigned char const [usertype] *
> >> drivers/char/tpm/tpm_tis_synquacer.c:89:33: sparse: sparse: non size-preserving pointer to integer cast
>    drivers/char/tpm/tpm_tis_synquacer.c:90:33: sparse: sparse: non size-preserving pointer to integer cast
>    drivers/char/tpm/tpm_tis_synquacer.c:91:33: sparse: sparse: non size-preserving pointer to integer cast
>    drivers/char/tpm/tpm_tis_synquacer.c:92:33: sparse: sparse: non size-preserving pointer to integer cast
> 
> vim +89 drivers/char/tpm/tpm_tis_synquacer.c
> 
>     66	
>     67	static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
>     68						 u16 len, const u8 *value,
>     69						 enum tpm_tis_io_mode io_mode)
>     70	{
>     71		struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
>     72		__le16 result_le16;
>     73		__le32 result_le32;
>     74		u16 result16;
>     75		u32 result32;
>     76	
>     77		switch (io_mode) {
>     78		case TPM_TIS_PHYS_8:
>     79			while (len--)
>     80				iowrite8(*value++, phy->iobase + addr);
>     81			break;
>     82		case TPM_TIS_PHYS_16:
>     83			return -EINVAL;
>     84		case TPM_TIS_PHYS_32:
>     85			/*
>     86			 * Due to the limitation of SPI controller on SynQuacer,
>     87			 * 16/32 bits access must be done in byte-wise and descending order.
>     88			 */
>   > 89			iowrite8(&value[3], phy->iobase + addr + 3);
>     90			iowrite8(&value[2], phy->iobase + addr + 2);
>     91			iowrite8(&value[1], phy->iobase + addr + 1);
>     92			iowrite8(&value[0], phy->iobase + addr);
>     93			break;
>     94		}
>     95	
>     96		return 0;
>     97	}
>     98	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Johannes, I'll drop your patch, please send a new one with the sparse
error fixed.

BR, Jarkko
