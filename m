Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D139F4A335E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353827AbiA3Cqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:46:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:64223 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240673AbiA3Cqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643510810; x=1675046810;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7Joh2wlG4KScj08pqGv75g32cYB6QQUKfXBpsr9F3Q=;
  b=VutsC3HtyNefZvimaVZrIv5/XVKu4n0M7zQq53QGU2FUROcfRrtaqenS
   nDS7nKPPSB3ezLQ/Od3m76sy0qK78IAoaDW+PmUjDY0rwwMZFi/lNVu9x
   78ene05Ub4a+IaJWvgikaIt0GUG0lDibM2Pp+iWakLOa29ynel8qrtJ1E
   4ImcpUsxxeP1adl3ryEOTSTU9KsJkS7Umv3Gx+DtjIKOyodwcFJAp7+Fb
   usF+9bdmk0sGNC2GsaGvD0DWvedJAQV4w1+wf+z7KJWA58P3IMqX+0f9C
   O71S3LrKasTYnKTn4F4z4P2+tCOk/m7KvdLuMj81bjySOPrfgpJuDQF1P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="310623448"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="310623448"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 18:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="626011340"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2022 18:46:48 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 29 Jan 2022 18:46:48 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 29 Jan 2022 18:46:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 29 Jan 2022 18:46:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 29 Jan 2022 18:46:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj30duC24KjHSn8ErirJR+64sBM4yBsy+8I15/NoEc2Xkj1/+ArHqztqbpTWQ3X5QY9Gg4+u8Sa6Npb628uH1hA9UFYmFS/9zRZsleVPomqQDAb4ruE0prPr1qaqlzxbSgfJ++UZ+iGi248hVhx9wvEN8g6G7PkWiSnI23ww3ExTzH8LIV5TerhFnoKhmGRdfXoFTKKwIqgEgEqFhQcVt5xK8Vesow6nvFWMdAaI18IO4ZRudW9ddI7ASR+i9yQfdcoeG+Yjfs9H5kCLj0g1N0oWQ60gGWI6jKFGOowALh17G0NI2IM3B0R1TA9okp8cG1YqhvDE6NUsVd9N8KrKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Khii1XoXMEijBQFvDsYoaucPoCx7O1hNIcD5oGoL3E=;
 b=jbe/niNpjMk8TP/4lhub5kT6DPeZjYSCGHxfnGcqqHM0Fzia68vC1ZHmEj3siXndCFBT99ElINNKsVr7Bdxeykv9LH9mJU4MVQw+uo8xOBDDiWse/cC9oAt7DlP+JFCGDf55+FfyptHCMjwARU23Y2a3hKfGScu74n2WubvZeH9+CKVyVCH/zrjngeu4Vz4iRQzQR1W9a87NxTAvSj8J7vOXB4xiuia6g5k/41qSRF5GA2JjbdID9XYnDOxLeXTdgEsXgX8W3vwn/ggXmZtv69aJTF/xx71brreB1Y2XVcmcx94DgC8SF3QtJWK0kAFzBzW15xxf1JDSIMcglSLf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM5PR11MB1770.namprd11.prod.outlook.com (2603:10b6:3:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Sun, 30 Jan
 2022 02:46:45 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 02:46:45 +0000
Message-ID: <ede6031e-ac32-d729-4b52-0503e7f301ae@intel.com>
Date:   Sun, 30 Jan 2022 10:46:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: drivers/iio/adc/xilinx-ams.c:1324:3: warning: Value stored to 'ret'
 is never read [clang-analyzer-deadcode.DeadStores]
References: <202201282049.dQhZXwBH-lkp@intel.com>
Content-Language: en-US
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manish Narani <manish.narani@xilinx.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201282049.dQhZXwBH-lkp@intel.com>
X-Forwarded-Message-Id: <202201282049.dQhZXwBH-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dc6ada6-f837-4ffb-f538-08d9e39ac111
X-MS-TrafficTypeDiagnostic: DM5PR11MB1770:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB1770D0A343DBEBA509563135FB249@DM5PR11MB1770.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viE5IIJoHkEi8Key1w0IQWJ73yV2AlowcOPM+Tyvay01AsrAw4iVT6liVwsuF5MecspwJLw+9r2rLNyvMjaWtt6umFeT32RuiZudauFAicuIxtg+ps+eBx9g65jhfpbNs3ZGGxYF0dAK/gJNTgXEHL080nDVjqKfcfKOUr51T7oMMqKSyga9+MU2Fld586XsmJTkMTE3cX+mkY9tqDoK4L9AxBAO+tMeozEt+ZRrM4F+4sQAoAKZDgAAAWGkr5/iEMZeaDMrHkl0uhYkIqT8XYpGkQgPF/YN9WPdpvOBGx8M7ZZp//4guCI5hOMSWZvYR4QksR/d5VShgIGv5MrJxK2AJsi479gY6Zgnc2z4kx3DXf9ctPn+hA6jdS8STuZ1nIqcKM3IZNmC2cLZ58bHmCw3nC7NU4GRFr577joGpnMAxB1sGCasshv7xJhA1nNHyVLPrsG9E3J/WxVsqv9ehray7/EBGBP2lnxWBz/Yi8Vd1Y3LRdT0xkT0jFNNtQxxp0A8MAr/6VZVgR4v9VfK0uP1xQs4CzQQqAaG/OoU5FRedDblYFTClSlz/183qz7BHv2/d4btEYraJh9wgcMKgFP8pcdSeYGg1K8FGf1Qrcv74cYywwlU3EN1nAj1mJeICj8Rrk7GuiTKJNwBIZzuUFiE8/pfIxwqrfwzVGhz0OdDCbmd+1YOVnyJNZ/Tv1mQ4QcAodw9KaoGyAOumnaYNwqHwWDK6p4kgzNxZaIUA4KNRYJfsS9m1JZ+euhiuE42+T1OwH5GinPsTq9QMYF7NoqR2Vu0KqlSnLJSrIStbJ40i0vmYRH9U6MzOJRJgTeq6ya52OIxn2HFFGlvkGXo5PYL7LB1eSMfzoFNx/19KHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(83380400001)(82960400001)(31696002)(54906003)(36756003)(4326008)(6916009)(316002)(6506007)(6512007)(66556008)(26005)(2616005)(186003)(8676002)(8936002)(2906002)(31686004)(66476007)(6666004)(6486002)(5660300002)(508600001)(66946007)(966005)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFOMWphYmxIZHRlekJ2ZS8vS0EyRWhoVlA3anU3YXMwd1N0dm5EcmxieFZU?=
 =?utf-8?B?aURETzF2cWlmS2QwL3hmU1lwcnBZaCszbEkxYy84UnBZb3p3UDZYVnBmeXJt?=
 =?utf-8?B?eU8rR0xHemovYmVLeXAwVFQzaU1LQ2JsRnhNSWxEYVIvTkIyNXFnWnN1RjhT?=
 =?utf-8?B?V0VCNGgwbXN1Ykl4dFJkcEtBY0JHTFV0RTNOc2xLeFplQ0lQRGZVZlVlQng2?=
 =?utf-8?B?VnhIbE11eW5KbW1TaThhV2V2Mld6Q0pqSVB6UGVpZUNvQlBnR2k3RjUyM05o?=
 =?utf-8?B?Ylo4WStLTUlySVdKUVdZNVFmVzdjdW9FdDUxTUw5UFFyYnRFU0lxMnROTmlZ?=
 =?utf-8?B?VXRnU1RFVU9Ta1lKK1JwY0tpYVZRcEpWbHhIcjBITDhoRXBoQUtsUGJybkVP?=
 =?utf-8?B?czhHUVJkQ3l0aE5CZzl0L1pITDJ5bUUzMzN1RC9NakJkbmNVVkxVOEtoQWRj?=
 =?utf-8?B?ejJhd1ZYUm14SE43WC9SQlBuQzRtQU5UNS9lbTlBNFE1VCsxc25NWXpwMEt3?=
 =?utf-8?B?ZEZ3cUMyU2J5cGdkaWdEVHp2R0RMRzVtYWdiOHptRkpVc3N6d1AvUU02N0hq?=
 =?utf-8?B?dm5qOE8wN2ZCRGdJdzdkbHcybktlWFh5RTQrOVlTeS9nWEVic0xjV3l3VGpY?=
 =?utf-8?B?VFJiYjZlOWZxTlJNelh6UlhzTC9oRU90aXpuNFlnZ3A2b25oNWFEUmtGSG8z?=
 =?utf-8?B?NU4vMmtyYS9nWUNVRzN5VW1IaVdMS2UrRGFiU09iMnJ4VllITDg3Qm5mdjh1?=
 =?utf-8?B?cy9oaHFKM3c1aWgrM01TejdwZFZhYnhvWGdaOW5nT2RVR1o0dG1Ea2I2UzVo?=
 =?utf-8?B?Q21tMGZvVVZGNlMwWE9oeGNlaitLbFlVVm9OUU5iY1hXSENueFVEWTBhMStX?=
 =?utf-8?B?bmpGaTAxcnk2Y2lQeW5LMHhFeTZMU3hGTFVwSHNEUmc4dmI4NFpMNkNaSEpO?=
 =?utf-8?B?emRFUFBwOHRlMmZBRkoyRnBRSmRuNUZyS3hRWkJFWXVyRnVONGNDSWNSQ1g5?=
 =?utf-8?B?dGJhenRvOTFNdDNONTIwZUc2dlVQT2pnL3pPdkhFcVRiUlVBbEcra0ZiTEo2?=
 =?utf-8?B?Tk1oWENxQ0gyNkl6cVhvOThaL2djMWxsZUh3UGZzRHVoVUpqYXRYa3N4VVEr?=
 =?utf-8?B?L3R6aWxyRE8vMjFHLzh3eVdCRGlFQ0UvVmlZTEhIaVAxYTlWOUZaWklYOHlk?=
 =?utf-8?B?TTVaTktqajU2RVdIclQzUmZsczVLVU9KQXo1em1WTlQ0bUVaWklFSnNCZkww?=
 =?utf-8?B?UDZWVlhSa3hNTEtzVVdpSytDSUorZC95RWNVam8rTHhPQnVIM0JJdjR6MDlO?=
 =?utf-8?B?TVk3S29MWG81UHluMnJCNTgwcm5LaW1oQUJVYThmczNxeldiTFBaVURTYVBU?=
 =?utf-8?B?YVFGekVadjRYSS9SRTllOUVjd1FwalBHeGxJZlVhT3p4Z0lzT2NHbTh5RnhS?=
 =?utf-8?B?WncrZ0NtQkFRMCtiRkdkVHhKS2dOb01UVDZna05NVE94R2NKaDUwQkpJUGRP?=
 =?utf-8?B?VGJZalVzTVN5dEhDRkp1TmlmZlRvN0FqQUQ2dWJuRER1Q1dwWU8zY2xLWXl2?=
 =?utf-8?B?WmJ4M1pRUlJVNUxORmFPY0NocU9IN0szYVh6anB3cnhPTjB6UVBjcHV0SnJU?=
 =?utf-8?B?alpUeWxtMFhFWStadXNnS20zbzFKYXNVeUZZV2dDSytWWjdHb1M1eE1uaDVp?=
 =?utf-8?B?WE1rN1huWnRBOHZXOVIvQVVsZS9ST2tTak91KzIzTWNBSTRtY2Q2V2hncFF3?=
 =?utf-8?B?eVRQQTByUWE3d3prV1ZZWFkyS05rYzBCVTgyMnladFJ3UElPZTY3K0pxTjRJ?=
 =?utf-8?B?MUdSOWQrQzZGRm1qNWozK0NqaVRQcUJkY29QckZUT3gvb2NSL3RtZjlUNGda?=
 =?utf-8?B?c2hFVjIxWXIwaGJIU25wNnltWm02b3JQb0c4dEoySWZEOGdzd0EvOFY0eWZQ?=
 =?utf-8?B?U2dkL2dZUTFaZHQ2Z29mRzdJNE50SGhISkZ3RnRPcktXYWVxdndkYktYYWcv?=
 =?utf-8?B?SDdSMy9UeFdGWHVYVEkxUXpkS2dUQUs0QXdZRkp0dFpVSm9va0JWeE9yVStP?=
 =?utf-8?B?SUp5WWtQbHZJUVhEakM5TGY4SldjdmRLcmRNb2toN28wTkFMMDJYbUt6Yksz?=
 =?utf-8?B?QW9td3JMZCtMdUVtNkw0QTFFYXE0NnluUERqWTVhOC9PdXk5Z3dJQ3FoZWlh?=
 =?utf-8?Q?nxpjljaoLcJ1BE8LrcXQ+PM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc6ada6-f837-4ffb-f538-08d9e39ac111
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 02:46:45.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLRz1cDIWkFliyq3qRo1xK8f6tVuEM1VnJCb4MyjVabCJYGiEw1dL2sRWw5Rjd5g/oAvfgZR597RMCq/E2OYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1770
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23a46422c56144939c091c76cf389aa863ce9c18
commit: d5c70627a79455154f5f636096abe6fe57510605 iio: adc: Add Xilinx AMS driver
date:   5 weeks ago
config: riscv-randconfig-c006-20220126 (https://download.01.org/0day-ci/archive/20220128/202201282049.dQhZXwBH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv64-linux-gnu
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5c70627a79455154f5f636096abe6fe57510605
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout d5c70627a79455154f5f636096abe6fe57510605
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/iio/adc/xilinx-ams.c:1324:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                    ret = -ENOMEM;
                    ^     ~~~~~~~

vim +/ret +1324 drivers/iio/adc/xilinx-ams.c

d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1253
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1254  static int ams_parse_firmware(struct iio_dev *indio_dev)
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1255  {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1256  	struct ams *ams = iio_priv(indio_dev);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1257  	struct iio_chan_spec *ams_channels, *dev_channels;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1258  	struct device *dev = indio_dev->dev.parent;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1259  	struct fwnode_handle *child = NULL;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1260  	struct fwnode_handle *fwnode = dev_fwnode(dev);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1261  	size_t ams_size, dev_size;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1262  	int ret, ch_cnt = 0, i, rising_off, falling_off;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1263  	unsigned int num_channels = 0;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1264
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1265  	ams_size = ARRAY_SIZE(ams_ps_channels) + ARRAY_SIZE(ams_pl_channels) +
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1266  		ARRAY_SIZE(ams_ctrl_channels);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1267
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1268  	/* Initialize buffer for channel specification */
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1269  	ams_channels = devm_kcalloc(dev, ams_size, sizeof(*ams_channels), GFP_KERNEL);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1270  	if (!ams_channels)
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1271  		return -ENOMEM;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1272
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1273  	if (fwnode_device_is_available(fwnode)) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1274  		ret = ams_init_module(indio_dev, fwnode, ams_channels);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1275  		if (ret < 0)
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1276  			return ret;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1277
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1278  		num_channels += ret;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1279  	}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1280
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1281  	fwnode_for_each_child_node(fwnode, child) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1282  		if (fwnode_device_is_available(child)) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1283  			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1284  			if (ret < 0) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1285  				fwnode_handle_put(child);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1286  				return ret;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1287  			}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1288
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1289  			num_channels += ret;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1290  		}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1291  	}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1292
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1293  	for (i = 0; i < num_channels; i++) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1294  		ams_channels[i].channel = ch_cnt++;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1295
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1296  		if (ams_channels[i].scan_index < AMS_CTRL_SEQ_BASE) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1297  			/* set threshold to max and min for each channel */
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1298  			falling_off =
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1299  				ams_get_alarm_offset(ams_channels[i].scan_index,
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1300  						     IIO_EV_DIR_FALLING);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1301  			rising_off =
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1302  				ams_get_alarm_offset(ams_channels[i].scan_index,
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1303  						     IIO_EV_DIR_RISING);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1304  			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1305  				writel(AMS_ALARM_THR_MIN,
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1306  				       ams->pl_base + falling_off);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1307  				writel(AMS_ALARM_THR_MAX,
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1308  				       ams->pl_base + rising_off);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1309  			} else {
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1310  				writel(AMS_ALARM_THR_MIN,
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1311  				       ams->ps_base + falling_off);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1312  				writel(AMS_ALARM_THR_MAX,
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1313  				       ams->ps_base + rising_off);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1314  			}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1315  		}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1316  	}
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1317
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1318  	dev_size = array_size(sizeof(*dev_channels), num_channels);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1319  	if (dev_size == SIZE_MAX)
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1320  		return -ENOMEM;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1321
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1322  	dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1323  	if (!dev_channels)
d5c70627a79455 Anand Ashok Dumbre 2021-12-03 @1324  		ret = -ENOMEM;

'return -ENOMEM;' ?

d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1325
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1326  	indio_dev->channels = dev_channels;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1327  	indio_dev->num_channels = num_channels;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1328
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1329  	return 0;
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1330  }
d5c70627a79455 Anand Ashok Dumbre 2021-12-03  1331

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
