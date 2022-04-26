Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55D50F30E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbiDZHxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiDZHxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:53:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BF15FFF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650959403; x=1682495403;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/CZPGtt/BXkrqb2w/EStBwMjAhHp0yQPncOMjjc4i/E=;
  b=dE7IbvCj9cX1MC1n+wdkHyfmp1FJCL2IaJS/+j6Rh/E2f4f0OUDdWTeE
   vNirhSaYTWig6Tk+kXgHb42ex4cmfVfMZgZPz1mir7J0BCYFcWHheW+yu
   5pFBSbqKd1CQQ5FFA2qvoH1PKrpLiOpE05g1vLJlYCdpvT31m1KJjdkyY
   wxYXSQbkdYmYs300Lu96NuelhsOu9oqgCMTUfynL83dvcYKWD/N+UgsqQ
   pFWFB8OItSlt1LRFUOwG8o4PEG+aG7GENc8LiFM/X9zeyumFX3VmFdWxF
   /0tQn9xIUp+4K0+vxv5V6fZczwqPLl5VoCliXvw5u7ELNpbpo7DmyDDKT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245411738"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="245411738"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:50:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579745484"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.89]) ([10.255.31.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:50:01 -0700
Subject: Re: [broonie-sound:for-5.19 88/98] sound/soc/soc-acpi.c:58:36:
 warning: initialization of 'struct acpi_device *' from 'int' makes pointer
 from integer without a cast
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <202204261004.8OOIWobj-lkp@intel.com>
 <62af4093-a4ff-62b1-10db-585235c06747@linux.intel.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a7f8091f-0afe-aba4-0888-a17e7175d2d1@intel.com>
Date:   Tue, 26 Apr 2022 15:49:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <62af4093-a4ff-62b1-10db-585235c06747@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 3:25 PM, Amadeusz Sławiński wrote:
> On 4/26/2022 4:54 AM, kernel test robot wrote:
>> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 
>> O=build_dir ARCH=arc SHELL=/bin/bash sound/soc/
> 
> /home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc: 
> /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found 
> (required by 
> /home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc)
> /home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc: 
> /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found 
> (required by 
> /home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc)
>    SYNC    include/config/auto.conf.cmd
>    GEN     Makefile
> /home/xxxxxxxx/0day/gcc-11.3.0-nolibc/arceb-elf/bin/arceb-elf-gcc: 
> unknown compiler
> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
> 
> Having a "nolibc" in compiler path I find it confusing that it seems to 
> require glibc...?

Hi Amadeusz,

Yes, the arceb-elf-gcc depends on a few libraries include libc6,

         linux-vdso.so.1 (0x00007ffd4a1f7000)
         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f4c4f36e000)
         /lib64/ld-linux-x86-64.so.2 (0x00007f4c4f554000)

and the below version is used in 0day-CI:

ii  libc6:amd64                        2.33-7 
  amd64        GNU C Library: Shared libraries

Best Regards,
Rong Chen

> 
> I guess I will be able to figure what's going on without reproduction, 
> but would be probably easier with reproducer ;) .
> 
