Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086258DB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244906AbiHIP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbiHIP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:28:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2136.outbound.protection.outlook.com [40.107.22.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF194B7D8;
        Tue,  9 Aug 2022 08:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF9mHfX4XTWEBkSrjeZGM7MsCMwG7N3ZpJqXCR2LnNPICOpvpMfp8ay8DQ+CiIiKXSGEn5+hbuAud+vh+JAMD3AB4ePr/e0vUJw6IoxrSy7BAexkg3BBf8+cpeI3sCfEdQBf2oEOIPorPeXq1r5oopRlUtOU4RngILEciM1Ji1X44t4epEgFFuTP/erP6K0LBsYHfljfsZ2T0pPUmsGFbSLVqVp83JNHbyzoCp9IjSenzuoCLKB9xy20Q6V6SMVT2FpE18muTnAS1bvfVOsauOdbdbATiA03Ae+54y8eHOT/NdBe+sZnNLczlgMVk7gw30Q94Pt2KfSRtEmnPbuYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIFDAyHLRuMhGFtBAPeb8RJLwWpsIdGFCJYnE1ujJc0=;
 b=bCon0HkruaHk9UFf+F/swXRRIRYTBznxpXMoyOG4Rhs4pqb9lgOjGiRO81wp5JaLwSFGxZyGqNTZAm+JWg0+eZ0v2N/8wK46j62WDUcsu5u4wGqhs6yP28YDA8QZmJM5ZMMRvjWQqugL1WebDdNL0nhWXLbt5mw6BWQgGsXCq6/KlXPQCB9USTJHlEXyP1ImWtYV06BouyM7aTwmPGiXi8TQJsmSJgDP0Wv+2z04znVexFWU3BJ5YnjyqRTdhAzdBdb7TIcf/WDWDs8u3qf93y++h+MpjThNr7KRqkUTCk5FO+vRmsiBdI5dasiUK+ojV5+N6+UAZHmiCr26aJgOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIFDAyHLRuMhGFtBAPeb8RJLwWpsIdGFCJYnE1ujJc0=;
 b=m19EHHWZqXropPeIPuLoc1PGyr9aiAuKXcliP9UmRuIkn8U3yD5XWoYtzIp61WLr1FXUf7RX6+u0CKcy6z1XIvN/yjaWkk+sdhHueNC4VFGR9282WYG1q69E2YwRLzdIElruA9gZIkhLP/ftt7MPx+qVNa7bXCNrToOrmKZve14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 15:28:31 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8%7]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 15:28:31 +0000
Message-ID: <78ca2114-a2d1-ad75-053b-c9c1d5727e38@kontron.de>
Date:   Tue, 9 Aug 2022 17:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/4] ARM: dts: imx6ul-kontron: Add imx6ull-kontron-n641x-s
 to Makefile
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <treding@nvidia.com>
References: <20220809152534.292034-1-frieder@fris.de>
 <20220809152534.292034-4-frieder@fris.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20220809152534.292034-4-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09165ecc-e304-4411-e27d-08da7a1bd100
X-MS-TrafficTypeDiagnostic: VI1PR10MB3598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmFx9bo4q+8gwYjO0obU+fhCn78YNKUT5qJQHay7FjA88nF5AeVEuKivBszIM+VGFvLaZWJRwUpstXX23Co0B8lQF4Pu96azxGI+yqM4MzDXHgybBZYtR9R8DJEqwV8r/B5JLmC0yiY8/Iz5yJb9YvdXxxuUiQY35smLhCwBZCqkvUE2HSF25c0vkaiCCleb3fiQhnV3eS4x7qS8WL0zp4tvytdxcVmd94DGBMYyqPJX53ZyaZAnV0kQ3EsN5cCs+RNT+ZB6cYb2FLpFC7T1S3bft19S3kWrmoUcJQ1rMAH+n46WNf4PJxm+PEo1usG6I+2THQuKpr7O60Iftx1+hJvviAir2vLBixxIJEJgGpEZ5H/TiL586+PjT6wFZAmd5wIkEGC4aLxZ+23viMSvJI6JF1qAcLdYfIQFRavLJSdQ1ofXLb1/dPg3omGwv1VsnNAl8gTyeinwlCH0odZjDqHEJWiFYOaccRYa1esd59XrIU+y3OBwlInaUja6INUiYiDG6zNlxRyU5ALAfsJZ5R9aFzw5lnFycposRz+qgxEPRtu5HW7avMfb4XQsF61dVbPfs1N2Ny96+4e2ONXpFJ6gX0E8/hcakRGJq9P8FsCLBe53aEL27uL/aEcHuprPzJRJuzsdbuKG3MXN+963bmPCkWqmVjJNVJSe+qlQjEAB1BLX1xXIacDBu1SLG70tXUYYDsBTQNQFfa3I+1WxMV6w4SZQ1Ej4ZdNZSiTQeGkOnxhNgapudn/Y9IhDLiSWXbkQWmzsvDxnl7XRMrs9FLwh2yAMwgKbqv6QY7JagA8BjLe8w6e05iGVQlGw1WDtBGUGPTS2gLPi17SFEw6iWQ7keJXG+CVPruhyASeTkRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(38100700002)(110136005)(31686004)(186003)(36756003)(54906003)(83380400001)(316002)(6486002)(66946007)(4326008)(7416002)(5660300002)(478600001)(44832011)(2906002)(66556008)(86362001)(31696002)(6506007)(8676002)(8936002)(2616005)(41300700001)(66476007)(6512007)(6666004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhSeWExWUo1Q05vcHZMQWk1TXBpRzNndkprcmJ2QVJlUXRiS0NYS3dhdy83?=
 =?utf-8?B?bTZWd0FpZGczcnlLaDAwelU3dld4dlVzQkppYTUwUmlTYlVNakFkWndsUjdV?=
 =?utf-8?B?bnlKU3NjOGZRQ3BTYWNUTnR6dFFJaVFkOWFzSUxVVlBvZWs5NHlzN2ZxMUlw?=
 =?utf-8?B?ZnQyOXNZNVZheWVzTlBGT2RvMlYwY2hUQWxiemdyekQzbmlQalpMYmF6L3dn?=
 =?utf-8?B?UGl4a3lrMk8yQ0hIS2tPMVZlUmc3U1FKTWU5VXZnRURpbTgzTE5VS2NpSWRu?=
 =?utf-8?B?WFJYS25LZnlXVlpBZS9tVWFrUVhtM01hNTJwT3E4RFJYblcvVENwMWhSZGha?=
 =?utf-8?B?ZEVzVEQ2YTlYbnlneit5QmFGMmdhaGdiYm1tZWZrbkFSVXVJT0xPSkQwK0k5?=
 =?utf-8?B?dERDV1hFU1FTdmNpMTRwTTN5SlRQa0prTERENU9qZnZ5Tkp0NGJEUWU1OE1y?=
 =?utf-8?B?Y0ZVd0UreFRNZWNSYVNyaWlqeFBhdWc3THcrSWlITlcrcDRGR1RKVkdBOHZr?=
 =?utf-8?B?TnY0V3BPaDZNQzdWbG9MQUNzSWczVjlRS3BXWXRNdmw1MDdzZnpoaitoZjFq?=
 =?utf-8?B?WTFEcEZtR0NNRW9UOGovUW9Ra3ZQOUdzRzdyeDdtM0cyamhaSzRrbURZZlZL?=
 =?utf-8?B?Q0hZL1R5ZzgwRWFpYmxZVVM3MUlDVC9iV2JLdUxJNE9CRTA2enI0NU9JWVk5?=
 =?utf-8?B?a2JJbEdrL2IyQjJZN2hOTDZ0OENZSWx1NWRWVnEvY3pETHN6Skk5d0xaOWFF?=
 =?utf-8?B?b3I1cHJXdllWUmJNdXFNUWtLek0xY0EzY2k5ZitNM3JzNXg1WTUybjFHbEhO?=
 =?utf-8?B?a3JuTU5rcVF1YW9rNGtSSTlDdmhuVUo5cHlmb0tERjJWM2dLVTJrcElLMzBS?=
 =?utf-8?B?blhJSkxkNDc5MFBXSGE3OFd0K2d4RXJDOWhoRmQyYXZ4M3VXRTRaUHRRRHY3?=
 =?utf-8?B?Q1BZbm9qTk1ub01sYk84VlJDU0RpZFhJREFjR1FGQWZaK09uNWNoWS9pRHpz?=
 =?utf-8?B?bDJYYlZoSnkwNFRrWS9neHYvUHd5ZUE1TGpVaXFMKzA5MElUMFF4dkpIQkVw?=
 =?utf-8?B?a1lDOWpySEl4ZXhudnMrWGpHZUFBZUpONU5iZXpoTkR6bkhlVmJpWHJVbnE0?=
 =?utf-8?B?VEp6Wm5lbzUxYkQwNjQ5R0ppQ3c3aHZrSVQ2dGJVeSsrTVIrWWNkdi95V1JS?=
 =?utf-8?B?NmVzTGJadEMzWGZESHdmQVZzMkJnWU9tc2FVZ09jZFFHT1hFOE5vWE5qaWU0?=
 =?utf-8?B?ZHI4ZmYxUjNvTFAxVXFQaUdJalYrS2I5SzB4QWZtYnNlRGgxYUJyczRmMm5M?=
 =?utf-8?B?aTJLYXl2cVk3aWJDUElYWWF1aGlFaDF6azM1MnQ1eHU2YlRPZHpKMDU0WXMy?=
 =?utf-8?B?M1ZpQi9XUExWUHFDYVZGN2YvNnRGbjNJRnIrcFJtblY0T1UxWUlWcHkvT3V2?=
 =?utf-8?B?REpvZG1aUTNJbDAxOGdBUE5keVh2TjVSOWhqY0llSkNRdm1zd2VOMkRnbG5j?=
 =?utf-8?B?cnpCNFlIYXM4SkdiRjRaMVkvRW92bVdDMHVJMFRBeUZCY2YySzJHZnM2eWZJ?=
 =?utf-8?B?UUxQbXNWbDUxOVRSeWF4Q0JqMFJoNnUva0RqZzhzVlZlbEwrdEZUMWdCYTJQ?=
 =?utf-8?B?YWJDbFU2clhidDVnTXZXb0FQamRRcEtncG1RdjBCUnYzR1hmczJWamhvcmJN?=
 =?utf-8?B?VlBISWtKZ2c5NVh4djg3U1ZpdjVITUd2UC9veWsxbWNtclNEL3VnNTlrUDJo?=
 =?utf-8?B?bTZMbTlVeEhPcHFUeVpqa1pmK2NsZXlZVGJvTzlBR05TOWZCaHpJTmlyYXRQ?=
 =?utf-8?B?OVVQVWVZcVd3dGpxNGxGSnZHa1dRUWIvK1dFOGFjZGtoYWw2K21sRXFzRkh3?=
 =?utf-8?B?ZmFQZE43RDZRM2E0UkFqUjRnTm0vdzcrMDJlVWRmWkFYTkdSTXFlNE9haG9W?=
 =?utf-8?B?TUQrSjN0bzlNeS8yZDlicFMrbENZZ0NqdW13MFRwWWN6Qnk2Z3RqMS9MS2R0?=
 =?utf-8?B?TkRhSGZBcC9vVTUzTkE0M3F6akN6bjBWNXlRaEhaVHZmNjVYQ2tRbEtxT0RN?=
 =?utf-8?B?MCs1U2ROaUlJK3pmMTBRc1J3MjN5bWFmbDhnYjI4MW1VeVJaazRkcC9ndmRU?=
 =?utf-8?B?bnhsd2F4QnR0Ny9PQXBqZzJVTFoyNVk3Nm82WXhucWpaRGprMm9NNzR3eGpq?=
 =?utf-8?Q?zzl502Rqcka0gLVyCN3oWPvs2TgJgsYuv6GNGYdtuxG+?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09165ecc-e304-4411-e27d-08da7a1bd100
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:28:31.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5obEl6b13ISMBt0Vr8WOm9ly1EWzodXX2PYbO7uU2w3tG0C5gAid2ID1VRppUhDydIz64cAE/oF0vMqWvorJrPe+3vFIgMERlq9BWiFAtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3598
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.08.22 um 17:25 schrieb Frieder Schrempf:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The imx6ull-kontron-n641x-s.dtb wasn't build as part of the
> CONFIG_SOC_IMX6UL option. Add it to the list.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm/boot/dts/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5112f493f494..2665db1c35bf 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -696,8 +696,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-geam.dtb \
>  	imx6ul-isiot-emmc.dtb \
>  	imx6ul-isiot-nand.dtb \
> -	imx6ul-kontron-n6310-s.dtb \
> -	imx6ul-kontron-n6310-s-43.dtb \
> +	imx6ul-kontron-n631x-s.dtb \
> +	imx6ul-kontron-n631x-s-43.dtb \

Sorry, the changes above should actually be part of patch 2.

>  	imx6ul-liteboard.dtb \
>  	imx6ul-tqma6ul1-mba6ulx.dtb \
>  	imx6ul-tqma6ul2-mba6ulx.dtb \
> @@ -726,6 +726,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ull-colibri-wifi-iris.dtb \
>  	imx6ull-colibri-wifi-iris-v2.dtb \
>  	imx6ull-jozacp.dtb \
> +	imx6ull-kontron-n641x-s.dtb \
>  	imx6ull-myir-mys-6ulx-eval.dtb \
>  	imx6ull-opos6uldev.dtb \
>  	imx6ull-phytec-segin-ff-rdk-nand.dtb \
