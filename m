Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B5491F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiARGMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:12:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:58305 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241419AbiARGMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642486363; x=1674022363;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bvjRsALnd3AoiVwbyJ/uf3RxBqhpi9nNXIDuXjftLxs=;
  b=X6T0MSlOYFNdT/oilUJAXBuPIDbMt3FnMBkVWAurNWGhuAsi9SSASdVv
   60D3p7qoYu/JUMoP1uHMXJWqtxe3fotTVizD1omDhQ9yoNtlwGdPnhcPi
   KUwNnMEUVprAHyKu2of1KyMJJh9m/7vcHnVJWM8fLNuaFDFq2YCCagrel
   8TPu7JHd0tTUpk26A3IJbssX3mxHrWevat1EtfPjLfZl2GPAhzw0TCvsX
   kZ8f6nwZkRQLq8bw2wi1ikFu16gXuIE7vU+B9rr6g+7AfYYk8YDNm9wEo
   hUsht56XE9AMCfGEGx0CCbLEcWzeG3oFYIy+qJYpoeo4HrNM0R7P9tE5+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269126032"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="269126032"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 22:12:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="531636117"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.237]) ([10.255.28.237])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 22:12:40 -0800
Subject: Re: [kbuild-all] Re: {standard input}:1381: Error: Insn slot not set
 in unwind record.
To:     Huang Rui <ray.huang@amd.com>, kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
References: <202201151944.siKQX7w9-lkp@intel.com> <YeZY7/KC7a03rCQB@amd.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <975e999a-85e9-fe50-3197-891273c18a23@intel.com>
Date:   Tue, 18 Jan 2022 14:12:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YeZY7/KC7a03rCQB@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2022 2:06 PM, Huang Rui wrote:
> On Sat, Jan 15, 2022 at 07:49:12PM +0800, kernel test robot wrote:
>> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5x0UsKxXHUM8eaXf%2FfEJg5A7m4lq3IIJB5yVoH8wyWQ%3D&amp;reserved=0 master
>> head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
>> commit: bf67014d6bda16a72deea11dbbff2a97c705ca92 drm/amdgpu: introduce new amdgpu_fence object to indicate the job embedded fence
>> date:   4 weeks ago
>> config: ia64-randconfig-r033-20220114 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220115%2F202201151944.siKQX7w9-lkp%40intel.com%2Fconfig&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=wvSyECxjF2Bq0hIolStzs%2FST9%2Bi9w8O4zNDQAxolvZI%3D&amp;reserved=0)
>> compiler: ia64-linux-gcc (GCC) 11.2.0
> 
> May I know where can I get the GCC for IA64?
> 
> Thanks,
> Ray

Hi Ray,

The reproduce tool will download the cross compile package:

   wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
   ...
   COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross 
O=build_dir ARCH=ia64

Best Regards,
Rong Chen
