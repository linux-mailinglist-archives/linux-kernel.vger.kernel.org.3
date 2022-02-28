Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE694C6E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiB1Nih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiB1Nif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:38:35 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2780FDEA4;
        Mon, 28 Feb 2022 05:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va+SAv4l6XohtuHXJ9Bp8yClcLRoKQz/SsNgcTe2m8X7iGCDjtpNiRsBeLi39mvplZeyALixlAe+B2iKJrTjJi8GMpLdYPMM1wKBmXynfFEI2Jz+N0BtCUCQ5noyRJVhItxc2ysiiuUzaFp2DZvQmSMYifRjEX+DWhyDi11suAZYqhzyl/EpQ77+zw7kmFF+hrE5iiyrOiaYxcpn1DCz3ixyWNVjRj07mfc0p+cnmaEq3HXkAMr9fsfaK4a+uI0owOseeclLzsNJEr9RKFBzCl7cGaH49BW+joCF5FSe/iRGRn0/iIwBLnHKxsid7CzTnO4WdnywwaNefNVYrD1TOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUgkZug00jCigowMOB3S/cszBQcBLjo90ugo5XYeL5A=;
 b=Y/WaWobIEfINWZ8QnGNVZEeB87CfZT8KyWHVZ1q+frY0O2GFGh7i/unqE3psrDqVs2I0JISfSe7YuCfXnItgmxoxEpNfBEpMXvZOHW1uaqFjym7VB450SXwbZJpFPQFsoSKfRiAT3dZoXkaESA/PWD92oKY3NaS/sfO/h1sqJlnMGPOT9Nu1l4RJO2yPAQqPful3RYXIohADhTyNcYPSJVADpSk1CKgkPzVUk0Cai5uOy8+iqVYSjrws8Z48x2Ov4shUnw4m3OPTHwcKmUJlFBKHs21z8SX4TLJrnsKYfAud2Q9im4+h5c5bHvnX9/YMjytzBNHpFxWVAEC75hEupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUgkZug00jCigowMOB3S/cszBQcBLjo90ugo5XYeL5A=;
 b=wE00xdlFpftesi/QT4DfZxXg9rP0Ys9BLJjKHNwQYTbpOuQsgWAaxt0zR7t5JZ17Ca/1ZA9vut7B7u45dnvdxtuCUJSVSyIwOjusZI1xL3ApLBvj2bil0wjDQvN6m7h4o1AX/HsG3NcQyV3EXdhKdXMWKvMyqc47ppLxYGoigH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR0802MB2348.eurprd08.prod.outlook.com (2603:10a6:3:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 13:37:53 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 13:37:53 +0000
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
 <20220227153016.950473-6-pgwipeout@gmail.com>
 <fdacf3eb-7892-c767-ae85-1672f85684dc@wolfvision.net>
 <CAMdYzYoEEY6-kGVDeWj9AoA98BL5hxnc_4CnUPiuStUnSrFXLA@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <56f8b74d-d9a1-7c6b-67f2-29586956670d@wolfvision.net>
Date:   Mon, 28 Feb 2022 14:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAMdYzYoEEY6-kGVDeWj9AoA98BL5hxnc_4CnUPiuStUnSrFXLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0801CA0083.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::27) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be13627-415d-41ee-4ab7-08d9fabf8535
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2348:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0802MB23489F0598C1D4AA2DD4819EF2019@HE1PR0802MB2348.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsPRpkI3Gp4eBefciRt6xsHRfes6A8rkBntEbvGC3tHF7q54fwFzprS7e4Yy4C1SR87CDZk3m1WSjLdB78WtLC/1YCq5ymvBci4opoUxHca/++mpHCNEv8yvBirFmxpSuZzNY+YV9pDUUcKoEFylqGsBTS9it6fKm3LymRimxbCVJ8kWJnWdtHa7Ag+vDjPWd/C8ijWt4i54Nuk79cX75tmnQPsvOwcHMjPp2wXRYyBAVyup3+d3BMGMtp0VhbBrJgb7zaFATFtaFA9pWCNohW5mXRD6NnssnaefPS2LvG2AUSVBSPpBWiSjMqTgHrs3WHrVA3GGuzoGJxEUTlo5khuqldaEwYRdMvFjzbgDsEF1S2QQRynAYA+H/23LK1L/QQ7n69VpZWddRVdiGq6ZCORMNf0vsAyEXG1xdtqt49L0DNOr8mO8Tf8ME1AZ9YXg+j3lsBsE7NwfoAi60VjaLyV7Y0WcEtjyntZURtRhM6514cjBnFjqKkl5maXEf/b3GA76gpcht4DrkFDI44foVaLb5+eL0xB4WIHvM5KysGFSS1Ey2BEp4a64QnTm/Yeia/TZLOMvV2VMLLRG/BlA8HmRQftVD3JQdG93u4mJEMeII5Zu8FOLFo6pHh5ZXYeHdfdTJEj8nd+lnvvSva5eMPwLj6fsKqft/MZI5nJMYaRyWGnhjOg+tX4jlknaQmH3uMA3CJSAD142yFlIsDuelWe/O+tp0v30F1sNe3yi0V7ognsREZGBnGhhYvRge+E5z4c0afkDckPBNm1+zllraw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(44832011)(4744005)(54906003)(508600001)(6486002)(6916009)(26005)(186003)(2616005)(31696002)(6506007)(36916002)(2906002)(52116002)(6512007)(86362001)(53546011)(66946007)(66476007)(66556008)(4326008)(38350700002)(38100700002)(31686004)(8676002)(8936002)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZoVEFTRnd6TVY2WWd4aGR2QWtXS2dZMXNYdzBGUHREbFI5MFRJTU15SmFC?=
 =?utf-8?B?NmNrcWRZTmMwdEI3WUpoZERxaWoreGZtekhkYVhzeUdWVHhkbkJRY0JtUUJX?=
 =?utf-8?B?N3pacUxuTU5pNkRQVXgzd3ZJL291YTk2M1V3Uk1rK3FxcGxjNU01MVB2RnVL?=
 =?utf-8?B?ZEFTMm5PUmw1TUVRVWc2WVBHdTBOekZSM0c4bVh2WXJsaW9QalpEdHhLMW5s?=
 =?utf-8?B?SWZCVGRBbHdFbTBweERRbUJ3ZGV3azRUL2t4OFBtbFdCbU5LU1NFYzYzeWVR?=
 =?utf-8?B?SmUrakIwaUluU3FBMXVXOVRCY2E5d2JTSEFJdUhQNXliZXJHMnJQalA4MXZz?=
 =?utf-8?B?ZUJ4MjZqVXloanJrRGtXcGhkTU10M3hIckNaVnZjSGs4QTRuMVkxOUFHK29J?=
 =?utf-8?B?bWVkQUZmaGhKajBzdUlGbEowZzg0a21GSzRuZ210ZWZiajkrd1dvaHhUUC9k?=
 =?utf-8?B?RFpweDBySDJWSkZsSVhZcms4cVRrVEtmbkNHS2p0MWloeXFZMDd6Rm1jS2d3?=
 =?utf-8?B?UmJDdzBtKzYxemcxdGZUS3IzYmhsbG1FNnd2dFpFUWdZVWVycEFiV25jR3hx?=
 =?utf-8?B?UFE2YVBsK04vNUlEQllqTzB2b09JZzYxL2NQSi8vQzlabWRReUI4L1plQTdZ?=
 =?utf-8?B?d1dDRW9BblNKT2xRNHlIeHZaaTFjSUtoZXM0WDFoNmpFbnlqbHBZaTZxb0or?=
 =?utf-8?B?bkttMUtWQ2JzK1VXbWl3RmxpUzNRUzBNUENkbVFsMFF1TFVwbm5RN2dxcjFB?=
 =?utf-8?B?TDJubm13K3JJTXh4cm5FZmZ5ZWlpN0tjbUdsOWpjWjh5YWw0dnhORWVCemtl?=
 =?utf-8?B?djBhQnFVZXRCUkk4aFFxckVtSTFHQ29Hamw3N1pjeGZxc1UvSnM3bXE0UWtZ?=
 =?utf-8?B?eXBjL050NUVmN1FFdURGRmZzK3FFV3VLTmZqSmRtcHZQVG93eG5sUTY5bHJR?=
 =?utf-8?B?QmFRbEtEOE5HRUVGR0QrcE8rcm9WeXlVdnFQSE1pbExZZ0pQcDFEQjBqQkpI?=
 =?utf-8?B?T3hxa0xEcGp6blZjcmhkWThWYTl1cHZYNWZxVWVlM2gvdHBTVGhMenZCMUs0?=
 =?utf-8?B?dXBNYVFycG9ieGRnWTFrN3E4c21VYSt4a1hoV2orZld3WlY3R1AwQlYzM1pE?=
 =?utf-8?B?OUlpZHlFRGJiQyt0eEFZNXJzOHZoWU9HMG1hUzdOTkUwSEs1YzQxcUJ2eVlG?=
 =?utf-8?B?QUdZeTVJZXVmWUd3TzdCQmo1UkVxcW9vcmlSYlpDTlZUQ1NtSHgwSTRYSCt6?=
 =?utf-8?B?Vy85Uy9UaHFvRElvZy8rdVJMVXFhRzYyY0lHSzBhNGd5Y01IekRGNnZzSDJs?=
 =?utf-8?B?RFIvQmhLYWtsYWhHUlRwQUpTcEZxSWJVZmx4b09LMVhLMGxaeDNzek9taWpL?=
 =?utf-8?B?WUkvNk5qUGU3cWdSazVLYkdDZFRNeVlrcnBJNDFWcFBZcGwzM3hqUE00ZitB?=
 =?utf-8?B?ZXMwK2JvdDVxRG10b1lrcmlQWEhIYWpMYVNmR2d3cFRVVzVGZFE4YXZpT1Q5?=
 =?utf-8?B?MTMzV05EWUx3c3hiMlpmcDUvL0xiMFBJZllUdTVoSVFRdDNpOEhLWkdzck9p?=
 =?utf-8?B?U252MUluSnNBeW13L2JZOU5oZUN1UFphSk9nNThaWGdrVGJ4dGgzelBkL2Fj?=
 =?utf-8?B?NXlXRW00VS9WakJVY0lpRDJKYzdQUXovOVZmVTlucW1nNFRudDFTNEM0b25V?=
 =?utf-8?B?cysxbGtnMzNsbUpITlQyU2YxazFYajJxekhXckV1T2xMY0l4VjBIQURnV0ZS?=
 =?utf-8?B?aWRYNFJBeWlYdGNBQ25yUkkybUxMeDJ5YklvaFBCNlBXWUY5a1M3UHlNUW5W?=
 =?utf-8?B?TnluQW5Db0RGdHFaU0xDV0lnOUorY21DUHdOSW55WUsram93NGtXQkZJMmhq?=
 =?utf-8?B?Q1JPalJ1V0w1cmhCWVRXelEzd3ZFRjYxTjFjTnArS01qNHd3REowd2t4STZE?=
 =?utf-8?B?aGpKT3ZQUTlXOTNLdkhvVjlhY3B3QzVMZlFvRExxVWNUVnk3NUM2dlJ0aUp3?=
 =?utf-8?B?YVgraXdzNDFOVGpOS1dnUXNHQmxvY3M3SWI5L3YwdFBkNVRLQWw5SGk3U0hZ?=
 =?utf-8?B?V3cvREZNK09BRk45V3dhUnZIYWRHY0hySmZsZTNJMjE3amdSZUkxZTJWa3Nz?=
 =?utf-8?B?NnlrYVJZQ0h5MXlIZ0F4SkVGbnJ6ZmIxN3oweFhQaXdJWjUrbHIrRkxXUkZ3?=
 =?utf-8?B?Uy9mNnVBNmtMVDJKVjRoL1dlNFBTU2xtMHZrVUdQb3NtdnlXSVRiZ3U2blBG?=
 =?utf-8?Q?GPdBd3t/krMfHX+wXmdFrZcplzuwelZIvyFzDtYcyg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be13627-415d-41ee-4ab7-08d9fabf8535
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 13:37:53.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFy9d2mAJwlBJ53j139nao0wGtV3XDr42Vs/XiJpRVY5qmYDdIQWVLg4OaQjos04ZJI3aqqDvzMuMnZx2hJ+nudZB2xUPcHgtadSOMTSKEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/28/22 1:57 PM, Peter Geis wrote:
> [...]
>>> +
>>> +&usb_host0_xhci {
>>> +     phys = <&usb2phy0_otg>;
>>> +     phy-names = "usb2-phy";
>>> +     extcon = <&usb2phy0>;
>>
>> I wonder what the correct place for this extcon property is. You defined
>> it on SoC (RK3566) level, in my patch for the RK3568 EVB1 it is added on
>> board level. Is this common to all RK356x variants?
> 
> Yes, the usb2phy is always available as an extcon unless you make a
> device that doesn't have usb2 capability.
> In that case you'd have to override the device anyways.
> If we want to turn on default role otg here, we'd need this defined
> here as well or things break.

OK, so it seems to me that the extcon could or should enter the
rk356x.dtsi (and can be removed from the rk3566.dtsi and the
rk3568-evb1-v10.dts in this series). Is that correct?

Best regards,
Michael

> [...]
