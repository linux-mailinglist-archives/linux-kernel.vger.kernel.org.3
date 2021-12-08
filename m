Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA846D7BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhLHQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:12:39 -0500
Received: from mail-eopbgr00132.outbound.protection.outlook.com ([40.107.0.132]:11332
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229743AbhLHQMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:12:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCiubGO4Le6F9ScWaLSRZBG45sDncVFi8ey5OVYD9uDW0MF4l835rQxAd6DrK6y5eVR+SKFz2iv6DseAYD8wCQv7awMIniSsexbPAubCS5rlPx9LQ65mxJCqjARz5ixkEG+7U4NcSvQRm/AqO63Pb+xtOlGJiYd4b8gZMS4PCxW5jiYpywlwT8hTWm48zsVgW+JfPs0OwzvbBKS+wtDFd9Ur44FBJAAzDLKX60O4rhr3KhEkb0gQRpbCbTF5Uh2QMVKP0Xr6Y2EfZF3XaIW43CjR5pU1g0GmjKLFEyQ5TUT5sFPRv5TDKCcaC2FAq9n+y6PjdeC2rPUBdcDJ6AwMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zfUpJ48AE/l9ZKzptCsv1FbyxRUr+zeRA9GrwMigmo=;
 b=RhKolK82nPJ+Yp1fknbsEevlOfHGQSRm5WwFGlV+4iMh4f0mfEEFXXwnPGUyQ0TQ7p2PXZgOwoQi0jPpqG2ScOUk34nUgT5+Roiv7R/U61efVsmyuwmLPxJ9CxhtuFzeXg1mLrOxSyuiFa/amfhar3QCPI1NkBLZxXlbt9twf9c1TYPPk65E60W8G4lBeoD6+8DAidR3efffAWgCJRj4Spa+CivdP7a1+QXBbhufDHd5bPy0K370bOFlR9xtnoIbAVJksqhQdNM9zuD66GE7a7Zva70l8iQzrIbzJpthh1nDo961LZDAUpynJAfi9Rj8y8DDSwBxtETpQIrlqrxVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zfUpJ48AE/l9ZKzptCsv1FbyxRUr+zeRA9GrwMigmo=;
 b=LzvEkir1blKE7OoADw4N3V9ZrmkndVxnz03cGIjJ86qvEF6T6q5PevcuhRBU7+36AYnAnsTfsfEcKO5FKM2gMnQSS4QLak+E2DZMI/xP7p27YGQcpTRofJAQLkrNTRBcyoHgk1+z0vKvTNFEWQCGtUhIh+1oftTH31rqFCU/lxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5388.eurprd02.prod.outlook.com (2603:10a6:10:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:09:04 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 16:09:03 +0000
Message-ID: <a98ea2bd-cf6c-1ff6-8333-9056931924f2@axentia.se>
Date:   Wed, 8 Dec 2021 17:09:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] pinctrl: at91: allow use of of gpio-line-names property
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se>
 <YbCmFac6/nU949/Z@ada-deb-carambola.ifak-system.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YbCmFac6/nU949/Z@ada-deb-carambola.ifak-system.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 16:09:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdf7956-d518-497d-8ba3-08d9ba650dca
X-MS-TrafficTypeDiagnostic: DB8PR02MB5388:EE_
X-Microsoft-Antispam-PRVS: <DB8PR02MB53882956D830488C4745DEC3BC6F9@DB8PR02MB5388.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLJw/MvWMsOGP2adncNQiJNqL0OlOiDhfkH9Lxq5UvZuo1JL+ZQDiz8U4JlqtN3kd1IIIRDNha7YPpFaYjV16xCZV2IZ/5tP0Fr9tzEnTqyAep/vNQwzguiIa5z6aHdAVH3T9KNA4BxB5vdLpLDuIGjwn9bUg6cckGB0zIKaR+US/V+0xl2yO2ANJG1mBmSHwkekh1pj+J3RwwmCF7C9q1o8t5gvhLBMxWvBxO96cns55JyRy1MLaEl337BM+WLyaxfmvat6cx6fwqUFjOABHPLnW8ThWkjPpnWWEHv5yVCboG9oh7ZJTZnHVNJFZq0iqY2lkYgJn9UOUNHXjjGlxvCTqVtScDwBGvfISrIKKalPjdZHrquUDuepQKVRuYUPpYnJZjhJSaoVNgbtys2kGrJE8fBwri1LKNELHVI7VMosDAb4T6/oxx1ghl9Fc5204VVmgHvM8e0j5hZh7FajVCwemrTZa6pEPhO8OGAt21wBrAQjHmbjw7Bp51c4O3nWkHIX14jHPyVgQqkzwNIar74PicYXp1RBdyeIhDwk9UsIm2+FFaNYo2PG3ey0zEKPcDARmztWio5oNSIdByp2bZtD2OJdWuuP/fuEFkcEzzNREGQiLnFTxJvabIe7fsM8mJk4G2QIBmsLmgwqnC4A2YkqXvA0FZ32H70s/xP2RCVugfaKgp2EJYigVoBxw27roBuYzwLaYN0xhk7Hipy5bnAKKPWe2waMyIlJZWbD5liyJL9MLfVaw4NHIiLLRAcpew34DmL2EgBUQ6almV0Qa4EPbmIypqFpDHJZu+CPwpZ2Eae12wEPcEpOCdAlK9b9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(376002)(396003)(346002)(186003)(508600001)(5660300002)(53546011)(36916002)(66476007)(36756003)(31686004)(966005)(26005)(8936002)(2906002)(66946007)(31696002)(86362001)(6486002)(16576012)(956004)(83380400001)(2616005)(8676002)(66556008)(66574015)(38100700002)(316002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBmVHNEMkhCNmxIMTFsYWx6Qmw1RE9kWUhJUVo2SGc4SXJ2SHBkZm95ZHow?=
 =?utf-8?B?YTB2K1U4OVYyRU9NS1dFNDYzQm9LTEN5UXY1MW5MVHpkdlk3VGcwV2FydzFZ?=
 =?utf-8?B?bERwUytpSWlGOTBOYmd5VDFLai9xQUlXa0g0d2d1UkRIVDY3YWZDbmhxUHE5?=
 =?utf-8?B?cDZNeVFaeGdYMmdWd3BvTWYwM2FJaWRubHdic3JDMnVnV2JHZU9Pb1NsMUZh?=
 =?utf-8?B?MDkxNGVzdTBnYis2ZVo1NTNPcHcySGNaMC92YVkzS01jV2NxRXRQVzBKVVdU?=
 =?utf-8?B?YXBLalg3bGsvVVlXS205cUp4cm9scE1ja2tmSWlyazBmMytTZlRFNG8wQi9j?=
 =?utf-8?B?UVdVR2NqZkVhUFZEZE9UUnNMUUFYV3NzbzZJWjRtMFJxK2U0aUh3eGFKUUFx?=
 =?utf-8?B?M1dweHRLemJkWjdaL2p1ZmtueEpyWUx3S2s4eERQMGhlSkVmSHJCMTZsUmZz?=
 =?utf-8?B?RSt5Q0hHb3ZaNXEyMlZWUlBFblVkWU9mU01DS0gwMFpEQ1BVTlBUc29YVExY?=
 =?utf-8?B?ald3akx3SzUyMER1K3lTUnZldkpKWTA0bmh6Rm1yZTcrZ0Vqamw1bHc4c0ZS?=
 =?utf-8?B?WmszZlFTWFAreXNteUxCVDZwaElDZys5TzVOZER6UnV4VkZzTjdZdjY0MXVJ?=
 =?utf-8?B?MVk2UXU3RmltZyt4OGZOT2ozWCtWZ3I2dzVCS2c4di9UM2xVY0ZqcEl6NHE3?=
 =?utf-8?B?TncwTXk4THVxakxxZEc3TFBwVkxMMTczaGhVTkxsVXdSdVplSzdRZzMzYXky?=
 =?utf-8?B?QmxXZzc0L1ZJeW5melcreDdpU0NFY24yTmdsOWFsUGd1NlJ2L05GWUduUTZ5?=
 =?utf-8?B?bkNvQ0RPS1NqTHVYMWJ2RFV5SjhndTZYM2x4eHJ4YktnbWd6TlZad2ptaXlG?=
 =?utf-8?B?T1R2L0E1WjUxalNtcEJuRElWNUt6OVRWUlhWcnhuVHFSSUJ3a3l2SnZDOU83?=
 =?utf-8?B?V0IvZFJVWVV2TmFKSW9oUlBYVTNsOVpna0FZT3BHZEdydWwwNDZESlpNWFEy?=
 =?utf-8?B?ZTM5VjZuUGkyWGtkTnBhVUJNcnY5SzczMEJEUmNDSUlnbVZSRXJHUmFmVnBS?=
 =?utf-8?B?SkVrUTNVV3RKL3o1WUhZQlhWWlpCT0REZm44d2hHRDUwdExnWGpveUJiTDdm?=
 =?utf-8?B?RXZJZFhmalZ2TFU0K0hJZjk2SitGRFRsZk1hei9nOWN3dERJY2sxY3V6dy91?=
 =?utf-8?B?TzVCT2t6L1Nra3NuRFNHZXVaKzN2ZGRvU2ZTN3J2ejJLTVJVRGF5NGQ3WHJH?=
 =?utf-8?B?NnlXKzRYQ2NvMHZZZS93NG9DdEhOTnAxNmt6ZnBxUE9TTzlBVkE5VUg4a2Zj?=
 =?utf-8?B?UE1DdGw3SDRSY0R5T1VDVTNpUkFZa0dsdDZOVTFJY2FOeFQ2ejNNK2xLUU13?=
 =?utf-8?B?Q2oxV296R2hHUnpvQ0lhSDBqVFM0RGR4MDI4SjloUVFoRUZxL3hISis2T0Ju?=
 =?utf-8?B?bEw1aURRbzk1TEZ2TmFmZllwUFBLOGh5dzdJZWtxTENIcTNCS08xRk8ycDdx?=
 =?utf-8?B?d1BQd1N4dlBiMXpJbXJLb3MyRG9OOHU3SkxFQ011Mm5XQ0NUTWpvTFZCNjhj?=
 =?utf-8?B?RmtTTjdZK0hBam9FRlNXTUl6aGRHYkprclpadEh0SUNndTVLL3BlWFZZWCtG?=
 =?utf-8?B?RVprQkZEaEhzR0Q2b0t3YWxvWStXN0hwaXd2VUNBWkFBM2ZMVXhtV21FbDhL?=
 =?utf-8?B?czFIS3JORUxDY3RaRGNJWWJLNXh0cE1Gb3JPWXBwRVhaWE1td2FrZWFTaGhj?=
 =?utf-8?B?M1BkYWlXQ25uNkMxKytsZHJqeTlZNndkT3M3Q0dGTkRsWHpUZEVHakk5UUNw?=
 =?utf-8?B?bEE5cGtqSFo1ZTExam5ic0g1b2ZVZy83YTZHbUJ3VjI4L2pjRTZUV2EvQ1A2?=
 =?utf-8?B?QUduZWtIOG5oMTJyVjg5WVBORm9FY2tGaUphcHlwTHM4Znl6ZXhpLy94dHlP?=
 =?utf-8?B?eVhGdHpaV0JpZ2JJMDk2THorTkNKV3BsbThucWs0eGpwRklIaHRadlhrK1Yx?=
 =?utf-8?B?WEFDdVE0SDRHa2xmMVNKWGtPRHV1V1VxejhIanE2cm9Fb3ExcnF4VHl6Qm1x?=
 =?utf-8?B?RDRLZnJRbmNYY1J0VnlGQVJWVSsxSmN4SllPWlJkTlVCTVFPaTlFejJ4ZlZl?=
 =?utf-8?Q?TfKE=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf7956-d518-497d-8ba3-08d9ba650dca
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:09:03.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PLl831nlDZT3tniLg813SZvfX1IEGvggfNDB85oOwjtxHD06+4tiBIHXJZfHR4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 13:33, Alexander Dahl wrote:
> Hello Peter,
> 
> Am Tue, Dec 07, 2021 at 12:32:03AM +0100 schrieb Peter Rosin:
>> If no line name is given (by not having a gpio-line-names property,
>> or by having empty "" strings for some lines), fall back to the
>> existing pioC12-style line name scheme.
>>
>> It is useful to be able to explicitly name lines from the schematics
>> or its function, rather than having the MCU names forced upon every
>> user.
> 
> +1 from me. 
> 
> I asked about this some months ago, but I saw no clear
> direction in the discussion. So for reference:
> 
> https://lore.kernel.org/linux-gpio/946021874.11132.1615900079722@seven.thorsis.com/
> 
> HTH & Greets
> Alex

Hi!

The last thing that was said was this, and it was left uncontended.

On 2021-03-20 12:20, Linus Walleij wrote:
> I don't think it's a big deal to change these names.

So, let's focus on that! :-)

It does indeed simplify and clarify userspace to request gpio lines
through some kind of abstraction. It makes it so much easier to
manage userspace across different generations of hardware, where
the HW designers for various reasons move things around. I guess
that makes me guilty of treating the dtb names as ABI (on other
boards), but the take-away is that it is so useful that I even
bothered to write a patch for the boards we are using but where
that scheme did not work.

Sure, I could NIH this abstraction and implement something on my
own, but it does seems like a waste to not make good use of the
gpio-lines-names information.

To me, it seems the risk is low that someone has both added
non-working gpio-line-names properties to gpio controller nodes, and
are then depending on the pioC12 style names. But then again, maybe
I'm just naïve.

Cheers,
Peter

>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/pinctrl/pinctrl-at91.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> I don't know if it's sane to fall back to the pioC12-style on empty
>> strings, or if someone adding a gpio-line-names property should be
>> responsible for filling in those names "by hand". I generally don't
>> care what "unused" pins are named, so either is fine by me...
>>
>> Cheers,
>> Peter
