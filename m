Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA450CACF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiDWNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiDWNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:49:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B0180712
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650721618; x=1682257618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W8aiW7WDpNTFq9qDCpszM1S8oEcX5Bsj4089g/7FQP0=;
  b=ltmm93tcPpNNkvUxyJEakAqAyn3WAUC0DY2ixpfxb9E3uAY4B2fDjZvc
   JiETeHiSPsT/Rld79GlDta7AmCaSHvTbmapXsXX7WOG5oby10EEJwwodf
   bzHLYa6RIDABCQvUkmSpZBkITGRU198Z0soVCSELHhJNMlsK39XCl7h3I
   k99ZRxGzv9iQ9sm5mqqeap1AI2UcTILGP83Jr0YcQugL4PTK5IQms7vq4
   Yw6c5AyZJXnq2RomZEuAgUSjtQimWhwt6cKDjH2yylRmVemQ3Diz9DU0y
   xKYLITtLWuUsa8z2326IEL9eGzeh7fwPEnNe3tmYzEqWeD8Dwc9wMNZs6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327814821"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="327814821"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 06:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="594549830"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2022 06:46:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niG6B-00005B-FV;
        Sat, 23 Apr 2022 13:46:55 +0000
Date:   Sat, 23 Apr 2022 21:46:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:x86/urgent 3/14] WARNING: modpost: vmlinux.o(.text+0x167248d):
 Section mismatch in reference from the variable memcpy to the variable
 .init.text:.LM90
Message-ID: <202204232143.iWyrqggA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   4cdfc11b2836e659c0b7b31152a8b0d976167b59
commit: 226d44acf6dfe71c9df5804b82364e93cf908b53 [3/14] lib/strn*,objtool: Enforce user_access_begin() rules
config: h8300-buildonly-randconfig-r002-20220422 (https://download.01.org/0day-ci/archive/20220423/202204232143.iWyrqggA-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=226d44acf6dfe71c9df5804b82364e93cf908b53
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/urgent
        git checkout 226d44acf6dfe71c9df5804b82364e93cf908b53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x167248d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM90
The function memcpy() references
the variable __init .LM90.
This is often because memcpy lacks a __init
annotation or the annotation of .LM90 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1672505): Section mismatch in reference from the variable memset to the variable .init.text:.LM105
The function memset() references
the variable __init .LM105.
This is often because memset lacks a __init
annotation or the annotation of .LM105 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1672583): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM119
The function mpostive() references
the variable __init .LM119.
This is often because mpostive lacks a __init
annotation or the annotation of .LM119 is wrong.
--
>> WARNING: modpost: vmlinux.o(.data+0xefc10): Section mismatch in reference from the variable iio_const_attr_hwfifo_watermark_min to the variable .init.text:.LVL187
The variable iio_const_attr_hwfifo_watermark_min references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0xeff2c): Section mismatch in reference from the variable iio_const_attr_accel_scale_available to the variable .init.text:.LVL187
The variable iio_const_attr_accel_scale_available references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0xf0048): Section mismatch in reference from the variable iio_const_attr_in_accel_scale_available to the variable .init.text:.LVL187
The variable iio_const_attr_in_accel_scale_available references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0xf00f8): Section mismatch in reference from the variable iio_const_attr_accel_transient_scale to the variable .init.text:.LVL187
The variable iio_const_attr_accel_transient_scale references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0xf03d4): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL187
The variable iio_const_attr_sampling_frequency_available references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.text+0x16726b1): Section mismatch in reference from the variable __mulsi3 to the variable .init.text:.LM208
The function __mulsi3() references
the variable __init .LM208.
This is often because __mulsi3 lacks a __init
annotation or the annotation of .LM208 is wrong.
--
>> WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL187
The variable iio_const_attr_ads1115_sampling_frequency_available references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL187
The variable iio_const_attr_ads1015_sampling_frequency_available references
the variable __init .LVL187
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.text+0x167249d): Section mismatch in reference from the variable memcpy to the variable .init.text:.LM88
<< WARNING: modpost: vmlinux.o(.text+0x1672515): Section mismatch in reference from the variable memset to the variable .init.text:.LM103
<< WARNING: modpost: vmlinux.o(.text+0x1672593): Section mismatch in reference from the variable mpostive to the variable .init.text:.LM117
<< WARNING: modpost: vmlinux.o(.data+0xf0eac): Section mismatch in reference from the variable iio_const_attr_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15b4): Section mismatch in reference from the variable iio_const_attr_ads1115_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15c8): Section mismatch in reference from the variable iio_const_attr_ads1015_sampling_frequency_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15dc): Section mismatch in reference from the variable iio_const_attr_ads1115_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf15f0): Section mismatch in reference from the variable iio_const_attr_ads1015_scale_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf1bb8): Section mismatch in reference from the variable iio_const_attr_calibration_forced_value_available to the variable .init.text:.LVL172
<< WARNING: modpost: vmlinux.o(.data+0xf229c): Section mismatch in reference from the variable iio_const_attr_in_anglvel_scale_available to the variable .init.text:.LVL172

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
