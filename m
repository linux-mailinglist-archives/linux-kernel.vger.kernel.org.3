Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812AC5511F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiFTH5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiFTH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:57:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F710FC4;
        Mon, 20 Jun 2022 00:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO7G4zN+apUPtD8Ugs7Wpjz6Mfa+wYxkwsNSJZNtMJdfgxeeCpneHLC727h8WE74TQtqfukl6+KLFyX3ynPMSuZYHDylb0v+R0L/OmTLblhF/bWo69DfuTTQLQ0TT++LvN5w9qoamnXme6BWZhiOHZ5nr/nEixNXs59rlOTBRXAdldx+VSDu4ySf4SZSeQOl36vzdUhsdJ6YsPS5mp1iaZhKvLFDBX7q5UKppOGLRyvN8X//i40xT75KSOL5XrmRUVbZ9/vrFr+MkluGAUy4TRUGf33kxb6pLoXpIXLBadfuh8NBEus8GZoVFDirgYscKu5hCycemBuGqw2SHWXk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5rilH3L7jNtlS/vUc/Nu2n0lrF5QG/3jLaiDPejOsU=;
 b=mgQdinU3nY1czDhV8dxMJ/JqzqqLPJKDnhBDoDb+FMkY0A9V1HMk8Tsc15DZEGK9F3XqanI1snnNoc/JfVi2nh4Z1iO5q03Ss/1X/Wud0mro4j6V8h88RQ3d3DWqPVzewVYxV7huEfcjUZ9ZWGK0rnFIhT0JSDklPLqkZybkjV/9sdL9MjJ127sLN/j8MXXxDsAMxZQAJo75a3H8UDVFmxOUIT+MJ8qKM+PJevPyIvayPtFTaoQDRlpLb9m4qBQ402+7dBH57pOup3SvYkzBknHjChqC8C9Fm7fYB3vIIyYKPGx0f4Icstwa0WrEU0oVmI96C9qK0lU9F7/dfWw1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5rilH3L7jNtlS/vUc/Nu2n0lrF5QG/3jLaiDPejOsU=;
 b=e4oMJShsUI3EH3p05KogEjMOIZk7PMs8UX1I+hr7bpOilTHiDFwr+jYbxUldqcw3NnugPIXYf4BF9uenEj74cOAbXJc5yJdsL2wZRWICkV4+ExMc+llHY5o8oAwN9ZKbRQaGFeAcV7hXflQ+YO7ktZRfYTEnCDdktiS5glX4sm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB6643.eurprd04.prod.outlook.com (2603:10a6:208:169::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 07:56:58 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 07:56:58 +0000
Message-ID: <d8af25c1d5e81d6b308c3162aae670f091b59bd4.camel@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS
 PHY binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Date:   Mon, 20 Jun 2022 15:56:18 +0800
In-Reply-To: <3f805983-47c0-9be1-f221-4cd23b847018@linaro.org>
References: <20220618092201.3837791-1-victor.liu@nxp.com>
         <20220618092201.3837791-2-victor.liu@nxp.com>
         <b83e3100-edd6-4f91-75e0-8a87447d8a4c@linaro.org>
         <89a29795e918343583f45b0f8a65a002592f8b15.camel@nxp.com>
         <3f805983-47c0-9be1-f221-4cd23b847018@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c1b9de-cb44-4e85-99c6-08da52927360
X-MS-TrafficTypeDiagnostic: AM0PR04MB6643:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB66439E0E0DE8E53CCBF3A40198B09@AM0PR04MB6643.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcGNLWquVqispSPgwMaomjycPC7ZdmcRPRqhlAGxJQPh9o+k4hfRg3SIuTEV4RrwZlrWlLp+JyEvAi2EWyPm6kTD+eXdSVw3bONJcctbnwn36TN2J13d4i79c9WX6PPRfk6HKFiO7+i5knEvn8aANlNH60O3B8MfMgXGK5slVWBzI6JfMEwi1HutlqA9G8ElY3tj/YdFfqt/mwio9dIyPnulnJgfXNU2DmfYlm+flU0ZGl6fIqQTLUdfuQuaP/ysz/4Js1thDoaGz5kJCbBcLD3/u5X6GpirU+Ym55yuwBoxA+QGY5Iw4huIz4EsgFXLqVqviB7gRn8UF0kz0/kzVe67ls5kDwSy5g2rUN7+TBXrGbGL/fJG/w86g3EQUOR3YDhEz1SuKaFKgPGWYKJpOwQdNgn02lgMaMXguyF0PJt78kWG2orIn4Y0WkJ0R9orpn3UC0/4CuU8DZHyGWNKpjojFKrrvAzXaffVMIDmCiE4kT2KTG4nTlcYYOL9tGrE7oQZzwnCINgFD4iuXOUoFP1Kdi6uGf3Qd0vbfNARQy6nGeRyYYPrK0P8zaMlWdsd/xyIfFmemMubAFnNs2YEwGIEB8d6YGePDvpfJumwiT5rHV+uSJUnISaxGLy4Io/Y+zYXhaf/1DK+iw0Yi/SXAq0frB23hxTY9I46pGuGXfJecyX4m0eHGs/JEo42RBjpE0YHGLroXjwyIqJtvC35BvwL+L70hVGMmlSAHxmUeCjGsJROW7434xWyXNvb1fPRaRwPjBmBxLxZ3UlrHKcW0V7ybEpBhFrkfcKQzbwKh0qNsBYx0BOPN0Ah64mxLfkh8u9Y9P8knTek33rKlrOKhFRu5WpO6kjmx944DnjNKC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(8676002)(4326008)(8936002)(66946007)(66556008)(5660300002)(7416002)(2616005)(2906002)(6486002)(478600001)(966005)(66476007)(36756003)(38100700002)(6512007)(45080400002)(6506007)(26005)(38350700002)(86362001)(316002)(53546011)(52116002)(186003)(41300700001)(6666004)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNDTURQMmxUd0xoODU4NmpweFpvT1o4MWRwbE05amtzT2NBUWJHUDRhbWcz?=
 =?utf-8?B?R3VYRVF2U2dHUkI2dHVhRVdXeWhPMmxPSHJmOXEvVlRxelJjeHdzU2Jqc3VW?=
 =?utf-8?B?OXBMd0xFR1UrK2w4N2laRGJCRTF5citQOXBTNDczYzkvVEdpcFR0dzh4R3FM?=
 =?utf-8?B?bElOb1ZHN2t4UGpRVG8rZXlPTlhzbkpxaFhuWEJlY2tpWjJ0ZWhnY2t5b0JI?=
 =?utf-8?B?eU9UMEVxNUVGQkg3Q3NUZC9WV0dXemRQS0dOWVpVUkdUVXBlbnBSWEJSY2FR?=
 =?utf-8?B?Y1RwNmJDeWRZaFljZ3Vxbmllb2wrODVFMWZReUl1QXllVEVrNFcwRmQrc0tT?=
 =?utf-8?B?UFJYUC9hR2E1L1pYcEMvNk5pUEdLR2Z5WW8vZnJyei9iSGpiQTEyTC9TaVJF?=
 =?utf-8?B?N0tZbHJRVW1uWkloUFkrWGl5NnFycy9qN0JNY1k1SWlPSy8xRVpIWEFsc0pI?=
 =?utf-8?B?b0Y0cVFqUFhDS1lDeDlFaC9RWG4zODAvcWoyY2Rnd2ZIWWM2RmxyWTZtenhR?=
 =?utf-8?B?dXIxYk9qS09SK0UwMzhIOVdNZmxSdzRDOUp4RGVpMy9tdTQ4STVHTmlwOGNK?=
 =?utf-8?B?VzFmZ0grZGNQejkxRzJBZEJIcXM5bld4U2NXMGVRQnlEdER2cTJsMUVlRnlW?=
 =?utf-8?B?ZnY3a2s3RU1PWjZORlFGejBNcFpyUzFoaG9zY2g0Ym5ZWnh5emYraFRKM2NR?=
 =?utf-8?B?eTNqT1hyeUNBV1U4aks1YXA1clVQRG9NYWFML1pFb3hUV2RzeklYTzdjRWYx?=
 =?utf-8?B?UCtaNFJVdFNNSG1JWlBDcnBVcUpyaTNJMTNDWTgxQXdqMVZsQlF0Tk5PbG1U?=
 =?utf-8?B?WlNUVm8xZFFZYWRWR2lRTlhlSlBYV2VSVElwT29RRVJINFp5cDZtREwxek0y?=
 =?utf-8?B?ZXFFYTNiVTdNY3l1R1NtMmZDQVZjSi90REJBR0p6K2IyaDRuSTBud09ucW0z?=
 =?utf-8?B?N21CYVRTMnN3Rlg1aXQwSVBXQm96RVg2Ullma2VOQmdDSHRrR1k0VHo2dDRL?=
 =?utf-8?B?WWExcVdmaTAxNWxCdE5GdEFDK3ZXTW1GTldSbEljNkp6NGlZblNSVnRuLyt5?=
 =?utf-8?B?MDdRMDV0MHpmUjNTZlROeThRRlBGUnN3czV1RkhTbUc4MklTeDVVUEVwTDdZ?=
 =?utf-8?B?Ui9Ib01KVTgwSDlQV0VDS3lDQWR0ZnpZWE9EK0ZQZnVkSHpLMDRwMTU2Q1lV?=
 =?utf-8?B?aDQyQXpENVh3SHlpdnFFblVYRmxEcHJibWpPRlZOOTdKVkllTlpGeFBaa2U0?=
 =?utf-8?B?aG5kWlQ3NkFzYk54am9zMEpxWHZiVVhtK1l1dHBCTkxpYitwdUpDUUNXQW9H?=
 =?utf-8?B?N1hkaFBjSTZId3l6TzNqWUE0SW1aSVVrNjF5enpHTjU3QmdtOHhVUlBveXNE?=
 =?utf-8?B?cGtMR3lYNVp1NEtkMmZNM3F5bTk5S09uaDNMbURSbVdpUG03LzF1VUNlQlR2?=
 =?utf-8?B?Ukh3eDRPY1RNemd4YWZ5VUgzSVFtWitqMVFTa3VXais5cVJXMVlPbjREWU83?=
 =?utf-8?B?UEpnaUluUVg5RHVzTnRwMk5WMnZxS3FoTXJQTG9ZenFYa3ByaWpFYkh1VDhs?=
 =?utf-8?B?ZTh1WFJaTGpwaDdzZHF4Rndzd3htRjhBQ1JGK3EwK00rMkF0dHdVL0NBbktz?=
 =?utf-8?B?WUkyRlpRRTVWVGpHVGYvM3ZKc3VVZVFNcWsrY2hPNWVQL1dNK092eDE0Ui9D?=
 =?utf-8?B?RUc2MnAwOW8vZGluemVMN1VLRENVdE85anorQ3VBOW9hSUZWYm1WQWlHSWk4?=
 =?utf-8?B?Y3RPTEMrNWRpRnlnRXR1SmVxRldEQmtuVXFaVWJYWVFCZzgyRXpQY21qcy8w?=
 =?utf-8?B?NytDQjVPWjhpNmF6M09lVWtHRXBpbTUvWmg3NHRPMkc3b0lmUk5FTUNIMHB1?=
 =?utf-8?B?bFp0andIUUFzQ2dSQzZwbDN5NDhPN2ZDckZyK05CdmpOaktwSWZLMjdkcVNQ?=
 =?utf-8?B?RWRyNGJHMlhvYXo0clJZdlJNLzV4NzJuaWlJNGF3b1VUVTFwWTJOY3lNUVlD?=
 =?utf-8?B?MjRxUEpJMkVzZC9IZm8rVDUxNGZudVh2cWRVNEtlRThiOFJObGluMkV0NzVt?=
 =?utf-8?B?RGFnYWZzYVFLNVdRZzhkaElVeFpYa1JKNGJCVUdVSnFqZEZjd0dwa1I0RUdG?=
 =?utf-8?B?T0FJaDY3SGxGREFFbkwzWDZ0ZkVkN0tITE5MWTFJcG16aEk4V25sMDBrS0xz?=
 =?utf-8?B?TXBHZUlGb1hRMEVqd1d6aTB0T3RPZWNVbmY1U0NtbXdIVFZCK0RxbG80TzJ5?=
 =?utf-8?B?YTJxOVRTajZBUGNMRUxvYmp0RTFNVlNla1MreS9JM2dlRG1pa0ZXdWhPNHRv?=
 =?utf-8?B?MjFzQjVickk4OEhMcWNGNFRWUVd2cUMrUkNTOUlCYmRqeEFZQ1NOdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c1b9de-cb44-4e85-99c6-08da52927360
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 07:56:58.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fja1hY+Ub0uNti7lyEO7yEMvy7Ss9lQVlxm6DcQ/FZIi9spDbHTTmIg7xSOFO2zC5FxxO5DnxfvJzXJ0bJe6YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 09:35 +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 05:06, Liu Ying wrote:
> > On Sun, 2022-06-19 at 14:11 +0200, Krzysztof Kozlowski wrote:
> > > On 18/06/2022 11:22, Liu Ying wrote:
> > > > This patch adds bindings for Mixel LVDS PHY found on
> > > > Freescale i.MX8qm SoC.
> > > > 
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > ---
> > > >  .../bindings/phy/mixel,lvds-phy.yaml          | 64
> > > > +++++++++++++++++++
> > > >  1 file changed, 64 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> > > > diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-
> > > > phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-
> > > > phy.yaml
> > > > new file mode 100644
> > > > index 000000000000..de964ffb9356
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> > > > @@ -0,0 +1,64 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: 
> > > > 
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Fmixel%2Clvds-phy.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7Cc7d6216ac12148ec95d008da528f78eb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637913073407696040%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=m588CiXOaJhWFbpEal3MjZaHtvOTUOVIujydIdPxSHg%3D&amp;reserved=0
> > > > +$schema: 
> > > > 
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7Cc7d6216ac12148ec95d008da528f78eb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637913073407696040%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=IGn5f05QrzyX05k%2FKgTitdq6OYN2FmdpsO6qHXun55Y%3D&amp;reserved=0
> > > > +
> > > > +title: Mixel LVDS PHY for Freescale i.MX8qm SoC
> > > 
> > > If Mixel is a vendor, it needs it's vendor prefix documented and
> > > used
> > > in
> > > compatible. Filename should match compatible. If it is not a
> > > vendor,
> > > then filename should be "fsl,imx8qm-lvds-phy.yaml"
> > 
> > Mixel is a vendor. I'll document the vendor prefix and set
> > 'fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum.
> > I'll keep the filename as-is.
> 
> mixel,lvds-phy is not a good compatible (and filename) because it is
> not
> specific about component version. Please use specific compatibles
> only
> thus also specific filename (filename should match first compatible).

All the information about component version I can find in the PHY IP's
data sheet is '28FDSOI-LVDS-1250-8CH-TX-PLL'. '28FDSOI' looks like the
technology name. Do you think the compatible name can be
'mixel,lvds-1250-8ch-tx-pll'? Or, any better option?

If the compatible name is ok, does the below compabitle property look
ok?

===================8<==============
  compatible:
    enum:
      - mixel,lvds-1250-8ch-tx-pll
      - fsl,imx8qm-lvds-phy
===================8<==============

I'll change the filename accordingly.

Thanks,
Liu Ying


