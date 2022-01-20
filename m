Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2784951F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376854AbiATQED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:04:03 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:56389
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376851AbiATQDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:03:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZmouuWL4zWZ/84ovKf1GFBJntEF9wSPU3midLC0ikcbM+E862yiOZenv/i9VWFFzIv8odOhtRtJQPVYieP9HylVn4acWaSbwOfZu6tWyvp8VFRxe4kP5JeF7dZRS0aiw80ihrDVJv/4U9GF9ckbbhYp6BAcsbcbxZBoubAoRNreVdAJ4QmicHqNG7D+MApVYfzCbKFpkGsBi3yE7RwtpEKJsqTpYK3rqGWFSJsCZ/gQyNl8kmDiSctNpyONMWvLZ4LHwdEgZMo4fBIb5FOEqlCLorB6Ikf01W4dkc5U56f9kOH6S7XvLjvYqwp+z7o/QQZTOKwpu7pr4R9f5DKshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ6QAg1jmHg/OvafZgvBPgihrPkvKSB5Z71c2st5RAU=;
 b=naCdDJYoT6t40LP56sdzrRqJVmDXvq+kQFeXbPGnryARJll4DCL3h2iwsm5Obh+s4ylcE7/pVTFxuj692VROHQkMCQhrIAjBqa2D+FXGQyoymicUdTf2uLEcOQg+9NKnXtfwTyxPlMILFcUW0dh17nyJep4TzV7zT2XB19R7nvZ33qD3UK4Gzs1ecdC+DwhbRS2DXTtSKdSX28gc3zmyFYez3U+QtLmtnibgrCo+z21H2AHiXjr8hHGn6PxljTHr8IH+SbZlVNWs3MUrHnBFfBGuB2pUI35DqA+0EtwbIMsgMOghRBtnWxVaEnbDmveNckDmAe2xzxrEhYwu01Qbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ6QAg1jmHg/OvafZgvBPgihrPkvKSB5Z71c2st5RAU=;
 b=W8hdxbdqjTFdem2i7n/IjhIhPPEzeUB7s2vZQZdRfoLX6+8v/CVpbU60iM7LOp55nOzyaWtFfyeeQyfDSlY83WR1iblpjR8T+NMFSgos81hI0YQ9Q+JjNnYIV8JhoIfUHvp1xFrEDiU1BGbrcc5B7Z3CTTt4qrT1hn/MkS1MK4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM6PR0402MB3814.eurprd04.prod.outlook.com (2603:10a6:209:1a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 16:03:47 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%8]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 16:03:47 +0000
Message-ID: <3e87ed0a-8b79-006a-dce6-62becc9906ef@theobroma-systems.com>
Date:   Thu, 20 Jan 2022 17:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal
 integrity
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
References: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
 <CAMdYzYr+UXU-x=OakdHnOzLe1e4Y0xdGR-rybsmpLCMGbsWwXg@mail.gmail.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <CAMdYzYr+UXU-x=OakdHnOzLe1e4Y0xdGR-rybsmpLCMGbsWwXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0064.eurprd09.prod.outlook.com
 (2603:10a6:802:28::32) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc18ba8f-3d9e-4a48-41fc-08d9dc2e7101
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3814:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3814D3DB29A4D9F8B0A7046FC25A9@AM6PR0402MB3814.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHa2Kt6UYxjcIONy/rVxmR0JcOqAI8cIZYVflmMaKWvxdYJMRpKjVNpy8jcnH36Z3pXReomvW1i8Seh/FJMiVD/gGiqqYqsmQFRqYfn1USknTFBs175z0efcHGqqUICk3zlVw0hJQG+UCG/GDFjN3Hq+jXGiQA0GrvuiVV5lK5fWfSnnZ/faQskBihzIC7c5/+FsQ95aQ5vwC6thaTVwzSY8bBiypHWJFsBZzGjYDdtQj6pdevCFhZh7VUt7gq2fXrCogBsxiSjNhOmcmZrNKkM+TT/Q6CT4DJHbI2eIEezyjJFkJcyAPDBRYTlGdg9MTA8kJsxL92YXVufAB1o7FF2R1sBvQ8ughVWx2cnDRu7KzV61Mp+TpkqZbhGFNfjhEqRiT9zA5UJ1qYnbd1N6hH6bxzz3J/WoN/NE63ExakD6eTKvhEpTSwtkBqSU8Q+I1t9Fp8rjDpIQFZJ0IfwvT01hYPLDnBja9Op99GLmeXCT2xkngldaillh+bt1V1AJMculoO0PNozgv17UZIuVfRu3E6MXGyl3QzHpfWoYcyJdDUYvLA/r5wZx6pwCVNSZDDvUHF9X8WemEfhCB37cIzVuOS51V5SVI8t92oJOQhnzrAN7UiR0vKW306einTpjC/fBXiV5z0LMmYkXM5MyozhdsYqUa4fs3G8pCwCmkhp+8tUWoPtLnEYTVnxLoxkKA+6uQxs2V1vbLjHs47ywvO0Fjw4W/ebuhY+fJh45zX4ftavCBNYRiiCoQpY2xG+6VT/oW8W6ykxDbJlLOtwYUfB1LTPyoVLEdMXLCw80YuzdIEPjECslD8XTuI1nzHnq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(44832011)(2616005)(53546011)(38100700002)(36756003)(31696002)(83380400001)(31686004)(6666004)(54906003)(66946007)(4326008)(8676002)(66476007)(316002)(66556008)(8936002)(6916009)(6486002)(6506007)(966005)(86362001)(2906002)(5660300002)(508600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFBEVitaVElMb3Naa0JIcHNhM1ZLbnF3WUNaSEFOd056Vk9QU3MveG5QRloy?=
 =?utf-8?B?aWtVRDl5TU10WDB0Rk93VnQzOUhsZmlrTDcxV1A2TEx2aVlHVXpDZEZsM2l5?=
 =?utf-8?B?aFZyNy9uZ1N4dHJhT1ZCWG03M1dkeHNpajdTNEpoUTdkd3kzRkVLdE5GcFJV?=
 =?utf-8?B?YTJ6RXZZQ3hRL3hhVlVkRTcwbWtZZjlyOEhibUdQZXg4a0VZeTMyODg1N295?=
 =?utf-8?B?ODEvVkVzdnhJanlKODVQdTZtWlNvQVErNFZxRlBRQzJnR09jSGtveStVMEg5?=
 =?utf-8?B?ck9MZmUrNW5ycUdrUlY4dURTL3VjV3FXMTU3NElZVjBrclM2aWVSM2xGQWF0?=
 =?utf-8?B?d0hlRjgzZ0VwYVZaRURlM3JQSURwM0hTbUZzZlZ5Ykdyc1c2VW5tZkJ4NCtx?=
 =?utf-8?B?TUpIcGtyd0JUVEV5YlA1YWxYQmQ3Vk12a0tId003bC9FTHJJZkpKTnhkaEk1?=
 =?utf-8?B?TkUrMkorcHhRVWk1Uld5R0sxbi9TcGtaYU9Lb3NUOGVxTXNDUUxUYXdIa01E?=
 =?utf-8?B?dHdtbVlvKzhnY0E5eEw0cXVya1hmN1l0OXpQeWx5dERuZTR3SE13TmhwSDNI?=
 =?utf-8?B?eEZRZ1J5VGlLTzVZaHhOem5NSEZUS2psK0NUWkJmWVFsclY0OFl4SmlOMXhP?=
 =?utf-8?B?UFZqWmVNZmhDWVNya0hlT3dMT1VKTHRzM2x1bHR0aGlzWXArTlRWKzRqUHlv?=
 =?utf-8?B?ZWtiQm1NMVA3cVZLdDVrTEZFckh2RUlNeDcxaC9aOTE2YndjZG04QkhJejFU?=
 =?utf-8?B?cnZNVlVhazhEU3JFN0hxeENIUFZleU1zZkNUNUhid1RSTk9hbzhXdEMrNEhB?=
 =?utf-8?B?dUw0QjBibzNjK0JiU05BTEMxWnRQR3dJZXhsaFV3VXk3Mzk0MkNzRjY0UEx0?=
 =?utf-8?B?cGx1U2N4Mk4vU3Q5STVFcFAxT2xoajA0RTV3dFA4Q1BhR284RFBPalVxQXlT?=
 =?utf-8?B?QnMrR3V3dXMwVG1mREQrYXI3MTVpUGw0WFQ2QTd3QWQxdTdyVzBlMDY5WHYv?=
 =?utf-8?B?MzhaVnN0WUE4RHBmRXlBeGlNTTdxZGp1cFhYUzk1THhEcFMvK0ZWbWJBbXd2?=
 =?utf-8?B?dCtQdWZMa0c0cmhJMjFEMVlJRFRhbkdreVh4QitUSnJuRlJxMmI4TTJpckk5?=
 =?utf-8?B?UEg4eVJxa2FVNm81S2lpSVJNRTJNeXlSTkIyQkRSQXltTkloMHFhTm12Z045?=
 =?utf-8?B?L2FKSHllMjFidlltQVkrNkVlWnFGY0ZPODkwdmZlajJpRENkQlc1eGJ2d29T?=
 =?utf-8?B?M0xVRTNHZFpwNitYRm1YdTBhc21jZTR2L080RHowNnl0eU1JMUpIeVAwdFVn?=
 =?utf-8?B?TnZnSTNwekF2Zmo1V0VJSjZtaTJjNzlFdUNaU01NSFpHcEowNVNTc0NQM2p2?=
 =?utf-8?B?RTJoRjNvamJVL1pCV3BjaDVFb0ZhMlEvb1ZxYWg3RFk2aStkYzJiT2tjSVho?=
 =?utf-8?B?N2QyRWJ0OFE4bndKeGwzVDBqc1ZWZUdpWW9SQ3N6VVZIZVRUTU1VZnhZUm1Y?=
 =?utf-8?B?a1dOcmJwZXZFMnJlMm0vTFE4TCs1ajBCWis0czlhd3duOUxYZi9IVlZpK3M1?=
 =?utf-8?B?dEUwZTdGSklrTkF5WmJldXcxbjJJRUFiNUI3MkpSblAzOHFCVXd5Q3FtUEdK?=
 =?utf-8?B?QjRnYzVhVUZhTElPUjNDRVF4OE4wbncxNzhvSTEwMjlENitGZzg5bHdMY0Nl?=
 =?utf-8?B?R0diYkNYSjV5dk5qcUVNTHNMSXUzaTMybnNVN0NaMjQwVmFlMVBMdGlpdm1i?=
 =?utf-8?B?eFF2eHdoWXVSTlRYWmdFZVFsWEVLTldFQTFZK2lDWHdoZitONk4veER6aWdq?=
 =?utf-8?B?NWxKWXFNekxITmYyOTRvdTNZVzZqM1AyN2szSWZhcXdXUTcxS0h5TGpQRjBM?=
 =?utf-8?B?ZTVrMVpUOGI3b0p6LzdzQy83TW9jSUNiTndaa09rRDh0ai9MT0l3VmhoeGxF?=
 =?utf-8?B?ZmVxQ1hNMVNwQndhWGF0aHBaNHd1NDBEVjRsc2JES0toZzY4anpMY0Y1V2ts?=
 =?utf-8?B?VkY5T0pjL0FodmN4YndBUjArOFpnV3BtSUlaaUJVWDZLSVhnQ1NsNHJGaVhO?=
 =?utf-8?B?MXF3emxEZERUUEZzM2NiYnlRMDFFdTBaaDhXeUxaVXNwU2c3Y1FqSjNrRllS?=
 =?utf-8?B?UjBxNnc3MHJSbEU1L3VXTVJxdnJqMUdtbTkzQTdnVGN2ZFQwaHZROHVQMFlS?=
 =?utf-8?B?VGt5WHlZbVBLZ1hWMGJoNjBTazJvV0VwYlBkdkxOWlJYNmR4bkRUUHRzWCtG?=
 =?utf-8?B?dS8raWpvVXRiOFk2Z0tNUEZieUdRWGZoaHJVQWNpNmU5Z0I2MzRqejI1WnEz?=
 =?utf-8?B?QzFkQjRTNzdKbDJKN1Q2QjUrN0hqY25aTGt1eXpBdGx0L2FhcHhBWEZNeTlK?=
 =?utf-8?Q?dIx5nw18FbsRsP2g=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc18ba8f-3d9e-4a48-41fc-08d9dc2e7101
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 16:03:47.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf0Yusm1ZK/jtIqzZU3p+Ixy/lB6i3ionvcQOtyXbI65VaBU+KpSOhdGA2Ut/XD9c1mwtyqBZC59sNFGYNqWyV5KNyA+/ZcrpHfUD9+yCPb9K7tGFvZLZ4r+XKtfcquO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 1/20/22 16:06, Peter Geis wrote:
> On Wed, Jan 19, 2022 at 8:52 AM <quentin.schulz@theobroma-systems.com> wrote:
>>
>> From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
>>
>> There are signal integrity issues running the eMMC at 200MHz on Puma
>> RK3399-Q7.
>>
>> Similar to the work-around found for RK3399 Gru boards, lowering the
>> frequency to 100MHz made the eMMC much more stable, so let's lower the
>> frequency to 100MHz.
>>
>> It might be possible to run at 150MHz as on RK3399 Gru boards but only
>> 100MHz was extensively tested.
>>
>> Cc: Quentin Schulz <foss+kernel@0leil.net>
>> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>
>> Note/RFC: as opposed to gru DTSI, max-frequency is used here instead of
>> assigned-clock-rates.
>>
>> AFAIU, max-frequency applies to the SD bus rate, while
>> assigned-clock-rates applies to the clock fed to the SD host controller
>> inside the SoC. max-frequency does not interact with the clock subsystem
>> AFAICT. assigned-clock-rates sets the clock rate at probe, regardless of
>> eMMC tuning.
>> Technically, the Arasan SDHC IP supports silicon-hardcoded clock
>> multiplier so I think setting assigned-clock-rates as a way of rate
>> limiting the eMMC block is incorrect and max-frequency should be used
>> instead (as done in this patch). Otherwise the SDHC could still potentially
>> derive a 200MHz clock from a lower rate clock thanks to its multiplier.
>>
>>   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
>> index fb67db4619ea..a6108578aae0 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
>> @@ -425,6 +425,12 @@ vcc5v0_host_en: vcc5v0-host-en {
>>   };
>>
>>   &sdhci {
>> +       /*
>> +        * Signal integrity isn't great at 200MHz but 100MHz has proven stable
>> +        * enough.
>> +        */
>> +       max-frequency = <100000000>;
>> +
>>          bus-width = <8>;
>>          mmc-hs400-1_8v;
>>          mmc-hs400-enhanced-strobe;
> 
> I don't have these boards nor the schematics handy for them, but
> wouldn't it be better to simply switch to mmc-hs200-1_8v?

Thanks for the suggestion, I just tested, by removing mmc-hs400-1_8v; 
and mmc-hs400-enhanced-strobe; but keeping the clock rate at 200MHz and 
adding mmc-hs200-1_8v; failed a basic dd test.

Cheers,
Quentin

> Other rk3399 boards don't have issues with hs200 at full 200mhz, and
> as I understand it hs400-es exhibits stability issues on most rk3399
> boards.
> 
> Feel free to disregard my comments if you've already tested this.
> 
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Drockchip&d=DwIBaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=OTusi9XARCbef1Ba5t1gv4_LqRkOaxFY3UtvYky6NVLpeiziqqmdOJ8-R5WXWFNr&s=xBnqhBu20rxvu_V-5EhXyA_yNxcJpa4Dq6HO2Ow3Gk8&e=
