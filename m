Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7614D4E4762
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiCVUXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiCVUXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:23:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2055.outbound.protection.outlook.com [40.92.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86AB6583B;
        Tue, 22 Mar 2022 13:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbT0pdFNaFPPp91htMftj5Nd6R47A1knv7hXDzLve3mBl2+Pfwiu6AVg6s3S+L32tNy+qhv5oZMCaz/RGn8yOuoDlnoxrA4M+HAemkHxiibU1zP4Wh7kNQDZhGe6WuJ25j4Pn8x9xKeE8PNSUjRLKuREFB4QoDjsmZ2++jil0wIq9R967Fy0KmsnUtStzBLRQsXqMsqZ/6lo3AzyQ5oup51a4W9SVSGojs/541uOdNOQJ8E70v0b4voa7Csk/mr4gRXvzIsw66vUV64O0eMlBe0ZcrxszUn9xXzjk5zod+FWbcB3ZVCEdqSy9W4aDDon4HO2goAIVCEG/V+zez/1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKUdJNU3HsjcgvpaDcN8glDhmKdVXPbWmZLHDRSf3E0=;
 b=Tdybg2mXJdJuN7e0zfG8q93e2YrKOxa88ukdrPBFuTfN6yBJJGo88/eczn1uV8ZCIZUh9ay+e+7s1UKqHqMjQp+Yhqb6ncdM12Lfp9ERghHkje1yPFgQ32f1MpHK5E7nBNctdKEIQcrMfpTS15MzKc6LVG8rXkgxoUtn1aOnSFK8nQH6dTVE1vDkhezZu/04rwcoZkh6kItD395RDyFi+VwC8/MOutJ8a/M63PtlcQqIo0yVNOStmqCvZykx313LHeiruPmjeOpsgWyT9Xi9ksn8f9npSu3JlIaxdLPIJyRa0nxOj51H/fEaSGotLAm2FPEdbL2sXwMk5Py8RFDv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by DM5PR04MB0253.namprd04.prod.outlook.com (2603:10b6:3:6d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 20:21:38 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 20:21:38 +0000
Subject: Re: [PATCH 0/7] ARM: dts: s5pv210: Bugfixes, features, and
 improvements
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB05673676DA7E6E4BF275305ECB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Date:   Tue, 22 Mar 2022 13:21:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [HAnldOGDVXVzGXgH6cD7dOOUFnHCnq/znYc12QJj2+5/Ko6U/+1x2kOgqP+6BhTh]
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <4e451cff-6907-8c6a-8758-77a1a20abc16@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64f8564-60d8-40ec-dcc3-08da0c419160
X-MS-TrafficTypeDiagnostic: DM5PR04MB0253:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAk0R7B2KC721hdTlaZjzLyUlkGKFEd7RiycwbXcO691jLMhDIqMs+n5kYlissTHotnmbhAMj7Az308HAXVUyLxjN2LSoQ4PjOuLe5WztD/n6O/zyF4O2BN5xouCbJ4hsX3bXT8YM9rJcq1j+sOIoZyje4K/DfRzDJ/CwLf0fx7Qsxm06hkfDp19MQkzkmS2CHPmN2tg37xP+MdfXm1TZwgxic5wi0hu7MLVr1BxfttU8ILgGF0oPOENpenkwWtir3Xh33RmOAeBHq5LHEUzryRzGYAT3qUurFtOCwNr++A2I//3dQ89bS/i8X+upAHTxQXvd5xBgJX0Xc4x6YogcP0MBS8/RHO4K5KpVT09bYwr4BgcWvw804201VRCnTVJWaw5VATp6bM4OqWH2PA0Bo1bqhaVByJNtnZtLPuLlr0JQEDMj2iD7CeLg1++9OWwDFIkBpCX/LIY9QMzo1k5rYhel9Z9i1N5shfdsMpG7HGa1WxNdLjktb/NlRMW9BaLfPZOFp+je/PQerO/kFB11ewkRP/hiLz9UhxFSXlYc089gk0UzQ4TyrztSdogVyCn+fE4DrnNO1XDkFim/33vJA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym9OK2RvbVUyS2pEdlVoTUh3a2ZZUVJJSkplRnJjZ3dLVDBZVnlNZTJwR1NJ?=
 =?utf-8?B?MDIvVExZM0tWSWlNRmlOUE5WMHZBRzNFZFBIeDYxdHpRZk15ZXBlNklxZlNX?=
 =?utf-8?B?bithcHgxSVFzTHkvN05wR2Q0SEFxQU9xNzIrZVNlRzB1bmtsZ1lZZ3huell4?=
 =?utf-8?B?WlJqOTgrYm10Mk5Oa3h2T3hLdEIxOUtlRXFBeXJDTllyZzIwOEZrWnlWUlJQ?=
 =?utf-8?B?WGdqWFpJNndSWUJ6UkpDUUtleFY0Y0s5TTBOQ002bDZwSHpUYmNGdGowMXhp?=
 =?utf-8?B?RjlaN1pRQUxsa2prbm5YVEVreEVUUDBvcVNkNCtpb2JmbHVGVzZBSzMrcXpG?=
 =?utf-8?B?bWlhb1dyTCtMcCtGTEVwZWQ3dmtPVDdMSW1EdHNPMTdXNlBKT2Rocjh4Y2Rv?=
 =?utf-8?B?WENKWmg4Y0VMeFhnWDI2bWRMWUFtMG5JL3NELy9nQ21iL1N0SlAyd2FILzVG?=
 =?utf-8?B?YUZoZTJjZko0cVJ4bkhhb3ZYSjZLbXd0YUNhbUx3ZDllN1JjNWdFbVc3TlRz?=
 =?utf-8?B?ZlpoZFhYSXpJVHpNdWZ2ZVk3L1BqT2VDOFF2Ymo1NTBEcDNFMEI2TlJMUC84?=
 =?utf-8?B?S2hMVjd5d3htbFE4SmhqQndjSklHY0dPbUpYeFhnM3JiZDNuNzY3N01sNHFk?=
 =?utf-8?B?dXBQR3M3RHBqajJUMmZjSG5QTnA3aTdLN1dRanUyQXlRQkh5RlBkV2l4QUtq?=
 =?utf-8?B?SkRMb291N2Vib05WRjhPd0pLQ1h1M2pqUkZqY0FPdmh4SGV1c3pmcXQxQ2dX?=
 =?utf-8?B?TWhRd0dwODdPQytLUWtlV2lpajhNOU8vRkExV2tnbGN0UklweVJ2MDFEM1VD?=
 =?utf-8?B?NGpXcEd6U1FJZlFXTmRyTEhHNDQ4czdnK1ZCMTJseWxlU1M3blV2Q244OStE?=
 =?utf-8?B?TjE5WXZ4dWs1bFdveUdLU0NVcFBPNTlBM1VyR1RCN3VJUXZPdVVidVNwT0Nu?=
 =?utf-8?B?YmpwWUN2VDNJZVNacjhrSm1QOEdQZ0V0cTYxV1QxbGFDTmVka1BRTkxQV0FB?=
 =?utf-8?B?ODR3SlVRNVcxcy8yYXBEM0ErdGRxV1M4L3J4NVpna0ZMVXUvUDZ4eEFIV0Nr?=
 =?utf-8?B?KytOZk1uRG8rQ2t0cEl3KzNOOTcxS1hoYll6Z0pwbXk2dC9XRTk0QklGa0Nl?=
 =?utf-8?B?M1UyMGhiZzUxOUFWM2R1ZldseGZENSs1cE1oeHJZV05IMW1RMWNrK01mUG80?=
 =?utf-8?B?cWZrS3dRSlQzRmFYQUtrcXNseU9ERWJyQmoweWhYV0JXQ00rVUNZc0lCNXlW?=
 =?utf-8?B?Qk03K0RKN3FRZVBVYytVaE1QeWIwWHBnQ3AvZWJPTkpKT284UGNKY2t5SkZs?=
 =?utf-8?B?T2hMd2lhaktCYkc2cjJEYkVtcG84TngzSHdxNDcxdWhkdkVIeVpENFk1SUxr?=
 =?utf-8?B?TWFpaXpYZW16bXBPTmJUQ1FHbzZXb0dLSjhHRldrRUN0YUFtajMwN1BBRGNB?=
 =?utf-8?B?WmJCcmhUanAwZVd3WndUTldSUkdmQnZkL2JxaEZSVXRuYUxyMEQ3U3BveWho?=
 =?utf-8?B?VHFvVzlSTjJXaFg5L1ZKdkwrNHBJTlZkcVR1UFl4WjlPRUNFMlRYcTRMZFM5?=
 =?utf-8?B?VGpIMzhtQXhBWWkrQVdnSlNzcHU3Wisvc3JzVytPVkF2aUwyZWUyTnh1SDNm?=
 =?utf-8?B?azdDRW8weFc3cG5La3NLb1Naa3lPVlE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b64f8564-60d8-40ec-dcc3-08da0c419160
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 20:21:38.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0253
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, it appears that I ran into connectivity issues part way through sending
the patchset.  Should I resend the entire series or is there a way to get
git send-email to retry/continue?

Thanks,
Jonathan

On 2022-03-22 1:11 p.m., Jonathan Bakker wrote:
> Various cleanups to fix warnings when running make dtbs_check are included,
> as are bugfixes for the panel CS pin and bluetooth interrupt name on Aries.
> 
> The new feature is charging support for Aries board, note that the galaxys
> (i9000) and fascinate4g (SGH-T959P) have slightly different batteries,
> and so the DTS can't be shared.
> 
> Jonathan Bakker (7):
>   ARM: dts: s5pv210: Split memory nodes to match spec
>   ARM: dts: s5pv210: Adjust I2S entries to match spec
>   ARM: dts: s5pv210: Adjust DMA node names to match spec
>   ARM: dts: s5pv210: Remove spi-cs-high on panel in Aries
>   ARM: dts: s5pv210: Correct interrupt name for bluetooth in Aries
>   ARM: dts: s5pv210: Add charger regulator to max8998 in Aries
>   ARM: dts: s5pv210: Add charger support in Aries
> 
>  arch/arm/boot/dts/s5pv210-aquila.dts      |   8 +-
>  arch/arm/boot/dts/s5pv210-aries.dtsi      |  25 +++-
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 162 ++++++++++++++++++++++
>  arch/arm/boot/dts/s5pv210-galaxys.dts     | 144 +++++++++++++++++++
>  arch/arm/boot/dts/s5pv210-goni.dts        |  14 +-
>  arch/arm/boot/dts/s5pv210.dtsi            |  24 ++--
>  6 files changed, 354 insertions(+), 23 deletions(-)
> 
