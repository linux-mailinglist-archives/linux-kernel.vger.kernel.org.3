Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CED4A9F69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377703AbiBDSos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:44:48 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:62622
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240086AbiBDSop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:44:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvyhP7L0DJpPHvyBebRtIJM5nxgZZ2D4SYCuVyf31YOMo+5oxCiF+0BMAyy6QaB8eZ9PR5zwBlh/wNZc8NXhFhB2qRgYnHGoNes/y5AHV+L8H4p5umJ1OM2RkE4ZEdWhN5pubPI+aDDuu5bMpRdaTIB3UmhyUmB72l+eMuZ5OkbdEBVmZcAmHgt3wzQyZ6fkIDnEbSLFVGwsCOx7yfRWVOUwnPX0IrAX8sKlNozZEap8N8CY8agIwVZUvdFOy3dsWKvL10h/RpsbRhhz/dut7f0a5JSorVSLnMH0k0d09qJ8sm1RMg6NEELQ7M8wRueZ0Vw81aLr3wdVlBbFduaZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDaT7d51GWfkBUfr0FaOFUF6S5i3bjXWbZV+tEtkwlc=;
 b=gzlel1V5UYzGE9w+j+eltdiMasz/gZvBeccJNIVFAWKp001/iHqztBbcoui7RMtHVMraSbBmN54DQWzCsxv4TKydADLm15pd/P/mRC+GLkDV761N6JdTcARtYRpwUngfHq66OXIvRLv4rjATlm4rJwTxRFpRwlFAM3mkf/FBGMpGhmdtWTZ4AE5//IwYW2U1T2mccBeQ8gpEtjCG3LQyS16RsatuAerR6RD35qs4vzHqy+0Co0xxYxfDtB6Ir/lyCXqBPt/w6T19pyk84gl5/uErauTwfrUQfspJGv5cicqN/bDNSwBXDkV+EHh7jnNj8oLXNse2IihLUQJiBC9DHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDaT7d51GWfkBUfr0FaOFUF6S5i3bjXWbZV+tEtkwlc=;
 b=EgGDGzd8ldfACsweDjw0Dt2ermADAJRtkj7gsbtOsAFi1JOfrk/t+rvvBYQ8IhMuGmiKvi+6cP8IDkoiI5JhLnRLRLly/gkFqliIHIVEqOi0YwUuA2e2X7CjfBcrNOT21mIoHUzTOyF4kzYL3Y35lFCSghlm+KCTWiug3Qfk+mHBkTH1zZKSqioK+g+/kkgjG3jWmyW2QEEFbXRZHs0FbaxGG8WVobNucbAHjuqtc7JSMD9mYIZl+jlOPeICQ2gZrooE24WMd9tZboGVYEb7LaH12ff7kK7GcEHjF7oABNRZaWWDp6FE1xLvJjBxNjNNp6m4uy+zDdSQMMpQEefJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3706.eurprd03.prod.outlook.com (2603:10a6:5:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 18:44:42 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 18:44:42 +0000
Subject: Re: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-6-sean.anderson@seco.com>
 <CAHp75Vc--RYW7P0wLA8Jcr53xKSkphJV=wTeZiPC-AYu4sGYFA@mail.gmail.com>
 <2c1832a5-1e13-1423-2be8-e31b5ec5195a@seco.com>
 <CAHp75VfGFNFqOU0BymNwh_FWKVw+rSyJJRDSKOinWY_Z39qaGA@mail.gmail.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <928f7c83-281c-b995-1bf5-be35b7539de6@seco.com>
Date:   Fri, 4 Feb 2022 13:44:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHp75VfGFNFqOU0BymNwh_FWKVw+rSyJJRDSKOinWY_Z39qaGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f25442-ded6-42e3-d6c3-08d9e80e67e3
X-MS-TrafficTypeDiagnostic: DB7PR03MB3706:EE_
X-Microsoft-Antispam-PRVS: <DB7PR03MB370642DA3705B9D4331BA21196299@DB7PR03MB3706.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1dEERJdXk1UM6TOLwwPdWR3+zBmX9iWFuheqGsIJIDsSDOYbpx2vqnrbGVlVM9Gx/LEnn+f1dr2hOL3z6f5We3aVJIgqyPpVwOGEG4I7KCjfiZ7os8eMMQ2jXRggdXlpEuWtKmkUfVRs7dHvM/9MInWXGvip9+Gfw2GgQTEGPsb9gR5KTJD2Hvj03dPStGf6qw/ovBYYNLaF1ZL7ctLTDf0hqrAeA65nSkCh8DDUe9U8+8xxfVJkg/iulMQ2P0ZTDc+RSp2wAFmLNlIuhObMJ36L5yoYHqDGxtmNzoeAWKIAJtcTyvIebwGPw1b0J+IRwE1++Yaou+EgSXg38RFvhrsU+bllpyIzC3AFdExHciVVCbKxvZyllSHIUMuu/JzvgEBkp9jpbQ1kaTZ7m3Kp1nBphFkSKK7x4F7wdq3xWPp01KIvpFg5Q7v0Mpr+YFFXQmD8b6CIePltr0cekTVbTwYMdii617O/u1KS/+LI0jdsziHfriIT0Ci7Mnuq3nNvCB2mIYzDgL/cQtkXGReLQQLTJNeKY9vKLR8TLMZv0QIkt+ImaqTG7d7ygUmQaI+FIZT0jQB91mm5abFVPlANPcO0Y6yY3TqOk2XB82ARgpVr9M1EnbfDfe0pVNS8yZuH8kwtIIaYX9z+GQYSL8TdyjFj9UGCclXD7FUTM+ZhoKj8XwGPlmfxigp6qV6kjKFR7QYswxEfyoJgkUmEMFq4PoVH2KZUBxyVLQMixXCG6aIrOVFj2yckZ57xWiM4QjR+ocSTj2kZor5vMhBlSzTtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(86362001)(38100700002)(31696002)(186003)(6916009)(36756003)(31686004)(53546011)(38350700002)(54906003)(6486002)(5660300002)(4326008)(8936002)(8676002)(26005)(66556008)(66946007)(83380400001)(6506007)(6512007)(52116002)(2906002)(66476007)(44832011)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Jyc0FzWHROU2VTQWlacDlHNGhXd285SXBvTFhJbytOM3dZTG9zWk5ZMExn?=
 =?utf-8?B?bjR5ODkrWjhEdnJsdlJrUlBRK0YxdHFUS1JwWlpDcXkvTmxodFN3eXBlVHV2?=
 =?utf-8?B?dmpOemhEdlJnWk1jUkMwejY0N2Y1czlYSmcxM0F0R29oZVI1eGZVQjVOMktL?=
 =?utf-8?B?R2wxa1RiV29pUFZDS1lndTRvZWVVM2dIVTIrTjVsYjZvZFZhWGtTTElKT1Yz?=
 =?utf-8?B?NmhkY2VGVzkvWHdqaHF3bjF2clBuOWh3ajdZV2VoZVd0VFRDZ3lQZ1BsRi9w?=
 =?utf-8?B?bjlRMGVZR0hPdGY3cmFKS29BUU53Sm45VDQrSmZmUFV1cDhraWszSlRWbXpP?=
 =?utf-8?B?U0FqT1hxcUhFc0lSWVpjbXJWbThZRkt2dEdLNFBQN1JlL3N3azYzZFNyY3F1?=
 =?utf-8?B?Qkg4RnJqRXdsZXlmOC9hZEpzbnlLejNhaWFsN2xPdldSTTRhZXVOdkh4ZCsv?=
 =?utf-8?B?RUg0SHhYaUJCM09lWkJpZ0ZLb1k5MkVlaTR1MEZDNVJvWkYzMlQyd1RmYlFW?=
 =?utf-8?B?Mlc5MWxSUkFURWVnOEhSUHVUeEZCVkZIS1YxQUJ2WjgzRUdidmtFNytaR2JF?=
 =?utf-8?B?Mk43RENwMlE1Y1E1cmdPMzRaM2psT3krS0RCWW82WGZEY0d2NFFhcE12Z1V3?=
 =?utf-8?B?Umo3QXBDMWZTTUJ6c1FlTGNobmc3Z3E3ano4Tk92ZVZuV0xrbDhQTk1qZTZp?=
 =?utf-8?B?ekVESUlaYmtWZVp4VlVhamF6azdxQnpXSjNMTjRqanZSbytwRGFjRHhraHVz?=
 =?utf-8?B?N2ZSNFd2OG5odFdIcUNEeDFVM0d1emUwSEd3Vi9XZmdCdzFqbkkwWjd1U29Q?=
 =?utf-8?B?VkQ5NTdjR3Z1SGJ4TURCLyt0WGM1VnRxQlhDM3JzMDFHM0NXM3B1cG9iSUkw?=
 =?utf-8?B?T3VWUzdhYkRSU01jOGFkOHZSVU9ZOXlXdUdOLzQrb0U5MXJxVkM2RldiN2pR?=
 =?utf-8?B?YU9hYndxaWNQOXVYTkhRSWRJcVBqYjdBY1M4WGZicStzT2w1ZXJycUFqNVI3?=
 =?utf-8?B?R09iVWhRZ3UwMWVmY1VGY1FvaldKWmZ5VXRPVW5TbXQvMUV1R2VTRmVDVGZT?=
 =?utf-8?B?UThFdHVOYjFGbzFoQU9PaDJ1ZXFtUTlXc21tSkUvUDV4TFU0aU1mZXd0SkFO?=
 =?utf-8?B?RDJOZUViK0Q3OTlUbExuTGpaR1YrUi8zWVpueDNiQldpd3EvUWxiRTJ0WVVN?=
 =?utf-8?B?MnVvdjFDWDZPREd5amFsSGRzeHZ6Z0NoQU11RDR2cFdMUGdQeS9PT21jN2du?=
 =?utf-8?B?SU9od1YrUTN5eEJ6U0NCb0xQVXROeFpzTHQzUjNXWGgrVkhPcWhCMGEvcyt4?=
 =?utf-8?B?K0pIVW1pbVN1VyttVnl0d0QrSzh3ZTd2Vnc4VTlNek12TDFUakQvTW1xUDJM?=
 =?utf-8?B?SzAwbTFMY2ZwNm5RSEMxTG9hT2RHcWtKUHU2cnhTMU9lb1kvYlp4NWFsUm5n?=
 =?utf-8?B?TVAxNlFpMEl4c2l1cUQrWmMrb2FqS3d0S0pJTDJheVNaV1pCbld0TGNzYjdQ?=
 =?utf-8?B?dFhmZHk3dXliQW9KRWFtVGNzcThpeXh0R2tQVGMzTkpEa29OTTZEU1dLam0x?=
 =?utf-8?B?ejk3S1JCZ05Sc1lSOURST0N0QkZTeWNNVjQ3VHRQZXM5RGZDRWoveURNNzVI?=
 =?utf-8?B?M0hYTXh4cEJ1NEVFR2w2YUNXSlFWa1RCQVRvU3FFVW9sM0hzYUZSTHo0RE4v?=
 =?utf-8?B?aHozSDY4YWVoRElpUTFPM0N3OGY0bXpKS2N6V0VmSER3UFBVMEtnYTgrY3dv?=
 =?utf-8?B?cEg1UnJ3VVB5ZTZQeFFjb09veDk5aHVSb09XdVplQ0x3L0VhdDkzcjVkL3E4?=
 =?utf-8?B?cGROdUZybHNPQXRDUFc0WS9WcWY5SDBrdW85N0d5SWc2cTkwRzVwL0l1QzVo?=
 =?utf-8?B?clV5MFRNbUlmSUFxdXBSbS9LVU85SGFlZ1JwRHdDeThKRVNXOWhhR3VKblU0?=
 =?utf-8?B?NSs5SG9vT00xTW90RmRrWlF2T0VwSVNPc2VVYmhMaE9iNTN5L0V3ZzdTZzVx?=
 =?utf-8?B?RUprTERZWXIxMUUvd0RuejRqOEJ0Nnl1QS9ZN1VSdUl4OVQ4WmthZEo1OXlG?=
 =?utf-8?B?VEtyUUtiMnB0SURUVzQveWZTajNwbkJwNjU2a3ZSU0tjZlFkZmNVMnpFMzZz?=
 =?utf-8?B?c1FOdU96Wm4xZHFnbGFjWFUvZ2YzaU9QNzRjYWtVMnJpWWJJQjdqMGRzSlpW?=
 =?utf-8?Q?02s1FBsHgWi7DxsoF35Vn+M=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f25442-ded6-42e3-d6c3-08d9e80e67e3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:42.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agSYMPOllem6twZgerMIA/jdfr6iq6NmFwY3m43H34kgVIG0E8dzqGHkAdrVOiMnkYde7Q+gZMdafvsze7CF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/22 1:38 PM, Andy Shevchenko wrote:
> On Fri, Feb 4, 2022 at 6:00 PM Sean Anderson <sean.anderson@seco.com> wrote:
>> On 2/4/22 7:54 AM, Andy Shevchenko wrote:
> 
> ...
> 
>> > On Thursday, January 27, 2022, Sean Anderson <sean.anderson@seco.com <mailto:sean.anderson@seco.com>> wrote:
> 
>> > Is it function or interface clock?
>> >
>> > We have standard property for the functional clock rate, I.e. “clock-frequency” (in Hz), can it be used here?
>>
>> I believe this is a "functional" clock. It it is a reference for the USB
>> signals. I'm not sure exactly what the purpose of this clock is, since I
>> do not have access to the databook for this IP. I considered using
>> "clock-frequency", but I am concerned about ambiguity because there is a
>> second "suspend" clock which is also a "functional" clock. The latter
>> clock appears to be used when the PHY is shut down (and not necessarily
>> corresponding to Linux's notion of a suspended device). If it is
>> necessary in the future to configure that clock on ACPI platforms (e.g.
>> to set GCTL.PWRDNSCALE) I think it is clear what the property name would
>> be (snps,susp-clock-frequency-hz).
> 
> In order to have more or less unified APIs in the future I would
> suggest using 'clock-frequency' for the "main" functional clock. For
> example, 8250_dw uses it for the baud rate generator, while it also
> utilizes auxiliary clock(s) on some platforms.
> 

OK, I had a look though that driver, and it seems like it uses
clock-frequency only for the baudclk, and e.g. apb_pclk has no
corresponding frequency property. For this driver, it would mean that
the suspend clock would only be configurable through device tree. Is
that the approach you recommend?

--Sean
