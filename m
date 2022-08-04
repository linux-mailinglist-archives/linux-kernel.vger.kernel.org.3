Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227B589A37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbiHDJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbiHDJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:57:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70138.outbound.protection.outlook.com [40.107.7.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E426612F;
        Thu,  4 Aug 2022 02:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFQXDL4CEW3p2Yp4ZmnNKOMqOeh73oJyxRviDnWvQt3cGdfFBqb5ekSma7ReXtYlh3U1VZu96ZauIosj8h52ejBQ1MK1GvoC499uCR3GEVqfDZ5pE+0Fv/HVum4LwXVH1rRg6VHV5O/SCEVa1WHIESxGMrnfqw4KMA28Qa64IebwVDzAd3ZOHGkyulkj1OeHnwhrVWMXoS6Z4KqUmyL+rS/8umxw7G2dQ4qc8HIogb7yUNHkMbCwVdx11C/A2VoOIukHwzKhs06wyk7MtJRmL3+5qslb2o5MCbycHYHYmuK6FcYXBacfMWjvLNpFIlv5n6yL9OWq25vJ6bzeBTlXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVNVG5feUAQ3sQAp7M9grxfXHT9nu9rX9gKByFFwnr0=;
 b=eOCbWv4w+4MghKxdx2PYZoTBnswn2rPrKo4grNguZIEc+GFiD47ptcNQgVCBAXRo7Mr6egXv3N5btz/hGPjv+Lgtg2ri3I/IaA06OpIQrDNN4xhKz2M4oTKD8q5XAXYyfnQB5ohKsJlLatAnot7RXk9i774APsvpVx4rRlw+8xvkY/4md5P+G5K9s1bad4px8eUcXN/NlZ2HlPGsj6D6hObRvOXBMil+6HOIYUi0IQR3DYwYtq6g63THQ0DoazzqtInaKDL83bUXRhWYymbn0W3e5tLVlHmacbTuIsiXyrYME8BNelc0dooIzNnLVK0gojkU/S5rTtYE3vK57ebVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVNVG5feUAQ3sQAp7M9grxfXHT9nu9rX9gKByFFwnr0=;
 b=V1HATDJl7Noqm98zYQbSixezzg3zfHKjk/YWA+vPEvilui7nk4FrKzph5WXj6Xc8zmmMDzFjSjvL0eB/BMrDkH3FyYUOo9nobVJKDolJ0/eDfgAjdw2OUmllY89nxh1FJy2t0X09uGeM7XKOlsTELL2zAO30n5iPDGCrGIGo+1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM6PR10MB2869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Thu, 4 Aug
 2022 09:57:45 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8%8]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 09:57:45 +0000
Message-ID: <917495af-96c3-b35c-f5f9-8e244a0d7d0b@kontron.de>
Date:   Thu, 4 Aug 2022 11:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "dev@pschenker.ch" <dev@pschenker.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
References: <20220722075600.10943-1-dev@pschenker.ch>
 <7ef6812e-5732-e8c7-e796-f568de4eef62@kontron.de>
 <48e83d4f3755ebef722734f65777822529ab08f9.camel@toradex.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <48e83d4f3755ebef722734f65777822529ab08f9.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0037.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::25) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d4342cd-d812-48c7-19db-08da75ffc768
X-MS-TrafficTypeDiagnostic: AM6PR10MB2869:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jka4FfQkoD5VBAKl1q8tYHQuBrIM9cP4yylex1hMCRBOkhCFWhHhmHkmcBuZabdKmHmGlpSMwDEMSWvcH1OPd0JgLxdXZhiuQdahwVBSNcj42YcwslbRAperTDsors9wqpWbg5yEX4Tv+52vZkVyILvX0X/0E+WK/zU7DRMgoUcH5zlOC9ZyDaAOR/CvKirxiNKZmudAll7mietIr3REycLiAjlgHYP/X8ntQ4d6q1p+2ix+eL0ds3iZ5j6DKHXYGF+z9JL1bkE5AJNuPJUHshSdh8lc867c1SydRXQzjoucZ/6CvYudLiT/6qlTpbIcZvlLjGj49keZ1reJLzfC+mCFEwzqLXIoDoOnK0DoOl9NcbixPNChoFRJQDXMjzkCjGUGe557DWmTHOTekysL7Z/CXnOu3eHVrNPg8dfEU1ry8s7lbIWVQYCSv0ThXJCXKwae2bWvxFhgUWg6INfxk9jUK+x1s3y9FY0maNHe3S4neNYjuHVum+sSK5V/QiZv1YvsRNiPv7y1ej50hJwfJF+eZmhK58aNcGVShSrvKLeeh0rQEZVO+32TbwwWL34fINZwC/fJrdYULRwMIH1ofLz1BcpWkFazOeNFBFPr21qJAS36+MZZzZwivy3ItKbrv5PrA2QRBKiDlkS0TnZV8zJa8IGiSTAaWCzEt7qCxdiHqVAK/m+nXcGN3mdAPvaFdHeQzjlNVEE5aMaBw5G4kLlw9LVaheW3eX+KeHC/vOjPBFWB6Qt92PceCVcVyZL8jhT2bp5CkRJHy/PthZW+raLORImRVvRzHBm+HEsUZHW5xCkzvX81KBxYY99+sOwvw+SX4qIUW3RA6rFOuFUvCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(478600001)(86362001)(31696002)(38100700002)(6512007)(2616005)(6486002)(44832011)(6506007)(8936002)(41300700001)(6666004)(2906002)(83380400001)(186003)(7416002)(5660300002)(110136005)(316002)(31686004)(36756003)(8676002)(66946007)(66476007)(4326008)(66556008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDVIVUs3Y2JaVUhhM0gwS0RmM2lzbHBWR2lqZGppemNhakZ3cFpFVTcyREFi?=
 =?utf-8?B?QmZ1aFJkNDE3RnZyelFLcGt4aW9RMlpLNFdPUE1pTlRzVW5CQVVZbExrYmRN?=
 =?utf-8?B?QTAzbkNJYVppQU01VVFrMXlYZVFvcVRzcHRMekg0V2RRa3E3OFVORVBDTHhx?=
 =?utf-8?B?bGZJYUdZN0ZmblFOZnJLSVBONktpSW5TQS9ia25uZ3ppYnRod0VmTEl0NzRz?=
 =?utf-8?B?K0RVd2ZrQlkydUpGcEpubFl1a0pQVXdLejgyaTMveWZtV09tODJjNGZLbzlx?=
 =?utf-8?B?aHc0SVVxejBmWjhqRzJKUGZUeDVvVHJibUpHOWNjNndTRU1JVVBFcTFMU2F0?=
 =?utf-8?B?RzV5ankvWVBzYlRmM0FRT2tDaWVFeGE3dWdUc0N4OE0zTTBiTHBhOG1vbnZV?=
 =?utf-8?B?MEpnL0d6dFBnbGVDdE1xR2FydFkwVnlzNWEzS2tBRGpjbk91WnN6QWpkbGRq?=
 =?utf-8?B?TmZwenR2S2tNY1U4dVJCeUZZQm9xMnNnRWJmdEt5RUdLUGxsNnFWRzMweDR5?=
 =?utf-8?B?L1FVZGVHN0JBOTFhSnh6SVljSmM3R1ZSRlI5cy9DTkJleHBNa2lWVVF5RFht?=
 =?utf-8?B?c1JJTnB6dndMVlNjdTdYc0swK3VDenB1OXFPbUQ0OVlSQ05YaEJmWGVOTyt3?=
 =?utf-8?B?MG43L1hMNnNVcmkvRzJvYUFhTFhQT1ZsdW1udDhDOFl3QkVNTnlhWDdGeWtm?=
 =?utf-8?B?ZitZMlN3QmhiVmVmbzJpT1BobmxRK2t0QVR4Vjc3eWltdGQ0a0tzSk95WXlI?=
 =?utf-8?B?aU1Yc1EyM29ZbXFJUk1lODgyd3ovRkNMQ0FTZ3BWbURYQng1Z0JDOURFMjN3?=
 =?utf-8?B?RDVCbXJuR1JGZlp0L1o0VnBpdURacTNxUnBQb2Z4aDF6NXpXMkxYZnZDNFZv?=
 =?utf-8?B?T01lYjZ5eVpwOWJ1ZkhPN2xnMzJFcmlnZDdGbG9Pb3NRYkVHTXFlZC80c21q?=
 =?utf-8?B?cWMxK0tucmhPOHh4RE93RDVhQkVjcHpGaC8yalVkVk1BbUU3cnBVU1V4UFBI?=
 =?utf-8?B?aU5KZTR4ck55OUJaVExBZXhFQlk5R3NVRWF0OE1Tclk0RHhpL3kwY3ZvTHdS?=
 =?utf-8?B?dCtuWVR4T1YycFh4Qkp5REFXVFRtbjFWZEF3WkdBVm9hajBPM0wrMm1CRUox?=
 =?utf-8?B?UlBYZGtnWTI3UHN5cXpZczg2TWwrUGNxWi9NVDgxOHlXOEpYQWtjVEd4NFV4?=
 =?utf-8?B?Uzk1NERWVGttcnJvQWQ2cnN2cDNuVnJBS2VER0ZZVGEzUkhRbWIvaEFqeDVK?=
 =?utf-8?B?ZEo1VUZIVnluTzZZamFzY1c3aExYOUl4U0lyc2dHeXlqK0s1c051Q3I0Z2g2?=
 =?utf-8?B?SEtqY1dLTWwrZ1FUbVVRSkF5NW14aGFSSmV1aTlOZFRsQjEyNHpaWm1udFZB?=
 =?utf-8?B?WU1vZUxPUVlWUmVncy9SYzJpaUpIdGYrN2lOTkR5eVkzRG00Syt3b1VoSDA4?=
 =?utf-8?B?dm9MV29XVE1TUG1aeDRFY3VUSXpsbkJQakVFTmFsYXdoSTRmYUNpVTk1MUxY?=
 =?utf-8?B?eFRsdVduVWpDMUxZRUJXbVR3NEdHN0ZicjFraUFPNlV2ZFBMVmpoL3VQTHcz?=
 =?utf-8?B?NGxYYnFYM3B6NUdXZk84WmgrNERuWHJpbVVkczJSVU9JRDVsSno1Ri9zcEhS?=
 =?utf-8?B?Z3FNQ3JhVDZBeFdTelErMlprVk9jMXBaQk5xWVNlQzUzeHd1Qyt0UVdVclB1?=
 =?utf-8?B?eXo1UUhsRm5WNmJIS3EvbUtCbWlxVjNVVWV0MCt4S2l4Nms3MzhZMkFhWVJZ?=
 =?utf-8?B?NFVaSkZVNzFNS2JVZTBwTlFnSWxib3E2QWRWNEoyVmIrcEF1UVpJT3N0OWw0?=
 =?utf-8?B?dllVeWhycUtGNTlaS1RvcjdkS2dVQzRueUF1S2xVQ2RuZ21hbFRmL1dFVmQr?=
 =?utf-8?B?bXd3SDhMQS9SS09Yb3UrTTF4dCsyeGs3Z1ptaUFFWHVwNmV0WlNZTDNyc2ho?=
 =?utf-8?B?WWNDN2s4Y1dlMGhqUVNvVFp6SlN4RDRvSk4rTXA4blBYUjBjZzQ5ZFRaV09i?=
 =?utf-8?B?L2UyRHV6UHJaQUdhRDl2WXVtTnVnK3B6dGJyaXYzcTlrZzF5czBOSmJJbDFW?=
 =?utf-8?B?NXhnQVZoOVdONGI0dmZxMFgrSXorbG5ZamtZWTZQZDFNcDJyRGFPQklLbGhk?=
 =?utf-8?B?cWIzd3VvOEdnRnVxK2RCRUt5TVI3dVhJTlBxMWY2a05qVU9YYy9kenpzK0hj?=
 =?utf-8?Q?9WI7imvUJOvGwHE4eRNJnD1huBpR8mZvzAwEXQULnDip?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4342cd-d812-48c7-19db-08da75ffc768
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 09:57:45.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExZ78t5qLOrfMzxZBQBh+sFOiSf57+ViQz1JXJTeSX72ScVIbEtzLlONDrjFeukCEaHwES6kyJ8RvKEiv/rWkHQH7Wdel9AtJbbKI1+hhuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2869
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am 03.08.22 um 23:26 schrieb Marcel Ziswiler:
> Hi Frieder
> 
> As Philippe is about to go on his well-deserved vacation he asked my to help answering your questions. As I was
> also involved in the initial analysis of this issue I am happy to help.

Thanks for following up on this!

> 
> On Mon, 2022-08-01 at 14:14 +0200, Frieder Schrempf wrote:
>> +CC: Li Jun, Jacky Bai, Lucas Stach
>>
>> Hi Philippe,
>>
>> Am 22.07.22 um 09:55 schrieb Philippe Schenker:
>>> From: Philippe Schenker <philippe.schenker@toradex.com>
>>>
>>> The Verdin iMX8M Mini System on Module does not have VBUS
> 
> It's actually the ID pin we are talking about. VBUS is connected just fine.
> 
>>> signal
>>> connected on Verdin USB_2 (usbotg2). On Verdin Development board this is
>>> no problem, as we have connected a USB-Hub that is always connected.
>>>
>>> However, if Verdin USB_2 is desired to be used as a single USB-Host port
>>> the chipidea driver does not detect if a USB device is plugged into this
>>> port, due to runtime pm shutting down the PHY.
>>>
>>> Add the power-domain &pgc_otg2 to &usbphynop2 in order to detect
>>> plugging events and enumerate the usb device.
>>>
>>> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
>>> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>>
>> I'm probably having the same issue on our hardware.
> 
> Does your hardware also NOT connect the ID pin (sorry, Philippe initially confused it with the VBUS pin)?

We have both (same SoM):

Kontron BL i.MX8MM:
* USB1 connected to Micro-B Port with ID pin (full OTG)
* USB2 connected to always-on onboard Ethernet adapter

Customer Board:
* USB1 connected to USB-A Port, ID-Pin floating (host only)
* USB2 connected to always-on onboard HUB

> 
> BTW: According to a lengthy discussion under NDA with NXP the ID pin would need connecting even for host only
> operation but our current PCB does really not allow for this to be easily done even just for verifying NXP's
> claim.

Hm, that's news to me. So far I can't remember having problems with
designs that use the OTG port in host-only mode and leave the ID pin
unconnected.

> 
>> There was a previous
>> attempt to fix this globally for all the i.MX8MM boards here: [1].
>>
>> Unfortunately this didn't seem to work as intended in my case (see
>> discussion for that patch). Looking at your patch I wonder if not having
>> the vcc-supply for the usbphynop causes problems in my case. Do you
>> happen to know the effect of adding the regulator here? I don't see this
>> in any other i.MX8MM board devicetree.
>>
>> Could you test Li's patch instead of this board specific fix and see if
>> it works for you?
> 
> I read that and doing some more testing I just realised that detection does indeed not seem to work on usbotg1
> neither, even though that one has the ID pin connected just fine! So it indeed seems to be a more generic
> issue.

Yes, I think this is unrelated to the ID pin.

> 
> Okay, for me Li's patch actually fixed that detection issue on usbotg1. Yeah! That is on one of our carrier
> boards either Dahlia or the Verdin development board where usbotg1 goes to a regular fully OTG resp.
> device/host-switchable USB-C port (with ID and VBUS pins being connected). usbotg2 connects to an always
> connected USB hub, so no detection issues ever there as that hub handles it just fine.

This is similar to the hw setup on our BL i.MX8MM board and your results
match with mine in that Li's patch *appears* to fix the issue. In fact
when you disable usbotg2 (status = "disabled") where the hub is
connected you will probably see, that detection on usbotg1 stops working
again which tells us there's something wrong with a resource that is
shared by the two ports (clock, reset, power-domain, etc.)

> Now the issue Philippe's patch addresses is on a different custom carrier board where usbotg1 is a device-only
> micro-USB port while usbotg2 is a regular USB-A host-only port. There, unfortunately, Li's patch does not fix
> the issue.

I think this is due to the fact that on this hw there's no always-on
device on the other port. So whatever shared resource is needed for
autodetection to work gets disabled when all ports are autosuspended.

> However, as stated above, according to NXP that ID pin would really need to be connected. So
> basically this patch here from Philippe addresses an issue with our broken hardware to make detection work
> regardless (by basically indirectly disabling auto-suspend).

So if Phillipe's patch fixes the issue for your customer board, but Li's
patch doesn't, this means that the HSIOMIX needs to be kept enabled
while suspending the port!?

This is strange because I think I tried this on my board and it still
failed as soon as the other port was not unsuspended/enabled anymore.

And I don't see how it's related to the missing ID pin connection.

> 
>> On your hardware, do you have an always-on device on
>> the usbotg1 port?
> 
> No, as mentioned above, our Dahlia and Verdin development board have a regular fully OTG resp. device/host-
> switchable USB-C port. While that custom carrier board has a device only micro-USB port.

I was asking because of what I explained above. If the "other" port is
not kept out of autosuspend by some always-on device, than Li's fix
doesn't work for some reason.

>> If yes, does the detection on the usbotg2 port still
>> work if the usbotg1 port is disabled in the devicetree?
> 
> I believe this might be a separate issue recently also reported to us by a customer. However, most likely that
> is/was on downstream and maybe even on a different i.MX 8 series based module, not quite sure. Let me check...

For me it looks like this is exactly what this issue is about and what
prevents us from applying Li's patch as a global fix for the
autodetection issue.

> Anyway, for us on that custom carrier board detection does not even work in the regular case with usbotg1 being
> available (albeit micro-USB device-mode only). Unfortunately, we don't have any carrier board where the full
> range of USB tests could easily be conducted

Thanks
Frieder

