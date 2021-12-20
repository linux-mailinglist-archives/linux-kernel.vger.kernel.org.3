Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8047B549
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhLTVhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:37:34 -0500
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:63219
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbhLTVhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:37:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XASAVE/QVvCXMxDNYVgOzj2/tqkpWJ0kVZVXgsFwlmbC8gQWw+ofI46onFJha7qDFlq95fE0dYsMUw+/zg5AszbGoDOKeomvejnKXLkwX1ahde7CzGgr/jKGyN6Dm4pjtnRCWkhSghrC5r9kAeHwMozxZVwbaI8cD02X+Qst7pOfL1QSw1u2xcN/2lwCbI6nHxBvbgM/VeySf1M8NKUr7iZn5mxbQgprD0YdMN3+/e1RdKHkbP+gvS67iW7jBdBsiSIDkjpL9U6pGx6eFtbXbwYvGaykh2TKsf0w68o619Rljx2ap0MyZIVdLWh/vJFVKtpB4ps8KNZiPU0cBeYirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgB7iOo7wf7wf9nDPy9Ka4dKVYu3o232OvyQUPkQ1+w=;
 b=awlFUWonYYrR3UU4fYCCGjZElXFd/OiLSHxaUCNsTNChVm4/mD2Gg3jZT+eI2MdIC5LWHQMK0Zv3ywwVAOM4XcfHc7BDCG2Ep78pP1sPgZVj/wKbumEFjlE4m5tC9NnZZxTHNDMKPFRAgzfMdLV0NvnB0IlNVNR0QU72nIGskNyV+C/dCDYWOTamlsY0GqJe0HchcZb+D8Mp2tmG83/7wGP2gLHgzjNy90LzkoBYFEn+ktTnxeBE6uHKCP+4Fcxy4mt2h1kJgA1Pdd8PeIhX1ROlWfPEjcj2jjQjlRx3gqLRQd8TPLp2ALChTO05im3Ur+80aHUi36wRBEiS8G95Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgB7iOo7wf7wf9nDPy9Ka4dKVYu3o232OvyQUPkQ1+w=;
 b=bSdMay5XFGl62sFZLAx/qUnPhPuaWtbyAo9inI7LLtj70rDzMK8jOvMLNuacc4t5b4/4ER0tuJqpRbq7l/iBDY1feB/81/xpoiWflStwxHyOMV0C4ayqS36te3vRmlk7Cqz4v29YhU+891Kg+kCugfvLqxtysTbj+W3Sh3afSic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4475.eurprd02.prod.outlook.com (2603:10a6:10:68::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Mon, 20 Dec
 2021 21:37:29 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 21:37:29 +0000
Message-ID: <898286f0-170e-633d-e924-a5703de468b1@axentia.se>
Date:   Mon, 20 Dec 2021 22:37:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v10 00/14] iio: afe: add temperature rescaling support
Content-Language: sv-SE
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20211219223953.16074-1-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0094.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::7)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4365a537-8cf2-46de-f9a9-08d9c400ec21
X-MS-TrafficTypeDiagnostic: DB7PR02MB4475:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB44753CC66FDC6CD71E45AE67BC7B9@DB7PR02MB4475.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a86sbql0GblOp8ZIjuweQem5W5SuD1Y4Ymm+DaUo9Dc0A2qAR+ND6tzTn6X5NfT6xxi/NSWRNs4+NkPQSHs56Qqyeqqm8UbWc1twVymw27doh5c0+RcdBmlXNCSQc0R//85Ntmi8W6u8VTPmv4zQgYfMGdOHuWsUNDZNapgrMoewQ9+b6CwP0w8AzQNd3/qF/s6QRMPl34pp+j1WkEYwrJpayT/VbFsyjpnDtHM1IlFLkd0FmQ9uCYTiqeSyVxJKjU2RWjIat9cyvM+h5HOrHvc7fr2NoLBX2pmdHB8K7CRqXTm6TMW+bVC8xR5gLerIrgqoib8uYiboO5wA4x7Rqeb9i0YmlJxPgKuzUexDAmPkmIZ2qO3TGKJnWqTcsI90YpogYC2ogAiy5FqSmem1sHvmwXGmJ0WLoroZVzYeIH9NsDCKB3MGk5/p3GmjaQAqJ4dYdPHTZB7u4H4FyUDw6SApWInKIrOMQkzIHd2g+emsAX8u1nxWvvPiG1P6AIj+lzbIWAtuFgyGCaicJrZ64qiZuT5nW/bFT81QJhxDBg+QUW4xJFacsu/ZsRtZkUyxaZ6C7pBiM9zpo6hRaySHEUaXWsKFOKdDEi51qd6Px2EmhkT0ePuVcaATZac5DkKTk7Z8cgY4BLn9KPz/PC0sC0MAuK/mttHwzuhdmFiN5fzhIGVR8A4dr1qWjLzLfnxlnad3gW+qU2dk6MsoYNZCiKF+XCl5SaM9eKrF2SZrKMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39840400004)(66556008)(2906002)(5660300002)(66946007)(36756003)(38100700002)(53546011)(31696002)(86362001)(31686004)(4744005)(66476007)(36916002)(2616005)(6512007)(6486002)(26005)(6506007)(186003)(4326008)(508600001)(8676002)(6666004)(8936002)(4001150100001)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRaYWMwQ0Zwa1hzZTZIM1RsSVM3U2owRUZrcGdScEQ4Wk5GS3NPOWdEN3Yx?=
 =?utf-8?B?cWl0WE5nWVJRaG5pRTYwbU1ONGdYSjZPNG9qZ05KU1JMTS9EcW9Bc0RBOHBN?=
 =?utf-8?B?SWpCbm10OHFPbmgrRktMNmQ1RWxuTTFmdWRpcitwMkZWY0k5NkIzRGRoSFd0?=
 =?utf-8?B?T2hlQjI5dlNGUEkwdWx4enFwSTRicDIzbzFqV0lPeVNyVzg1U3ErOEc4TnBT?=
 =?utf-8?B?Q3BPMEN0eUU3NnhlNERiUUVIU0UrcXJZMXZobFlwR0tjbUVmMWpFYmNMUmR1?=
 =?utf-8?B?b3k0eWlkUVRMbXZLNnhzOGJFMUtkL0Jjc0FnNVJRbWR2SDIraWt6RkxkdmEv?=
 =?utf-8?B?Y1JzN0NqdmVyNHlUSTM0VkRUWTlYaUFZTkFnUmNmUFI3bHZWdStXWDg5ZzNs?=
 =?utf-8?B?Z0w3Q3FsOXdBdHcyTTBYdm5URWFidjJ3UTlnRnl5QmlTeC83a2srbXJrOGl4?=
 =?utf-8?B?aVRZQU1OTVY0TTBUVXordWUvREN0ZllQWUEzdzNyUE5xQnpaK1VZTkl5YWlW?=
 =?utf-8?B?RkRPRXV0NWxzZGVETmFvWWM4c2VSQytMNGdIRVp6SFZudmtLVHZPbnRlRnhz?=
 =?utf-8?B?S3dpd2pFK3Q0bzh4dCtSSUV0WWI4NU1OQU4xbUdiakVNUVp1cU5GLzVKbzhH?=
 =?utf-8?B?ZnFTU2ZsRFltdUtYODdBZmI1Rk9udjZVaDhOcHd6YllMenYyeTA4TlZyNUNq?=
 =?utf-8?B?b0NZQ1EzTTQvaTJ0cVZXNEFrb0JKVGZYQVIwUmVMYlpobGFaWHVROGxZR09z?=
 =?utf-8?B?VFlTemZ6cW5qa0N0RkJwQlh6dTRSNlpwWmswVElsUzdScDBFd1R0UW5hV25E?=
 =?utf-8?B?V1V1dHNBblo0S1ZYbmNCZmtSN3hGQ2trYVlGYVZ6cldNSk1TcEtaL2pPK1ls?=
 =?utf-8?B?S0RnWVZOL2FPR2QwM1BvdUdEamxmcGMrb3IyYTYvbHNRYU5YU2hvUUVhU0k0?=
 =?utf-8?B?R1VqOW5jV1ZxdXR2QVVPNDhIYkRPYjFhRGdrVE94QjFHZWF2ZWhxM1F2VkJt?=
 =?utf-8?B?RHZaK2M2cEUyaEc4WEszeSsvdWtyRTM4ZTdVSmxPc2JRcHRKalBnZ1ExNjNS?=
 =?utf-8?B?TUlUN1JDd1Bxa05obFNkWDBjN09LS2Y1RjFwNXpaaG0yeStSVkU3K1NFclA2?=
 =?utf-8?B?YWNqL0pvSXE1U3N3Qnd3RHl0SkpFVGVKTWNvOUxQeGc2Vlh1T0szY2N6a0t2?=
 =?utf-8?B?NGRtU2E0bVBBZzBNRlZVb3I5Wm14N1pqdy9QU2Y0QXA2MjhvWWJyei9Ta21X?=
 =?utf-8?B?MGMxQitYRU95c3BYVkI2ZUFZWUZFajJMSnJnaUx4OG5Vc3J0Y0Z3Y01aMnUy?=
 =?utf-8?B?bGpNaUx4YnhNeXFYd3BuK1MxOFI5aWEyRGZHNzZ0R01nZVNMVFBTclFIa1Z3?=
 =?utf-8?B?a3czS3dRT0VyZTMxK0lodWxZUGx5ZURTREZRR1k1QTk2S0VFUUszVzU5eElM?=
 =?utf-8?B?UDVWUFhsZTVJNVBYNjZnZ21jY2xCNTFKMFU1aHVFSzFMSHdhdUI5dFRQdzc2?=
 =?utf-8?B?R0dTVlVvSnhuWXBIaVdtSVNKVWdJa3ZWQ3l1MkpRUXNNK1lQc2EvcGg3enkz?=
 =?utf-8?B?QXIraDdxVEFsRlBiK3MrZ0cvZVJJWnlveUxxN2RGQ0FnTGlyTEMvN1o0ZTdq?=
 =?utf-8?B?bkhqMlJrYUFMbkFITGJkV3JCRnFvT01yckVmeThZenl0Q3NIbW9lLytzYXF0?=
 =?utf-8?B?dmQxU2tlRnRqNlBUd0djMTRVcklOcXJkZG5JWnVncnRVUXF3Q1M4VnVsZ1Fo?=
 =?utf-8?B?a3BpNnFnay90SGlvS0gyY1IrYXdOc3BiRS82b3lJRFAvYThld0NXOUtpUWhm?=
 =?utf-8?B?Ym1UK3FQNlQ4RFdqWU5rWjJVcHk5MjZsTjlDaVRqejdvTFlLR3pkR2xOVVdP?=
 =?utf-8?B?eVV5RUgwY25sdURJaThHZ2xpcXh3YVZacHlSMFFWQWRnYnRNSCtpRGQrb2NQ?=
 =?utf-8?B?dGhXUHRoUVR0cXY0UTRmekpOa05FRmZRaUZjcURoQTM5WU9CdFg3SlBhRzFY?=
 =?utf-8?B?UUFSTkpyZmR0UGoyOFBjZnlYQ2R0VUZObUxTTFEvU0VYRmlvUkhPVWx1MGJn?=
 =?utf-8?B?WmJqMVVya0craGhhcGhoZWlVYWo0cHpORTMzb3BsdDQ0allRMXd5QUdONllt?=
 =?utf-8?Q?ZJgs=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4365a537-8cf2-46de-f9a9-08d9c400ec21
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 21:37:29.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgiU0PTUKhRUs1BhfeFpg4/86HLM45WCy+c7C/eQb6SyaXzv4/jbeB+Fv04rQUAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-12-19 23:39, Liam Beguin wrote:
> Hi Jonathan, Peter,
> 
> I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> the rest of these changes pulled in, but I don't mind adding a patch for
> that later on.
> 
> This series focuses on adding temperature rescaling support to the IIO
> Analog Front End (AFE) driver.
> 
> The first few patches address minor bugs in IIO inkernel functions, and
> prepare the AFE driver for the additional features.
> 
> The main changes to the AFE driver include an initial Kunit test suite,
> support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> and temperature transducer sensors.
> 
> Thanks for your time,
> Liam

And thanks for your time and persistence!

This now looks in good order, so for the whole series:

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
