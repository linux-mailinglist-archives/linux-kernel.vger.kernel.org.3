Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A17586ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiHAMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiHAMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:34:36 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2091.outbound.protection.outlook.com [40.107.104.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C740BEC;
        Mon,  1 Aug 2022 05:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV9br0gmkUFuWcmxFTleciPxKffYYLEprpksL6oKzKxbs6sRpCrhSDf3EDVkx5pjEwqhaRceQdd3lxvhLpaxK+reuELCEuSqYDbOUZeic8S/Da/WV6ZDJLbW6s8XPPg4lUYZcAZgQ7BfzS9oFdFkai49PceJJdq5TEl2Az/qgFQSe/9HuN0s2FUaT+rvKuZouUqS2PZf9qdzqCTw9BQIqiSR9dSjZAi080nkQ/1dXF3fREqVzeWzS3HI8MAzkarN0ivVv647h7OtQThlSlziBS6zBIfp0PgVxZrfI7C3VPBxkwy5aa9l1TyIBCu/KZw8ba6u7IJZC+dweVjHJhykOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoViaoT4lMWPOQeq0nHE371KtFD/bh5S8sSMM2zIg3w=;
 b=ncJLeCyqWyWDbOksFaicUxm6ebgsjQdnFKlmo5OaUhziHcpC7x8m7EMxLCLDexCa5IxDgDtlFw5fFW67iFPLNsK3SgosWclMN+HapR/1HerGYT9kybyhiUWLEn6wCNbJkc7c1FdG39wN1SMRtsVWlm0xJUvF3Plzrb4+f1XgLGJRlF1uNdfWX6CcHS3IDLRUgINRckdc7Pv0JGqg66wt66RDqg2tnI80lNXm3dLjAwmg0oVzqhEqb7siOagPw5c38VRyFRf1o6hgpo9YGCciDr9RH6//K2ZfxsGfXrn0kZa99WQCDHPgHn8VpzuPtMZhmlKUNhrQsASSPDXkvVp3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoViaoT4lMWPOQeq0nHE371KtFD/bh5S8sSMM2zIg3w=;
 b=aayFlvQrs4P9DN3nSB7Pu0PfA9wMb+7Lzb5Afji+sOebVONqE31mwiIhuN9u/NNLdA/YfgWJ2q5OlCCaT8LIceZNPuI/SvMym6+q0d139spdnEdpqm6N/qtcqprdYGGjnf7hn1zse67vVQV2Z338VPQYdCX40cqx66a8hNXvUdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB1997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 12:14:16 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8%8]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 12:14:16 +0000
Message-ID: <7ef6812e-5732-e8c7-e796-f568de4eef62@kontron.de>
Date:   Mon, 1 Aug 2022 14:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Content-Language: en-US
To:     Philippe Schenker <dev@pschenker.ch>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>
References: <20220722075600.10943-1-dev@pschenker.ch>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20220722075600.10943-1-dev@pschenker.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a271ae-faa7-4664-47bb-08da73b75a97
X-MS-TrafficTypeDiagnostic: VI1PR10MB1997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4GXdEMxgyo5/DEQcLKvvkHGSBWf+6DILGQQEXMtH+sNtOZdQ3sbBtD72VYElYx0TAeucy2sVvlssnOgM51xhC2FUAt+JZKhJZ6fGS5pocu8BOcTScuX7nt/AFNVCG7pTkzwD5rCSCunVY8nqd4ZOfVBURAblVDJwGXye9w5M7ePAVLaeRtQE2ntRX4qD0O76fpvdUVYh/aePBHsqML6JJzX2NTh+xGLbdzlP82vt4WDmdk0ds4KiMGVI+aGCADQAfOeEvR198Qy5E2MJTUqMbwjPgp5jlpnYcEugTmF/ae37wqMgHpolSvF8/bYJtp8Fjhp34+3ENv9T6ZabwhVI4A9AGGBP1YTz9mYdcO4pJf11qyCWF4XgE0q4WQBdr49ApgalvSAn3hI+zdylOePZK8NuNaxsYt4BTu2KiiTT1SKAJFjsdhg+dZ4YZ3qlWGRkVNY/UYm8VT38270cEsNtmpbdt9S74e4aZI7jKjegp4eV5pxPYGJ91A3VKJNJ4L/8XFzvp8XkT9ZurFXL2XLsKoZjO/yFGjfYhR0BOtf7EmcMR7LeNDWhCnEjxq+0MVAvc2fsn8m2qy8oExpPdiWDw0/D9hdWKlXBug/eBq9kQIV8Q30BFXuhHCb1pV+eajjjCdjRbqivSf3cH3pYoN6tK50rYoeIlnKsaxhrOKQ5AlNt3ejhCn6CtnBB4WB7fayTj3jL0vpztgwY3dtlHhR1cDH8XZJsf5cbZrJzeXZ8x/rEtatwh18sZhfFKcpjuHYfkz06l7+xhiaH1BK4EWv1pDBd7pUgJIVsjBpEOenhQ3tGXye4YWYY5eraU0Ilr44sy7z/KF5PZuNSNKAb9mEG+NZqz/MyYHnK8Eucq3QMdmURF0muQygU27hnLgxTI5U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(6506007)(6512007)(186003)(66476007)(4326008)(66556008)(26005)(8676002)(66946007)(31696002)(2906002)(8936002)(478600001)(41300700001)(86362001)(44832011)(966005)(2616005)(6486002)(7416002)(5660300002)(38100700002)(31686004)(54906003)(316002)(83380400001)(36756003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bytjNkoxZlRiN21nQ3FiSnhudW9KS3hxNG41ekV1NHZRQktKa2VaeHZGRXFU?=
 =?utf-8?B?T2l1T3RIUFIwZlk2SnRLcVNlcS9FRWhRMVV0aXd2ZFYzTGxBa0ZSSmNIeHpN?=
 =?utf-8?B?OHZSbjdIbEFKS21YUE5IUzRhZGlYT25MNURMTnpwV1RuUVREQkFmVlhxZTdY?=
 =?utf-8?B?SlhBaTNWNVdwdzJaYm9GWUNDWTRUY2E1d0xTMHN2R2czZ3hBblpVWHU3eVB4?=
 =?utf-8?B?c0wvV3E4UzJadEFOb0NVNkJjTEtxZlVHdEdRT3J6dTRmdmIwc0w5eXdqWXlU?=
 =?utf-8?B?ZEJYZ0N2Vk51SnBvWUYvTXQwbXZxYm1DK015L0tkMVJMMXpnaEFTYWFIK3M5?=
 =?utf-8?B?NGxsaWdENjVvUU9MLzNZTEdyMGtYNVVPTDB0NWhoOWdQRlcrWXlhWmN5MHp0?=
 =?utf-8?B?VEJ1Tk40bTlseVo2Qkp3WHUxTXlpbG1WYm84all1UWdRU0ZDSkhPd1dlbEdV?=
 =?utf-8?B?Zm5WWVljTHluYkRVVXU5c21WNTd1K1M3VGhpQ1FUWEJvenV2ZG5ybytDOTVp?=
 =?utf-8?B?R3RQbmJWei9MSEZDUmNSQWtOdHRiMENMK2VhUjIzbjlaSXpIOStuR3Z3TzBr?=
 =?utf-8?B?NUt5LzhkQW1SYWZpM0tKWmN1ZktzS1BnR1djblBRWGdBTGh2b01EZkhkeFZF?=
 =?utf-8?B?dy9JejdzZC9Ibk1XYmI3M1BoL0d5bFNZdXoyNEZRamxaZjNQM1ZWSndIaGEr?=
 =?utf-8?B?RmhQR25NekFLLzN2TStiOCtqVkFkQUhFeDQ5cytHRUxER1lEQzUzVmpBQS9S?=
 =?utf-8?B?YkVVekxwVVVRTWwxdTdBcG96QmdyYTYyYk1vbmdvVnk3eHRTemlmTDZZeVBE?=
 =?utf-8?B?eFNNclo5ZXFCaGdzR1E0cTFnUHkrejNMYVNjUVI4VDZEZGU3OHBtMEtYWW8w?=
 =?utf-8?B?SjljejRsS21HcWV4TGxSSVBRWUY5cERuQ01RWStGb3hIWmR3T3BsWFpVTnlQ?=
 =?utf-8?B?a0RWSnBpL3huWlZRWWtSZmVpSDZWNlNva0ZvQ0NzWDUrNUxyanNTQlJCaHo3?=
 =?utf-8?B?R00yaDFQczlhLyttWW1FSytuTnJQS3RUeGlPY2l1Z0JvVmpyUHRTZ3BLM1pN?=
 =?utf-8?B?dFdQVmc2NGh1a0N6L2RrR3M2Zk4xU2tZM21UUDlNb0dnZEtUNU5WR1NRVC9T?=
 =?utf-8?B?cGtablE3T2dTOGwvZkdpbXF5VkQrQ0NBaWlVQVY1ams4aXFqQzVLSTA2Sm83?=
 =?utf-8?B?cGVLTkZjb2FNd0cvWmdoV0dVTDBqZVk1MEluS3czNnZTNHZUZW5oc0RqbFpD?=
 =?utf-8?B?TXlUYjZxWWd2bVNHb2tOWE8vQTFhSEtvVTRFK1NOSzJGbC94ZS80YmdVWUJC?=
 =?utf-8?B?cEV1cW5qTlhjcjB5OTIrN3BoZTJ5SUVCaWt6SmRXR2N2S1RGclVtaE11ZTRQ?=
 =?utf-8?B?TTJyUGtTak4rQytUcTR6TU5UdEZVSGlsT1ZWMjkzUWhGbS8ycEY5Y1BzSDFy?=
 =?utf-8?B?aUJZbGtSaElrTDlXUkM3cEpadVN3RVhCUS9WZEg1a2ZKNFhlREFFeVg3MXRY?=
 =?utf-8?B?eUowc1JmMnJSMFVQWjNZdWFBU1R4QnVwN0Z3SDZTVlhQN3hwRjU1c3pkU0cr?=
 =?utf-8?B?VGFwOVhJVHV6a1Q1L0IrZHRNOEovc243SC96Qm9lTTVFNW8vRXpEWUxDNGRT?=
 =?utf-8?B?MnhUeVZFUUtQQzVxWE5lWFVEM2hOWGFLVlpQT3c4bUVScTFwYndUYlZRd2Fv?=
 =?utf-8?B?Skt2QVAwZXJIZUpmZ2VGU2YraHNKcExKYzhHSFVtNHVFYzBWVUdwelU1Z3Y1?=
 =?utf-8?B?VGRmN3lwM0tZY0tUWXZIRXVQRnhmdVZNNGViYndmVHJSZ09NSjRPMnJjTnlx?=
 =?utf-8?B?QUhpdjBqZjlkNCtpMzA0QUlWNktmREdUc0gvcXp6SG0xVUdBbGhsd3BnK3M3?=
 =?utf-8?B?N1hGYnZFSmIvUzVrYW5qZE00NHdVWEZBK2FOVUZvMk9ENldWbG5yczhwYWRo?=
 =?utf-8?B?MjNCR08xK1lIOVE4aFZONVZDRVhDR2VtcEtnV21DTDZKT2xja0hnUjh4OEgr?=
 =?utf-8?B?aUhxeHIzVmtuZ2xUY0NLam80WDRJVjdqK2gxMDc1Vk5WNWdRZy9jOXhVWTNK?=
 =?utf-8?B?MlY3cjgyMUFCYmtLSko4SzkzSUlzWUpNeFZQQUI5TmxrUkEwdVM2bDNkVVJV?=
 =?utf-8?B?OWd1ZytoMVlqbElMWVdPWVZqM2p3WEF0NU1FT3FpSW9mNGp4dEYvQ3p2Z3di?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a271ae-faa7-4664-47bb-08da73b75a97
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 12:14:16.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzjaQF2vkidwf/9phvSUuLPnIIa2+eWCUTflqlrcvM4XCa2uyJH83tFkJpNQCSl7s1y1YVj1Y/oGSFMY2uwskD8HX5frB8lHTt+nE7X4/QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC: Li Jun, Jacky Bai, Lucas Stach

Hi Philippe,

Am 22.07.22 um 09:55 schrieb Philippe Schenker:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> The Verdin iMX8M Mini System on Module does not have VBUS signal
> connected on Verdin USB_2 (usbotg2). On Verdin Development board this is
> no problem, as we have connected a USB-Hub that is always connected.
> 
> However, if Verdin USB_2 is desired to be used as a single USB-Host port
> the chipidea driver does not detect if a USB device is plugged into this
> port, due to runtime pm shutting down the PHY.
> 
> Add the power-domain &pgc_otg2 to &usbphynop2 in order to detect
> plugging events and enumerate the usb device.
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

I'm probably having the same issue on our hardware. There was a previous
attempt to fix this globally for all the i.MX8MM boards here: [1].

Unfortunately this didn't seem to work as intended in my case (see
discussion for that patch). Looking at your patch I wonder if not having
the vcc-supply for the usbphynop causes problems in my case. Do you
happen to know the effect of adding the regulator here? I don't see this
in any other i.MX8MM board devicetree.

Could you test Li's patch instead of this board specific fix and see if
it works for you? On your hardware, do you have an always-on device on
the usbotg1 port? If yes, does the detection on the usbotg2 port still
work if the usbotg1 port is disabled in the devicetree?

Thanks
Frieder

[1]
https://lore.kernel.org/linux-arm-kernel/f4879eed-79a7-3a1a-8dd0-c1a6ed367f34@kontron.de

> 
> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index eafa88d980b3..197da74837ca 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -737,6 +737,7 @@ &usbphynop1 {
>  };
>  
>  &usbphynop2 {
> +	power-domains = <&pgc_otg2>;
>  	vcc-supply = <&reg_vdd_3v3>;
>  };
>  
