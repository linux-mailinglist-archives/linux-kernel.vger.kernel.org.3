Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBF4E8D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 07:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbiC1FBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 01:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiC1FBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 01:01:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A617A94
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648443598; x=1679979598;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ItKVeN4kQ5zqSlKbMRK95RjmRwNynHEFDdYPfqUO3vo=;
  b=OYVknlkgdyEYcmGXAmmoSzznGRN4qMBoiY6IRMBxTM7ISw/cA74kE2mu
   uisWl6HvWbx2FnQsmiXIdx9KKOqZR/G1I9clZ3akHuXQ/qEzIot98/eD/
   QzX/ib4hxhTNgKCBh3Nv3yW6SWhM9oGfyf6FxMuMFnUGwY02VcoN9fa0d
   BGe7BArR1kW3yE0Mj11tIsfZK6zXz1NhYlpU9zmXZ6T/jTHP/CQ8pcAcM
   XmQyUADsyBjnkzs15sxG6c25sJrCA+w4cDt8nWxvQYzIhn42m0iYvVniv
   TH5GR+1WW0jFOTghNFlRV4QexpBtMC/7C3WX4rF46tBSLV3sJbp3k4ebH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="345347459"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="345347459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 21:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="563246755"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2022 21:59:56 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 27 Mar 2022 21:59:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 27 Mar 2022 21:59:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sun, 27 Mar 2022 21:59:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM9DH0uz/7VI2a4Yh16YeZTqe19y6qMT2y/Lfh9xznMPXs1cBtLBvvlMUIW8jowmRIOdrypW0OVSg0lJnpqokB6FgU0OLA6iz4I5CMhtKqSITApYEi3FklwMqPBo1c5qqkcauI234X467rf6z/K7NeFaEEh6CGWC7E5iSG9CRSSwPS63m+0pguLjtAoU24Hf1EDNzddPjELGuscHL5QEPOM39DajKzjMAPhRM7jx/rfF8sWnqvU6mkP5U/PVk2JaIDR9HjRCgGV/ByhtQ50SAnwIoLO8KWl5mlrEiPthOEkfSFL0gOTRUP/7NEXtrNjdDxpX7K4squuUVIuB81q4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jlp/FIEhU1OsAgzC/VX8Rk299SL5B4cLhRrn2X0si0=;
 b=iWirDrn1GUAMD5zw2+6GZKqRagjO4HcDrfIwRXS51Be8rpb+zkgeDsHDr78c/Bxgj0SJsjim6xiUQ5ZKqp5QkEdxx0AM/DP5EUJeqdH3qPWChCIhJw7kSLuP5DrKtV0V47tYwicqa25m4EjOEfOwF0c+QWnj2BvhE4KYfVgCz7V5inNr5j5oJ/UQY1G4his3bTZuSWfr/NwlqkdAN8Hauvc/A51XNg4uC0YtojqukA8wK8HURVFXT0YwsCEhzQnqG/hcDeQTj1aHv2f+sQJvDdpJCZBoK7TZ01Kc0WREcYS7nuUZh/279jVCTNyMDY0W8oD5fuR2fA0UpNIq7eW1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BN7PR11MB2595.namprd11.prod.outlook.com (2603:10b6:406:b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 04:59:53 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 04:59:53 +0000
Message-ID: <0daa1ccb-3ca1-480b-9965-62f62342f901@intel.com>
Date:   Mon, 28 Mar 2022 12:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: [drm-misc:for-linux-next 2/3]
 drivers/dma-buf/st-dma-fence-unwrap.c:148:4: warning: Value stored to 'err'
 is never read [clang-analyzer-deadcode.DeadStores]
References: <202203270435.TtRcG3Pv-lkp@intel.com>
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203270435.TtRcG3Pv-lkp@intel.com>
X-Forwarded-Message-Id: <202203270435.TtRcG3Pv-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd74644-d03d-4e09-dfd8-08da1077cbe8
X-MS-TrafficTypeDiagnostic: BN7PR11MB2595:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB259566AF16F60AE92F064598FB1D9@BN7PR11MB2595.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZX44HU3xA3T/gboTfzX2JhsE/hS4coJNIte7hyzu1CHYgsdExW3Eqt4gAHCFdi475CmId9kV9lLbjY5BWPRyAkjMAkACMKpPa37XrRf2C7fB4YEnf14BYlLmS6Nx+pZE0aGzktzUFAoGsLT0XVUpTluUcU0HtRfJtnNgzAa9MUX/342+oIwJ1bXz7G/LvkWprWwc2uIYORA8okwjf76a3OYpWzlHoeF7iabjBr2u7PW9Fy6fcajkwkeTxgUe3AHdbGqIAaIvDbEH1S1xW4kzteaOPl6lZgutTPLjNqPzO49dEJU22hdT3l5GIjCreXiKfWe2ANfH+dGFS6r/n6FsKUUukUTNKKSlSlMv/mhidBf1yqU8qj9sd6aBlBrJNmRuEPv/2J1Z+jPeBiEzKC96oOmHmidreFNGd4V0b0XAaqEpo61oloRUOqFzrlW6jGiQTSxtJRssi9JT+1eDgr1ibaTdB+3M6XUPQ4qmZ7cJK1gNLX+0RfHzA9A0f0USaNdPOo52JEqQgQ9lDqLQO4bPdrUSpxTYNgNukWk3cNcM+18wKvBbQ2/sYRNCssd9EUKAoL/Y4ojqA85YVXPp+XH77pXb8nsXjS3RS5/6r7k8D/XFAxy3/29vTB7JURC+Uv26Oq/tuohg3bUgb19EoPqQJH29JBlYa0h//C/lWVWpX+hjIjkJUA4peQc8wZiai5Ma7SMvcXu+zku6LcEx3SKXKZoaa42S+YyJuqqyiQE/G8QYGZg6cJ46wJzfm1Q5s1q4xLZYOAnKnRkWUtmFaoCdtQi+ZGlUOhcd3+OBuOSEHDW5Zmlo9ydbqMBkhhgqUViGs0DGTRqleWAnBw1BVEZmqkRNgMuGonmveNw645n+kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(83380400001)(6486002)(54906003)(186003)(6916009)(2616005)(966005)(5660300002)(31696002)(316002)(36756003)(26005)(66574015)(6512007)(38100700002)(66476007)(8676002)(508600001)(66556008)(82960400001)(6506007)(8936002)(2906002)(66946007)(4326008)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZElrUDNNWTZ5VXdXbkg1c083b24xQ2EySk80aHhCek5HRHVERVpXTzRsQkkz?=
 =?utf-8?B?V0YvRVJwMnQ5RGU2dnhjcU1xVkpldFRKK29Ham43Z3V3N2NKbW1kZXVKZTFH?=
 =?utf-8?B?Z2QyL3BraE1sc3BTZkJLUEE2Z1FOdG56YUhtdmhzVUhERDdsT0VOZ2lMb1kw?=
 =?utf-8?B?ZGorRU5oTHlkL0x1dFRhbkxKcUw1enZsaS92c0t3bXlmNkREZk45am1xYkZE?=
 =?utf-8?B?am1KUlVjTlU1UWxiaVJQQTBUQXBsQWFlZU1LWHZWM1FwQitxTVpGZFFzTzFr?=
 =?utf-8?B?c2hmNUt4UUErN3Q2SG9jeE9LQzM5OUNBaDNWR0ZkaXRUQ0NsOExMVlV3WW5G?=
 =?utf-8?B?VEVZQTloazRsWFZRYmk5TS95RGVSL1V3Wk1OQ1JFekM1MUxYRU9jaUtGelpi?=
 =?utf-8?B?WmpiMWtrMDhwTjRpR3UvWmhGSWxIY053aGxRemZBV2dSeGkwTEd6QjZzWlVa?=
 =?utf-8?B?aklONUpPVlpHcVZiSStuWGJZY2VScDdQekdvT2x6N3MwOXFMUnE0b3MyRlRx?=
 =?utf-8?B?d0s2cUlXcEM5OWFzQWc2aGFncGsvUlM1Tm1ERzhaZjRET1JZbDFIT1Uybjc1?=
 =?utf-8?B?SEdkSzF5Ri9IMklNbnRacm5UZUVxZVdLQ2RIUjFxT1hRdlZMMTl3MW5SK2c1?=
 =?utf-8?B?ci9qeUEydWxpSUtDanAyZytQQ3haRERLZ3J2RklVTkNEYVdMbnFuRVNab3RY?=
 =?utf-8?B?VXdEcWw2VUdXRVcvcWxyNWVQdXgxc0lVMjZDa2xZUER0WkFmdHp2RUhWSFR2?=
 =?utf-8?B?VTFNcU5HVGNEbkg5RWx1NUZNV3dYVVhnckpueG9Vek51ditRbGRWckpUclNj?=
 =?utf-8?B?enM1b3ZwTXhRZnlENHI1NCtCU2tjYkJvWWIzTlBGczAzNjBhWFk5QWZxWUFh?=
 =?utf-8?B?Qis5dFhHS1ZVQ0hkMURWZng1MFFVK3k2cHJhTWd2aEp0eHZPK0ZTZ2NVRzZI?=
 =?utf-8?B?RnU4RXJINEtMQXZKWmtnZXEwZmdsdmV3eHVzOFNZVXNTYmJyUVU3cWtUWnY5?=
 =?utf-8?B?c0ZYbkRUV1IzQ2t2SlJ5Z3cvN05GRElkd3RqOFFSWUdVNkJjMGtsaC9uanFt?=
 =?utf-8?B?Rk4xNWNnOC9NaWRNZUpnVHB1bTAxaElYam5QRjAzcEZXVWw5UEJLSUlHbU0r?=
 =?utf-8?B?cjY0SlF0MjlWcDFKM0l0K1dsYkJnZ3lNWS9Td0FtY09xcDRhczFLMzFoMHN2?=
 =?utf-8?B?ME5oRk1YOW1mVFVSVVFzdXZzTFhEaU5OTjg4bTV1L09tTmdnd2t0d3ZEVkk1?=
 =?utf-8?B?eUNiYlBnNEVaWUlxaytYcWdXcnlYSHlqYzVCY0QyME5HWTFJNjlha0w0YXJm?=
 =?utf-8?B?NjRQOVV6MHRlQ1I1UUZiNVhoSyt5TzRPd0dZYUdPVUtCVUx0azcwNk93U2R1?=
 =?utf-8?B?S0dqL3A2dG1pZGdJUm9lMzJDdm8rY0pDeGVoazk0NUdYeEJ5aVo5TnBuOEM2?=
 =?utf-8?B?c2xyTTFPNmRxblNRNXVPLzBtZktMaXRqdkJkZi90YXVWQ2t6Rkg5STlwSkJ2?=
 =?utf-8?B?K0I5UVBVeHZrUGJKMmtUc0tUKzAxbm1xazU5YnNoT1RTRTJIRDlzT25mUXZz?=
 =?utf-8?B?QTZqTHpwZ3habFFSNWZEV3VOTnlJeGRxLzlJaVNmRlpIeGxxVEdJOGUxMmk5?=
 =?utf-8?B?bkxDazh4VkVRNC9selNUdytVa05vWm14bTlSOE5YWmNMYVA5SmgvZXRQWEps?=
 =?utf-8?B?eHplUnNNTktqRTVwZGdzbDB5SnZ5Zy95RWlETnBHTzR2bFVZQ3JKUEIzQ3JV?=
 =?utf-8?B?V1dCMmdtNkdEQ3ZvOGd2akYyYlVLNFRoVlRUMTZ2T2N5STAvT3NGR1Vtb3hm?=
 =?utf-8?B?R0xmbytlRDQreVVtRmhwVzhDTXBNb3VvWnVTN3dCQm9GSHY1OFU2RnV6VXYy?=
 =?utf-8?B?Z2ozbnlrWTlmWWcvTER4ZUd5UEZVMnA4WFJKUlk3SWxpbU9Va1lQV0tDbUJv?=
 =?utf-8?B?a2drb0M5WlpWY1pNS2l3ZG5lSHhpQVlUNDFVbmx2NTcrWUp0UHFTQTROMXBG?=
 =?utf-8?B?VUhTYlhJRCsxUEQ3YkxkNkE0WnZoQmdKTXdoS1B2Ukt0VCtJZEFFVGRXcU5s?=
 =?utf-8?B?QWZ2SHo4NHlLTVFDWllkWjlqRlhhdzR6RUpjamhNZ2pEMWZoZzE2R3FEUkQv?=
 =?utf-8?B?SFlGQTQxMzBkNXF4SjY5bHRpdExEdmFDOExhaDBNaE1wVU9hUUI1ajB0VHMw?=
 =?utf-8?B?T0FvcDMzT2EvakNJVnFZckx5NTdJVEFQb0wvekdna0tya1dpSm5SK1FCdVNu?=
 =?utf-8?B?UlhvR3dxaXZkSWVKNkREalkybnJoSWpVK1JCeHB1bW5zVUhNb2pxendxd0p0?=
 =?utf-8?B?RGE3ZkFzYkRmdTJUaGhNZUIxVGg2U1pBZVEwSkh5T1ZYLzBlRmFEdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd74644-d03d-4e09-dfd8-08da1077cbe8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 04:59:53.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qglcf+BM5nMQ/dDCoq2Rwp3mk6WQmnstlrlEyyR53o9TzHJpoYay3f5AkyB6iihklmQJL6ZV/vkTUy4kDUiK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   519f490db07e1a539490612f376487f61e48e39c
commit: 64a8f92fd783e750cdb81af75942dcd53bbf61bd [2/3] dma-buf: add dma_fence_unwrap v2
config: riscv-randconfig-c006-20220324 (https://download.01.org/0day-ci/archive/20220327/202203270435.TtRcG3Pv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv64-linux-gnu
         git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
         git fetch --no-tags drm-misc for-linux-next
         git checkout 64a8f92fd783e750cdb81af75942dcd53bbf61bd
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/dma-buf/st-dma-fence-unwrap.c:148:4: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
                            err = -EINVAL;
                            ^     ~~~~~~~

vim +/err +148 drivers/dma-buf/st-dma-fence-unwrap.c

64a8f92fd783e75 Christian König 2022-03-11  120
64a8f92fd783e75 Christian König 2022-03-11  121  static int unwrap_array(void *arg)
64a8f92fd783e75 Christian König 2022-03-11  122  {
64a8f92fd783e75 Christian König 2022-03-11  123  	struct dma_fence *fence, *f1, *f2, *array;
64a8f92fd783e75 Christian König 2022-03-11  124  	struct dma_fence_unwrap iter;
64a8f92fd783e75 Christian König 2022-03-11  125  	int err = 0;
64a8f92fd783e75 Christian König 2022-03-11  126
64a8f92fd783e75 Christian König 2022-03-11  127  	f1 = mock_fence();
64a8f92fd783e75 Christian König 2022-03-11  128  	if (!f1)
64a8f92fd783e75 Christian König 2022-03-11  129  		return -ENOMEM;
64a8f92fd783e75 Christian König 2022-03-11  130
64a8f92fd783e75 Christian König 2022-03-11  131  	f2 = mock_fence();
64a8f92fd783e75 Christian König 2022-03-11  132  	if (!f2) {
64a8f92fd783e75 Christian König 2022-03-11  133  		dma_fence_put(f1);
64a8f92fd783e75 Christian König 2022-03-11  134  		return -ENOMEM;
64a8f92fd783e75 Christian König 2022-03-11  135  	}
64a8f92fd783e75 Christian König 2022-03-11  136
64a8f92fd783e75 Christian König 2022-03-11  137  	array = mock_array(2, f1, f2);
64a8f92fd783e75 Christian König 2022-03-11  138  	if (!array)
64a8f92fd783e75 Christian König 2022-03-11  139  		return -ENOMEM;
64a8f92fd783e75 Christian König 2022-03-11  140
64a8f92fd783e75 Christian König 2022-03-11  141  	dma_fence_unwrap_for_each(fence, &iter, array) {
64a8f92fd783e75 Christian König 2022-03-11  142  		if (fence == f1) {
64a8f92fd783e75 Christian König 2022-03-11  143  			f1 = NULL;
64a8f92fd783e75 Christian König 2022-03-11  144  		} else if (fence == f2) {
64a8f92fd783e75 Christian König 2022-03-11  145  			f2 = NULL;
64a8f92fd783e75 Christian König 2022-03-11  146  		} else {
64a8f92fd783e75 Christian König 2022-03-11  147  			pr_err("Unexpected fence!\n");
64a8f92fd783e75 Christian König 2022-03-11 @148  			err = -EINVAL;
64a8f92fd783e75 Christian König 2022-03-11  149  		}
64a8f92fd783e75 Christian König 2022-03-11  150  	}
64a8f92fd783e75 Christian König 2022-03-11  151
64a8f92fd783e75 Christian König 2022-03-11  152  	if (f1 || f2) {
64a8f92fd783e75 Christian König 2022-03-11  153  		pr_err("Not all fences seen!\n");
64a8f92fd783e75 Christian König 2022-03-11 @154  		err = -EINVAL;
64a8f92fd783e75 Christian König 2022-03-11  155  	}
64a8f92fd783e75 Christian König 2022-03-11  156
64a8f92fd783e75 Christian König 2022-03-11  157  	dma_fence_signal(f1);
64a8f92fd783e75 Christian König 2022-03-11  158  	dma_fence_signal(f2);
64a8f92fd783e75 Christian König 2022-03-11  159  	dma_fence_put(array);
64a8f92fd783e75 Christian König 2022-03-11  160  	return 0;
64a8f92fd783e75 Christian König 2022-03-11  161  }
64a8f92fd783e75 Christian König 2022-03-11  162

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
