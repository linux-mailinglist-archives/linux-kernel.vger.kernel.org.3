Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB758A965
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbiHEKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiHEKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:18:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C492614;
        Fri,  5 Aug 2022 03:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT3YkV+UyBL8RISV3CjtvrotJUVl7lT4GNOnw4NYCYRaocMD/JHP8/EL8vpUW6/A5igQY3Ael3hZyhkR5hapqxbrK15Q9q5APXlxJ7QbF2FO8hH1hr/6ncGW3m7lLuOkZmmAnvcu6nAGppeG8mlqjDnL41bn/qwU+Xf5DTsPNMCCCSDxOMAHByt+JQ8IEHFmVwLZeoRr3DcEjXYzzYFLxFqI90XLLnED3iCj7zgWL2UuK3iq8E5+3AymturkgCKvIuSi2AbGkCUFOo8/24e81QGSzBU/ebqI8lBF+Kcc6Wsj34C0GPJT9ly0viXozvGXX60KxUiC385tnDsjAxreSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF8fPkdn8B19hyJaQ4M9J/P/qwqg7zbFw0U0tRtXTF4=;
 b=JdfQxi9p4ehjeLUiVNj81Y8Yf8UV1nKGYr1xddJ5L180eHJj2k3vW/leYnXhvs+rewdJphTbhriyKQpnL46dtnmMpAdEYeil+3gg4LvLRqSYKv75mpMdqbsmF7Ss0aXXfCIMpCnxXMVyMtdUQ711TqEEqvT6l3DSNkLlzkX3a6xpfBIRXVGtfH7WK0jtXWGDbdtVMqFj4WFoFJSFNgGAtMxUp8cOyA0JM9lDeULfDrWnlPztHD53l9qJq2i6NJ/jXww72tmIi/Cc9ehbKmwDPKV8M48BvsH5OK2zL3oQv+BTsXygK6Cf6Psc8O+pj45lwU+9uIXLBJk5Ro2wTU4g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF8fPkdn8B19hyJaQ4M9J/P/qwqg7zbFw0U0tRtXTF4=;
 b=COvAjNBK5Q0ddiXiD+0xxMbySM0le4ceACVaySh17K3GM+QudAqq8IUcddMNkCAWOkQnEFkApb5xOd26F3FWymuTOfYXAdY7569XKr6R6fepYdXTsKMTNKCZzeRJS/Q9THohK51aZlFBDgHiquMCuaIzUQli82Ptn60LvQdYkYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 10:18:43 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 10:18:43 +0000
Message-ID: <2c6161058d1253c1eabec274ca8c1c98bdc6d490.camel@nxp.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
 link MSI bus binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        robh@kernel.org
Date:   Fri, 05 Aug 2022 18:18:34 +0800
In-Reply-To: <258c3ed7-2247-d4c3-73be-ddcddee3a3a0@linaro.org>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
         <20220804061133.4110734-4-victor.liu@nxp.com>
         <258c3ed7-2247-d4c3-73be-ddcddee3a3a0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5df765d8-c3c3-4402-8b8c-08da76cbdfba
X-MS-TrafficTypeDiagnostic: DBBPR04MB7881:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5t0hUBb2Rl8VOy8U+i94/08DEXbyk25GoD8y3FZAWlEhQw0o2cTK4yGCTfQdU6MevAwwPMkKgLTc91/MAavRkpmXegZySRcNpjsFYTmIelTmqjW1NI4pcCjX7ah1Jy9J6HYbwxLoBYGLklMJtTF1vbt4g+V4WUePrV/QW5XnlKB5v1HJRd3uAG5oxavnqlkQlUZcTW4dsY41MCEMT+sME02LGUl0yCaeVfWnVHOEXBVQSsFMROuv2um5OFRDXyY5RlJv3GY7ZOes09AHRvvtk8008In6BYs9O+7bN7OxUBlkXk044IFGhKUMEH3KGXEYlncQOqLz3Ec4bBfRhKA9IpwNghDRo6xDchLKvhyYImCiap5tWxEnxNzjB5Bn30pppRaFQhx5g7uU66wumxXk3UGAEuXoDtnhLNOb/pC8xqajfh2+7gs3tK6OZBPUlK5RB3XvYB6jD6EYgrNP3FrjhWdQQWLlKIg6l8+aLftXU/tfqN2aYnm6bfhM0kf8wso8hLQcatFqM0HpeF1F2wi4ZhKTOSm2i4c7AiBiSUIhkeTZEWwVMcB2kdFEkaDqbFU1x+NX6u5iTOO8/OEnHTVQrcIOjVPGF5fHqOp14bzupEm7+2RfX0VfLeahHyz5biLfHMK4XXr9RW8WxsD0u8qkkHFJaKZ5wnpxt8o0Kg61L63kvAeems8++e5zUZYjPw6ka+lhNfrTisQiPUJEKyMiwhvTGSY+AqU7fq89pZrlDjtXNHES5PlcsbpO3Y6SUM/MOFaH4q1ckaP3sQLI1C1ll0BwaRgf1txoBqfre4Fy9UZJL5qU/uSQp2sIrIUWdyJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(53546011)(6506007)(38350700002)(52116002)(38100700002)(83380400001)(2906002)(6666004)(41300700001)(186003)(2616005)(6512007)(26005)(316002)(478600001)(66476007)(66556008)(36756003)(66946007)(8676002)(86362001)(6486002)(5660300002)(7416002)(8936002)(4326008)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FaVkx2S1ZGWC9MV2RjMHR4ekhWekZXSjNxUUFhWXVNcnM1YmhCZERpa3o1?=
 =?utf-8?B?VUd3RThXZFo0V0s5aFJzdWhUUVVqcnduL1NEUEp5Q0JKYkE2TlZWdExXV3A2?=
 =?utf-8?B?d0lNSHRJRHl4UFFhcTU0NitqMjA5UXQ4aGZ6aVl5T0x1ZDN2Vmh5TEZ1V2FH?=
 =?utf-8?B?aUUzNEJ1U3R1WW51V1FzTWIwTFNyVnFacWV0SmIzS0hkNW9DL1dyK3JZclRx?=
 =?utf-8?B?T2c5N3FVVFczRHhGVnlucTRxSmhtZ2xzUG9WU1oyRjhxSHlHblkyTTE4d2FQ?=
 =?utf-8?B?MkNYNHVJcm9FdUNWbldxUkN5bUpJeGxLWGM4VTR1UkRpVkFCT0FVMy9wOUVB?=
 =?utf-8?B?bndqaGRTSGRualhuRzlJVjNobk5DTGxEUVhIWFhFcEhVaEU3ZGRreU9FbHg0?=
 =?utf-8?B?Y0pEUlEycnpaUE1id2IrRFlnWFBxelJheTlXMDhqNnFLRVpPeHltVzJxcGxN?=
 =?utf-8?B?UUtYK3h5QlF0MnloTFQwNWtRVXlvREFkTUcvaG43eHNzU0ZLNm9oYTAyVFlL?=
 =?utf-8?B?UWRXUEkyODZEQTJVeEpjOWt2dlB2UGkxWFFCSG96aFVhUUthZ0VQeXpHNmlt?=
 =?utf-8?B?WXl4ZmpkNURGSDBLSVBBWXV3Sis4cVVrdG8yZXRsL1p5MFlNSWdIRFE0T3N1?=
 =?utf-8?B?YnQ4V2RzbjVVeGpkWmh0UmxIOVY5MTYyQlBFalpCcTJEcDFNU3diVDdhbEUw?=
 =?utf-8?B?NU9UWGNNNjduL2tRQzA1SVVzYWZTUytpS3NMcXpNWjB0R253bGs2bVI3R0Yx?=
 =?utf-8?B?QVVncGUvN0JMQ2NtRi9saG5rTVl6Vzd6YTltTDhMSmNHMlZZQk5iZ0pIc3Fq?=
 =?utf-8?B?NXlIMi9PYTZhQkFFbFFMbTB6VklDdlMvaUFSZS9DVmZBajNnTzJzazgrbmRt?=
 =?utf-8?B?OHBZK2NIcUw1OWdKSHRueGUwRlY5M2RwSnpBZ0J1YWlGSG5yQWtHUlVxM3JD?=
 =?utf-8?B?MExEMDlNNUNqTEswTWpmbHhvVm5CdFVSSG03V1puTG9KUERWck5jU0t0M1B0?=
 =?utf-8?B?N29DSDRYMm1uYVpVOUJFUDZHcnNxUUJSazdMSVR4RHlyZEFDZUxNUTVVbVVK?=
 =?utf-8?B?MHBRVGJZYWdMbldkaDlzc1FTQUs2SjRhbWFXeE1BOS9WOUFLZGFDbytiRjVI?=
 =?utf-8?B?dXBwdXNNOERkdGJIdXBEQVAzY2VjVUtnR041bmYreTZaS3VrdCsyNlRvbjgz?=
 =?utf-8?B?enhQVE1jZW9ZY2NkMHJCbWpsY0Z0VG5yKzYyR3BzS1Z0YnR3Z2M4SUcyb0U5?=
 =?utf-8?B?dS8yZ1hJUG9mNnlTNFp4SExmZDFITkx0ZkJUeWdKSkM1T044amxEdGp5Z3VL?=
 =?utf-8?B?ME5xSGE2L1pEb3NpbnhmZUs5bmtpTVBHbmNxd3JtVndDczF1cUh4YmRyNWFo?=
 =?utf-8?B?cERCVDB0dUpzU1VWd0hBZ3FtY2wwVkZ0Ymc2TlZlWWZaZy84RldvL2tVcElt?=
 =?utf-8?B?aEV4bi8rTFc0UExKeEVSL0NaRGZpZDRyME00dmZaanZZQ1FjRC9ka1hqTDNC?=
 =?utf-8?B?cWZ1T1psb0p2cnBtL0JnUXlHTGRkYytHYVpiTWl3YTFKUzFHZzg4MFZqbkpv?=
 =?utf-8?B?QmxQK3puVmhvNEVuYy8zeTdwdkhDd1NRYXV2MlI5NEdNZ2JoMDJTUWVwWVNZ?=
 =?utf-8?B?K3RsQVVjMldUMUNYekNHaVBFQ2IzUTRuOVBSYXNGQXRnZXl6QUkvdFJPZlhZ?=
 =?utf-8?B?cXBpQU5ZbzM0L0dvSU9lMXdVeTlsRFlVQmdWT0svUnBkM1hNYlYybWtrdjRV?=
 =?utf-8?B?S0hGYmUwY0owQzh3MkVUMjZraDBHTjhPcE5lU3luUVVxZVFXZE5mQmQ5SDZl?=
 =?utf-8?B?T0VBUHNzYmxKbnpkVW1iR2pLTHVwOXhzYkMvNlgrOFArZWVBUmZBQWZNWXNK?=
 =?utf-8?B?Vk1MdGoydGlDNSsyMVN1dGpiWnBoaU02YTFhOVU4dzlCNUVTRW1sTGFPL21r?=
 =?utf-8?B?Y1VWOGtwcTRVOUEwY2wwa2Z0UHEvVlBpRTlDa0NyMmRCWGROaVU1d2VBVG1U?=
 =?utf-8?B?bkEwYnh2cHlub0huVGpyMnN6d2lWd25mdGpDUVV1bk9GWEc5YTBYYktZRUgx?=
 =?utf-8?B?SUdxK3d6dTArM2hoaVJuYmUxYXpYMU90TGFvV2NVTUFlRnQrbHhmeG9oYjlO?=
 =?utf-8?Q?YdiyJwJEQ7NSlHWpCxQsDCFEy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df765d8-c3c3-4402-8b8c-08da76cbdfba
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 10:18:43.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhi/CWljJdEP8A6+YWQ9EKPcDR/Phx21kVku4olFCQTWuqCPByu6OV9BiltXpjr7NpY98HRFgNL5P0fbUBW4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-04 at 13:17 +0200, Krzysztof Kozlowski wrote:
> On 04/08/2022 08:11, Liu Ying wrote:
> > Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped
> > bus.
> > It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> > DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> > MIPI DSI controller and Control and Status Registers (CSR) module.
> > 
> > Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> > link MSI bus specific bindings.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> 
> Thank you for your patch. There is something to discuss/improve.

Thanks for the review.

> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8-lpcg.h>
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    bus@56200000 {
> > +        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus",
> > "simple-pm-bus";
> > +        reg = <0x56200000 0x20000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        interrupt-parent = <&dc0_irqsteer>;
> > +        interrupts = <320>;
> > +        ranges;
> > +        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
> > +                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
> > +        clock-names = "msi", "ahb";
> > +        power-domains = <&pd IMX_SC_R_DC_0>;
> 
> The example should be complete, so you should have here children.
> Otherwise it is not a bus.

I may add some children whose compatible strings are in-tree for
i.MX8qxp. It seems that simple-pm-bus driver part(patch 1) will be
changed due to comments, so maybe I'll respin when it's ready.

Regards,
Liu Ying

> 
> Best regards,
> Krzysztof

