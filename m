Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F55B148B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiIHGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiIHGSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:18:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F3B8F3A;
        Wed,  7 Sep 2022 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662617923; x=1694153923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h7UFyxQ37a8wduIVEb+Lk3Y/mAMSepnETzjuCke8Pgk=;
  b=b9yxhYciGJ8YSpW6LlaU6Z9oZMBB5UOcl7lOc5XEcmv3sEAxdTjaBqaq
   r/5+hpz862jD745gGmXLw8a79T3xqGbonb9CJH+gBWsi3hf0H3ya3yCS7
   7c0rOOg94jNXoY15vNhdbziQ8lmWyy2xsFNVW4u1oqvgzHpkAyCPFYigF
   1bL35Ay5OUSQZRvwqC1hh3dvXzGkJYpiHkjqRAO70tHcnsmB3tikCUrtn
   A0MZ0Ocff6iHoJAmWpu46aTkaa1EHIbHndISNHSJsNksfgq0Iz4fohwr0
   01PwTSeAuPXj2jYamds8e/3Bd51YdwW5mY75XG+gA61Xqum71iTP69RXq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280108337"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="280108337"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="617355231"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2022 23:18:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:18:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:18:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:18:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeSB9pPNM7sVRhxhGMwan2VqIFpMyxymfCl4FF9c0Sd8xYDE8lVwTuSQEB64W77EJA3IoJwd/CjzYOfFtZ3BBj95YFhAUvmIDeC8rRG3h7MtX4oXD+xkSPwKLc2rk2F36SgdOWL79nKmxKjZitTifRdn5ChdHLXIvS9/qPUyH5fd/0qygLW945nigffNrAW2G+8QYT10qid7+8S8EESa9T3WehzNZnrQ3eq9yZ1PyDRjL0fqTnZcmMV1GlMCcyw6oQBtAlglANCUcbaO/T0Yk1sbgrRd5lHoBKpa15lUn8QpPubW8oYAZLy7WN6egH9B1csP85rPSPJSr0XCLTwJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+PFgFQN4E4blUsN3nI0Dd35E2UBbhbizOlN8anIWI4=;
 b=htl8IOKfamX0nMtFa8tCPqFtzwW1NaSoVioHFSAA3eKEDytxJ45K7SB1lMvZFG2IKtr0AHGHIqkOlYHIOWs8+2h0trKMeA1H2ZQAOFlSMVbcMyLEHt/7X5j3XeLn8sD0bIQPJG1KgPiPt7wF9U8pfqfsMBZdMsEYqQupPwHFODxHxVQvKe+w3JEloVztYXKs5ht0G/6D+mOB8SiiQUkaZZZV2JMKfmPBabBfAgpR/tNt4wVngsuAvqR62g4LzXEnFOXzYqdg9vWK2SAdu13CKa8fhTrwbQgN/cj77chnWm8V1geaOkADbWJHyHuBavKJrs3KQEsGN4mSo5U8fTjxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5789.namprd11.prod.outlook.com
 (2603:10b6:a03:424::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 06:18:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:18:34 +0000
Date:   Wed, 7 Sep 2022 23:18:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Message-ID: <631989383c505_5801629496@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-10-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00665e11-e4ad-4f6b-a457-08da9161f5b2
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtG3N/OE53z1+5dus6UFgPWOaqCSa5W80Etj9vh8vJnPo5mp7uo7jmmVUGhrttit60TcR/6X3SFTg4m1SIP/UoK03c2EB0bYxkbetPcR8e3wanOFU9VjlPT8y9Mi/w4E8OGV9IGUNOWK5bdt+vryeFj4vmo+51siKvNN93kTSKP+JqBullcsnQdCw/k1aaMyWSK4ix/ygDadf6meuYcDL/tGJbexBjoMzDMhVmnF21KhWFfVbYLYlwdiEe9DM/Ht84EmTAM9O/b/av3bKm9F8DgiRoihYYeDgkk9QXbRbcaG87gITpLaRMOU6466tnUnJnrJ6DYqnrE2Eb6YrzyLNfgAkq0oy2/34WEPwOxs/YoyZd7iwXf2XjDsLT5syTb4QIz0181d1o2MT+CA4nFwwjc2tZVr0s91qZkfU4OxuHbP6aPTcF4SlpaxI5M/O7S+5/fziGUQy3LYllGsYlAIaKH2MNcdFwPSJ7O3Z6AY7wFTqd2FsG7GGz16pyw33ZpT6cP9bi57RuYB+LMJlQ6YSdhf6ryCFBtp26V0aobED0GjGDS4h+BO9hbmmVn8jCBOcSmZq/sGHuzpJcDWbE8H/pENYIPjhX/YQ0rDkT0LYO+ek42CTzL01xZYbgcuWG6ukdJSkkCMWaClYrsseQxs6nte7jPO1u6FT0z+1liIifg54kvMwSDV2LckYo+EzpRQ6MVn80MDH4WQYOgDfUU/5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(316002)(82960400001)(6506007)(4326008)(8676002)(66556008)(66476007)(66946007)(110136005)(38100700002)(2906002)(54906003)(8936002)(26005)(186003)(5660300002)(478600001)(6486002)(86362001)(9686003)(6512007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iWHmKK3uknAR/bjw/O+BlQbo+JTr1/sQZKrXlAaXVX8is6n0B/AaXMbv6iXn?=
 =?us-ascii?Q?5sLWgxtXKtNfepgZZX271p647miE5gWtDW+XdnU/pvYAzqRW3gqM+o74waz8?=
 =?us-ascii?Q?N7Dtt13ymg1PYx2dhOfncRr9lf/cuyXmrf14NoqZLezg+bZVQaFf2Avh6m3B?=
 =?us-ascii?Q?x1yei1m3sya24Jd1pZGGXbw4nEAQ3Z36B6+Soat6reiQ1oWB6DUxaeU1eBQG?=
 =?us-ascii?Q?VTxZnydCBnyTTjbacznA64XV5jWszG2qIO1bL4xWXiL/Y+ycyQXFcG+CTQfX?=
 =?us-ascii?Q?CGEcrS3WFPfM5gZ0RrvuaZ6JtKzjaZ1XtkXDe8Vzx3mrI0ol+dkwQmlE9PpP?=
 =?us-ascii?Q?3PzRgX3AFVTqanMCdNlwn6jnBZwgAKecx6EWFSZen9u9pnde8iXPTzhB4Ia0?=
 =?us-ascii?Q?JRFiRoKTcOP8fjGs7VswfQlBUs2NhqQKh6jDSOwWielZr+tpKfhju0Q81hlv?=
 =?us-ascii?Q?jHZKWu7r7XydCD8wRJ6FvMUjIjScyQp6RKrdfF3se+Zwrizyj9bN2Sf52cAY?=
 =?us-ascii?Q?RPFknK7A3z3kUCJHiN68WjLsTj0oHJe++dmYhmi6l0hmTH1OtWDCwfsTB/ET?=
 =?us-ascii?Q?5Wqvx/mDy9sBQNT+Rq7vnp7WsYs+qdelOQ8yHhGFRZmDj+bNcgjyVamoKcif?=
 =?us-ascii?Q?SCeJnoec7LupI/SOKa633W1/XuczlxDvvlbOTiuB1vxUZibPSx/YbvxAzJN0?=
 =?us-ascii?Q?NSzDnjqMhvzJov+ak0NChECbeO/m0jwX7RHKgA+LtMMNmRuRFV/SIGckBOfb?=
 =?us-ascii?Q?EEvV/cAgIACKYqfq72Dgb9qsPaQ3I3D0qes4bTUVbrRJJ+5eQmK7yIpp00rD?=
 =?us-ascii?Q?hX+5CtzRN2jUuFe6W4n9C8Col+7Y8WVYdve01Za8RH9jytezYSWFBV91sVG0?=
 =?us-ascii?Q?5cxyhhws+3EDWXpZKu3F4RN81ulUvTHS3D2PqiN6tnpjxlST9Rg+Z8O/BMdA?=
 =?us-ascii?Q?w/r9F8B7kWng5KFD+guWRjbFPDhq0xDyNE6xGtv2lm1/0xvSvLVc/Yd2PqPr?=
 =?us-ascii?Q?/+Odz6apkik1pDgajI9JWxEu3w0XmmC9A9vqHvxSWrO/gkNxCIzsejDMDBqY?=
 =?us-ascii?Q?d71baknUWgtQtkd+2q1CBDm0sXVKCxkoMMOZWVp3pfzExbnAuCHC3Ftc5Z1m?=
 =?us-ascii?Q?FY85rCz71iksFwJswNDfRmKaJVL+iQMjd/LUU+jVUUSYmcOcDdS335U3mqzc?=
 =?us-ascii?Q?VAfkqRAaVIfLuP0IgAHKOlZKyQmFuHrzqmR6U6REusXw66nOlFARG+lrI+UW?=
 =?us-ascii?Q?T9BIPRm+YOnMfV4iakbjtJkkdtEwM0LamZOombhG7y+Fvukxn1DgrTwAjRXg?=
 =?us-ascii?Q?f0zy4YWvAVx0dHLeTTLpAHsNwcM0dtXMboMahpPhRwegf034DlPZyJZG581l?=
 =?us-ascii?Q?w8WKjglhgQAFM1D36njmo+lqmHXiaBujyowYcpiQz9u6EZi4MmQhJyRp33FR?=
 =?us-ascii?Q?pirJGGFic0FR0whR+YDZBwZy19G+DPuCGftxMvFqP2mKuiaaDWJcDDvSC3ON?=
 =?us-ascii?Q?uHVqiDgm1xYidDUdKr6CRTFIl2nXH1aiacR2U7V3GIECdQKDtKHhOZjlim/n?=
 =?us-ascii?Q?LV79y6TM1SC0/Ri/ApyEAaAITs7cXk4K9k24hNsmg1NFIdsM3lAqSUAFAAX/?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00665e11-e4ad-4f6b-a457-08da9161f5b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:18:34.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM+c/IiOw1w75yJ6D0LGtkDPTITy6sxtNSVvbiYYSCLsxVbrLn4bCxewC+f/2ifsxDx2Tmy696p3lZ4hShR2R/27pSEa5mFAFXi16qfBE5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The UID is needed to read the RCH's CEDT entry with the RCRB base
> address. Determine the host's UID from its ACPI fw node.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index f9cdf23a91a8..b3146b7ae922 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -368,8 +368,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  {
>  	struct pci_host_bridge *host = NULL;
> +	struct acpi_device *adev;
> +	unsigned long long uid = ~0;
>  
>  	while ((host = cxl_find_next_rch(host)) != NULL) {
> +		adev = ACPI_COMPANION(&host->dev);
> +		if (!adev || !adev->pnp.unique_id ||
> +			(kstrtoull(adev->pnp.unique_id, 10, &uid) < 0))
> +			continue;
> +
> +		dev_dbg(&adev->dev, "host uid: %llu\n", uid);
> +
> +		if (uid > U32_MAX)
> +			continue;

Looks redundant with existing _UID matching.
