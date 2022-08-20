Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3691A59AA88
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiHTBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiHTBmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:42:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8ED5701
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660959771; x=1692495771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3mKKmkmP7KLS3Osccsn4JUnHp9tvDD+w9wER8H2ldE4=;
  b=UmAlDz+YAvTaXrVn4yXI50A0ra3TmQD6oWV8DbB8HykVn9GEC2dgA577
   SVSjs6E4kgfdgItvoXZ27lecQ4tk25rpK+za9mPFNaMWTkrV8UfNhljOi
   wno+OViC+1jexewdv/UOvtBrkf8e0ppvKqIT9r/JFveoWcDosKEhVp0YJ
   kpl5ISULKw2b09D62bP3VzmTEx7+I9Xrx+aN1AJ0rsQfNAncPZJxBHMWZ
   x7OSeTkq74cPEdYUUQwGJiwn4zKX5t3z1GKNrnKWuhQzDKXuDZWhrFqtk
   NnG1LZK58E/LUTJTo0gawd79RscDbd5yQ50BGrMr3Coy4wvg3JuDzwhlb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="291884839"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="291884839"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 18:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="676634108"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2022 18:42:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 18:42:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 18:42:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 18:42:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 18:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK9tVpMiXtztUBWUw3varumViiw7yTDaUTYoYJmF6k4IGepz1pG1J2KRIh4T4igFjfgeXxle6E3+zBcfX3U6itsgs+mjwX7fx0bGB1wXsMesYkD2aTR445e7vApAg88SA7178txFOc3lubrisKEFyGG/3Z6QNPn86BFQs+FF59LwQSAKxyJO5peoMUifxw9UXLF3g9+fCqY35Z+OUs9D/PXyvl2mNMPf3G2QJlbhY+VYj0wLdILGP/3awFWjUQRaB+DSrcXtd8ttrNX8R7gkYx7W1+UOmwGCCpZPoM3J1stmlTJbt2RyuQ0nLEvs2c07qvnhPPQS0BREheETlZOa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mKKmkmP7KLS3Osccsn4JUnHp9tvDD+w9wER8H2ldE4=;
 b=nQNw9YGu2tfXxoZwe7DKY18uUg4EvbpN+m8QsqXLzQZQMF+7XU55Gu6vb7+3jZ8s30/qt7gn64FSeDuEjUV139/+ntxU6eopaLROF4wIfJ/c5i5E2+AabjRI2lHdWWgH1ybrFIqUB2da1RCeKq8ukZFfOWHq2QXmh1CvbXLNfJ+pjya0d5GBGe55zAgoj0eryprYFzuJYVSxnPfVU4kgp6Y5ETkba6VSn6peqVoaVz8+8TZStOU4LDzVx0RqAmLRoSeFgcW2Jf3XytQINhTolGeZ93AEoDwuguj7zmg8qQPQ8cOpRlLkeWbpTw0ZSr4sUYaPim87b3zyZv1mhKB02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2221.namprd11.prod.outlook.com
 (2603:10b6:301:53::18) by DM5PR11MB1804.namprd11.prod.outlook.com
 (2603:10b6:3:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 20 Aug
 2022 01:42:45 +0000
Received: from MWHPR1101MB2221.namprd11.prod.outlook.com
 ([fe80::481e:1aa9:a675:db16]) by MWHPR1101MB2221.namprd11.prod.outlook.com
 ([fe80::481e:1aa9:a675:db16%11]) with mapi id 15.20.5525.019; Sat, 20 Aug
 2022 01:42:45 +0000
Date:   Sat, 20 Aug 2022 09:42:38 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <hch@infradead.org>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <jxgao@google.com>,
        <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] swiotlb: avoid potential left shift overflow
Message-ID: <YwA8DttmM7wgYuHv@gao-cwp>
References: <20220819084537.52374-1-chao.gao@intel.com>
 <38c58aa0-11c7-f553-95fd-292fd4944a75@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38c58aa0-11c7-f553-95fd-292fd4944a75@oracle.com>
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To MWHPR1101MB2221.namprd11.prod.outlook.com
 (2603:10b6:301:53::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d03f04b-8e35-46bb-f36c-08da824d477c
X-MS-TrafficTypeDiagnostic: DM5PR11MB1804:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWJQHwgTR2dM1pqOb0WgiN1SLG3YsgVafTfwMl789Ao+RJYCdY5/IENTGKFocO1Cw/q0UwKhBzs+VXLbwYhx57iQzbBBieowNRH6gaumEoxyanx6FMX8CEcG6bd4mnJosP1r2k+XeCppAkdyBVaXeyoRkEAAYpC/9hSiHH5zH3/cRCWjojWszGJf+40BTEb8nj6czicQfsosIb2eAwNrCJ26UL6ZAVlutQ+T96YmzxYkqPV42HzlmebCsAvVzTdJlxmhvsxlO3rpXstbYjrkrZ8HbAgT0DZ1DOJOIFdzcpn9fFat2hQBc1uZrvFUhebn4dkZbvKg4XTh/17GraFXT/XT0WpK6xG8PXAAjFAmYxwiD+njsoZgv1Kx4YDlZNqonzsz1lFheFPZaIuHeczMbfHdkKABMHSFA059r8w/0S8Skmzz1ySKW36ibNMnmEb2EbCrCS6xjMZc9mgkW/Huk3u6XkoLLmA968HZF7aEiszGFDZYn7NlUWIsn8Z8Ocfwe4GVawZ3HHy3w+OYB2UaXp+KxRokKTBTml0AjCdoq2XjsJuzVM2c+/BSHVZv7ZuMaKt9bsEImDYH2LhLXR/SQo3eLu6Kpm9H/fMAw9V+yzXbnbvx9AGdds6mbK3ARSP6yftyRZjL/LeqmxiFLPXulOcgMIb+fNfNYjuJk6R8nvLY5fNP6ptcQc0cn1cjLGl4Jo0eGpww2jzAg9zkRGgqccG0oiimSQ80xcUc0whNUMc8TbpRLEgKWxtIcuZFVfxf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2221.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(478600001)(9686003)(86362001)(6512007)(316002)(26005)(6486002)(6506007)(8676002)(66946007)(4326008)(2906002)(33716001)(82960400001)(66476007)(66556008)(41300700001)(6916009)(6666004)(5660300002)(8936002)(44832011)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeDTUs8nF4XzMPY9bn1XRaj52XSHq/fEWEi/IVgOezRVYAgbSFmTQTxy+Q84?=
 =?us-ascii?Q?KFgfUEpssrAenfhNqVSc6+dnUQbHtfINGaSnTOISyukEnVqFsEV9fcw1pOYG?=
 =?us-ascii?Q?y3OFD6sYMDNvGR9pXUddrUt1Nkr9/y7W7aNkgID3T4J5t6Gg5IWjVZPAdssh?=
 =?us-ascii?Q?1bnH0ZDNTIxVj7YFXiGivmmFoKH8ebyuTF54XhSed3cUpVGA2yXJ1tJtgkCu?=
 =?us-ascii?Q?kf/zuZOICyq7stdft1qaS184PI+a4AEjzYCygLKNFnSxnyTIpwx/y1et15k2?=
 =?us-ascii?Q?UclphMdbqbLNe5DVA8A69oaHKIy+pdX+ZAtYwN6cIJ4ffkRU7PaG19lFE30g?=
 =?us-ascii?Q?F3IgP7LApluGbwBkBxwBfcC9i3/KnBVL6B2XjHsodA/FDTQfNVt7URoJEvD4?=
 =?us-ascii?Q?M+MtA92BrCRFO3qr+UvEMaAIf4ODJ3RJ8n7R7L1M/aaTaAAPd0Rq0LPe8V4E?=
 =?us-ascii?Q?WkNT4OO1V4LxnIByLE1bN1DegkuPWbonMfcxTTiPP1QzpoQbYK7uZpX0VhdH?=
 =?us-ascii?Q?VPaFsrJ5qweoDMYLBeHO6wyQgozPRYNqlAXH7BslRMfvCKZ86w7vUQxsm0XM?=
 =?us-ascii?Q?OE/X6DNaApoUptnkgSjQ1KS57tb6rpuvu35RkTtO/KOKuZOCq6JLNd2wpHjF?=
 =?us-ascii?Q?jA+ba9b06MhOiWoSl/SaKMiCbLbOuKoPqd8fCaRC1mO/WEMOdW5lP4tA7irR?=
 =?us-ascii?Q?AKChq9zB7225jru2O6ubS21Of1pyQHM8Qt+ZIwQT/OnlzCNrDgAW4rWrkcOr?=
 =?us-ascii?Q?gTVJrgFlzgu9WvoEp2nWFXYzc2D9f0xum6eO32SyhcB7CEa62UeTmhUK0wIV?=
 =?us-ascii?Q?roRHgaa80v2l2gcgSmx1kZlomSK/x/KrlV8PPQ28A886J5vFns8zuqx8xTFp?=
 =?us-ascii?Q?ZAJAXbcmUTl+HzCL36lNEhTttucnXNFpSltt3tSJpTyV4LZNg/48/lXzcQw6?=
 =?us-ascii?Q?/Cksk/qk2LAg8pq9ooZ8Em4ukIzKCbpEcvNagn+9IZfJOedqWfavST4kZeSB?=
 =?us-ascii?Q?bPbl4wkA6EI5oXOSvol3tMMpyZU1706s6G4knvYwhOwCQ7Dy3T1jwif4VM5j?=
 =?us-ascii?Q?wTrXTT6TiKzTcbd5HYSenE9k3yV0KlW3yvb6YTvoqrPIFZYqdnhA08GTPAFI?=
 =?us-ascii?Q?MRyQ5bRFXpyY+vnUpBELm7n2y8ZEg/iZyzCfZSlSEJhUUGHvogyX/f2HEPsf?=
 =?us-ascii?Q?QLf7N9E/u/WZ1/a8GeEbS++/APd2hLDNlr5xoPPzYtVT1dFawuhHg2x1sD9S?=
 =?us-ascii?Q?Yi6pDlMC++b+2EvNqWW04Z7fxhSilWPRS3M2MW+lRJo3CE4iQ5KBN+8YbMdj?=
 =?us-ascii?Q?fTkoz+tdvaSLkI+oIgdfmE/vUw7ESAdZ2uMtEIGAZaXvJRkamxBt2raJkosF?=
 =?us-ascii?Q?flLpgVbUUFWNh+aDd0aNsI9LfLFxcj3ZAsMqVA35HjWvQhtyKCcZGlIIi0KM?=
 =?us-ascii?Q?g8i2Y7Kb4FtyombqCdncQUFjXGrrRstdFNGZOL3yjcKFRWYNOn6agM/tzzcw?=
 =?us-ascii?Q?hrul8FjaxCT8DZ5l4Edc1MedQbeZOw4fkpQXky9s0l4qgcUmArn3945mAsQM?=
 =?us-ascii?Q?Mo6ozy9vEbmnP+bIbQHs/cWm5NgzdftK/xcgUHox?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d03f04b-8e35-46bb-f36c-08da824d477c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2221.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 01:42:45.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3DnihihJKvn6KpRc9OQZ39sHQTv6GOCVnPtL17fAte3WDRdJckSId6ygNRa3qdP4o682uIgVXWA92KUh/iZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1804
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

On Fri, Aug 19, 2022 at 06:44:05AM -0700, Dongli Zhang wrote:
>I also encountered this when sending out another version of the 64-bit swiotlb.
>
>https://lore.kernel.org/all/20220609005553.30954-8-dongli.zhang@oracle.com/
>
>Unfortunately, I could not find an environment (e.g., powerpc) to allocate more
>than 4G until swiotlb supports 64-bit.
>
>Although xen supports 64-bit, but the hypervisor side limits the max to < 4G.

Sorry. I didn't notice your series before. I agree that the overflow
isn't an issue if swiotlb size cannot be larger than 4GB. That's why
I said the overflow is a potential issue.

In an internal effort to measure the impact of swiotlb size to IO
performance of confidential VM (e.g., TDX VM), we simply added
SWIOTLB_ANY to the default io_tlb_mem to lift the restriction on swiotlb
size. Then we hit this issue and worked out this fix. I posted this
fix because I think the fix by itself is helpful because it removes the
implicit dependency of the left-shift in slot_addr() on swiotlb size and
then someone trying to lift the size limitation won't hit the same issue.
