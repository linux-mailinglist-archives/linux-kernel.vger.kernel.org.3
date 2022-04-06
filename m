Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D334D4F605A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiDFNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiDFNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:47:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39133C8100
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:04:29 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2366Aox4008097;
        Wed, 6 Apr 2022 05:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=no2eUXscBHSvRZ7O2It38W8eXT7w8davWXs4Eg5n67w=;
 b=aI2xtU6wmAWheuEapsgnRJAWtLsZKT6/z9ClBBkOELqdd3XznHsACv/prh7NYKH58OJx
 0COCXudcU5MFVPlLsIKCWVkBy0uvf8LauMeKBSRuIaDun9kCOTaJKs0eZNQoaOo2ZXPi
 J8ziYRU5Vrwa8vPgCYIQrF8BzXEV/e/O5YNWHXPPEuyznoDeerTqgzG2zYQsAWzlXU+O
 r/MUTp5JcUpJh1nl2g+FmXOXDHfJcFxdbUZ6Po7WJ6AKmNb6V/2GF6dTqQCgGoh1F8UO
 MwM8c1QWWFNypn1TCbSJnbHiSKgIs1JjpsdQ5X9lsMOg3sGhptyK93YQVdoz53H2lHVg 3g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2d0gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Apr 2022 05:03:54 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 11:03:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 6 Apr 2022 11:03:52 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A3EF2C5;
        Wed,  6 Apr 2022 10:03:52 +0000 (UTC)
Subject: Re:
 [broonie-ci:20220318_rf_asoc_add_a_driver_for_the_cirrus_logic_cs35l45_smart_amplifier
 29/29] sound/soc/codecs/cs35l45-spi.c:66:27: error: initialization of 'void
 (*)(struct spi_device *)' from incompatible pointer type 'int (*)(struct
 spi_device *)'
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <202204061233.zD5PMrQA-lkp@intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <e16cb5e1-a0bd-e5c9-f758-6d73b4ff0cb6@opensource.cirrus.com>
Date:   Wed, 6 Apr 2022 11:03:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202204061233.zD5PMrQA-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C7V5RAMlF6vFYCUj2Ptxyuk08s166whl
X-Proofpoint-GUID: C7V5RAMlF6vFYCUj2Ptxyuk08s166whl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 06:04, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git 20220318_rf_asoc_add_a_driver_for_the_cirrus_logic_cs35l45_smart_amplifier
> head:   22d0ed9e232c66cf1d388c39fafac77c0872ae79
> commit: 22d0ed9e232c66cf1d388c39fafac77c0872ae79 [29/29] ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
> config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220406/202204061233.zD5PMrQA-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=22d0ed9e232c66cf1d388c39fafac77c0872ae79
>          git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
>          git fetch --no-tags broonie-ci 20220318_rf_asoc_add_a_driver_for_the_cirrus_logic_cs35l45_smart_amplifier
>          git checkout 22d0ed9e232c66cf1d388c39fafac77c0872ae79
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash sound/soc/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> sound/soc/codecs/cs35l45-spi.c:66:27: error: initialization of 'void (*)(struct spi_device *)' from incompatible pointer type 'int (*)(struct spi_device *)' [-Werror=incompatible-pointer-types]
>        66 |         .remove         = cs35l45_spi_remove,
>           |                           ^~~~~~~~~~~~~~~~~~

This is fixed in V2 of the patch.
