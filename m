Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4F59BA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiHVH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHVH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:28:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D52A426;
        Mon, 22 Aug 2022 00:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUQCyQHcY+hL9fTF6veuGE2LdsN2DqCD+CdYI0PKHDQh7sOnV3wLZ/3rgzcAWakZuAM0HigGPr00C8iHtTf/S9g7ZvJ+el/4rc/CN0TUJJD2TJyTVkcL5FGdEAFEqXWrKYnMwsZfAC4Ws4qxTLWbrRkWpYR5JU1ggviExX7Se+Fz7+eRHL7mOmUiXaJ/N9NDPNMWFHO8Y7MMctN1aST1pcGGmB3sSmmB4lWDDtKkLuN53lQTDIKQ/t9x0dkuINTp79zBmzC5ISOIVdmebgeO4WJZbOAxRC5wsNJBW7iEpT5waIe8CF6aak8Re4gV+2vKnOUXbJPuzlGOqI+1yGUs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65wbJn7a/0YLgEfJ9xjFSGHn4c7weDuGgPyqY1t23BY=;
 b=IkAz1YeieIFO+SurQGCefZiEDMDiiunAjP99lVDrpEnKQg7DshnVfTdl84WxKBnQyQvGXPQrTVx+UDJL9voRU11FS1qijtqfWu5/dKzb6yx8SlUwHHyU1xkLG7T+3bDv7KPuMkO8kypoL2t+y93vUKMZbhDHymzpaWucKEmQHFMf8pSIyJdM5gRt560bOQah9PVBs1FyHb5h/l7w8MXBu/y90OjCUTBPSE4AvnQI4YPX6KTEAAG8Xv6jUyUkzmJoWlewBD25ZaA6bbkk2iFTvBO5qg8GJnpGZtdCqFT25w2gxZI4w9KihJplSjMEZK1B1DNDl3HjcP99PYtSlPV4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65wbJn7a/0YLgEfJ9xjFSGHn4c7weDuGgPyqY1t23BY=;
 b=0Ne5r5grV1MCm8j2XrcQDyKrBlJtLYnjnyYrCMG0Nsum9Ta1tGYoBv+ntI4KmRHU0jZEnW3pU1twTbCM5l91jX27gOhk8BixuDXQtwF70mb6/sk1D5QTWJQTiUGXlIZJfJ9fPJSlnWJyyNnIl0lX8IWRqLjiDA8iQOmQNrs3+Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by AM6PR08MB5174.eurprd08.prod.outlook.com
 (2603:10a6:20b:d5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 07:27:55 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::2c84:f6b5:8727:b073]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::2c84:f6b5:8727:b073%11]) with mapi id 15.20.5546.022; Mon, 22 Aug
 2022 07:27:55 +0000
Message-ID: <ef5e2424-a5c3-4032-71ec-9884d38ec190@wolfvision.net>
Date:   Mon, 22 Aug 2022 09:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Add support for the RK356x variant of the Inno CSI
 DPHY
Content-Language: en-US
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42100465-a58d-428b-387d-08da840fd47f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9w0AjrjtKfmfomraVZtMYxMx89v+FBozKDha3HmjRBG94Rx9Wo3uW06GxsCXfojG6aKlHa3HWz8XBn9UXwhKMydemCnB5NssPpg4taPFtj1x7wCVh+0WkqrPpYJ/ZK881wuwXl619Z4PC1qNdBoA06u41hJP5kBkg2Env8BW2jDjFcBepxQwPMDceIr1+T9O8/v8WCqyg3zyR1SQLpJiTykxM/EoDmEkeGNziALehK5+HLLe0adf2Pi8iVjAeZ9ddD7yV2Q/4HGFARW9UoEqZ4X2Ay+mES/6ybztmaSZrsadEa3a7KOcMyaUAOsYV6nI6PBM8efnh1SxB3IlVAfCVen7JOK23AVXMvIGuMNmxQazTvNjylNSNWLYBLbbSFgwy69c83hf3qXjYv0nEML0vV98N9pq9QpkcAzNzbMwNTS8nogiwlBAIgKl9PeSEs9xUqmfj4AaT5tZfIgVExXFWdgB76ciVwZYu2FtabvAEpyTWITxf8eO6duw6grjONiGcl03kG1lwgDorKES2RdKMomOix6BgrBDJJPi6UaHl6Nzl9M+QARXhhPNkLQz1t7330ZJ1plpWCu69LO3IH4u8fLgB5sEVoG5mmg8QpBHrEp1aKBUylDVP8v9yj5uWK9zlp0Pn7uFJw7asCx8iujAlM31DgmUqFQXDLkS5LpNaYYucSVdE1STZ2SXd66SOfkYvluoD7xEli/PmxLJg81TgdvljKdk165AB0YNVs3qVwpcQDbb4NtT0QbGdeAMAq+rk0TND2zTHBL3DgcJrzM6hHFtGffXsmIJmsVe35SelQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39830400003)(346002)(136003)(376002)(66946007)(86362001)(66556008)(66476007)(8676002)(4326008)(31686004)(31696002)(54906003)(36756003)(38100700002)(2616005)(186003)(8936002)(6512007)(53546011)(52116002)(6666004)(41300700001)(6486002)(478600001)(6506007)(7416002)(316002)(2906002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNjWTZmeTJEL1ZVM0dMYzgxZW5hblNMb1RVQUlvdndaYWxZaTUySGZFdTkz?=
 =?utf-8?B?K0tWSk5SOXh3dnJqa0MvRGhIN05rM2JTd0hCRDBYZUczNitsZzV3NkI1MktL?=
 =?utf-8?B?d1g0VlM4RFRyU1RsM1pBdkFYbGRmQ0pjcTVuVStoUloxSnNhRi9qN3RMYUJI?=
 =?utf-8?B?aWtxT1Bad204eWt5VTdGOVozZUdJRWpoT2FkUjc4MnZXUTllUTRMZVlQclg2?=
 =?utf-8?B?UWFJdEhaTElKOEkzZVdGYTFZTDZOUnpjeUNVeExpK3hVTEtSb1ZXamUxNXdN?=
 =?utf-8?B?bE1XazRlRnc3V2k5OXBHMFgybHVMekk4YlpZVVVSQWdIanZNaWEyVFhMSzZw?=
 =?utf-8?B?TVFjbmN4KzlLV1RQOGNoNEJ3MFMxZXQ1eURWODlQclVmN0w2ZjdaQzFhNDdi?=
 =?utf-8?B?cGhvd0JSaXpwdWRIZnMrOXB1R0pxajZwaUFNOWs5bDA5SjZYWFA2MWxRZTFN?=
 =?utf-8?B?dzhDbDdGNDlnT0tpWS9zUm10UlJ3Ukp4Y0IwOFBIWGltNkxxOUJkejZZS1V6?=
 =?utf-8?B?bDhXWUlYTWpVejdKOWdoVWlSSEVwaXV1V2x6eExHK05XOXhyTEtScHNyUzhK?=
 =?utf-8?B?ZTg4NWRQdGltdWIvQWtFSXFHbVFpaDg1U0J2amxNODkyNko4L2c1cEhNcWVF?=
 =?utf-8?B?VFJyNDBZZDdsZjRYV0NXKzMxb3Vkc1JvWHoxS1FqSGpGTy95TVR4RS84YzBk?=
 =?utf-8?B?cWNrSWVnUGswalZWbVJ4Sk1lenhvYU0zY1llSUl4aXhwcDJpTWZxOHlraW9J?=
 =?utf-8?B?ai9BVTFNbUVmSjRkOXhLT3E0dUFWb0syQThzVHVzSVZ3SFpNNzhUREttMFI2?=
 =?utf-8?B?NzJCQmFWUGpDbktMRWZoOGt3dWVFbUIyM1J3NlVqZnVoWmlVaEpQUmp6Nldn?=
 =?utf-8?B?c09KWElwMmdWNTR4K2tmclJrYnZLUituRW1RVFk0b0poSXZKNVhDMHp3N05T?=
 =?utf-8?B?V2xBL3VSRFBmTjhnWjB2dEJ1MVB0cG5RZmpGYW40OUt1YUhmaFBjeGpKb0Yw?=
 =?utf-8?B?ZTdWWUxQUWpOb3gwRG5pQjlDTi9hOGRpYUlaTjkxTWVoaEVCSUx4K3BjbER0?=
 =?utf-8?B?ZkRxUDJkcGE2T2RmUjl3L0tXUDdUT1VibzQxWVJxOEtHZDM2aVRpYjFVbEhF?=
 =?utf-8?B?b1Yyd005OXRjQThnajFBby8vNDlHMEVwNWhKLzdGbE1LdDNtSUVvem1qV2Y0?=
 =?utf-8?B?UG1kUTNod00rblJZckwyQTRqazhRczVHQ1BMc0tPcE0wa2hlVStudGxFajFu?=
 =?utf-8?B?V0t3WTlvaFBna29McDhyb0JYcSszUHBNWmgzUmNTNGFOd3RNakR6aS90cW1y?=
 =?utf-8?B?aktJUTF3a0ppZ3ZjcXlkdlRleHhRTE1qMTB4ekYwczFJaU9FeWVEL1E2aWlZ?=
 =?utf-8?B?WHh6ODR3Qm5xY05sWlNBbkhmT1lwLzFoZjVrcTc4TCtqOWRpL2hieFJ1cFFr?=
 =?utf-8?B?ZjY0M2EwL0VqN0x4djRwc3kyNUhQek16bFB6T2FtNktUR0VVTmhwQnRRa2J1?=
 =?utf-8?B?WDZQOWhsSk9IanhUTWRVOFA2TmVaaHM0K29KUkE5VVE2dTZweDVjblNoaVVK?=
 =?utf-8?B?cS9Lc0hGRXc0QlhYTkNQK3ZGc0R3ajdoKzQ1Q1hkSXp6aW0wMEhnMWNGb1dI?=
 =?utf-8?B?bDFEV0ZST3NYNW42TGlaamc5bzA1T01yN3FVbFBFKzd0djhzUGR1QVdtVHM2?=
 =?utf-8?B?UFpDSldyRmtyZ21JNE1tMkhnVDI0ZkxhVTNPNlBsK3EzNnRmTUliTUExMXp4?=
 =?utf-8?B?QmNuVkt3SFhjb3pkclozN3pSZ1NPM2V0T0swM0Q2VlFnTDFoSXJqWlRhR0lR?=
 =?utf-8?B?d0dIWW80WCsrVi8vWnZnQVJFeUwzaWF6bXlTV0JkT0NkeEthSTNNai9WNmt6?=
 =?utf-8?B?OE1JNVdaZ0JMRHg2OXRmdDI0dUV6VEUva21vOHVlMkFoeFYvZ2xkdE1uRW15?=
 =?utf-8?B?UVJLSjZQWkY3WUF2dCtKeXc1dEZ1L3l3czliblVKZHBKU09wKzMxOGpLcnds?=
 =?utf-8?B?eGVrNUV4eWx4NU1WdlBNTXZHTU5zaExwUGxZNW9LWVpicG9XdWZjam85cS9F?=
 =?utf-8?B?U1V6T3hZbzlaMFc2N1RwV0kzT252T3RyZTJxeUxQSXI0anhIQzYzdXdFdFkr?=
 =?utf-8?B?WjlBYnZ2dmNVYTZMb3FWczJ2dzVUL3E0aXEwa054NkNYdXNITUFlZ0NtZ21H?=
 =?utf-8?B?Z3hCTzNLZ0dwc1lOQkU2Z3N5K1prdUsrMHBtK3dTN1k2RXN0MWtLS2Zxb3Rz?=
 =?utf-8?B?UC9VMXg3ZG1OV0hnTHN1Q3JvQmZnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 42100465-a58d-428b-387d-08da840fd47f
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:27:55.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg233yJZYNs7AAUrbiUXVT5elfedHm+qJw2y88E0o5oOn0cTl5be7x9d0ZOnUeySRw9coc76y7yMi8hBJQOjjg5RMWtLfncrGmm73dp2MDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 11:15, Michael Riesch wrote:
> Hi all,
> 
> This series adds support for the variant of the Innosilicon MIPI CSI DPHY that
> can be found in Rockchip RK356x SoCs.
> 
> Please note that only the basic operating mode is supported, in which all four
> CSI lanes are controlled by the Rockchip ISP. Split lane operation (e.g., two
> lanes to ISP and two lanes to VICAP) is not supported.
> 
> This has been tested on a Radxa ROCK3 Model A board together with an IMX219
> camera sensor and a patched version of the rkisp1 driver (with support for the
> RK356x variant V2.1 added in a very crude way).
> 
> Looking forward to your comments!
> 
> Best regards,
> Michael
> 
> Michael Riesch (3):
>   dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy
>   phy: rockchip: add support for the rk356x variant to
>     rockchip-inno-csidphy
>   arm64: dts: rockchip: add csi dphy node to rk356x
> 
>  .../bindings/phy/rockchip-inno-csi-dphy.yaml  |  1 +
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 12 ++++++++++
>  .../phy/rockchip/phy-rockchip-inno-csidphy.c  | 24 +++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 

Gentle ping on this one. I am aware of course that it is still vacation
season and the merge window was there as well, but it would be nice to
have some feedback.

Thanks and best regards,
Michael
