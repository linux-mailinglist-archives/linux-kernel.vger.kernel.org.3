Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26350F25A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiDZH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbiDZH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:28:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992797CB02
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650957940; x=1682493940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LXuPJ7VPUOwtoUWhYDB56Agnxb9OPhmTFvaXas4CAKE=;
  b=lQZ7m+NAlNDQc3JbQIkVm4mcdGG7lERXnesroLDGSHaCd/cSx99lOzHO
   eLGuw+oFOL/pgxjqYnYR6O5d5pnLyZfxcayM/KbwG6kBXEOLIX6CTs9hw
   6tM2cbNKedx5Bmnqama50uyq/FSiIC0oo6tyqrrp/O4pLbUzShrGynyiP
   iXHrYADajeheoy1s6zM2n92V+ZJ9zUX/asaljlbiwkNgzElBiBrLmLHCN
   WgK/lI1huU0xTdU/dc2qNzr5SThK3X4q+CzH3Lo9h2ZJJBRGOo3uCcXIa
   C6XkImkFr19QgVfvDC/lG3s82BtI/PFIdbolrSjPGWWxemagmw8sDYCJf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290624564"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="290624564"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:25:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579732726"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.209]) ([10.99.241.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:25:32 -0700
Message-ID: <62af4093-a4ff-62b1-10db-585235c06747@linux.intel.com>
Date:   Tue, 26 Apr 2022 09:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [broonie-sound:for-5.19 88/98] sound/soc/soc-acpi.c:58:36:
 warning: initialization of 'struct acpi_device *' from 'int' makes pointer
 from integer without a cast
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <202204261004.8OOIWobj-lkp@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <202204261004.8OOIWobj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2022 4:54 AM, kernel test robot wrote:
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash sound/soc/

/home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc: 
/lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found 
(required by 
/home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc)
/home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc: 
/lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found 
(required by 
/home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc)
   SYNC    include/config/auto.conf.cmd
   GEN     Makefile
/home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc: 
unknown compiler
scripts/Kconfig.include:44: Sorry, this compiler is not supported.

Having a "nolibc" in compiler path I find it confusing that it seems to 
require glibc...?

I guess I will be able to figure what's going on without reproduction, 
but would be probably easier with reproducer ;) .
