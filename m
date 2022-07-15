Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A64576741
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGOTRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:17:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D342606A2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657912672; x=1689448672;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=V4Eewf6lWyUp24qfZWpfsxA+0VBIRoC8t2PNjrEd1VA=;
  b=Xyu65RvPMPPQtciwk70nJe2zaNoYHLQxqumFYwclP+S1Rj0DCQ03JBGv
   k/WsP5QcFNFbQxbt9Dk+SDxkgnl9O/Qi6ydoLxqsUo6Lz5HwtxQmazcZL
   pj9GG+vTp8lW/DHCVq8e/KT5cpCaRWsuiW6PHhCeSOGGKwG+A3KXqe1G3
   VpAQ3Znkfs5hBbK3q3VEeUmpe7n8t2aGR++N/nmOialF1eEb09zEEEfA3
   RqttLBN0jviPzSKPx9C0Ijn4XEkn0pLTRwK5LBf7E3+768bmFlRfWEQEB
   X/PegPl1OH7guYm2zskxA9VnMnl1JJO/LgAWx9r3h1jzcCSZF/h+Rq61h
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286617710"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="286617710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="773085852"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2022 12:17:51 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 12:17:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 12:17:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 12:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b57l+VyAZUgwA5NKUcK0isiTAXdQGzFiQ6cQIoiQjHyNyk33L8T9zAU9r7/4UDpMa/CADfUV91k24i+bo2gtJrQlVZlgkOzV02PsvrkNe8DaBBiGkuAcsVjCHpc3K6xn99PTizsJFonIgqRV9+KWFKJjgiXyC3A065ksVSFxLXFyBkDK5k/K+1h43YEXRwP7iNRsSk9PYgSgf5nBU2+Shmdj0DP/M+hfTj8VGhwc0pP48FvRjZl6c05Fsvl+aG2/S+Cay/IoyrpbSC0KMk6tVGx9rJugUXAzRBYH7uuOg1Gs0Mr6Dsy+79VcI41NSSLqGeZ6tsdcpa8y4PeRMOQ3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxpAcl1xCwBXPDwwwRjOPUZXDfiPS1xVmqc/42D/NTE=;
 b=FSEe10wMm02hEdIIy4EfbkFbo6zrgJ0ezdpS7zNcBmw2J00lorgQtFBkKR9lx3NLSw+hhcL0l4z0voSzzKM35CW98NgsXjyWGs4yZerVgR9QpPTJlKg2FxPV5vbmRQWdp49x+BRBJy3Ut5y+PLpKnQPHC+Won7pPcTSruS3QPXs4rVYrN6RMyAF4VHevdQcO0M4xAymby9SaO2bN0DLFwtfMyH46nWMAb8oBArfI0xP+ipaOMHcfj9AhY47OnLgaW2SXQlpkuVOZMc6z/7YoN42Tyqr317ZWNhuw15alUGQUT6Tqnm8CPKxYD9d81rNP7Z9cSPiV/NSG2FFIoCbsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB3559.namprd11.prod.outlook.com
 (2603:10b6:a03:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 19:17:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.018; Fri, 15 Jul
 2022 19:17:43 +0000
Date:   Fri, 15 Jul 2022 12:17:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: badrange report spill over to clean range
Message-ID: <62d1bd546fce2_242d29499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
 <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
 <62d0c0947c3e6_1643dc2944a@dwillia2-xfh.jf.intel.com.notmuch>
 <82641e64-1003-d11a-df9c-73f3b61d6b8a@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82641e64-1003-d11a-df9c-73f3b61d6b8a@oracle.com>
X-ClientProxiedBy: BYAPR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a63f5760-2b6b-4747-1575-08da6696b122
X-MS-TrafficTypeDiagnostic: BYAPR11MB3559:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0TwsSfLKu8yrPcYb/+eNdXbLvdih6DREcDGJjsdUrLQllSwpDAKg7cq07ejcF4hfo2oI66W/BW00A5lztYxGA2+nhUN1ZPCWt/KKpUe/a/tszu8hWxXf3QpBTkFiqHi5Leb/AtiFsFjOy7/5a0/0ujLOWuYjT0y1eRkPEJnBpNv2HCCJQ8Q5OL/+2oULV1l9k58D+mBWy2dCWnjWOSeeQwpE/moLXNDzgl3MTMFeySAlqn8gFT6cVHorMmAIRsqz1SPWEAHtDtHH9sh2CAoJ11FZMi44b4LRhGreSvmE28F2/FzZZkt1sFpI3ejBo0hdkgU43rdupcI3G0te1AwrPI3KZ8zkKIMjjXAxl4RT+YEGtoEI9686KLCKWw80nwnl1JkMh/LRSOIoQOXcWKlx5rEWWRBbEB7HsOBTV3C/mqc9OSXG/j7SW62MXYmcx1AZZG+/iTOAE0ulbSDzEuGL16xRQGLRKiMGAlLP9o7QtXAYyX2268HCXH8tWymJjxYGfY+dkUaHwED/+KOXOnfjhfpgDhJ80ZQZEDF43ARhh6W6vgE+1KHdRFd/QnZtd6Lkh3uG86XoPiJlkO11/ezoaD6KSu0X97/GEvrlZWYBSPqq0R7zGZpUxoAY0bkIXQg4fNhS1QCQ+bx3lxlXzzfi04j1Otpx5rSNHdDXqiAntvsE6qUx8zd6nF9TDjcvTsH3QnkdhIS3ydHnQLvxDy7w3fiJbFB2+HBft4lLb+L9RaBwBQak/nufjCPp/mxM1aL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(396003)(136003)(346002)(26005)(66476007)(6512007)(53546011)(66946007)(6486002)(41300700001)(6506007)(8676002)(66556008)(316002)(110136005)(478600001)(86362001)(9686003)(82960400001)(186003)(8936002)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PuY4Wh3i3Dmu4gnDYMe58t7UxbJezK1zbo49FNAMLs64UI2xt2/m3RkdpKG?=
 =?us-ascii?Q?GuIes2ZqRWrKk/udXLmo4ciTa5wccDeYNyGuYF9ApK0lbPZZSxvdIlyD3kIv?=
 =?us-ascii?Q?EZ51L61torJBJz98V9S38biHVhXl8J13s3U+xWKtGVqrVi/IMM0GD9ws4KFF?=
 =?us-ascii?Q?pROiFmfOvvxNtUUYES32DIQt5VGz/dI4064WRnV5nkXOwlGbCLMokK/qauX4?=
 =?us-ascii?Q?a9giCOhTzYY+E42QhegYMbHJDCCKN3c4zh20WXSuDJUnme2RU3GRObbaXGid?=
 =?us-ascii?Q?6vpcVeRmP6ffSSfI6zhZI9gbpFDyzlVwD5hbP9mcHxKBftWmE5g2el0tL3QS?=
 =?us-ascii?Q?05a4Q+A4dNl+VOE/5gNDbTU5ftjk0h0+uA0MKrsP2VheDq1wD7+slP13D/tw?=
 =?us-ascii?Q?ZT2s5CxQfpQc/EVSKfukTT1pnOWtYzwCfaco2iS5pnC4KfXS9NUjIl9aPBxF?=
 =?us-ascii?Q?oi7J/AR4FFouStx4r2X8neDOOz+SdgFCusY9rcOpJPOcpKrOkje1dbh8FyCT?=
 =?us-ascii?Q?tTevk4TR0KZ1x5znyywgYRv/zr0zgWsHGEHvauoZOurrDuM8HdFlM8TNFiID?=
 =?us-ascii?Q?2woCitqnTJLzBzM9kI98HBM82FoyL2qrXZwDMgwpF8Lo+ZnVvd/GZkAzdic1?=
 =?us-ascii?Q?E6tix3ot7uTITz262fWgFlpUwBD07Cq/UPk6V0D73GOyPEWmqZ12+kvat1Xz?=
 =?us-ascii?Q?YAhay6OdARCrvA66BzYsS5Xc/6CVdTYYYtWPtGRR5JpwvCa1MR3Eo70LyYGM?=
 =?us-ascii?Q?eIiHFFp/p/yyObloJuSS4vspvFR8kuEOBMYfmQhjLmRHg1GJvjTgdhZBO10l?=
 =?us-ascii?Q?tPXtpuQjs/YNcQYboIZSqZxo12Y/hcynf2cce7IXP2CAQy9nCOEnqp3d3+4E?=
 =?us-ascii?Q?PXIk7Nn5O6PaKnaIM3yFOOPoO0OFxXCBVTN3RR/CpQev24PsbD6ZyalBiMCb?=
 =?us-ascii?Q?KAAMT0WftbQZFSej3KA0ARKrTX1ACQl4twPlQh+lXQb6/Hp4eixMailgO2M9?=
 =?us-ascii?Q?2ecdBz/sDe2g/owqHOnAq/rJzzE8DKR1G0e9AIouiOcJwUJ30CuHNbY6jpnQ?=
 =?us-ascii?Q?35HWk8AmOtEZTfclwDtjVAN2MRnz6GJxPmSEQ1O1xRfCiGGliX/jwOIL7HIt?=
 =?us-ascii?Q?DFTChJQLkHxMzRL+vD7HtLwjpR1ZVGsm/yXtfmlkb5yqNRdaychNsobNKVwz?=
 =?us-ascii?Q?dAKN+9iXN+HL+lGzwUVOqmoeirwiWBdf+h+soOQ/M9oRkt2oqxVfhsDIayTk?=
 =?us-ascii?Q?jc8oaZw4fdQAOAACzsWpfzb/7CB7GP59tHVREYyg5jeEMvdmUaTiV8pt0NIU?=
 =?us-ascii?Q?NTFYtyo6rMBsF0paE8uZbIrHbOh8sn0WClUU+dVMz9Aie7gvIoa4qqGacqiB?=
 =?us-ascii?Q?Uc2alLTFjx3GZxD3EXcoGom6+VJdGi1tpXNBF/aNqc65ggkEjLHMLOeJB33d?=
 =?us-ascii?Q?5ic+7bDqYqVXAzw3qHWzEigdmZWtcnlXewuTFRxoasa3r6bicXjGxCFXW8BJ?=
 =?us-ascii?Q?HvOG3TGoHDQNtncZV3LCauqgYDoinSDDGF9nnh2BHobf0HsK0btBRLSx9+Z0?=
 =?us-ascii?Q?zGqFqEydvoNsVBU6a8/3h1/I2bhmoPg71qZ6t+O7Eid3lZQTrYY1Csw2Azfh?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a63f5760-2b6b-4747-1575-08da6696b122
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 19:17:43.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80H5j9NTOOznG/NYbZlpRgFYXq6VPIUKpyJO7qzHFOLj3j6GWqWPmiUUZ6EX1Xe9DGp003YODKkczQrawyyR4eXHK1d0wiTqI2HAMYSNoXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Tony ]

Jane Chu wrote:
> On 7/14/2022 6:19 PM, Dan Williams wrote:
> > Jane Chu wrote:
> >> I meant to say there would be 8 calls to the nfit_handle_mce() callback,
> >> one call for each poison with accurate address.
> >>
> >> Also, short ARS would find 2 poisons.
> >>
> >> I attached the console output, my annotation is prefixed with "<==".
> > 
> > [29078.634817] {4}[Hardware Error]:   physical_address: 0x00000040a0602600		<== 2nd poison @ 0x600
> > [29078.642200] {4}[Hardware Error]:   physical_address_mask: 0xffffffffffffff00
> > 
> > Why is nfit_handle_mce() seeing a 4K address mask when the CPER record
> > is seeing a 256-byte address mask?
> 
> Good question!  One would think both GHES reporting and 
> nfit_handle_mce() are consuming the same mce record...
> Who might know?

Did some grepping...

Have a look at: apei_mce_report_mem_error()

"The call is coming from inside the house!"

Luckily we do not need to contact a BIOS engineer to get this fixed.

> > Sigh, is this "firmware-first" causing the kernel to get bad information
> > via the native mechanisms >
> > I would expect that if this test was truly worried about minimizing BIOS
> > latency it would disable firmware-first error reporting. I wonder if
> > that fixes the observed problem?
> 
> Could you elaborate on firmware-first error please?  What are the 
> possible consequences disabling it? and how to disable it?

With my Linux kernel developer hat on, firmware-first error handling is
really only useful for supporting legacy operating systems that do not
have native machine check handling, or for platforms that have bugs that
would otherwise cause OS native error handling to fail. Otherwise, for
modern Linux, firmware-first error handling is pure overhead and a
source of bugs.

In this case the bug is in the Linux code that translates the ACPI event
back into an MCE record.
