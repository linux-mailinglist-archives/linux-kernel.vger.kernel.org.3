Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672054191B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbiFGVTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358268AbiFGUWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:22:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2067.outbound.protection.outlook.com [40.92.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1017C6AD;
        Tue,  7 Jun 2022 11:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nht8JmLBtJXEBznZXi3jjXIXWtRP+sbTvn7iLJq02xd/lanl/l6bWs01t+VBE3VM5dVObDAVNhbX9X3EMM7SeBw68H//7Tu5s42ONJ+8dL+KiqowUrFrP8EzkDI4o+UlVNlFtrYr8OOiC3W2qp06KhLmvHUWgRfrIMGGc6ghwoothAA6PyB1ci/ICOPuA1NynEWjdOnB4fOKZ6yl8nyqYJE2K4HIFqCfYbLP0/hgD5IJuCHx1T+ybci8LpHcQFu+4BT3UiHa9QcfWzEHseop8WoY8RjpgRQ1y4ZoQUwae/Mp6W9hjdHZ/VINuYc8LoPNjsH/MrdSVkN7Q1szFNtiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+Z4zht1sFByQGiYmQIrYXxd2kBBeoTcTO8elbgbnTg=;
 b=KBP7dmo3+QRxCmGfGPXVuqz69AY/on3YVZDa36bYeD4Qhv8QvZ69vJ9ElhCwCTD7Pn01mTiuSuaoJv5Uq5syUWn9RC+rKBsGmR1nEJ6/76NPNTyN7hHOh460agC3J5QOAZep/Qi0chqzveN7PuoTM33gQHuZQVfw50qmaF8prySHhw13qL+DJqVkxCs45s1pmjGZ++WXUx85fkDMCx+AQ+wQVSZ6/1b0uQ+jiqWBW8/vx/qKYJEsxT8VA1Avx+HgFoj9RbvVYuEcyuZeOq2iq+uwt+BqlDTPozM77uPONQb5iiNNFDaZqJVKpXQ8Og4pYBDbbZ6r4NFQKNF5hUOleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by BN0PR02MB7885.namprd02.prod.outlook.com (2603:10b6:408:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 18:31:48 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e179:40c4:4269:70e]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e179:40c4:4269:70e%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 18:31:48 +0000
Message-ID: <BY5PR02MB70099A0E4C060E52284DCE46D9A59@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Wed, 8 Jun 2022 00:01:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/3] drm/panel: nt36672a: add backlight support
Content-Language: en-US
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20220401001810.81507-1-jo@jsfamily.in>
 <BY5PR02MB700935F5817128CB7C3991CDD9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Joel Selvaraj <jo@jsfamily.in>
In-Reply-To: <BY5PR02MB700935F5817128CB7C3991CDD9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [uHUVQl3FvT0MV1NIB42qP0jy67q/XIWc9xEENbIDu+09BEu+ZHOU/UaJZ3UmlAAd]
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <2e964339-85fe-9bf7-2df1-aad3ea593bb8@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 798a7039-6fe5-4154-b931-08da48b3fb04
X-MS-TrafficTypeDiagnostic: BN0PR02MB7885:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyeB/lQbTXB3dIeP7BXG+8mx52D3dl1Ek6zrUtFl1QtshHg6p6ec3VO7m9a6VUQsGnMh+P2YB2HyLWXzIP/BdqRCXaxSn99TN5GzCh63iVIVUbmIa/F+khVaKPrqY5S4PXz7DDnURyR3ZhV7E28sb+kxmNes6gZcuothkB8GEqVCkQXa0sxgrx9jCdFGasRYmWjLZN7KUBk3sHVL+Qm4yeRvDRWkCOMnFBd2QqzkWmzcKBjDjG4DCO0yXy28u4dcb+cFv7e3CcE+4x5Gl8sUzI1YhP914BO4XmF1n2b62n0LB+PAIYhpFT9BkvNKpQBDBUlvEt5SrBQRoab4BjLvuJYznLxGtfhiNr3BKSbcxvhv2p+e2Q2z0raO9SEvWYNXJzLqTfXPvGrEqppPQ+oGS+GpL+uKvG6BRRjCel+EjKHdcFIzIMkf1aq6UiTs9+WEJmSQ9b5qHthokqh2PtgLFOElkI8guSj4zYTIyhfaQtDvDzCpMYV50igKCJryIfp5phvZ8DihftYPr1VzMo5ijK/X739frS1LlWhGtjfcuj0z4SkvH4uj8cCH2Urzp96qYYtTYB1Xij9j6rjAjiWIJQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S252akR1T3ExSHk1QWRhN2ljUDF3VVg0T1BNYjl6dldjckRIWm9EUVVrYUJH?=
 =?utf-8?B?anQzMm1SWHZXbmpFU21DYzF6NW9NM0NhZHVkYkh1cVUxVHlYQm00MW40ZFU4?=
 =?utf-8?B?TWpMbjRrWUx1TWRqNk5FaWZzdmFCVTRBTjc4b3B2WWx2alZMU0ZTck1tekRI?=
 =?utf-8?B?Q0JzZXVJSWlnTm5nVGZhcUFSamVKOUYxV3hnbjZRTVZDQWZSTjIrOHN5UzJ3?=
 =?utf-8?B?RkVTZ2lHRFpacHBiUnRscHRtZGhEblRGc1RTWTZkVkhNVXYyRFZXNHIyREVI?=
 =?utf-8?B?ZG5oQXlGUzN2YkRjUnZvRXVKS0NVak9vanpYK3kxRnlIYllXOEF3ZEdqZkdi?=
 =?utf-8?B?TEwvakNsUkJyU2ZNdWxXRHh2OVVYeVVFL1gzTWU3NEYvdXZsWVNjcEl5Q3VW?=
 =?utf-8?B?T3A2SnpVN1c1aTJpZm9xbGFHZWtXZ2JmNG9MZkNoR3RXTitWL1dPcHJaUGY5?=
 =?utf-8?B?OU1qYk5ldHVyeHZwUmYrZDRra1ZiWFNzV0dvbnpSQVNncDduQ3ZTKzN5UkMr?=
 =?utf-8?B?dGdZTjI4K1FkOGNWUjE5WFdqaUJ4NGYvb3VQdHRDRTBCY0k1V0ZYbys0NVFq?=
 =?utf-8?B?TTkxWUppb2JaY1BUbHlWdjJKTW5MMWh0RDNLRTROOTJQVFVpcDFFOHBXS1Zq?=
 =?utf-8?B?QzFZTHNrODNJdC9DdmJiUWNvU3M0MGZjMWJkeDRPRnBMSWR4akE0THVsVGhl?=
 =?utf-8?B?S3JIM2ZxUW1JM2lJTjVYdW1wSTdwdm1pa2pjL3VzbEUzMlVpby9KRDV0TUla?=
 =?utf-8?B?d3FodHFBdytsMWlWMGZCY2pwMzhrSnBhTG9Telc0dEswa1ZBRExrSWQ3ZXFs?=
 =?utf-8?B?RVlweEZ5VGFvVDk3ZlhKZEpad0Jqb09iT0hqMGdiU0lpb04wU2FFWkV3eThh?=
 =?utf-8?B?TFR5czJJVXB4KyswQkZVU3V3MFFQTExpNGhOTHZTTXpQMlpPS2lYdWFQNlcz?=
 =?utf-8?B?MXBKSXJxSmFLTTVCaFRRd1VacGZVTngxR2tZSjZrRkMrR3B2d3ptbEpkUWZp?=
 =?utf-8?B?OFVVTVhSd2ppQXhTNnpveWxaa0NwcWUvN1RBaWJCTEJpZHJwRGFSUW9VTWlp?=
 =?utf-8?B?cmhvbkJOUW5KQzFaWHZxQXdySC9tVUc5WU9ITXNvdTJlek51WWlTeDFxWkww?=
 =?utf-8?B?N0hSL0Vsc0tyc0I1V284Zlc2ZVZEU0xwUWlNb3VwQ3pIYlp5SlBXZEttcTFB?=
 =?utf-8?B?L1Z2UkJGQk9iL01ZVHlHYXNlY0s2RTBZOEQyVE1xUCtlOTlBeHFzaThSNkt1?=
 =?utf-8?B?dnFKMjJyclovd09GaERkanlxV1RVdnNpR3hNcVlLbnJpbHRlalEvbk5WVDlO?=
 =?utf-8?B?MXNxcnI4M3VMZm92R3IzWmlKSzV1QzArS3ovQ3hhL0UwV2JEdEtxaE8xM056?=
 =?utf-8?B?TTRkbGpBUmd5N0x6VDBjZ3EvMXR3SkpwSmQ5OXBJZ2tYWFRzSTg3ZjlwT0w0?=
 =?utf-8?B?emthQWlaT0luRisrRTdsdlRoQnQ3eDVlMERFNHJCWTM2MjQwQjFaSTZEdWVl?=
 =?utf-8?B?SE1abHlpUnpUTmJ3aW5RckRlVmpMV2pjNERjNlhGWWYxMmJmaVRFNDBvQ0NZ?=
 =?utf-8?B?R2JvSDh5M09pOGFQaU5ZbGU0dEkxcE80NHZMcXFRVktteWNuT3pPZ2JOcWQr?=
 =?utf-8?B?RXEvWDlHbkEvRGRpVG4xN3hnS3ZFOU9Oa2VpVFhzRHByZy93OEZRa3BJKytT?=
 =?utf-8?B?V3F0REk0NU1TVGszNDJzVTdabXdIUmMxd1BQUHFWWnJ0UllmZVpIaTh4YUV6?=
 =?utf-8?B?S1hoZEh3NjM0V0FVdHNyVVE3N1ZTcitycjlaRWNSb1FiMkNxRkp3SDh1dFlj?=
 =?utf-8?B?WXJ6VWptdjlNR1BRSUk0RnNZM29kMnhsKzlmNEhib282bjlPZWk5RU56K3Yx?=
 =?utf-8?B?b2JFZDczQUl6Vi82UTRlN21SZk8wUS9PZWJaTlY2UE9RbnJoVk4vWTdZTWdw?=
 =?utf-8?B?QUROSUdqN3BIYUFhT1pzUVkyM0xPOWJUcGd5L2Z5dlJZSk9YU2c1aEVlNjVY?=
 =?utf-8?B?TWFlTU54b3FRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a7039-6fe5-4154-b931-08da48b3fb04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:31:48.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7885
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can see that the dts changes from this patch series has been applied 
to 5.19-rc1 release. However, this patch that has the related change to 
the panel driver, is not applied in the 5.19-rc1 release. Any particular 
reason why it's not picked up? or just that, it got missed out? Kindly 
let me know if changes are required from my end.

With Regards,
Joel Selvaraj
