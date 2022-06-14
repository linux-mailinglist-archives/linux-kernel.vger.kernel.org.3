Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27C654B19E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbiFNMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343565AbiFNMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:42:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD3B856
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPrVsR58pn//3UP2nmS23LZ8dB0Ae0Ki0E3zBCOw9FjCuMuE27g93ctqc9wT01V1A5PGhV2MydYDggZ4WxE6kTvsQy6z4gieSIw9Gv+zt6HlM59rsH3d1jLK3XY7jhgDJjAFyHobkmMkgtCYxzRvBeVqo40jcCpsnEfdc1UW6jniZhy9rUH5PIXwBTeS1zlrwTjF/Dkbrk35dmhxG6YSRCGtU7QlZpkNq1+TDdWUuJ9GEYpGfLGSQM3tjvyjoK1aE48ZdnUpnY5SsrURcTf6LuTMI2Xed1yDekBoO7Ru6ABL2XovncQ/aWKs3S+j5OLPnXvPY3X4wGHBaeHsHyH2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWdBRt3G18qqnBO/WN4H1AXoIaAiatOqskAbiPxi2Bs=;
 b=I3j4puebPL5Urix59Tq6Rcz3Y2rftTlbgQL0IDuUcXwJUAl27/izuNAKbh6EWMFZlyOY4jIPTh4Che0bGvH/evAnnLK9N8zbU67EjMlf+lbGOV27blyXyaTFuHGYAv5ijnbOOeshwQoWZkZANTBf4WeUYTe/02WgOwAnbBh09Vqt7hcXwKTDVRyTZI6goK7m4K+a07lWHRcRPu5Irw+DKl9mS2gxgKnXp9HlOS1g4sATz2ZzAFylQrnLI996sBTqZDFfEwyyXonlbPfOuc+QVRHmPSg1a38sNIewKjWfC5hTi1sug8bXKcVzMqforkk3CTIfYDIE3q5P99e9RiGoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWdBRt3G18qqnBO/WN4H1AXoIaAiatOqskAbiPxi2Bs=;
 b=sJq0O1Ccv8mxf34ng+GRjiAJIUxTVLHnnzvvW38HSsLLIPmFnVH+dQs5kipjYKaCqpZgOn08p/O0zVQs+stJTpb1POxgRjxP6ZQJ8xoKmwh7VukCRZpXpnzknxCAr7Exvfz84H8aHFfAKfbP0kyqAWHeUddFWCpsln2FzXIcQqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 12:41:08 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 12:41:08 +0000
Message-ID: <778790a4-1239-e9d9-0549-6760a8792ceb@theobroma-systems.com>
Date:   Tue, 14 Jun 2022 14:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Making Rockchip IO domains dependency from other devices explicit
Cc:     dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>,
        david.wu@rock-chips.com, jay.xu@rock-chips.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::25) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5b0ada-8953-4d10-8876-08da4e032752
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288B56101F73EAE1A4A2DEEC2AA9@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGniFAZ51HsaKJoKlWapxkKn1foO8TkAzGL7IWG2MYV6/VLjNR//DbHBgIGCiGnFWwBwHfELT3jLHFWWAi/CjdRMyrbxHO6vH55pDirbMQwiCIHFEAf9C213cb+Cnm/PHO8Sw8TKXCl7wM4IYpnBaMPWA3Opq24GbbvhKHvnbcMamAs9mhYk8hp2dgHTFnkP3FQnXMQfLrgnyBCdADdlH6Ucx2Atk9VUnNP1g9lMU89f3baXPEqHrjvZUD7D4zyEqYsSltb7Syy10+fM7vytcMsSgCyDw2tkgh+JGKZ9zUg76zOHBd8UVX7GO9/f06n+SOC7bSdkyoppOc01PDdiFEHumCKWkwKmtKGNSJxXJXPevDf0Qi8FyRRX+blkMVZkX9EmRergM3H946UQHX+M9aB1eE0W3sqo/Gtak61FRaFMe8QEyUXHi45afM2DSky+QSnYPcLoZScueM4WYApvQPdgQOhiYe3oLZMA6j7juf3ekY2f+o/6DcoAukhkyExr/I+YuKbapZwWkidfpjNWPxrsmrxPCZqqIBF5LJ4OMsFIAtOO1yLjz2N8sjwOeu8M6cQ0/IWTBgnHI1DDGTqIR1y2wRSBs4yODIGDWoEiuqT+vyqweQdx7lwyJzSaPHX48PkygYWtXiM4ZIHIfex5kfMQjUM8nmelIk0zFfmUr72BOS58KFfR6ozCgAZ8rHNRuYbroEUeXti9n1MnVbnwA+KJzOV27viLCWvhAordUHjeEOgSrEunMrqxca2cnBNpvNjC4lNqwk2+CTyzen6AlocgywN9tptneQ8bQN99zvobwO99eG+GcsD6cuJR+5cGCAPbbYEgnAjhgKax7qH2xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6512007)(83380400001)(44832011)(186003)(6506007)(26005)(36756003)(2906002)(8936002)(31686004)(5660300002)(8676002)(66946007)(86362001)(508600001)(66556008)(966005)(6486002)(2616005)(38100700002)(66476007)(31696002)(110136005)(316002)(4326008)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJqcHYrNXBOakFHdyswd3NiYTF3czJQc2ppaWVSYXpBQ2J4ZXRBSTRzNU83?=
 =?utf-8?B?MXVSVXMvNUtvREpWUUFVaWwrQ1BNM1dqNlREckNTS0NTU2p6WklNYzhXckRn?=
 =?utf-8?B?NU9QTEp2VlNlajAxblNkQ3lzdGd4VjV4NW81eFR5OFhRRW5NM3NsTE4yR1Rq?=
 =?utf-8?B?dE1EVUtmbHlUaGR0VFRzVHZIbzJNYjg0T0hhMk5Jc2pXandjL0d3L3dubHR3?=
 =?utf-8?B?YTJnYnVzM2dxNDVCaHJHMUtPbjBpWjVYbVVGOFF6aWdHN2lNUFNsakIzR210?=
 =?utf-8?B?SEx4WVZJTWNsZWZYSkIwdk5wTG1ib2U1Q3B5Ny81M0ZIRGxqczd6eUMwZExB?=
 =?utf-8?B?R3Z5MnBMamZTU1VjcnVEc1hNbG5DVWdWOWVuWmFsS2VDdERubFFFdTZnQlBN?=
 =?utf-8?B?eHp4ckNIbllEbmF2OUVGTXBWNnFzMGRYTCtyaFoxOXRFMkdwdml5TjVXYVY5?=
 =?utf-8?B?ekx4T2pocXlyYVB4YThlY1IzSS9JY0dFYzZLendhbVI4MUM0ZG4vVlBLaE5D?=
 =?utf-8?B?ZDJBSmEvQUZVWGZUY24xZUxtaHJXTFM3eXFrUFBBeEl0Q3NUdTdVOVFwbGNq?=
 =?utf-8?B?Z2xWTDdXNWw0bFJTaHFiaVFMZENVWlNZRUF2Zldmbmd4TGY3NCs4MXZrUmFr?=
 =?utf-8?B?dXYyRm8wbnowM0YveThGdzdhdFR3REtQU0s1aWJ4T3lRNWZlSFd6Wmg3VEZC?=
 =?utf-8?B?b3VxVnZ6OXFobE5TUjVEVnJVcGFGSHpFeTYvaEVXUkU2Q2hwNFlUNk9sQmxy?=
 =?utf-8?B?aHhEL25MZnZROGJRaFpSQjBrb0JtL0NoY2RQV2RJOTJkNHkyb2pIeVFySEJB?=
 =?utf-8?B?amErRktXZWNqK3pkN0gzRWRTbDM0bmJrbDlNTld3bTY2aDJNMWZuSzkwenNi?=
 =?utf-8?B?VE5BWUl3TkdZYTI0MmM2UGJhZXdJS3ZGQ2F3endwb0U0Q01xUVZuWkg4d2c1?=
 =?utf-8?B?c08rRkYzbjNJNGE2YjMzdXZ6anQ1RG5kYmxldU5jeG51MWxtaFY1ck9IRDNX?=
 =?utf-8?B?RXdMSkFJQ3hhTmRLdDNlTk5yS2E5K3lIN3VBZFIrS1Y4dlJWV2VMZmN1Sm1a?=
 =?utf-8?B?dkRFK3FGTjNEUlpvMUxVQVdMSEp1OG9rTkdFWkVuYzZFbThwRjJiaGlrSGtL?=
 =?utf-8?B?bnFaZitxOW80Q2tRVFN4a3BVUnZKeUp3WE9YYWpPSTA2Z016cUcrUkQ1STM0?=
 =?utf-8?B?RjZobVhic200V3liTkhFN01aVHNUeVBLYXhwRlpsWEt1RTZMRjdaVlZQVEkx?=
 =?utf-8?B?eCtyTXdkOGlBaEZzRityRUNRbFl3THpZUlhLZTRLSFBOblZVYnl0Z2R1aHo1?=
 =?utf-8?B?TTFRRXc3K1JMSkRwKzNDWVJSbW5CZHlQT0VaT1J5eWZMTGlUY1JNN0FRMHJU?=
 =?utf-8?B?eWkveUU2VVFseUNlKzRmckF1Z1VSUG9jZldEVlpEdG55WHZkY0VTRGRTSkth?=
 =?utf-8?B?ZlQvanNNdFB1USsvempubysxRjBqVGYyM1RvcnE2WTEyanErK0ZnQklDaVZj?=
 =?utf-8?B?UENQR3RqWW50NGp1dXFCVHRzVGlYN2c3aVFZaVRVbGZ5VVJEemtOY0U2V3ZE?=
 =?utf-8?B?aG9XSHV0c0VQQitVQkVjdnErU3piVkYxMHprRk1MWWc4UkxrNFByZStHMTZX?=
 =?utf-8?B?Tzd0cG0vRXZvOWFQYnY0QURVTzFrakovbk5oWkpad1loZzBnN25mRi81bGhR?=
 =?utf-8?B?MzJMbmdpQXcwMHArRzNjNDFqRit1ZDBJUTBEYUNiRklITWJBQ3RIVlB6YnZ5?=
 =?utf-8?B?OVZyekxXamJ6ZUVLSHdVSExsL2NTMWFUUTdkakgyYnFNanhVbGNjQ1pJdUJG?=
 =?utf-8?B?NTFqa1BZM3hoVjVtMXVFc1cyZ3RWNFNId1pIVjZpbzg0OFE4VmJRV2hBd3J1?=
 =?utf-8?B?eGp3SG0weG4rTDhQWXJCa0s2emJrR3YrdTZRVmtiSDhJblZqVW5sM283dlF1?=
 =?utf-8?B?KzVKZnMvamJ0ZytCUEZVSUpWL3F5R1FZVHZ4K3ZKOFBQMzhhWjgvSHppWnJw?=
 =?utf-8?B?RmIxWFQ2RFBBRUdaaDk1ZGFsL0RoWktrQ3RQRWQ2aG43WVZYZFM0S2thNlBL?=
 =?utf-8?B?SWdYeW9jSnhtcG9icVhVS2FjTktqQnhSR2RoRXdGVWNrYThJQ2ovdy85QXBt?=
 =?utf-8?B?RTVRaWpzOXZ4WWt5SGxrY2o1S3V1dWNUN2dGSHhlL1lia3dHTmJjTlB3TEhZ?=
 =?utf-8?B?WDRZV1owNGN2S2dkNUZvamFsdWVXVTdiQjZCTndhaHROSzlyZTNkdGRUZVNa?=
 =?utf-8?B?Qm02a3hwNUdaM3hJemxqdFRSd0ZSYU5odXkrL3RCUjU3QUZ2cWtoUUx6Qzhv?=
 =?utf-8?B?MVdGZ3QySC9OekJuamlndjlLbHNteXpSSy9pL1VLdFRvY0xmV3dHdzhHeE5a?=
 =?utf-8?Q?ha7xo+sD+WPJ3Pg+iDJqoHca1Ot8gllsCNYSv?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5b0ada-8953-4d10-8876-08da4e032752
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 12:41:08.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11UQgSJcZ30aNoMoJuYz35HBD7pM78h2x1GLOpG0HiPGoN+RGIWppi3FBGWEIXNEm8gN5wudRQERPrcY1Z7OAgYgwfc03+/UA35qSTvOxoUIcpZoDaQPj1aAr63TYFfQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have hit an issue for a product for which will send patches in the 
next few months and I'm asking for guidance on how to properly fix this 
in upstream Linux kernel (we are currently carrying a patch in our 
downstream U-Boot bootloader instead).

On some Rockchip SoCs, some SoC pins are split in what are called IO 
domains.

An IO domain is supplied power externally, by regulators from a PMIC for 
example. This external power supply is then used by the IO domain as 
"supply" for the IO pins if they are outputs.

Each IO domain can configure which voltage the IO pins will be operating 
on (1.8V or 3.0V). It is unclear if there's a voltage divider in IO 
domains for lowering from whatever the regulator is supplying to the 
supported 3.0V or 1.8V.

There already exists an IO domain driver for Rockchip SoCs[1]. This 
driver allows to explicit the relationship between the external power 
supplies and IO domains[2]. This makes sure the regulators are enabled 
by the Linux kernel so the IO domains are supplied with power.
This driver is a regulator consumer and does not offer any other 
interface for device dependency.
Currently, the IO pin 1.8/3.0V selection is made based on the voltage 
supported by the regulator attached to a specific IO domain.

And this is where the issue lies. The product has a camera sensor which 
didn't even appear on i2c until we figured out that its MCLK was 
actually oscillating between 0 and ~150mV. It appeared that after a soft 
reboot, the camera sensor would then appear on i2c. The driver of this 
camera sensor attempts an I2C transfer to check its ID, which fails the 
probe of the driver because the IO domain of the MCLK pin is not 
supplied with power yet/correctly configured (the io-domains driver 
probes after the camera driver). After configuring the IO domain 
correctly in the bootloader prior to booting the Linux kernel, the 
camera sensor is now working just fine.

In order to have my camera sensor working and not rely on what the 
bootloader set before Linux boots, I need to have the IO domain(s) 
correctly configured before the camera sensor driver probes. The issue 
is how to represent this dependency in the device tree.

It was suggested to me that we could use the power subsystem and use 
xxx-supply in DT for this, by making the io-domains driver expose a 
regulator per IO domain. This works fine if the IO pin connected to the 
device is already a power supply for that device, so we can just make 
this gpio-regulator depend on the regulator of the IO domain this IO pin 
is from. If it is not a regulator, this would mean we need to modify 
drivers to add a new power supply DT property for each driver. This can 
blow up pretty quickly and require, IMO, non-generic changes to driver 
to support SoC "quirks". Such would be the case for us, because I'd need 
to add this power supply DT property to the clock driver so that when 
the clock driver is probed, the regulators for the IO domains of the 
clocks exposed on IO pins are actually also enabled and the IO domains 
properly configured.

So I think the best way would be to have something transparent to the 
driver. Something handled on the subsystem level?

Looking a bit in the other kernel drivers to fish for inspiration and I 
stumbled upon pinctrl-sunxi driver.[3][4] This driver allows to specify 
a regulator as power supply per GPIO bank and will enable/disable it if 
there's a new user/none. The user would just need to add 
pinctrl-0/pinctrl-names to the device tree node of the device to both 
configure the GPIO correctly and enable the regulator for the bank this 
GPIO is attached to.

Technically, since the pinctrl subsystem has much of its behavior for 
consumers abstracted, this would make it a good fit for doing things 
transparently for drivers. The plan would be to have the IO domain 
driver expose pinctrl configuration nodes that are linked to a specific 
IO domain which would enable the appropriate regulator. I feel this is 
quite a reach/abuse of the pinctrl subsystem. Since the IO domain 
registers actually are configurable for 3.0V/1.8V, maybe this is 
actually "pin control" in the broad sense?

My suggestion would look like the following (based on rk3399-puma.dtsi):
'''
&io_domains {
	status = "okay";
	bt656-supply = <&vcc_1v8>;
	audio-supply = <&vcc_1v8>;
	sdmmc-supply = <&vcc_sd>;
	gpio1830-supply = <&vcc_1v8>;

	pinctrl_bt656_3v0: pinctrl-bt656-3v0 {
		pins = "bt656";
		function = "3v0";
	};

	pinctrl_bt656_1v8: pinctrl-bt656-1v8 {
		pins = "bt656";
		function = "1v8";
	};
};

&camera {
	[...]
	pinctrl-0 = <&pinctrl_bt656_3v0>;
	pinctrl-names = "default";
};
'''

We could also do checks in the driver so that the selected pinmux 
matches what the HW is capable of (e.g. if an 1.8V regulator supplies 
the IO domain and the pinctrl is requested for 3.0V it should fail). But 
that's just implementation details.

I'm looking for an upstreamable solution, would that fit the criteria?

Does anyone have something else to suggest or some feedback to give?

Feel free to correct me on my definitions or assumptions :)

I've added some contributors of this driver in Cc, I hope you don't mind.

Thanks,
Quentin

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/rockchip/io-domain.c
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/sunxi/pinctrl-sunxi.c
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
