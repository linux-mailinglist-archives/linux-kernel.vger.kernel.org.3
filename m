Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB914B9C85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiBQJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:53:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbiBQJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:53:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A53B0D3A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645091580; x=1676627580;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6I2pNwcHEwPyxFG/lbEdjnuP6kEoR2R/Fr5pJFpGV4k=;
  b=ceiJlqnpHwchFUkKmApnEZuuo8KLixCQkpm8jthw28GSbXFcbpRvEbJh
   9pfVKcRBFU+NUZ9cTbheNkjltqEOyHMVX+r1KSE3KPuTdt3pnK60a3jOh
   bI+Eo/qdmA8jzPMV0SsHzFiIP+3aJDhKfHLr+TCSqvFwRloZPq9n6bHq4
   CFgGYxyg5TeO0kizVvkTG3QuSLx/c2w9tD30EatYTFmGpTe/JSzy6ZS9O
   u0+n+6FIK5Sy2FKgfNlC53bNScyiV02wtNZCBhvBNd6y8l19hGCnjktgU
   BT/EVFb0J4OzseFstUYkU3qMiyw4bp3+t6Z+0kE3XnlKDKfgUR083FuAV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250574951"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250574951"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="530086306"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2022 01:52:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 01:52:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 01:52:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 01:52:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJlEWsOVDZUoANhs8QlqGuJCVdDWeiBU9UEKZt227bl+pfLOwxKUSClxx7Hr8UEu3ZMHkO07YvdydIpa4WKuFKes/HL8QFKYVX2DvonDncMR+NazTou+VAfMqif61isUEg0qFBaHgE5R0hWu1npcK4xCelW5M3fdKHJ2lK3yHbUjNSoL6WY5BfULRKh6VcQJGeOLHB8coXhgSuLnt15wpuGNasIo9r/MlZnsMQoquTR1JEpEaJp7gVz/YIfD3g4SbkyvEXvTZOCJM5RjIsejcSnAVV4NqLeLM21BNxqB3zHnXax0sQRR68qld5xBsR0tZg+Uw2LXg3BaclQ/0uVmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZL45qq0tntvy1KzLJTOpR9CIurtMVGpJnEuleWiM3Q=;
 b=cPxJRcR+KMlx5INcmM0t9lVOrlSLTH9XIBOYeLJRvTUViP1X2/MeS34tJeqAIV43rZ8blulTayhApWUWVXWbAsNLZa+uM/utKnXFEN5hLfw3OVlyU41sBQHKwN/UfLlpFNFPl+2qclmz6Ky6l6x5EPDNSK+mNNthpV8Gah7lP7Gq7LDH1INHwg3eOEuD71wz3vVbPaFOeKYY+YiRQMzzVBcrOOXjfFdqa/N/cpTjH/ZW4koCX7pPpz9KXV2PVfvHxzfEmPQoJXWgBGWzt3U4IKD8E8JyTc90GuiruEUBQE1HVsvlGuEOHkR5fIJ8XHkmOq2WgBjMi1z/G2XMBJejkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 09:52:56 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 09:52:56 +0000
Message-ID: <ddc1fb54-f7c7-8936-1b5a-53e7ce4b91b2@intel.com>
Date:   Thu, 17 Feb 2022 17:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: [jgunthorpe:iommufd 18/31] drivers/gpu/drm/tegra/drm.c:998:23:
 warning: Value stored to 'domain' during its initialization is never read
 [clang-analyzer-deadcode.DeadStores]
References: <202202160335.Mb5DqLiM-lkp@intel.com>
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202202160335.Mb5DqLiM-lkp@intel.com>
X-Forwarded-Message-Id: <202202160335.Mb5DqLiM-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fd9513f-3b3d-4bc6-505c-08d9f1fb45da
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5772F1112B9F658CC454A4B0FB369@SJ0PR11MB5772.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AU7Y8G5QK49apeIIPfk8ftlMk5XFIn5T5Xk8DGaQPQf7VxGnzVW8TO2xi9Lt3psWyA/BLtjWRc9wS8huBkD1zDOYndqIaXiq3W4gCdZldH5fmwvU3dvbVTqUG6EIoQLRm1MZ/yL7xs4dGxI9KD6zBDOX8JdzwVX9fD11xlGaIEUlEaDNyk1y5yeOD2SbOvklI0hRrUUShnrkDuXjgMadukNtHO8XEqw07HyqO1BeIt+Xl/JR19Z3lB20z5/1gsO+0O3woi4WGdUMW1tXs7+KLVBQqnDhh2/jsFNBoHpwyv7iIj8HVNPYiXSVSGLECj4JaosMmgzVYNXT2J8Hjb/F8vjQBJ4FH2y+p3bKFyUqBxf0uDgEjXG1+yiFKvyvSun+MxOjpG9EbgeGoDQ8/pyYutpO9bcBYM8JIC6hqQZ/WsRixIIUVgdGQ3eevG7aAuVUvjJem9kbRBjF0TN5VREh59/D3Fk6UQqTQgAyzYSR8HRTh+YKM7ENMVRXilEOATH/zTXr/AipgUhkDAcLZKGXxuaFBagc94cJvNxzsbp5oOIJH3fyUiXmBblccexLHE53h7jYVn1hUMf9ruwfAqOZYRrOBrmoVeOjtvcH/S77B3cQPVILe4BxcUKxNYFA1RBYpTDigHkkdKQeQUrljS7ADZelxSsx3GDUqzjHMr1d0EDyIFG6a2AGVST/ZlcqVSQjtMw6n06R5i1ommOM7dXrvvRzvfdz0YoK0QVkiieu9TQG1KAOFKm1MZNHreWuaXEwVnsIbHbA16gV/AX3xEggN0L4QUr9/W+IguHLlRK1Wr1Q8DP+Cz+0RKu/ecrB1fG2obWnYhKJPP3Fwu52UHWEwXHUxrS5G0H3PdcBKEcn4HE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(508600001)(36756003)(66946007)(66476007)(26005)(186003)(4001150100001)(82960400001)(31686004)(83380400001)(2616005)(8936002)(966005)(6486002)(31696002)(54906003)(316002)(38100700002)(4326008)(8676002)(6512007)(6506007)(66556008)(2906002)(6666004)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enl3aWxGenVmcVdTcDhrSlVTVENCV0NwRU1saDNTT1EzUk9rdU5sT2lra1Zr?=
 =?utf-8?B?MHRTREFwV1FoektYS3I2d0FIcGVYRzh6TVdPVHgzNlJZUnY2WG53T05icmNT?=
 =?utf-8?B?U1R6YzhzeVp3SGhxeTU1VDlLcmxUaFg3akpUckFtWmpMd0ZDNnlEWUROMlo4?=
 =?utf-8?B?ajJoWG1nNUVMMzc2bTIvZG13U1JrbEZGQU5iVmpiWHl2d3ZITjd1ZWprZkE2?=
 =?utf-8?B?WXIzME01SG13c2puc3YzaE5yQ2EyMmgrRk1DdTkxTXI1L2IraTRkdjVhU2NL?=
 =?utf-8?B?NkFpTStsbWo1WE5xYVhwd01nMVlYd2ZGU053QzdVbUxiUGEybVJRdnN3RitF?=
 =?utf-8?B?c0xwWTgxSFQvSk8wRTFTVUl1bk1EMVFycnBET0Z3Z3JBUm9CbDlFeE5NV1Jo?=
 =?utf-8?B?cDNVcUw1ajN5OGRwamlhRStEYnZ0cGl2RUhaTXdBbVUxejZUK0wzaTFUbVhK?=
 =?utf-8?B?d2VxLzJRRkt5VDVtWHhjWGNqSlE4UnhYUkQ1aFQxVWx2UzUrQTVnS0Iya3gv?=
 =?utf-8?B?Qnc0SW5SekMwVVc1MUYyTWs2TUxIN0RreFZCU3VxRVBvTm5hNnZzVjlWRjd3?=
 =?utf-8?B?OUY2WXpvYmVBK2wxRmhTMzYvRVhmZnY0V2w4M2lsVVlYeDB4UEhnWVU4aS9x?=
 =?utf-8?B?NVhmSEVKMEJCSEVOT2toL3gvTElJRHk3aWJPSzFPb1hJRngrdndDaDhJd1ZT?=
 =?utf-8?B?Q05BOXZ3SFUzaVlKRHhXUFAyekt0dTBsVWx1aVU1ak9waTZvUTExbXFlS0ox?=
 =?utf-8?B?L3FjU1BlZ1JML0RpMmcwY3F3VU9UbW9aS1hEV3V6djRaNGY1NmNlSUFSU2dP?=
 =?utf-8?B?RGdWNWp3WGoycTRkRzU3UzFFcnIveGtzRDA5SXgwVmxWS3prTUpnNUliKzNh?=
 =?utf-8?B?RGxCSnl2R1Q2WFY2UGQ2RzJRUDBrVk9Qb2RURXBZREJuZjl2RjRSVlp0KzZS?=
 =?utf-8?B?TlBYbzI5ajJDbndzQUdvVkM1YVdvd2FLRisvMzlNMll1ck9YRHRJSmh0YjVW?=
 =?utf-8?B?VE9LUExNb2lURTBhalpkQkJsSWI4ZE11MnZJcjRKclVMM3VmNVN5a2JZSUtl?=
 =?utf-8?B?R3VKNEtzUXMzWHQvcXRnbngwbzBhU1pWeGZuU21GVjh0YXhaYUFPYkkyM0hX?=
 =?utf-8?B?ZDFHc3dyb0ZJQTlZUVZBNElvMkp5WDhXbktLOTNxQVlpK0h6cFdGNXh0b0pR?=
 =?utf-8?B?K0Zrc0Z6TXRSZisyOElybVkzeFAyTkZMT0JRQ1RFcFVNS3ZXVXV2REJPa3Zs?=
 =?utf-8?B?TWdFamFud3JGL1NMRHphcmhpYW1XaXJzbzljMTd5RmlVRXcrWUMxL0dEcEJm?=
 =?utf-8?B?ZFRxeU1SZjdqY2E1dFhscm40azVhWmZ6cWRhNDQ0dWN2QVJKbHNUemNzajBE?=
 =?utf-8?B?NmZ6dk5welNvdjFPdmZwS25PR1FnN3E0UnJpNENvRllhZDJualZHM0N5N0J2?=
 =?utf-8?B?SzlXTGR6TmJSVnlEcFlrYlFQSXFjZzdOZE9rK3dLejh3RmozVkdTN2lraDVS?=
 =?utf-8?B?ZkxzaEN2aEIvNmpOTDFLN2FHMUhYd1ZlQ3lqVGtzNTZIZmNWd1FQU0ZtSkh2?=
 =?utf-8?B?UFZ5U1hWMnl2SjBpY0poekRHaUhGMFBjam5LcVQ1a0phdThYVGN3TzFtWGdO?=
 =?utf-8?B?cElURHAwRVMwL0Qyc3NXcERzUmxlY2pwUXZwUVRnS2hId0U5UzRPQUo4NWc2?=
 =?utf-8?B?MU4ycXZ1Q0dJM3dRc1RUOFRIR2d1ZS9UazRPTFd3cE5ZbUQ0TW9NdmQ0MG8x?=
 =?utf-8?B?Vkg5ZkpUQXdiOG5DbXp0NnE3c0Y5L3RmekxnU1l3ZFcyMVRoSy92ZEphL3Ju?=
 =?utf-8?B?YUVpeXovU3dTYXREeXpXWU1SNG1rZkg5VE1HNU94NzFhWCsvY2NnUFVmWkdZ?=
 =?utf-8?B?cHcvNTBNbDlQMk9TQjg1OUJDMzI2T3pYczA2enNXRFJvRE1xSUxua0h1RFRy?=
 =?utf-8?B?WlI1elR4bUkrd3AwWmNlMndISTkwWlEyRUttOXRwVUVLYU0ya0Jhcklrallm?=
 =?utf-8?B?ZmpFa25ITGd3MlJJcDRhVVB6V0VHc0QrcXBRRGp4b3hHdXVvMGJaZlF1VEpW?=
 =?utf-8?B?cU4rLzN5TVNCc3NuU2ZlNXNnN2g1U09Dd1M1MjlDNUczY3NRNUlqUFlGVElS?=
 =?utf-8?B?QjA1OWhqM1VVNVNtVVlYQWM0M2EwYktmOG9LbTc4WkwxeUxlcWphY3lPRFhT?=
 =?utf-8?Q?idwJaIupV5EGZ2mnRq4d0Po=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd9513f-3b3d-4bc6-505c-08d9f1fb45da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 09:52:56.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W9g2OjM+4DUHW0o7oNamQWoks0OG4WJdoJVvTisziNb2ztACJ+C6zV2n9ctmPh6ffktAG7g0zl91EnsjF9X3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   6b5b3f20ed6b64824c2d447b4f4555fcb390bf3b
commit: ae38950aefd81c9648c5416ec4a5003e4ec03e42 [18/31] drm/tegra: Use the iommu dma_owner mechanism
config: arm-randconfig-c002-20220210 (https://download.01.org/0day-ci/archive/20220216/202202160335.Mb5DqLiM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://github.com/jgunthorpe/linux/commit/ae38950aefd81c9648c5416ec4a5003e4ec03e42
         git remote add jgunthorpe https://github.com/jgunthorpe/linux
         git fetch --no-tags jgunthorpe iommufd
         git checkout ae38950aefd81c9648c5416ec4a5003e4ec03e42
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/gpu/drm/tegra/drm.c:998:23: warning: Value stored to 'domain' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
            struct iommu_domain *domain = iommu_get_domain_for_dev(client->dev);
                                 ^~~~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/domain +998 drivers/gpu/drm/tegra/drm.c

0c407de5ed1a329 Thierry Reding  2018-05-04   995
aacdf19849734d1 Thierry Reding  2019-02-08   996  void host1x_client_iommu_detach(struct host1x_client *client)
0c407de5ed1a329 Thierry Reding  2018-05-04   997  {
ae38950aefd81c9 Jason Gunthorpe 2021-11-18  @998  	struct iommu_domain *domain = iommu_get_domain_for_dev(client->dev);
608f43ad27ab267 Thierry Reding  2019-12-02   999  	struct drm_device *drm = dev_get_drvdata(client->host);
0c407de5ed1a329 Thierry Reding  2018-05-04  1000  	struct tegra_drm *tegra = drm->dev_private;
0c407de5ed1a329 Thierry Reding  2018-05-04  1001
aacdf19849734d1 Thierry Reding  2019-02-08  1002  	if (client->group) {
ae38950aefd81c9 Jason Gunthorpe 2021-11-18  1003  		iommu_detach_device_shared(tegra->domain, client->dev);
ae38950aefd81c9 Jason Gunthorpe 2021-11-18  1004  		iommu_device_release_dma_owner(client->dev,
ae38950aefd81c9 Jason Gunthorpe 2021-11-18  1005  					       DMA_OWNER_PRIVATE_DOMAIN);
fa6661b7aa0b520 Thierry Reding  2019-10-28  1006  		client->group = NULL;
ae38950aefd81c9 Jason Gunthorpe 2021-11-18  1007  	} else {
ae38950aefd81c9 Jason Gunthorpe 2021-11-18  1008  		iommu_device_release_dma_owner(client->dev, DMA_OWNER_DMA_API);
0c407de5ed1a329 Thierry Reding  2018-05-04  1009  	}
0c407de5ed1a329 Thierry Reding  2018-05-04  1010  }
0c407de5ed1a329 Thierry Reding  2018-05-04  1011

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
