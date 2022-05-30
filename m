Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453675373BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 05:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiE3DjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 23:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiE3DjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 23:39:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB0719E1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653881955; x=1685417955;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KehZANxrPj0+D87teFNBUyn4jB7tpO4HexETx05RpEM=;
  b=lXtKzPZYSgnvUXDI7IVh0BaMy2GS9XHdkT4T7FKvCpm+93oIi1WiZ5h/
   EppI0IUSLYdzrukwfPu1YOqX60O+l+rNZohd21gcTnBhnGS4s9txz81T3
   cqJE/nYMVa3c7pVBDeRR+xQbj8vvYQzFw16POgY8YRxsaGBLyGj18ltxg
   AXrF33MK8Mma6HJEH2C5MZFCrVJZA/kv8uV9sZqD+acqYIfHW5PG+LT1x
   frisfYuj0wDp+ySFsShhOA52e7tW+NtwxqAWdUMtZxEq+1yX7fn8574PZ
   wN5bAiEt2IyOM+nnsUHjo40ZecFLpUB1UoNs3NDQABFOAusyvJu+kuv3K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="254758272"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="254758272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 20:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="719719207"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 29 May 2022 20:39:15 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 20:39:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 29 May 2022 20:39:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 29 May 2022 20:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbsm5RJLZwzTLa/TvJT96wcl4XQXoZ+StyxCUkH1ex/KNMicKm+VJuG0IW0oP1nyQ8HDo7ttJAxt89fZ9+49LT9T7u/YlMe1V+C4NJMChhv9qXBwMlpKr8YY4wdtbw8m9wGxzGdQo6E+VBQC8aXIadh4C6XKPMrUia080+vey81MsUWnMe7XkbB/nlSXscXOuclUg9PM/tXi7JhCY6oprDSFjt4V84AzIorVPmZOrXsMQA3vOJ2vZS+tqc10EQxaEIFaT9o+8VI3PaOCaOAC9QTYHYsdAxrgMpRBiDvwOU6KXDJCuURVzwsnMYmLD+PzSUlQExDg7apYSklYA/i2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWHv5zC3lDpxSaKAURryv52sKolVLYwFv8M0z8q4aAU=;
 b=JfKGN0voCXVh3bfJKldERb6pk5NJDPDgOduS4iAeyszd9+Nqj8oRp8HN8AveDkRZrdUju7SdVHwYYFuJ27U6svA6/OvlsllP1cOnsbpsCpui+HwFjHM4lgLNTomIV3mkk6LiyU9yJ9Wb2WqVD+NdVJMoe8igWMw/6mh9h7KbsIgoLNoyBZ1w+iQXTwqYwS5vMMRb0oCivOex3JfdLWvYKWjQf3dBWZ2Huk2/pGu4nkEuXrrz1YmK5txfoxdZJbCKg9I3aAq87aT9Wcj/pZUFbRwF0zUWZL1zMOlyXqh9ZOP1YHCkYxjcU51jumt4hu0BBr0OsqFclWgsc16jU/CRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by MWHPR1101MB2175.namprd11.prod.outlook.com (2603:10b6:301:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Mon, 30 May
 2022 03:39:13 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%9]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 03:39:13 +0000
Message-ID: <5c931c7c-323f-8a84-103f-7fa2cbede773@intel.com>
Date:   Mon, 30 May 2022 11:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: drivers/net/ethernet/intel/i40e/i40e_main.c:4643:2: warning: Value
 stored to 'pf_q' is never read [clang-analyzer-deadcode.DeadStores]
References: <202205271213.1X7QjLjM-lkp@intel.com>
Content-Language: en-US
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205271213.1X7QjLjM-lkp@intel.com>
X-Forwarded-Message-Id: <202205271213.1X7QjLjM-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2141641d-24b4-403c-751e-08da41edf69f
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2175:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR1101MB217551CA1F3EBF0C6409A7A0FBDD9@MWHPR1101MB2175.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5RnFfsIH3UY9vOHapTKfvtt3PA+SkMpL1EqM4oa6TeXqbnw8hUsW0DcQC0GnkSYze1Gwj21vlwa6UU4ScNXVbmOJVvqj6DDrc1F8QNHMrLcLURPPQcITRY79Cz7Dnt0CCVlhY5nlmEf+qmo1JxCijR6Va0aiIs7H9MM5M9CXknQ2ByOX2A8Ybl9G/2XtsMJ/wHtp6xv7J1qeF+f86Tb6+t14IMWWcdX9HSXyyjelI3YTTPZoFuh6ROMrUaE5yrxOzdIz3gRITzZFQORmCuAMMSylcoMG+3Cns2mTpq5afuS/LbekMCbhPjoEoWauDH137erIqUigYA8sg0E+a3pQB5QvpxtTAfnIABlckHrWzA7g38gvgmX11T4tRnkgGYVKszjgKsOsSi3PA9AbBKM1w3O8l9DJ7K1G3MMhGQrZSGQISrOiqwqmyxk/Di7Ghc8GjxhM2iamRO6elAlk3aa52kyXB28XWkOWE4hGxBdPFuyUGed6PKIzSUBNgFTLoRBpHyc5mklm/EP0ZQewJVidr04lLzWDKGcMBZkJexv71orCZxDs0wwrAamgpT2Z0HH1YUJooXYB+i1Nh2ShjRGWpoZX++Ec344SKD48RtzzjJd8dHa+Elq2RBtiV76GKrh0zd6vQ2b9Y2fcVkUdt09d7QE1K0qy49QC9sScOnSaeGo9KhJsPzXV4Jt9V3dneNNrYkePqM7IpCDDr0VtJviijL/tK+3AxAxkVatVwK4Lwb/uRBGqiMRgb7141N14GRvRB2AtEXPxOAbR39BX3I/IuuYE7efQxoVB3fCbhOwdNX8uV7BYnv1epicmRINrsarpPh/bhC83YEPuH7N4qjmeO67CpzFdLdEzlY5/3hR39s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(186003)(6486002)(2616005)(6512007)(8676002)(107886003)(31686004)(36756003)(966005)(86362001)(26005)(82960400001)(316002)(6862004)(4326008)(31696002)(4001150100001)(2906002)(6636002)(54906003)(6666004)(83380400001)(508600001)(37006003)(8936002)(5660300002)(6506007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpqK3VmbjJsNlZFMmFncFFIdnh1cmJCZ0VBQldpL0Qzb2hvZUlpUFlVZk9y?=
 =?utf-8?B?dFdJMVpLYmhtSTR3WExmOS9MNEpXYUJxN1R6ZFNLak9vTlBhVjlZU1BveWpT?=
 =?utf-8?B?MCtYWlRDWGl3aFY0OHNrM2ROakdvNHVuSW5QdnNKQmNVaEwxemlNR1RKUzdh?=
 =?utf-8?B?U01DS2drc2VTNEE2ZHZvajJsUkFMaXZNeEJPeENDemx6bTFwRk5DTjVHUWlv?=
 =?utf-8?B?ZS9nanZ2L1pMMmFHSDU4UVlxNERKNktaOWNUK2R6MlRadU8xSStZd1JzV2Zm?=
 =?utf-8?B?YlJKWFAwMngvYklSRE44WkxJOUtJYzhsWEpCYS90TTBMWWFhc0RHSDREeExa?=
 =?utf-8?B?MFBqU25NR200RG1oUUVLSjNvM3FzcnJ4ZGw2NGd1TTdET2pOaG9Fbk9CRFcz?=
 =?utf-8?B?ellGK0ZjWVFmeHRiS3B4eXFvVFRvNjRpaW41ZGtKSnNMckczam9LYmdDendP?=
 =?utf-8?B?elRtdGxHZjBYYWh6U2JmVlhFeDFkN2MzVWc1QmlTZEdzbENtQVBKaGZwNUIz?=
 =?utf-8?B?UDJna3hVVkhXRFZadkRJeDVjTnVsUDVjQ05LZGhxeEVYVzZMc0JzTGJ5RlpZ?=
 =?utf-8?B?cXhGMEVPUXloTitRSUtDUk4zUnZxK2xGbXFOOEpCckMvcmpTOU9YcE1xYnFh?=
 =?utf-8?B?L25INWxjbWIvMTVSYUk5TSs3bFR6SlZWL1hjbHpJR2FVdWlNcnhoQ2ZoeC9I?=
 =?utf-8?B?MzVKdVZ3THcyRTNrWEJsS2tjTmM4aE1xZEJSSWM2bGY4aytkMEw2eFBsR09T?=
 =?utf-8?B?M0NHMnJaQVpSWlBBNG9qdTZOWXBMNnpIS2lvN29XbzdsV0dHM1Nyb2FyMUFP?=
 =?utf-8?B?R0l4M0Q5cTkrWndjanludXY3QnhRVnhMS1o0UURESklzQWdiQy82V0lJTTdn?=
 =?utf-8?B?Ni9hT3lwYnJFNXREU0xIOEI2OXVOZUlLY0srWU03UHJ3QmFncC9KUSt0aEpU?=
 =?utf-8?B?Qzc2UmhnYkhzWUhmYmgydHh4L1NpVG5ObVdJb1Y2UzdUT3V3dEtkZzZNc3Y0?=
 =?utf-8?B?WklCVkQyekxXMzFIUFVpMGJKR05kYU1EVmVRZFVpb2dGYklkQ2xpVzhFQm4r?=
 =?utf-8?B?YmVsNHVFZFdBWEp4dncxWXVUblhpYStBZ2ZUT1BUQlExSDA0RUZMSGlFd0ls?=
 =?utf-8?B?VnprSXo3QUg3V0R6N2NqODB0WXo2ODFIblhjSGxIMHJ0alBVU292aFBzTUZj?=
 =?utf-8?B?VHBOZEY1Q0J0THRVbkdkdGUvdXpiOUFzbkJKTTlVbXZlbGh2Vm5oZStzOG85?=
 =?utf-8?B?UFNqSzZOVEtiaGF0VUt4dCtuUm00Yms1TUZHWUkxbTg1RHNxME5QZnNGRDA4?=
 =?utf-8?B?QWFDa0FHT0tNVGREZXJrdWxLZlQwZnk4UXdJR0RnVVpLTXhMMGpTMnpRWnpQ?=
 =?utf-8?B?WVZlK0NNclBDTHNpem5adVk0S1RqRTFlQ0RBOUVLTDRLN296TDlsYmJLakhr?=
 =?utf-8?B?WHM5M1lVWGRhNkU2dEhEeU1zTTF1UzlSSlEzcFREREI0aDNLaXpyL2VEUTNj?=
 =?utf-8?B?MEtNdUhhT0YrTVBHUGd3NnQ1bWxGemFLMWR5amMrWjAyYSttc2lEMGtCc2Jq?=
 =?utf-8?B?dlV6UTczK3VFQlZRK0QySzQwd0NWenJJL0hkaTBGRzR2L1lPU1JadzIydGVB?=
 =?utf-8?B?eTFYVi8xbGlqY3kxQ3puY3pHblA2cjQzVlRXTnFOU2lmZlVJMnRhdkpnOGRT?=
 =?utf-8?B?LzNrNkFTZ0RlbmRTN0FkcHJjNmtzUHlDdTFkeUFNV3pLSG45NC9PZWdTR2ZX?=
 =?utf-8?B?VzgrSURQUG5nYTU3TU9oU2F3UXFFcnM3VGNaK3FSTkdtMUNRaFNDbjRvbjFX?=
 =?utf-8?B?ekFWNk5sbXJBaFAvdHJ3dWtJcEJVdHBTSFlTSUQ2RkVPME5WUDIrRmRyS0Nw?=
 =?utf-8?B?NWl6SEJVRWN6TVNTbUU3NFRqdGVlZWRSY0VZUUVXdGpwWWloVkNHRFpicERy?=
 =?utf-8?B?VlZWZm5ZMkpscERubkNsLzdWd3orUjVWZndJaDY2N0d5YUN2eklDaFNjVCt6?=
 =?utf-8?B?MGYyUnpQdkR5L095Q0hzcHUweXFJMzloTG1SaUZPZmk3ekRGNHdFTjFqeDhY?=
 =?utf-8?B?OEYwSUZXOVNza3R6dXF6NWNETkV5VGlTMk5WcnFoUzZpclJxZE4rOWIrTUpC?=
 =?utf-8?B?MmpnUXFpOUU3UWgxN0FrRytoQmExay9uOTVDU010aEVad1ozNWZ4QTY0TkpU?=
 =?utf-8?B?cXlIbm8rd1FZRXRxbTMzVGNsbXpIWS9pZUxWSm5wOTJOdXp3WWgxV1BQcW1r?=
 =?utf-8?B?VHdTQ0tCckoyV0hySEZZR2Zxd1RTcTY2VGZ0czhGdWZySW93VFBFaVA3REFl?=
 =?utf-8?B?aWFVaFBhdldBWUZlRWZYUEZVKy9tRG8zaEgyTDl0ZmNIdVAxYnYwdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2141641d-24b4-403c-751e-08da41edf69f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 03:39:12.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l75Idl1pOayOwrYotNvMhdbbIGxxZ1QkXXCFQkFHZvzYxyrTM1RtaZbpua2kifSp0A78DIXhwQ7xN0HWdajVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7f50d4dfe816dd916a7cbf39039674825c2b388b
commit: 65662a8dcdd01342b71ee44234bcfd0162e195af i40e: Fix logic of disabling queues
date:   10 months ago
config: arm-randconfig-c002-20220522 (https://download.01.org/0day-ci/archive/20220527/202205271213.1X7QjLjM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1443dbaba6f0e57be066995db9164f89fb57b413)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65662a8dcdd01342b71ee44234bcfd0162e195af
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 65662a8dcdd01342b71ee44234bcfd0162e195af
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/net/ethernet/intel/i40e/i40e_main.c:4643:2: warning: Value stored to 'pf_q' is never read [clang-analyzer-deadcode.DeadStores]
            pf_q = vsi->base_queue;
            ^      ~~~~~~~~~~~~~~~

vim +/pf_q +4643 drivers/net/ethernet/intel/i40e/i40e_main.c

65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4616
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4617  /**
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4618   * i40e_vsi_stop_rings - Stop a VSI's rings
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4619   * @vsi: the VSI being configured
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4620   **/
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4621  void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4622  {
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4623  	struct i40e_pf *pf = vsi->back;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4624  	int pf_q, err, q_end;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4625
3480756f2cb93c Jacob Keller         2017-04-13  4626  	/* When port TX is suspended, don't wait */
0da36b9774cc24 Jacob Keller         2017-04-19  4627  	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
3480756f2cb93c Jacob Keller         2017-04-13  4628  		return i40e_vsi_stop_rings_no_wait(vsi);
3480756f2cb93c Jacob Keller         2017-04-13  4629
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4630  	q_end = vsi->base_queue + vsi->num_queue_pairs;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4631  	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4632  		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4633
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4634  	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++) {
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4635  		err = i40e_control_wait_rx_q(pf, pf_q, false);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4636  		if (err)
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4637  			dev_info(&pf->pdev->dev,
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4638  				 "VSI seid %d Rx ring %d dissable timeout\n",
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4639  				 vsi->seid, pf_q);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4640  	}
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4641
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4642  	msleep(I40E_DISABLE_TX_GAP_MSEC);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29 @4643  	pf_q = vsi->base_queue;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29 @4644  	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4645  		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4646
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4647  	i40e_vsi_wait_queues_disabled(vsi);
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4648  }
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4649

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
