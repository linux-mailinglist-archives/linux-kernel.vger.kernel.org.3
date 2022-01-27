Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3549DAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiA0GlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:41:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:65117 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236758AbiA0GlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643265670; x=1674801670;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BuijASRn6CtoXp9Nr5PM8T0pZ9PmfzZNxrv0N9Hiwlk=;
  b=nXZtmF9He4aGz0Xh5BpQ5S3ryaCS1EoNUOxNyG1ir5cb+8Z5gnal3hc6
   4w5oxBqU4BGfNYFlNJ2EuOCHEoTH1Lr7evGvOEtfkcIuHZP4Rtp6iKWu0
   eBvf2hob/YNrkDhZRA9yo9EQpYaPT3IZNxZJFYFPBFDjBYNSBpCZEHlLz
   d9n9+R9Bs1S3bSCSOaB2BF9r0fxK8a44RZlwtiwEgDGZAleipTQYL5rUb
   jCGxRFjohbg8Kv3OtQZ16K+E9oSm8JU7ipSeahnrx0L423lPHCDraeanp
   Zl0WIffutzJfqIX0M+M1s2kntze87lyYrQjrC6AExJS1zh47C+NSfKxUU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246543684"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="246543684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521099275"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2022 22:41:10 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 22:41:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 22:41:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 26 Jan 2022 22:41:09 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 26 Jan 2022 22:41:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+A6oEDgtI3mvza3nXw0BBD2l/zllP/awLY1HeBX1YxQPQUhrRCtiI9txeSYFTP6cSrQsToeV54ocW2v2TLN+yaIngtYq3xVwSunICapKiOlE/Xpg2FweVT/J7oHBxCOhjwA1zdQK8mbE07HQVi32+Tn2QAm3HquPoOlZ4idqKqTlxz8MfsTXY2onxQC6imDv4UAA1nEfyscOLpERpzakaPyAKUxFLyx9BmdTcRyDVbWs2SGNHnA3k3+dmS1aeBMivDLqeNcUX6Pg4XTnXRx2vg6FjYR/f6QVRFjmtTNr8eAfcMUKzh0F0soz/H3QVwfInpBd70Je/58d5cKsKBFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjyQTF44CZZLss3kgBw8wVXB6QFjis+4rgdKDTT2f2k=;
 b=dXoHJ9Jg3RdWPuBz52rwZP1DBklIW73/8WA7u/tY+XlPNKzleJbQhJ9NAeWao1FkQt+1egT06Bi1nNPTFOQpVKD15PNS9BhHp/izEjIZ/nYzdW+hBaqk10F3MsLAFf10uiy+mwTwFNxm1qIXsnGJG5HxiTbGf74FFK1NMxNYul92MUb2Qaks6l9ezR1KYDvMk9zRmXGrO0ENy4Kopq2zucFtGWu1AjM9QnYGuGYZ9c/t48LA+B3PMcFJagIQ1SwbEKVaMUtOyCRM6zgzR2H8GariubANLsJ5RjimUP0LfJxTKwvPMoyYsBCegJxeIbE9z5KRMVyhFDnIM39NWHk8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by MWHPR11MB1822.namprd11.prod.outlook.com (2603:10b6:300:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 27 Jan
 2022 06:41:06 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 06:41:06 +0000
Message-ID: <1531501c-ec77-5219-8bd7-c9db3ae6f2fb@intel.com>
Date:   Thu, 27 Jan 2022 14:40:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: fs/ext4/super.c:5649:3: warning: Value stored to 'ret' is never read
 [clang-analyzer-deadcode.DeadStores]
References: <202201261659.dZZOrgxb-lkp@intel.com>
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Carlos Maiolino" <cmaiolino@redhat.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201261659.dZZOrgxb-lkp@intel.com>
X-Forwarded-Message-Id: <202201261659.dZZOrgxb-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:408:ee::24) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a8a712-098e-4aa1-dbf2-08d9e15ffe99
X-MS-TrafficTypeDiagnostic: MWHPR11MB1822:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB18226C454AC09BCD3455C1BFFB219@MWHPR11MB1822.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:124;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/jMyeTby0g6EK63lb6pdhZTbkqAiIF6HtZ8uunF8hGQ9O8Hych/lUWUI4jWRwzUuIaVvFtpNy6W7E2LHfxwP3l6n/AqSwAcH2msrKjc+SC0Iuo6QttOfFxQycrSQalEDjEf3GafQYsSr+dB0LSA7nZnmkxl9uRLzmpi+4y/wWlpA0H47Ua63xPIcbjfJugxocHgm1HDDMpNid7I08UUs8NqyR5GC48LXdiK9plGGqlm2fS3gd2RMP7fH/3t5oEbk7Vvfc3Oy42By0XmFv83n5SuQFtHHg4U+fTkn+8Y9gQcrNqQWu1jG49yokOb807MzIF8liRxRdiZMKSn9MAvXdoqJyq6zDuNaR4AqKHfcz90kBgicN95w9kceV0aInTIPjSfMNbaxdrDXlcDhLGhM2wgtjwB3mtfZXvq9t85G1/XzFOLXrJsPAgA0A6148bVZORHos0gM1SVDj4YMZrpE/p2VRj9N/m1qMgysl0lAl6/w4uzDzkSoprJXTJaDH2VKDn3wFAbpOHlvbr0SCBPeth3upzrTsU9K7ZsZfIojcsat04GMMoO5f2EgKWmhFY5DDhDm+6c1io9ZZliEaJFQ+MB0j0fZfSoF6gB2pX6NcbXrszYjVacvUbcqeL16ynfGeA0scBeBLtczvYFaQg712As6VSICxUFxV7H7gBUD9YZY0S52uwJ4nvqvEV9ZBQIZDgY9vvbdVM2lJdd81++YSACMxzWKTColNn1Lvs/feVtCbIK6SWfCK1f3YTkjFwUPgXgCCE3PMEjO2UhoAAyhpYZOaO+WFSp/YUoLwyPkkPPhtOBbDdyG3e40BbMC3Jb6xFSMRSfOsSKWBWMnjRURnbYTu7oOaH8vts7ZR4WUxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(508600001)(8676002)(966005)(36756003)(31686004)(2616005)(83380400001)(4326008)(38100700002)(31696002)(316002)(54906003)(6512007)(2906002)(66556008)(66946007)(4001150100001)(186003)(6916009)(66476007)(6506007)(6666004)(26005)(82960400001)(86362001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1o2M29mY3RmcDhWY2k1eml4Zi9xYUNmOWF3KzRidjFvd2dPc29BSjlZeThp?=
 =?utf-8?B?OCs3UkM2NlpqSTdLbTgxQlFyYksyQmhRZzNvT0VBUlc5Yjk4dDEvU3g2NVZv?=
 =?utf-8?B?NWMwMjFacm9kVkpVeHZINHYxTmRySkxIQ1U3aUk4aDhsR2F3L0QxTExDWWFI?=
 =?utf-8?B?RUdhMk5oQnhmZVpPTE1TVCttbEQvSGwxUk1xLy9hS3V4WGEzeTV5Um42bmhR?=
 =?utf-8?B?K00zNUpNSzRYd3dOVkcvSEVWZnpFQWZFSEFvTk5BVy9rOENWc0NlV08rQnJC?=
 =?utf-8?B?ZHlrTUZuemFqUm1SeXlsZEtKa0dhWkFBU3RLWnFjWU9ROCttZTVvYm9HVUhF?=
 =?utf-8?B?bTlHb3Z1ckU1VzJ4akJyRjBNSjNYRWRWc1o3Q1k0RGNXYmJVVk5QcmFYMTdM?=
 =?utf-8?B?RXVaWCszSlZvRjBUL0V6YWprdzkwS0syZkNQRnZHSmU1T1h0S2tFRTFmV1JK?=
 =?utf-8?B?V0R1SUZ5MWhlNkN2WU1vOG9saVlUbEhEd1ROV21jTFd3cS9iK0VzSEtMYWdH?=
 =?utf-8?B?RTZkbEpwdWVhRHBBWHJXNDMyL1NNaWM1ZDQ3Wi9zTkNpMklxVU13KzhnUms0?=
 =?utf-8?B?RGNOOFl1SktkU0c1dVhqeko3TC93MnAzaTF6dGpEcFRNM3JQL3pxSjdjZGlJ?=
 =?utf-8?B?cTBidVA3bmFxdkVRZmVZZGcxb0crem45Y0dUamZ4STlReE5tUmRIV25BVUpq?=
 =?utf-8?B?SFJ5T0hNaDF0ekhRbGFZaGJmN1dNdWd5Nm15VlFnZWg1V3hpcjZENFY3YjR4?=
 =?utf-8?B?STY1NzQrclR5cFJ6VnFpa3NDblZJV0twMk1sREFzYUdzcmZGVU8xaGNQVDlp?=
 =?utf-8?B?dVdEd3R4VGdCRWZGM0E0aHEyb29SVituZU53T1hRSDdkdVdOL2pDbGVISXd6?=
 =?utf-8?B?aFB5VVBPZ08xWXU4NVF5c01VdElXZWl1aGZiaDUrQ0xmWFFvS3Y3QWpoQlBq?=
 =?utf-8?B?RENiZDlVN29rdkZBYWxzMk94T0xMYUF2NTBiaEw3YXliekhRdWtHczgrb2w5?=
 =?utf-8?B?Z0Z5SlNWOUFRRCtYZElSODk3cGdXM0dlUTRCL0kzZHYxdU9SRmVjZitzMHBL?=
 =?utf-8?B?M296ek1mWnFGV1ppajJLaDY1V0Y0VVgzek9sK2hpYUU2THJSQ2xUQi9OMERZ?=
 =?utf-8?B?dEsvZjBPOEs0SENNNXFRTS95OXE1bWM1QS83TCt6cHVUTGJUOVJrc2VqWWlD?=
 =?utf-8?B?RXNVOUw3akx1Yi8yM2NEY1FRSDBqb0ZMb3dwZEh1WmFuem1GZWYzTnA2UzND?=
 =?utf-8?B?U3BIUFc1MExyS3YvZnZ2MmFzM3R3WUhwcGNpZWNOVi9lYlF6OWRHWVpsZ25R?=
 =?utf-8?B?aDM1TFNQUW9wbytIdXlxUDRrQlA0NytUeXBjd2krNWRJcGtCWUlmdEVlZ0l0?=
 =?utf-8?B?aGlpbFNuSDBKdGw2RHFETitTSUxOUk5uWWplQnlacVBHNW5FWndHbHFtZjFp?=
 =?utf-8?B?Zit6amVjaGEwZzNKWjdKQ2FTMDJQaERaV2ZqWS8xcmdUc1VMeDZKTjZXdldF?=
 =?utf-8?B?U3RrV3FtMGhtTzlTZWlKSUoxL1dvTkwvc0tiZk9HVnV2LzBpaDByazBkQWI5?=
 =?utf-8?B?MzVad0Y5dHVwNmVwZ3Vwc3d3cGJXKzd5QXJLS1d3QkhQNnkyV1c1QXh2dWhC?=
 =?utf-8?B?YTIxTGZwckpIUkY5b05lc0N0TnFVWDZJbERoNEhnOHMvcHlTNmN3OGJJVFNh?=
 =?utf-8?B?RStsMXlRaUMzV2VkRnZQOVRSek9SNDhzaS9HZkF5TnpoMDZkUUNmZVM2SDhy?=
 =?utf-8?B?QTdsRmw0NjZFSi9IYWw2ZllZcE5HM2REbVFRazN2Z25xMjZBaHdkSGxxaFI4?=
 =?utf-8?B?WGVWRFZqV3ZLYlZwWGVZN3phUVRiTE1DbGNFZjJzSlJET0hKMEl4NkVGT2My?=
 =?utf-8?B?SjgyNytvZ2h0Y2I2ODlLUWlyTDVlWDV0T2czTW9zRmZjNEJMdFB0ZFk0OHN3?=
 =?utf-8?B?RGRlcmNWNmZ0bk5RMDYrY2p0dFF4Z3dtZ2hiWTcyZGRDR1ZyeHU3dkFjYVg5?=
 =?utf-8?B?NG5wUzFXcGxXQm5Lb0VLSEhJaHE0alVyMzBjQUx4eE1ybDV4QkVKVkFXWjg4?=
 =?utf-8?B?Vy9ITHFWK0FrRzgzdWlDUDB1VXdzSmloMmVTeDQvRlNyZDVXd041TWJkMElL?=
 =?utf-8?B?d3UrRENneGg3VUh6aUlQWlIvVjNyUmJZMU9JRXdoMUprTTJaRHAzVVNHYmR4?=
 =?utf-8?Q?D/ECKhlGLteb/1RA0+xKwds=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a8a712-098e-4aa1-dbf2-08d9e15ffe99
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 06:41:06.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+t3iYkHBhpy2k27/J9haxtrYYOCRAS87B26gczUzQi2g9R0JJReZPh6/WQtyGO+1I3gTiVnL02mjVr/anRXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: cebe85d570cf84804e848332d6721bc9e5300e07 ext4: switch to the new mount api
date:   7 weeks ago
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220126/202201261659.dZZOrgxb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cebe85d570cf84804e848332d6721bc9e5300e07
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout cebe85d570cf84804e848332d6721bc9e5300e07
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/ext4/super.c:5649:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                    ret = -ENOMEM;
                    ^     ~~~~~~~

vim +/ret +5649 fs/ext4/super.c

ac27a0ec112a08 Dave Kleikamp 2006-10-11  5639
cebe85d570cf84 Lukas Czerner 2021-10-27  5640  static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5641  {
cebe85d570cf84 Lukas Czerner 2021-10-27  5642  	struct ext4_fs_context *ctx = fc->fs_private;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5643  	struct ext4_sb_info *sbi;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5644  	const char *descr;
cebe85d570cf84 Lukas Czerner 2021-10-27  5645  	int ret;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5646
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5647  	sbi = ext4_alloc_sbi(sb);
cebe85d570cf84 Lukas Czerner 2021-10-27  5648  	if (!sbi)
7edfd85b1ffd36 Lukas Czerner 2021-10-27 @5649  		ret = -ENOMEM;

can use "return -ENOMEM;" here

7edfd85b1ffd36 Lukas Czerner 2021-10-27  5650
cebe85d570cf84 Lukas Czerner 2021-10-27  5651  	fc->s_fs_info = sbi;
cebe85d570cf84 Lukas Czerner 2021-10-27  5652
cebe85d570cf84 Lukas Czerner 2021-10-27  5653  	/* Cleanup superblock name */
cebe85d570cf84 Lukas Czerner 2021-10-27  5654  	strreplace(sb->s_id, '/', '!');
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5655
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5656  	sbi->s_sb_block = 1;	/* Default super block location */
cebe85d570cf84 Lukas Czerner 2021-10-27  5657  	if (ctx->spec & EXT4_SPEC_s_sb_block)
cebe85d570cf84 Lukas Czerner 2021-10-27  5658  		sbi->s_sb_block = ctx->s_sb_block;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5659
cebe85d570cf84 Lukas Czerner 2021-10-27  5660  	ret = __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5661  	if (ret < 0)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5662  		goto free_sbi;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5663
cebe85d570cf84 Lukas Czerner 2021-10-27  5664  	if (sbi->s_journal) {
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5665  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5666  			descr = " journalled data mode";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5667  		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5668  			descr = " ordered data mode";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5669  		else
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5670  			descr = " writeback data mode";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5671  	} else
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5672  		descr = "out journal";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5673
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5674  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5675  		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
cebe85d570cf84 Lukas Czerner 2021-10-27  5676  			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5677
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5678  	return 0;
cebe85d570cf84 Lukas Czerner 2021-10-27  5679
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5680  free_sbi:
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5681  	ext4_free_sbi(sbi);
cebe85d570cf84 Lukas Czerner 2021-10-27  5682  	fc->s_fs_info = NULL;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5683  	return ret;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5684  }
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5685

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
