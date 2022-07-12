Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D3357108B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiGLC6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGLC6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:58:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D613A18E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657594728; x=1689130728;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8VC5Q15vxqjg4c2ROAm8pb7lnkexIwcMJPuEHCYuMKM=;
  b=H+TAulKENz4YkDUqZFms+DpI78gBbGXn9eTg+Vex8SCBKuMgl3ea2tAf
   PaiehLOWkY26CdK0hk55ygq6y1jtbMfOOC3mmpgn6izUoMtLHki1+XoUy
   Ljqk3dIxl+WYHRgAVwjWpCKBP/rh7jPE9cOb0yULfsN+0NJmU0X9mBmSm
   1e6m3KxMcScS1GseLeVcQfkB6O5OwJzTC+288AO/oX/1ElGlot4kk5RUV
   qRRCmsC0LfMnNbkE19U9o1df8j7lP8kDJT3VgI/bnB8xWOC656cL6XyEQ
   qKZuV5AMMS2fGDVa5oc/UofH5/jSAOMNNfG52T/LRFqMLRGC82xiIwkmD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284849616"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284849616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 19:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="922029895"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 19:58:47 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 19:58:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 19:58:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 19:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqhhgdvUVcSiOWWm08uW6fsy3A6Wk1gtWfqmmQrAa9E6/5Hns67CJShOFBwqJKbQFRzfsvssSMX16QjGLVEDt0ZBu2GPRvbbsnyCeLO8MKx4I9+AbsoJrpKfS6lnYlnPigJz1gV9Xz5Be24dbWPj5Y1PYa44UBxpVR/FFqCf23Lqc1qWi0HUY/OMDLZcbq3mF1JAOyqpGAPh4OQuveD0RV6sdKmAVR9G/sYuEUCJyxN5nZFAtEX6R8wkaqb2RWcO95CehStQtdDbkwVpfqMgrXpg2Q2Q26eCZBWpdipGRWJFE0MkCzVqMJblxDfE+bgxcnuDXTeecvbOkiDOYA7y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Haa3xySdR3WQUXpkmt/rPelfM0Og3DUnGF+UExJiS8g=;
 b=bP9I6hVypmJA4W8b72K53AqmVL/S5X+e8AKtg/GDK+FEthQkNqdXgmpEndlcPsvgRbFkQeBnfdEuaATKVz7MQx3zbD4GLPaHg58qA+nSr5kEn5G1u9jYISi6O70Cf/XwJHZuTDui/BuTdi+iUfTrOUsKQuPxRFn397kRCgjKnX/i16GBAcmmSM8h5D4tt6Hao0aRvdWR+ib+q+PG5F9fLX0riW7qfT4PSluYLYn9wW7PF3EUUrNM/HBwcGpn78Lj5qqHnp6J0CMoIiz02QDyar9HSLfFFdfRzEnZv6d/uRXPmlo8cpceTlOKMtemsq3KWkVCsri6N48qb9dqRBKmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 02:58:40 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 02:58:40 +0000
Message-ID: <2612c190-68c6-bc25-84a4-e7bd649286ad@intel.com>
Date:   Tue, 12 Jul 2022 10:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: drivers/dma/bestcomm/bestcomm.c:98:30: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
References: <202207120948.8wPKTGWL-lkp@intel.com>
Content-Language: en-US
To:     Anatolij Gustschin <agust@denx.de>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207120948.8wPKTGWL-lkp@intel.com>
X-Forwarded-Message-Id: <202207120948.8wPKTGWL-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d976b1af-eae3-4b4e-4f89-08da63b26c5c
X-MS-TrafficTypeDiagnostic: DM6PR11MB4626:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiM3WlgE1riIvWIjAd3RhtWOLbbau9sQ/xWTOFhfYM+XjfnKssyLqAalGIpGz0Of7dhKORyM4VPUyjXIdVIvKea5VkVuum6w3A7yyY+Q3NSl89d7zlqLIwO5XkY978RhGC42bcAiPVNrWsm3F6nWp/Qd+dsb/z2eAqPNhwUtfmpwOHLUzFHwoIvRwIMKrNso9M8YMcAb4Jhn5R8RNuPpYm2KsaEgX3nGetNflSI4goNZrLsaiEPsA+dW/i7dRAgYA7Re8yCHpaRE8QL9SI2dRrhD6sGUmPA090Pu2mpX6s2T7qTkcRvswYlJOVcEcMeB/h/amE6psLLNzL+x7URFlD6sC1O/8yu1Hd+yoAKK4sxCgxtcKcYrlZLrHSK57aABUHHY/gtxLOXCAcUPA8FA/+d7NUm4FqyRYoJjMiVvHnOD48/U6bTvvzWgJSJpqtxQyeI2RMbHfuGURbmuanW8Xtf0z/ZrD8Vrwf04ylbQyiMp7THuunJtdbafVd0RoKLnXvhpbUpkNIwYozqAFiKW84FpGSzNfgK5g1AaGQx3B9NW803/dgP88Sr+dxXvUtuAwbU5Xnzr++RKyMeLtx03U9dJnBALzsBk4rkvL1+bXT8EjrINC0Mi2n0yQGEIindckhnJHlGh1NHtoS3kic1YFyjppRrMOQ78YCez15ljsf9YsK60eX57WYQHX7rl5qn72HY4aBD1TTE6AebhVfNAeyYQ0CrvVrRa7TF5CQL2v+AKhjq5V7G93GmW/glK2cwbP3a7WBNeAvUWhd/I9qT+rsS23in1dzuExOa/BZVoagG08uq8lRJhzb0wpa6yqfK2MOMXRWO2mmhkO9XBsf3KbUJCoCFD1Xn7mIec7KS85TdfxOX/cLtzEzHHGKYrVWepD3nu75qn1qd+Bf2cbbkqcfia+ptbq7b+CX0WozcvIiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(136003)(376002)(346002)(31696002)(38100700002)(2616005)(8676002)(83380400001)(66946007)(6486002)(186003)(82960400001)(5660300002)(4326008)(66556008)(30864003)(8936002)(66476007)(4001150100001)(2906002)(6512007)(316002)(6666004)(41300700001)(6506007)(6916009)(966005)(86362001)(26005)(478600001)(31686004)(54906003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjJEVEZkTU54STVFVDY4MHdLaFEySzRaS2I0dGxMREtJU1NhcC9FcVdzSzJP?=
 =?utf-8?B?WThaeU85dndPeE96Tmluelk4YXpIK3RSamxmV01NSllWZzI2M05Qc3JleW9F?=
 =?utf-8?B?eDFEYTk5KzFTZzhOaHprTVA5QjErM1Q4c2dobzIwM0RCL3RILy9lV2JEM3Zu?=
 =?utf-8?B?d2dsMC9kbFJtRk84blJpK2hZZW8zQjhQdEhnT0VvaExpdjZRYlkyWHdnNlJT?=
 =?utf-8?B?aVJNOTZZbzlzdG44UTh3cUcxSDArNjFjcHo2UCttVjBZcTJIYTRHdHFBcTJj?=
 =?utf-8?B?SGlOVExCUEVxeWpHWDNmRkNJemMydUVWbloyK2F6REN2dm9aMXBhMDJ4QWkv?=
 =?utf-8?B?TTZpaG95ZE5zQWpkZ0xSa0VBMHB0RlJHaGZPbjRXWkhQOGZjZFVBZE1yK3dR?=
 =?utf-8?B?RXVHOVFOaXlBTWpCeGlTWUlPeFlDN24zYStkZlBHb2x3UWE1M3c1bG4rRU5G?=
 =?utf-8?B?eDRKWGFBUVBZNWpHendFMEluWFBjbWNsMEw4bGJpSmJBUXJuQ2JYWGU3b3kw?=
 =?utf-8?B?Q0IwV2tqQlFhRmRCcU1zWXBMWlhyZnF1eXJSbG82RGRxdGQ3TmNhQXZqUE80?=
 =?utf-8?B?REc3blpMM0xVekdlNjBMWVBWZGMyb2lEbkd2QXV2eExBZUtFbXB1UVRlNTE5?=
 =?utf-8?B?T1N5UGU5ZFM5QlJlVEU2MHI4TkxtOEYvSXhKSlZsYWh0UmcyZmdHbllrTysw?=
 =?utf-8?B?VVF1K2Z0THdVWXZ4WDZqSW1Jbk9vOVJXdFFCNGtCZ3hhU1cwUmYvV3JNYjYr?=
 =?utf-8?B?VTJ3RmxGVkFmSjQyelhnZmpqNzBIckpsUjRHSE9HVWt2SFVDUHNORU1NK1JT?=
 =?utf-8?B?V0lYZ2wzYmErY3g1RkRqcjNkanhseEZwU3RuOUFFVjRJdlBHb2VIL0MwSWFW?=
 =?utf-8?B?a3IwVU93ZDBoaEM3cXNpSStGdHBzM283YXM3cmhQZGNwa2lkV0hIaDRDZXFF?=
 =?utf-8?B?NURGczlhVThGdDhJd0t0cWRQRjczaFRINlhlS0trRVNYQmpKTGt1azB4eDV2?=
 =?utf-8?B?a3RCVmNic0tDaC9DWFh0TlB6cHRtenRBSkp2d3RDaVNCQWR0SDJtU2JBd3RB?=
 =?utf-8?B?UDZLNjA5V205Mm04Mk13Ui9neWVXQ2p2VThQRjN6VUhob1BCUXl3Tk5SQXF0?=
 =?utf-8?B?aDUwTVNhVm5ZYkVGTWVXU1RJRzdyQkFKUlo0RkFObnc1bEduRnFTZW9VLzJk?=
 =?utf-8?B?bHI5SnpBVythWDVYSzFkUGp2VGQwV252SWVsMmRIbnFJR0JBZG9aaVB3UlBt?=
 =?utf-8?B?RktVLy9TalVjY3NGUVBkS21jSFN0R0JZOGxEVFYxWDlGY2UxYjRraFV4Vmdo?=
 =?utf-8?B?YUJhblpmZFArYjl6dll5dG9HK0s4UjdIZW4wSDFkVFlvS2ZCbFI1NjVncXZ4?=
 =?utf-8?B?SUxlRjlhYzdmZU9GM2dwYk1qM3BOVEdOL0Y3ZlhkaDN3dEpTLzBCbkNXVkVD?=
 =?utf-8?B?N3pXTnFHQzEvMEJXT04rT3RLbFA5bEM1KzdjQkFkLzMrcFRBRkp1S1lMQWdj?=
 =?utf-8?B?QTRhaW9MNW12ZXJSZGgyejdxMmdiVGxLd2RyNmxqTzVsV2hvV0pDeWZ2OVc2?=
 =?utf-8?B?NmRWSk56RW8rOUdOY0M0SG5RU2JiUUYxdkpoaDVLZjdiVURkL2dBWDJvaDRp?=
 =?utf-8?B?TXowaTlFUXdLejh2NEhqT01OUFBDK0tCTXVENzVEZk9aT1lXRlpiQmJSS0pE?=
 =?utf-8?B?MG8xVEN5NENjY0xIRWwzM0RwT0RhTE44MFh5ZmQyMDZ3M2cxYkNpSURESVcx?=
 =?utf-8?B?TVJaeXl2K1FxNHRFckNudEJOTy9zaEhQM0w0TTNZRVhQaUtFMlpnM05lUDRn?=
 =?utf-8?B?cnVxNW0zaFlqM2toWnN0dlBScjRTTjR5ekhFQmtwdU8wMlp3ODFXTm4rSDRG?=
 =?utf-8?B?Vk5iYzc3aW1DdVp4UW1DWGpsV1lKZ0hxYUNNVU1XRUh3eDJkNEZldi9tT2Ro?=
 =?utf-8?B?Mk4xbFcyRjdaR2tEOVZacSt1dy9yRVpkS1VxbDRLdjFlbUFVT1lzWC8wVDNR?=
 =?utf-8?B?T1lyb3JEazB3dTJ4NTdGeHZ1WlJpQVNhZmM0enNETzRMTGZtQ2Vxem1VRHhN?=
 =?utf-8?B?Q1ZSVW4vbjRsL1NhR1J4N3ZBbW5wS0ZuNmVHK1kxbGxETVRGdUEzcVZkajZJ?=
 =?utf-8?Q?dVFpEbW6VAOmFqLheKjpQLrkD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d976b1af-eae3-4b4e-4f89-08da63b26c5c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:58:40.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM/GK+EUtVhL5rv551HqYoX+eJpLm4em17bTAkL1mjC+h6L8V/fTYLhJlZixlQ2C3h6MQ1m77iguYmFIrhs/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5a29232d870d9e63fe5ff30b081be6ea7cc2465d
commit: adec566b05288f2787a1f88dbaf77ed8b0c644fa dmaengine: bestcomm: fix system boot lockups
date:   9 months ago
config: powerpc-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220712/202207120948.8wPKTGWL-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # apt-get install sparse
         # sparse version: v0.6.4-39-gce1a6720-dirty
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adec566b05288f2787a1f88dbaf77ed8b0c644fa
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout adec566b05288f2787a1f88dbaf77ed8b0c644fa
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/ arch/powerpc/platforms/powermac/ drivers/dma/bestcomm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


sparse warnings: (may not be real issues)
 >> drivers/dma/bestcomm/bestcomm.c:98:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
    drivers/dma/bestcomm/bestcomm.c:98:30: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:98:30: sparse:     got struct bcom_bd *bd
 >> drivers/dma/bestcomm/bestcomm.c:189:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *[assigned] var @@
    drivers/dma/bestcomm/bestcomm.c:189:19: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:189:19: sparse:     got unsigned int [usertype] *[assigned] var
 >> drivers/dma/bestcomm/bestcomm.c:190:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *[assigned] inc @@
    drivers/dma/bestcomm/bestcomm.c:190:19: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:190:19: sparse:     got unsigned int [usertype] *[assigned] inc
 >> drivers/dma/bestcomm/bestcomm.c:196:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] *[assigned] desc @@
    drivers/dma/bestcomm/bestcomm.c:196:21: sparse:     expected void volatile [noderef] __iomem *d
    drivers/dma/bestcomm/bestcomm.c:196:21: sparse:     got unsigned int [usertype] *[assigned] desc
 >> drivers/dma/bestcomm/bestcomm.c:197:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] * @@
    drivers/dma/bestcomm/bestcomm.c:197:25: sparse:     expected void volatile [noderef] __iomem *d
    drivers/dma/bestcomm/bestcomm.c:197:25: sparse:     got unsigned int [usertype] *
 >> drivers/dma/bestcomm/bestcomm.c:198:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] *[assigned] inc @@
    drivers/dma/bestcomm/bestcomm.c:198:21: sparse:     expected void volatile [noderef] __iomem *d
    drivers/dma/bestcomm/bestcomm.c:198:21: sparse:     got unsigned int [usertype] *[assigned] inc
 >> drivers/dma/bestcomm/bestcomm.c:305:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_tdt *tdt @@
    drivers/dma/bestcomm/bestcomm.c:305:27: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:305:27: sparse:     got struct bcom_tdt *tdt
 >> drivers/dma/bestcomm/bestcomm.c:306:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *ctx @@
    drivers/dma/bestcomm/bestcomm.c:306:27: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:306:27: sparse:     got unsigned int [usertype] *ctx
 >> drivers/dma/bestcomm/bestcomm.c:307:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *var @@
    drivers/dma/bestcomm/bestcomm.c:307:27: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:307:27: sparse:     got unsigned int [usertype] *var
 >> drivers/dma/bestcomm/bestcomm.c:308:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *fdt @@
    drivers/dma/bestcomm/bestcomm.c:308:27: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/bestcomm.c:308:27: sparse:     got unsigned int [usertype] *fdt
    drivers/dma/bestcomm/bestcomm.c:311:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] * @@
    drivers/dma/bestcomm/bestcomm.c:311:35: sparse:     expected void volatile [noderef] __iomem *d
    drivers/dma/bestcomm/bestcomm.c:311:35: sparse:     got unsigned int [usertype] *
--
    drivers/dma/bestcomm/gen_bd.c:169:25: sparse: sparse: function 'bcom_gen_bd_tx_init' with external linkage has definition
 >> drivers/dma/bestcomm/gen_bd.c:145:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
    drivers/dma/bestcomm/gen_bd.c:145:22: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/gen_bd.c:145:22: sparse:     got struct bcom_bd *bd
    drivers/dma/bestcomm/gen_bd.c:229:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
    drivers/dma/bestcomm/gen_bd.c:229:22: sparse:     expected void volatile [noderef] __iomem *a
    drivers/dma/bestcomm/gen_bd.c:229:22: sparse:     got struct bcom_bd *bd

vim +98 drivers/dma/bestcomm/bestcomm.c

2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   48
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   49  struct bcom_task *
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   50  bcom_task_alloc(int bd_count, int bd_size, int priv_size)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   51  {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   52  	int i, tasknum = -1;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   53  	struct bcom_task *tsk;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   54
9560aea4e9d17c arch/powerpc/sysdev/bestcomm/bestcomm.c Grant Likely       2008-03-22   55  	/* Don't try to do anything if bestcomm init failed */
9560aea4e9d17c arch/powerpc/sysdev/bestcomm/bestcomm.c Grant Likely       2008-03-22   56  	if (!bcom_eng)
9560aea4e9d17c arch/powerpc/sysdev/bestcomm/bestcomm.c Grant Likely       2008-03-22   57  		return NULL;
9560aea4e9d17c arch/powerpc/sysdev/bestcomm/bestcomm.c Grant Likely       2008-03-22   58
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   59  	/* Get and reserve a task num */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   60  	spin_lock(&bcom_eng->lock);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   61
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   62  	for (i=0; i<BCOM_MAX_TASKS; i++)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   63  		if (!bcom_eng->tdt[i].stop) {	/* we use stop as a marker */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   64  			bcom_eng->tdt[i].stop = 0xfffffffful; /* dummy addr */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   65  			tasknum = i;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   66  			break;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   67  		}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   68
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   69  	spin_unlock(&bcom_eng->lock);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   70
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   71  	if (tasknum < 0)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   72  		return NULL;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   73
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   74  	/* Allocate our structure */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   75  	tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   76  	if (!tsk)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   77  		goto error;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   78
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   79  	tsk->tasknum = tasknum;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   80  	if (priv_size)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   81  		tsk->priv = (void*)tsk + sizeof(struct bcom_task);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   82
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   83  	/* Get IRQ of that task */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   84  	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
aa570be6de67f3 drivers/dma/bestcomm/bestcomm.c         Michael Ellerman   2016-09-10   85  	if (!tsk->irq)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   86  		goto error;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   87
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   88  	/* Init the BDs, if needed */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   89  	if (bd_count) {
6da2ec56059c3c drivers/dma/bestcomm/bestcomm.c         Kees Cook          2018-06-12   90  		tsk->cookie = kmalloc_array(bd_count, sizeof(void *),
6da2ec56059c3c drivers/dma/bestcomm/bestcomm.c         Kees Cook          2018-06-12   91  					    GFP_KERNEL);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   92  		if (!tsk->cookie)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   93  			goto error;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   94
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   95  		tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   96  		if (!tsk->bd)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   97  			goto error;
adec566b05288f drivers/dma/bestcomm/bestcomm.c         Anatolij Gustschin 2021-10-14  @98  		memset_io(tsk->bd, 0x00, bd_count * bd_size);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16   99
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  100  		tsk->num_bd = bd_count;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  101  		tsk->bd_size = bd_size;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  102  	}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  103
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  104  	return tsk;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  105
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  106  error:
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  107  	if (tsk) {
aa570be6de67f3 drivers/dma/bestcomm/bestcomm.c         Michael Ellerman   2016-09-10  108  		if (tsk->irq)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  109  			irq_dispose_mapping(tsk->irq);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  110  		bcom_sram_free(tsk->bd);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  111  		kfree(tsk->cookie);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  112  		kfree(tsk);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  113  	}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  114
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  115  	bcom_eng->tdt[tasknum].stop = 0;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  116
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  117  	return NULL;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  118  }
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  119  EXPORT_SYMBOL_GPL(bcom_task_alloc);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  120
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  121  void
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  122  bcom_task_free(struct bcom_task *tsk)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  123  {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  124  	/* Stop the task */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  125  	bcom_disable_task(tsk->tasknum);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  126
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  127  	/* Clear TDT */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  128  	bcom_eng->tdt[tsk->tasknum].start = 0;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  129  	bcom_eng->tdt[tsk->tasknum].stop  = 0;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  130
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  131  	/* Free everything */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  132  	irq_dispose_mapping(tsk->irq);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  133  	bcom_sram_free(tsk->bd);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  134  	kfree(tsk->cookie);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  135  	kfree(tsk);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  136  }
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  137  EXPORT_SYMBOL_GPL(bcom_task_free);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  138
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  139  int
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  140  bcom_load_image(int task, u32 *task_image)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  141  {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  142  	struct bcom_task_header *hdr = (struct bcom_task_header *)task_image;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  143  	struct bcom_tdt *tdt;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  144  	u32 *desc, *var, *inc;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  145  	u32 *desc_src, *var_src, *inc_src;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  146
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  147  	/* Safety checks */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  148  	if (hdr->magic != BCOM_TASK_MAGIC) {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  149  		printk(KERN_ERR DRIVER_NAME
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  150  			": Trying to load invalid microcode\n");
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  151  		return -EINVAL;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  152  	}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  153
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  154  	if ((task < 0) || (task >= BCOM_MAX_TASKS)) {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  155  		printk(KERN_ERR DRIVER_NAME
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  156  			": Trying to load invalid task %d\n", task);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  157  		return -EINVAL;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  158  	}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  159
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  160  	/* Initial load or reload */
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  161  	tdt = &bcom_eng->tdt[task];
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  162
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  163  	if (tdt->start) {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  164  		desc = bcom_task_desc(task);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  165  		if (hdr->desc_size != bcom_task_num_descs(task)) {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  166  			printk(KERN_ERR DRIVER_NAME
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  167  				": Trying to reload wrong task image "
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  168  				"(%d size %d/%d)!\n",
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  169  				task,
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  170  				hdr->desc_size,
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  171  				bcom_task_num_descs(task));
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  172  			return -EINVAL;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  173  		}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  174  	} else {
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  175  		phys_addr_t start_pa;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  176
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  177  		desc = bcom_sram_alloc(hdr->desc_size * sizeof(u32), 4, &start_pa);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  178  		if (!desc)
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  179  			return -ENOMEM;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  180
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  181  		tdt->start = start_pa;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  182  		tdt->stop = start_pa + ((hdr->desc_size-1) * sizeof(u32));
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  183  	}
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  184
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  185  	var = bcom_task_var(task);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  186  	inc = bcom_task_inc(task);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  187
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  188  	/* Clear & copy */
adec566b05288f drivers/dma/bestcomm/bestcomm.c         Anatolij Gustschin 2021-10-14 @189  	memset_io(var, 0x00, BCOM_VAR_SIZE);
adec566b05288f drivers/dma/bestcomm/bestcomm.c         Anatolij Gustschin 2021-10-14 @190  	memset_io(inc, 0x00, BCOM_INC_SIZE);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  191
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  192  	desc_src = (u32 *)(hdr + 1);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  193  	var_src = desc_src + hdr->desc_size;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  194  	inc_src = var_src + hdr->var_size;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  195
adec566b05288f drivers/dma/bestcomm/bestcomm.c         Anatolij Gustschin 2021-10-14 @196  	memcpy_toio(desc, desc_src, hdr->desc_size * sizeof(u32));
adec566b05288f drivers/dma/bestcomm/bestcomm.c         Anatolij Gustschin 2021-10-14 @197  	memcpy_toio(var + hdr->first_var, var_src, hdr->var_size * sizeof(u32));
adec566b05288f drivers/dma/bestcomm/bestcomm.c         Anatolij Gustschin 2021-10-14 @198  	memcpy_toio(inc, inc_src, hdr->inc_size * sizeof(u32));
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  199
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  200  	return 0;
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  201  }
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  202  EXPORT_SYMBOL_GPL(bcom_load_image);
2f9ea1bde0d12d arch/powerpc/sysdev/bestcomm/bestcomm.c Sylvain Munaut     2007-09-16  203

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
