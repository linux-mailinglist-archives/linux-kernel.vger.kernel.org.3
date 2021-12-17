Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34647896B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhLQLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:05:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:35338 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234890AbhLQLFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639739112; x=1671275112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G25DkFb4HNWk41Ihod4FGrE9OmwvnIQxqHl69zJHwFc=;
  b=Vl+coi//DXSSGRRfNgWBsNvnuqpC4xx2Pz02Gwucpf+yI3x7+dF9FCK/
   XztB1Jj/i/73jzdlXzfGfRB9EweZzO3lBG+vGH5jPrSjBVJb2PCR1OYpt
   GVqAAGyuPGcJ4qgLQ/yQSSEnC+HoEUXG1tuTAusy4hyYLU2WJm3Fdh7QG
   aowV2wJntp7FOjf7a9UHB4m8zSQETiYyMeDn4dYGcXLYadg0YUfSfT+2D
   NFFtD7eIhxcuvYi31ZBQ5TlUakQ7ZkyOFInO5NPzQU8lChW1SnozenSCp
   dkZNePiuVGoEqQTXo3hb0gsYTxWA4oDHBSMQOdHNPCEHY1VDRlukebpuy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263905803"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="263905803"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="519704204"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2021 03:05:11 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 03:05:11 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 03:05:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 03:05:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 03:05:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h96FvLsK5lUQ0Z6V8gJRHE9bWM+WwLkIN2Iys1If2ifqShWxBdElyFMcJLgUbDEt7mfomW5hs0UDnQduN8Bjgr9d0eTYaFoodQegTAe+e7W2X+z4VGTP/ldgxzU7iqCmjdPZsvHvGr6EkE/PKQQ7mbZgnQuhvv9YDQr1KHl63Gdvc3gzntY8iK5Z+UkQZYcIVpmpxnksJ7UYOHxmZDQFq1Eye019FQ/tlXo+UXr1tUSNugR5HQ4rXhOMyTmepzYEf9sIrp8EKO8YHn4HKV9JFNGajegB+DboZZPfYF7/STG2AL8O9YX8oW4I8Y7VEGqgfxi2K4NhCBbkHfSYuLufSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B21F1AoZ/8US3d6BVNOwyuYb9qizbl07UZKfHdVeCU=;
 b=TBlXcqSV/I2+bZwEgmi84IhZNhMbrndrPo+0ZNl/xME0+gBHeyeXp2BFJobkknqz1iLTXMLZ2Ak6fyzTBYT/KokG0nv3UVX+L5UyuVfY6NyOgyn1t53moPm0bjKLEkSmHNToHdSWIr3J7h3TfifnVdzkeX24gh7DcDp6lKBvwVa0C4/ML1n6CVLnAT1UCNvXIqBJOH86L1Q+MLWi4dAUpe6mZdfUSRM0zzx2UvZ/n145oAEIFgjr0xPB8rsCeEIC/I7zm98+m6DEpDjnjuzQcJCCCuTW2tetF2FvfY9EyHJZ74dYxELhRQO0skxIxXAWrO/ppkBF8Y59kr3zRj8QcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN6PR11MB4052.namprd11.prod.outlook.com (2603:10b6:405:7a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 11:05:09 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 11:05:09 +0000
Message-ID: <cfb2d2f7-06fc-5930-4d24-b51e8b69c9bd@intel.com>
Date:   Fri, 17 Dec 2021 12:05:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH v2] dt-bindings: dsp: mediatek: add mt8195 dsp document
Content-Language: en-US
To:     YC Hung <yc.hung@mediatek.com>, <broonie@kernel.org>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>
References: <20211217070835.31709-1-yc.hung@mediatek.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20211217070835.31709-1-yc.hung@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::17) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fab9662-d4d6-41c9-dc50-08d9c14d16db
X-MS-TrafficTypeDiagnostic: BN6PR11MB4052:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB405255F626354DFE5625CB39E3789@BN6PR11MB4052.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qdke4xeQH4Tpoc+o1AYo+Rbh3y+titP9iU8EpDY7qfcF2RLyiFQ5/C/yAIaI+7OqArTPyY8ZQOYrDQkowAA6hgUTCXFG+wkpovw2mc20wWfiTX+jLbfrujMqdjHiEB7lANx2GU2+yjVOugC+3F4NbHCucCjFO012y7RWkUS6ZgOXGxTx9rmlF6YA7v8z9Qv+EHv5hPVrsSHHhjn1+iLZaDat8uCo3Ko07SeypcyiGuOQqQD/pIq9wkRFAvccop+dvO/pU+BaFCyHrD4lCFtWCp/4zae9yTzmds3iW7S115vaRrXHqMjPjtsTqKdR/ESiE4l43KxNiyjBAAc/vQXnVy/CVUecjGH585cHPnRY1IKNzapYI9bqSiV1eC7zH3Kdbx5rl1+HT/5N8dZUvVnr7euFqAKw7rgdSP4RAkHVqS2Q2HebG1Sc36K/5PdrJIwbZGPAAlOx7J2ADqDGBF3Uu3FipMJ5pebkUCJAyJ2ITYEiRASvlmvygbl9bWwY7wb9oMRVjRLljpKdFJsAKbV8MQC9Vt9U8HyzSBo1xjeG/Z11TB0/5CR551HCzqP+4AMAMFDuVda3tK5SEi4KvVaE36ZGTmd3fOBAlnxE6c5BNlgdej6ERuzPavGLEZpDqhrRomPq/M6cJdrzp96PeVk7HcNdyRympLgMXSziJF9x7RMjCyLUcao4UTNl3ku1x4JI4s2Yy8tIargLu39fd5aegmDKENuvmzwGCdSypF+IAH3O09NVHjB8BxOf+mnBCPM6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6512007)(6506007)(44832011)(36756003)(5660300002)(8936002)(31686004)(31696002)(2616005)(2906002)(83380400001)(82960400001)(53546011)(66476007)(86362001)(4001150100001)(6486002)(4326008)(66946007)(508600001)(186003)(6666004)(38100700002)(66556008)(26005)(4744005)(316002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJMclUyNDRtR0h1Vm0ybGM3VGhXOW9aYWh0REl5NzZ4KzZQNjJycEU0THkv?=
 =?utf-8?B?NlhkUlhjK0xEYmpVRjV0dDZNUDNSdnl1RXlGZ1RoeUJncDh5ODIxME5RV3ZU?=
 =?utf-8?B?MkhacFpzL2NDbnhUWlE3bUx5aG5pTzlvcXlWczQ1WVRpOThMT1NlYlQybnpF?=
 =?utf-8?B?OFpUMUc1bDM5a3lqN001ZlVheVI5dytRNDJLSlZFTUVIQmIwTWxLRE1aU1Nw?=
 =?utf-8?B?bmwwUHkzTWw2Mk1xazRkR0kxengvRng0UklMTkhzajB6dC8yVHVLZlhwcll6?=
 =?utf-8?B?KzRwUDFzdjRRMVQ1KzhTd0E3ZEEyelBpd1NUTVZXUVd6R2pndVJLSjlYdkd0?=
 =?utf-8?B?VE5CT1ZnRXpER1dEdmEvUHR2WlZNeHRrRmJmOUhhalhxV05RWVNPalhBTFVY?=
 =?utf-8?B?YjZnT2h0eDJ6QmplM2U0bldqTElIbSsxZjZLcEpSRTltR2hTZ0VIUzVDQWp4?=
 =?utf-8?B?TkpBalpQaDBDTFhLM1RhMFBSanpSWkRKU0IvNzlucjRPVTVKNUtyNkNsdlZC?=
 =?utf-8?B?T3ZaYllYTnRBOFd4cnB1Rk5OVjFlNFgyUExJZVJWNlRnR2dqeUc1UzVBZ1Iw?=
 =?utf-8?B?MHY3SExkUkJla01mZDg4UnhIYmtzSDF2YzFmb3hGdSt3U2E3ZStVV1hmTlJM?=
 =?utf-8?B?TUNUUTNPa0xzUFZENGxXWlFYVDFBL1BvdHZMVkZ2UldEeHhnTUhQTzEyQzN5?=
 =?utf-8?B?OVlnOHFWRU5xalc1WjVuUkVmU0c1dmxEWDVWQkd2dU1nLzVvWExjczh3YXB0?=
 =?utf-8?B?ZW81dkp0bTU0TlFSVU4rRjBIam0ra1F4SDJzdFZIRGFYWXlXc3hwckpjazFz?=
 =?utf-8?B?RWxDUFBtQnVNcVhobFFpVUJhWnpXdjBqN1ZscHBMa3c2bVhmK0V3QzBRdFFB?=
 =?utf-8?B?K0d6aEFMS2xoNnVRcmRoS1JQN2Y0bWwwSDJ1WmhVMkhxM2ZsVFZHS1U0eWZD?=
 =?utf-8?B?amgrb0YyT21GRkNxc0tEZjlPWWZHTjdSVnQ5bzJ4L25VakVHbk5uK3NQRC9a?=
 =?utf-8?B?NStNVjREenkvcUY3MEJKalBudjFQTlBneWd0dm9CTkcwZHZPdGJVTTFWRVZS?=
 =?utf-8?B?NHpyV2g3N0owK016NmhIRFFOcGFUeXphWWVaZUc3TkpXSGdiOHZHWlFBRlBN?=
 =?utf-8?B?RUJTOWxBNE9MTWkzYks4NmFreTRwN1RPcUZBTzVmdmg2NzlUaFFNck5RalhS?=
 =?utf-8?B?aGxGRlcxdEdtNGtoeEo2aUcxN29oNVk5ZC9PdS9PNWhkZ2x2RU16MTUvc0kw?=
 =?utf-8?B?TytCbmRYbDlyWWNNUUtROGNEYU1BT1MwNW45QU5pU2tpK1NBUWh4TnhpUUJY?=
 =?utf-8?B?bmM3anJubEhGRGdtaHJQSjZyOVMrZC9tNGV5aDVQMFAvNUhCcmY5RUsrSmIz?=
 =?utf-8?B?c2FwUStMQUl2U2kwdURsaVFIWFl2WkZyWEN0TzNMOFhJMFRUV0wwVUtGMExU?=
 =?utf-8?B?SFZOYjZJaEpqMFk2bHQ0NTczbGl6Q0hvdTFOZW1oQVEvZVc5alBjWWdpbDI2?=
 =?utf-8?B?OEFHNWJMbGlkZTZnOVF6b0tTU2VnT3NZS2wxWkYyMmZQbXlmWTIraDg2YVBW?=
 =?utf-8?B?Y2hDbC9Kdm03QVRmTVFHWFIvOWM4aC9mQ011bnNUR3M5SEo1N3FGOHZpN2hI?=
 =?utf-8?B?b0lsblFUUzZVOFI4emNEY2VuS1Q3Q3pjS25sZS81bkdUVzBBYWFQa1RmejZl?=
 =?utf-8?B?OHVVZ2IwT0svM0U4SDYrYWJidXNCWWdxWGlySVhZVGlZQkxEb0xpSnZNTDNP?=
 =?utf-8?B?U1pHK3B0RDRKOHBxSXE0R1RMdnBXN3Yzb0Y2Y0NGUnM1MzUrVmh4UkRTK2Q2?=
 =?utf-8?B?Z2FsckFPZks0SjhtM2lGL3R0a1grV3NkSGZMM3lQZG01OEpJZkJJVGphd3Nx?=
 =?utf-8?B?cGZ4OHZhNjV0WXAxbEhjTGEwK3BwUDJqdUZpOWJYbjQxZEtnQXJidWxJZ0NJ?=
 =?utf-8?B?ajhaWFRhVDBEWStRL2NEa3JXa2dsMy81TmhCSHJGVE5FTVQ3WVlyWkF2Rjcw?=
 =?utf-8?B?bkFtaU1FMnloRWZ0a3NCZStBRTZBMGR6MkM0b1BNcDRzMGhIMjQ1VXJqc2hi?=
 =?utf-8?B?Szg5OVdoUkVCZjNCN2FOOWZRR0JlWS9tZEtSbkpjbEQwak5uOU9HTExYZ1J5?=
 =?utf-8?B?UWY0QmJGcnZ2Z3JVOWFuSUZoMkpxQ0RiWWR2NmRseldITXVKamdORk1iTloz?=
 =?utf-8?B?RXljVHdTaTUwWlhHVlNYVHNEQkc3aFNoMGFoMlRucmswQ0h5L2t6K1lMamEr?=
 =?utf-8?Q?KQGbeFWuvt5NlvfP0m4jK7KFS3V8SEs1b0TigdtvjM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fab9662-d4d6-41c9-dc50-08d9c14d16db
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 11:05:09.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v88vHqgILvcliPAhbD+6csfLRh3gk3jyYMZjpiTtMyPqo7pOvtNTp1dK2maqnHZHRrYCV9msbKduF2dDfoSSnSQzThOkka9Py6sGPYvgCr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4052
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-17 8:08 AM, YC Hung wrote:
> From: "yc.hung" <yc.hung@mediatek.com>
> 
> This patch adds mt8195 dsp document.

Hello,

While above statement is correct, the commit message would probably 
benefit if expanded a bit. Don't get me wrong, I also find describing 
rather obvious changes problematic.

Here, stating what 'mt8195 dsp' is and what's use, even in a single 
sentence, would probably do the job.


Regards,
Czarek

> Signed-off-by: yc.hung <yc.hung@mediatek.com>
> ---
> Changes since v1:
>    Rename yaml file name as mediatek,mt8195-dsp.yaml
>    Refine descriptions for mailbox, memory-region and drop unused labels
>    in examples.
