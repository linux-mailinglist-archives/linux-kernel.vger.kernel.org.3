Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E3495A23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378773AbiAUGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:52:58 -0500
Received: from mail-dm6nam11on2115.outbound.protection.outlook.com ([40.107.223.115]:25216
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232349AbiAUGw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:52:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvB1rbikJb82j7bhbRbXo0tv6vdEwvsxHufaWJqYj3vlkBTslUUaLWHHJnyMl+RAzggfJw1RvKl3aX1T3/CREA5G78TkyGU+hTcdkO01wmgWkXLH8h18de7HQHLulcVZzVRmhlaqXCt8GloXPP9Pn36p3IcQH4e/0301rOdBluooR7Klu92vHr64xrJoc70CHldrXx3sGIGot6dE5J2J0ZEad9R26vxUV6UBptGdy5WPRzj5GSW25YVDelvqLftfk1KyGUbY6PWOcpxzaXY1UrIfbjWGf/x5nL1WBEttw64DYpHMutRaPKTeyOLcnhpQrbjq6foIv6SQwlIoS3fPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3Y24b2IBENytMc64c7sZxTqwH3DRKy9bYAXOq9Wp/Q=;
 b=fFXV2tROxsyk/9JdZxcU9SBoGzCE2Y+6Y0Q4zZZ49ATsWMpLUfHHyfj+siuksGTwRYbvNFdAlEmb7HYyaI6MtTs8D9GH96ZYodm59fXXRAHfVJeGACd6/diFoG9uUV9peeo5JGnt4xUbbUGC0YBBLLN5ou1oa377jpTvO+ot9a10vdK5DwCs/BIzbaLV7omsTyeuHzC1vPwVQNXQdJD9Iwudq1zargKts4VGbzhoZjb0Z6Ee8ozSEAaUj0V01LKeAKrngjfGqhdm2HdMUJ/lQuyxX1f0tS7ZOIkpqJDJNEaHIOr1kXkfXDh66MlmkrQKTl3BzgqOGHOyBEQSzwaTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3Y24b2IBENytMc64c7sZxTqwH3DRKy9bYAXOq9Wp/Q=;
 b=axDkm/8C1aQEGUBtGOym7ivY0ZlxInT3w/Lgy/9d85m4QZI/I6tXTB+mibjN0P4Jhiv07u2RerGOz8xxdVzlyYWAPDkq4OnX5Kktr+yjhmZMI17V1HKLkBjeT2b4Iwv8LzSrRA1H5TQPUqKR8dTuSVmsLR6bnnavF11dK0yHDKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by PH0PR04MB7157.namprd04.prod.outlook.com (2603:10b6:510:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 06:52:52 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 06:52:52 +0000
Date:   Fri, 21 Jan 2022 14:52:46 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Linux 5.16
Message-ID: <20220121065246.GA2039477@anxtwsw-Precision-3640-Tower>
References: <20220121061728.2038851-1-xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121061728.2038851-1-xji@analogixsemi.com>
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615c649c-1e04-4958-5e5b-08d9dcaaa4d9
X-MS-TrafficTypeDiagnostic: PH0PR04MB7157:EE_
X-Microsoft-Antispam-PRVS: <PH0PR04MB715719A4D62FC73950EBF1C1C75B9@PH0PR04MB7157.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJ5kGftmyD0E+QwJU/zBaCYON9fCYLRSapJjEB4Ox3ts1N23pG26m+GhYrAxCkg75asVsLv38XWX4KE0+EbxZMd0lpblptSJ7TifD0NcBA0nKvIvkXn8tL7HacTGeVRn8/YXLW6GJiFUfeSp12ubp1zwaJNZoSyci+jH0Q68owHEwVmOFZtmpQ9E/+DDMQ3tfJEv7Sw4pn7GPdM+8MhT//5I36Sm8upGGzZD99y7Ax2hffifyNggoKSy1MAPKhbYJOa0XhmMIniRi4GOsUZC6McEPn7InpHnRhvAF9RwcAAdII7FXbrjOpZXdHkabcylWALHPIiPqkKLDpQEZtPtDhhCOE0OrXT5WcappFdRcFdDupFUPKjpHTsoBU0FYhY2sBWmrj27/tTXQ/xKklzGOD0ybe1yqi4sRigEYIwulbHYqWhFwjLI2MPldHf80KJKO9kvWhiJhxySq+w8efLwfL0pLGJLO/90UuH6vrFjT++R4yVBJJk3fpmWMLOetkhzFnT7UiOB//6fPj9kl4bRMBcbODd2DMvnyGinrGwFosLR5R/A/FGKw+Qzjf3C7q/1giu0Qu9cg2cq7NGkwlxCi0BfUDcoxfXxtbeAl99STBNxzqLa0Zq0eWWg4GYFLzv2Woxt/aG5IPeLXcDaH5VXlcZpBY+oZCAfF96tCGSiKZAQDReJgFp1RWE3T80fN5pI5aBt0EPtPKIj6/u8Hlf1/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(52116002)(5660300002)(6666004)(4326008)(316002)(83380400001)(8676002)(86362001)(110136005)(186003)(66556008)(66476007)(26005)(66946007)(6506007)(55236004)(4744005)(33716001)(33656002)(6486002)(1076003)(38350700002)(38100700002)(2906002)(9686003)(6512007)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMBKmW0LqcWb31P9f1Rzd9TKMt4j1phW1OFMI3PqEl2+Rv5fYU204DQK2mSi?=
 =?us-ascii?Q?WTQrHnSjAIOiqjnnyWONj1b7oBesksG/J+AhV59G6HrvMq2PJWCQxz4IgS7O?=
 =?us-ascii?Q?TzVUT0sBf09OMdUUSNj9ZH0fnK047Qpyy5cXauV139dS2RzZUJ426Uc8U5Qi?=
 =?us-ascii?Q?AyqkxIQahqamcg1sh2SNPu+EP4rYIOgBjBR8C6ZyECE4CDq2Tx4pm4tOxYA8?=
 =?us-ascii?Q?Vbwb8BpucMTreXdMBgMsyVlgWUrUQ647V8bQPesHO8ptgIwPAQysIuZQphId?=
 =?us-ascii?Q?y+mxpPe+tibqAfDgYdRZlvhABi/DzxCxYkKxdjo1AEqCEcmqeUTjPvdws0AA?=
 =?us-ascii?Q?4g8l6t60SmGLkD6mm8dfBxIgjz/s1OcRomeBtVcrgde5HVMADBG4foDAlV3/?=
 =?us-ascii?Q?lJvF7KYvjsPkIg6tjWIu9me4sn/jmYAKM+5a7ufwAyMUvQug9XLJnRZGIIvd?=
 =?us-ascii?Q?2FLnPbgoWahokEu0XO1TWLFr0YKIl9OWSODy3bj7ZCM8v6AJTmFToRI6uADi?=
 =?us-ascii?Q?IT1umuTMgIhv2wiMmzLdy8bmD3bT0ww5PuESPRYlaVMeza48e9RFI6OShzZx?=
 =?us-ascii?Q?buDj+UQMyz+RTQMKBh7ryKScjG402dbKBKYdCOuUcUWHr6BuB1qOpx4O28pe?=
 =?us-ascii?Q?bMm1bl+Ans6XXQbaP1OYTN4CO86/vIbbbCLbLtFk/JGYQBIp1CZw9Iap1xtK?=
 =?us-ascii?Q?vhOZDXEMibrOhTxYAfmvUX5j5ASdntKE2l7XhsL5NUCMWdLU9BAOKaNWNQ5H?=
 =?us-ascii?Q?VlAd+T68MDZVz1k8lIk/dc9zn19ecd0TY1LRHyN34xEoDSLP2abbQwXpkJp1?=
 =?us-ascii?Q?OFrEcgijfyrv+CDn7THCwsk9tgyQKv04ZQxk72ChNC72R6qDolEL1X2Oipmx?=
 =?us-ascii?Q?K8o9+S2gB5S4/kN/Rq01X4nOpKiyc+eNmfv8gGm08cUSREbnrtDPzWsRfsDo?=
 =?us-ascii?Q?FdFxrWu3DQbsMC+0Z2XHxGuIxgmg2frb8npvFt1gkdTh4ayVLGX3tqi9zYZS?=
 =?us-ascii?Q?uRbrQR2jpJFQ6FrURxK2iVtAQdtO48jh+JbjXoXKI3/or6jsQ2fzgXdYyIhi?=
 =?us-ascii?Q?nhpIb85HguRyd5Cvh5jZjzBda2LM8S/nkdBKvTKKWzVLGeFIG3kw8BDy50dw?=
 =?us-ascii?Q?KwZBj5OXT1x7Bmqvuf4Wiyo0PK5AA2pGWKH51d7GTfZp7FWYIviRAdwZr4K1?=
 =?us-ascii?Q?Aa4EPFXjT42C2brxB4A96uta3UY/ODDFcRFcoqYshge6ugIvs/eefepS6fo4?=
 =?us-ascii?Q?/pPZpFmI7liHKLBJyKPWJD+yxRMsxJq3mxmSaW3AXFS+lxRHSmv5hu/lyPxW?=
 =?us-ascii?Q?pEUCs+qjiG5AIntbYXkXcVT1iPLrPc+9QRg9jHVH/7nW/cD8MRrHIR4QKztA?=
 =?us-ascii?Q?7c/26hX2KHkyFcdu9QfjliUda8zFv+JLWMJw2HIvStOr3ux3GPgt6hyauni7?=
 =?us-ascii?Q?Q3u8QFww0kYLKmmgwU/Ywp0VBaS7NbyA9Mj4yId1POSGcR6y5cXhgMWFtVkx?=
 =?us-ascii?Q?aaT33iAbqgn5+eplpbR+cn8MQYlOU+uNMT+Y8+o2Yq4NicWs5Ni8fYHAjo0G?=
 =?us-ascii?Q?9yTEiU6bEpufzIyzfqpLiGF3p1HtRMPtEudArW4v0kSBtrkwqN34yWHgPbBd?=
 =?us-ascii?Q?pgKIsNhs4wRcXBHENSNLrvU=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615c649c-1e04-4958-5e5b-08d9dcaaa4d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 06:52:51.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYgyCQUak0J9LTX0fb+Px+9qtw0AGb69O5G+unQ0bGL2qlUNmMVCsevnjYfpa/vejO0GsTaIIHdcFGI6s0pCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I made a mistake while upstream other patch serial.
Please ignore this patch, sorry for any inconvenience.
Thanks,
Xin

On Fri, Jan 21, 2022 at 02:17:26PM +0800, Xin Ji wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 16d7f83ac368..08510230b42f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@
>  VERSION = 5
>  PATCHLEVEL = 16
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc8
> +EXTRAVERSION =
>  NAME = Gobble Gobble
>  
>  # *DOCUMENTATION*
> -- 
> 2.25.1
