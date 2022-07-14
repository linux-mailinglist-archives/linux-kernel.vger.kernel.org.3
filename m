Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C45754F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiGNS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbiGNS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:28:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07036A9E5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657823306; x=1689359306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9IycQdzJ7jLKJIX8/dq827FwUuH5KwW6Su3z0Mip7jg=;
  b=IEli0dWM8hbpzwafKaGfNHHt88pRMR7QtLX0GmB8venu3uk9YCwJ0gtM
   KanIrWM/Gb+wkHh+4KU5ArqhcSlEJ0BBgya4MhNa0SrtMGO71F4Towhri
   eD8c/s19BZ265hC4Z0QOwHL5Gq0X/h/kTvzUXxBUyF6gHpyy7EW+BEcmZ
   h/i7uW3Q74n36X6EEIx32TUv4LIc9/o2RvVETv8rt+MBA540vfhnTG+hk
   aPF2SGIprdSqgkuabcoRgg0Nm2WAf48m0kgNLO3EDBHcLuhFhWJe/f51/
   FifpHcTCTduV6JadmBbl2cWdsIzdIelzcV5ZGvJKxiDvP27oU1ID44k6S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265389221"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265389221"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="593468714"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2022 11:28:26 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:28:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:28:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 11:28:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 11:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmpEi7bp7/LhHXDJANAQM1J09lxdwiSC4BMqgZYOs9eA937p8iuTGAvRPi/sP5isJIJrriswFP4bT8B+5WtgzJs0fJepyt7Y7SV/8iMflvEU4RshsAj0JjbJHY0cERanSyALpeR4sam0TTsJ3+Aq1AeNKAvc39OHHL+PPLwmmhROacR0HciyGezddPzbqg03cj9YQb8AJG3IPaq6zYMi0jqd8i9NkgnDcTyi497qPHaNpztGE3sH2j4w8hSeIEg2sp2y/tR62Q694f/4HGedQrjrRMkwiCfmAiUQZUYCTZQrsqZuqFNvZxFaClpvohoB7rtU/0t3gU4ihkRZcpE/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IycQdzJ7jLKJIX8/dq827FwUuH5KwW6Su3z0Mip7jg=;
 b=JRU7RdmqCRB3+rESjSYtp32d34nYVMaE/MAS4gGHpgHHpj73Fm75IycBRYxplOyRkXqZpbI1BRq74jITOBRxyzz7jfnorna5DP7hrIV5CiHupXobO6/pilIOKIatOue6uKCIkH/N93XYP7rKwV/yFLhGIFiyzGTE055ybfJwu3T3Y4oBRVsimQ9Qd4ik7qOMDk0HpJOZbAcVoXUuVeDmnDSO1PVzioTHWOAJMeMVoPnOAZWGlKmDjmqr+LdCxXjVAdfnolL824qt/4X3x/cuTfFE9EgMSrTZNfEfCen/WhBHle+mFYV+fXolMujJcoYQ3mVdMusIsfAP239RHxBpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1674.namprd11.prod.outlook.com
 (2603:10b6:4:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 18:28:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 18:28:23 +0000
Date:   Thu, 14 Jul 2022 11:28:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v1 1/1] nvdimm/namespace: drop unneeded temporary
 variable in size_store()
Message-ID: <62d060459476d_1643dc294e3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220607153750.33639-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220607153750.33639-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936e418d-4426-46de-9314-08da65c6a2d5
X-MS-TrafficTypeDiagnostic: DM5PR11MB1674:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q9L9/rg5YCVB6T1CUhrlqlkjxLB/7e0aG8iwBBhrY5BxDMMM2lqUunr5sor5De+1mr4X2QchBoudcqf23RW1lyuInpmEvpkd6B6P3qmABv0iL43x5hmUDyBU+QIklfioudSRZWGm7M7TyEBFtSswkWj/POjO+HpNv0ps9Yw5NOECqsZqhTN0EwvMI/sDD230xBbF1lfjPok5cg9ClWz7bzSjk82qn9OizIhYNcRuasGIDyT5HsIveCXyTu6pHmWHAK7DBFP1lT/xPCMkyjkqVYtsaTXVVrmQJ5yf4hWurkMTyZWOTvBu1wdXKC1HwEz2ZcqKLh6U6l8TBGeoLM0jij2SBw0IrOWJKEhJ0MxAOvO6wxbBTzJ2WJptFxnpq02XY+0bbWhEUqZ7d1/wgZR3aXmBtGhxUir4m1FfOwYZNeYSlWVhP65ghsAUUNkomSZmlPTsfha9qz/zatJZEdmrq1hmeGDkZvgLVIyPg8yA/GPJIpvg6mCuPWBC8+Jn2YW/vra6AgaisrBNIsJbzC11vI0fCiffVihWi6FLsqyGqPg3YbHXw4UgxBEC+gWtb5t6W9Vq+xIDPeuNmcLV3GcDm5Je/xotOkkNM2DEvxd8rEtO/ihI7GW08GyLipvhng+ZHNy6UJ6bdITH4muxhXCIDvQpCQyvR/2S3AKDsWMea3b+RaIhbICcj42syGch3245/5HJRqiSQFXbnH8bmQN+Ejtbiz/v4k6VRrQSGbPYHBVL1qRhZcoP61EomzavGdi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(366004)(376002)(136003)(2906002)(5660300002)(6512007)(83380400001)(316002)(110136005)(54906003)(8936002)(558084003)(86362001)(82960400001)(4326008)(8676002)(6506007)(26005)(41300700001)(9686003)(6486002)(478600001)(38100700002)(66946007)(66476007)(66556008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrUJcuCu2nzOxE3yXe/ofw9EqO23cEmg7lee5Zy7O68mMXTCMK/x5TlKk8ut?=
 =?us-ascii?Q?BZigYhcWHO4GCBkqJavguVQPfN7FTSlBUJ83rgO2MgRuHJz1RfOZAD53jp27?=
 =?us-ascii?Q?/7ngc1qisuqEgd+Jn98ghcSy3iiiQbTCYsyDf5HOCP9dNu3F20CpDO5SW838?=
 =?us-ascii?Q?TLIa1in4Gu9upOsstwjfmDFJDINiXO4dRs46UYN8kJSwxuER3MTf4tS9VNVW?=
 =?us-ascii?Q?4NF1ozCtMFG3rl60KryyHGyHO4P2rq1PIuwMOdwuw9rpFSFi77urkQnJtnSx?=
 =?us-ascii?Q?A8iLQYWOMcyQjbyf4DBt7tzZI5NXeOkGjVLhG0ftHeuOLSsbQjUuEnxcrnWi?=
 =?us-ascii?Q?m1ci6f37KXBwIoJGmHWXG97SOJXVpx0ft6kycj+aXnVNUrRauhoW7e+YjioY?=
 =?us-ascii?Q?dL7R8JruIwUi6prGdtWAR56y1ks4K8rbqEyMmvSAxO+P3jAKyvK0XVWs7xrK?=
 =?us-ascii?Q?KbDRGzZLuAiyXEaGMVU4xYl4fVuKvKnU8aFVGR07J/ChFJhz4rMbPDBvZW2v?=
 =?us-ascii?Q?KwBerbQhtskjveqsFaC3GeQwv87M4ZN19Ro96mehgRto9stHcxKeJ23ljsCQ?=
 =?us-ascii?Q?4koUJPyhuCAhU6s5oM4ymofq1WAxtMtyT7yG/py085qtaoFTfBOK4T79g9+x?=
 =?us-ascii?Q?GEFrc0n9N4DNfF3K3DrrGWjr+7dIutOgH3YS0GiDTB7/3+/8aap30vh7MDVJ?=
 =?us-ascii?Q?5ZEhu6At76boo2OR35qZGEjmBTtqi+4hsx//W9Gj7nnkferuUbZdZtakhKky?=
 =?us-ascii?Q?qicfTdO3brVgzdqsmcj2GYVsHaRQFQgcQNa6lAZe3h266Fig0zyXCLHkT2sk?=
 =?us-ascii?Q?6ZuLwNFCv9FPC3OgEqxjsavjupuPl2RwvBipbiUl58IxKhYApDiLCLNqwBtu?=
 =?us-ascii?Q?dXEsl8bRpDS4pkFTto5dirqI4MFi1pT6GVIJC2jQ8+5WttARlkTvhMTgznDJ?=
 =?us-ascii?Q?LYyQxjcLiCXXDaf99YLefZ5WCk06ccFN0GFkX29ogvNB37c6tGLu9QmEU90A?=
 =?us-ascii?Q?FRpCdoX8rxUnuTvMGSN8vqV8nm7wlDD06uvUGhxptSz2fTsMv2VBmJyD9Ea+?=
 =?us-ascii?Q?nO8OyEt268HH0CrgQJ8LB6eURW7lh4JIGZCqZeYnH9Kr7CykwtYaoEj+Fnhw?=
 =?us-ascii?Q?tfgfuPf+nYtSYSMz4V505Nq4sC6gGfUT3kEW4xl9fU87OJIUFyiN9eU5ewHU?=
 =?us-ascii?Q?60TK7cCsqdnmc7xFXPrOuJPIKDUBwu/AAebpZEtsEcy01OiaSw/s79WCdQff?=
 =?us-ascii?Q?gju2fQtUNZmaQjTT/3ON4jKncIW/6IUb3iH9ZHHrjrvkyexDj0FSJnLEwmxT?=
 =?us-ascii?Q?nO1pE72t6ltQKti3STsBNHpnX3XhV32P8T2tZqEXNByIXdBn6KHeXazYbEvs?=
 =?us-ascii?Q?GJ90jbHyNt9pE7iUXanPMwclgpe3qBaPRxeRKXZTcrSLUu0xgekXJ0XGVCRm?=
 =?us-ascii?Q?c+DVCChys0iFZUcqhV8ypM6WJgMaHhVbsydYq7JcEMpFHvGRTJvViXy399qk?=
 =?us-ascii?Q?KrnQIZsC+WhN3zLYQOe4e6NGci5ZuUnIY7pWe40QbrlUhLbBzZz1d74W0yjR?=
 =?us-ascii?Q?kwZsQ/nTT2v3nmY1DYoWpUW+ERr7dGXpkW4+zM8TegeGS3oe8Rffnb/6TA3W?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 936e418d-4426-46de-9314-08da65c6a2d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:28:23.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSKaJEwCiTw7F/p7ZGRddxjJIqR9JSLFm4QLs8HemqENhbKdxs7MixU0LeIFctLhrBgfWaEgYTFc4KmjzSrld8kA2woJd7laXAXnhxhJq+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko wrote:
> Refactor size_store() in order to remove temporary variable on stack
> by joining conditionals.

Looks good, applied.
