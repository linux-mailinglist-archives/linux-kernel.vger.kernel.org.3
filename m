Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4446E78A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhLIL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:27:23 -0500
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:16439
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235554AbhLIL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:27:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyHWSNGJzerlu+tBJCOdw053Co3tCh5PKQZdEwUjsJ+ZxRgAxFH+dJr8T5tV3pDntFWjnL2WU9LlzZToeFXk1BMFIFFVZTH9XT2Z0/BCsfhvXrkoizCsk7lZX0fhRDGpNoMwTng3LfvmSDvGZTpqrNvp/tvhierI1z1HrSxDns7rm1Xliwpesk2U9oi1cfeJfoMxwNrPvNhXtsPUaihTixDBWeFJJ7ogFbRamAMUMFDyQie57RceeKqraFVl1wAif+9yZpImVcjgUdu7OlyUZ8wMtnNRXhtE//OUCf0VDcqpckeesM+HWwR6ka5QgoUQBlMK0wIlGdMu6Tt0XK5b6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5AOJCSK/qoyi3um+jneOU1eQVgMCggKlTs7201DuYA=;
 b=fu/IN52GBs9kkMOtUqOSKDt5kmiXJGlrDOr+7GnYm6D0JIGPDD69Lx8zzfz3vJT6eL1Y69ux/XQXZoG2vemePtpZyzIZGowe5gY0dnyfY9zSSD4Bhxw1+s1kxEHhxSL0BAHcUbeeOAZeCVhzQSlKup0GiKZw8/u7i20XktAfprE4uBWIMvgvYlKhHqb53Vwvxw5bb8SflL/Hw0sjH8XmQLkfaQnIYm0DlLIVK708gpd/JKjcjk+9DTmhX/baosdvyIy0UvocKMq0Qx6z1wdVXAlipIUqzmdeWns59qTTNao6OyXJn9ACIIWTvd6Idv3xw1YhGwXQ2XDhVK7IhHdhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5AOJCSK/qoyi3um+jneOU1eQVgMCggKlTs7201DuYA=;
 b=AzEPyGVRneG9oPqbJYgWROeX4g9BR3ynpBhIx9PzQemCwLvQVTcn5snq5xhdUd5yoU6p3Kf+qDEyMybjKfLo3tsFH1C90eaCl7AXxhMHLN4TyQben/njoiPwQ2yeKVA/Tr+ZCkZUsVQhCFFdVZsWR6IL7hc9aNdlg513IAlu4MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3324.eurprd02.prod.outlook.com (2603:10a6:8:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Thu, 9 Dec
 2021 11:23:46 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 11:23:46 +0000
Message-ID: <9bf029b2-f112-b0db-a314-51204244fc70@axentia.se>
Date:   Thu, 9 Dec 2021 12:23:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] pinctrl: at91: allow use of of gpio-line-names property
Content-Language: sv-SE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se>
 <YbCmFac6/nU949/Z@ada-deb-carambola.ifak-system.com>
 <CAHp75Vfop8MpzkFRzQKt78UZc6DiEZTm2SYqJDtwm1KcsjC=+w@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAHp75Vfop8MpzkFRzQKt78UZc6DiEZTm2SYqJDtwm1KcsjC=+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 11:23:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9b2863d-bc29-4e29-6bae-08d9bb065d5c
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3324:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0202MB33247CE0F91329FF9AE37C64BC709@DB3PR0202MB3324.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pwd2dy36NNZwqrQdn07ytvj47Hg0N02/3KRqS4MswuidCywRAhfXyW2lt60vmCTCo4AsooQyA0g988pENHlK89nEZAw+YnFAo0RpW7EUeHNtt4lbTmsbbH+vuwyd45kSfZsPiAxR2NMK8z+7wV3KwjXz02rtelItO9WgYVl2BF1MPxh0l7dWNBwAsE0aTXvpH5n68znQbiChMWMPE/+YFvq1sj5LNEiSO3MdX2XUp6rnzfArAXm4pEf4Pl9s9nm9fucLvX2pumprUqdvbBT9Fb2IyNWOvaxb5a9Jy/vJTa9ycapjcD4Aeb19oozoozyZHfjXXs1uSvO4QKotDZSxP0Nxld0zhw/EPFjgo2qzmv9Gu/EfPueoj4oP+uL7CIwhB7ZBjiLZLiZak3ekYf1kVINebtP0MSILlqCg3w3B2gkWsoRiBIuwneH4O/KMigRVfJBgSXKDptJ/wby1Sr5rr4gRn/IAc2S8OAgTcy1EwOPKJvavXWQLfXscs8J+msOSLLdTxceftMwUAWQnjhS192AB98o2Wb9uHxgO1SgQNlRpenXatd1lkEe/Qy/5VhBuSpRIeuM99BijZ7ql/AxNRXEj6CCKo5nPD+kC3FbqsHi4yKjHvOalXF8XfvL2BtTvm+vW/WcrKXHpQ9e/aOt0/ngUKLl8A2VEFs/6e9xGlfUX+X2Ah9Mpe7bQMOJRhOEjLky0nE1Gm31qGzH722Io59iNF1qFbYQqxSikIYAfrfj6Dq/cS4g2AiP+P30BRQs5b9HFClpphvB0VMewfu7BjmHGRZyNll47p5TMhaLGGAt68CVIqkoTJF8N/6LChTga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39830400003)(66476007)(66946007)(66556008)(31696002)(36756003)(36916002)(53546011)(508600001)(966005)(2616005)(956004)(110136005)(26005)(8936002)(38100700002)(8676002)(2906002)(316002)(5660300002)(6486002)(186003)(16576012)(83380400001)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1YrNjVmazg1WUp6eEY0dVpHOUhxZ1ZnMnpXdFRuMU9lOXJ2RjEyeVNHekxB?=
 =?utf-8?B?V1BDbWF1TEFodlRqUXcxeVNDb1FhWUR5OWo1SEg4M3BFWnl2TG5DQnFWVEU4?=
 =?utf-8?B?aExPUUxzS1V3Vmk0Ui9aaDUzYTBuckIyOHhrR2hZc0R4RUFzdnFMeFd6cTgv?=
 =?utf-8?B?RUN0K3pVMFd1Zzk0dmt0UDY4b0RsMStZdlRFV3FJWkpabnRWSGpzY2VsSW5w?=
 =?utf-8?B?Ty9FK3FxWUtkeDcvM0FibVkrblFZdW1mT1JtTEM1ajhCUXQ4Qml5MG9VWWhy?=
 =?utf-8?B?STY5S1hzSmE3VWRaRjN1MkI1NzVHN0l1cG5jcy95U3FpSTFxM0tFMlM4TzRj?=
 =?utf-8?B?UmU1ZXh5aTlVWGYxcXJZR3pHU0VHdlJpNjlKbnRpd1FrN1VRcHlaZFhoUXU2?=
 =?utf-8?B?elNEZlJyMm5QWkNscUpobUZ2V2VrYjBUNTBtbUp3d2hxMURZNjlUSk5qSyt6?=
 =?utf-8?B?OGV5Mkd1NEN0ZVk4VkM1NENYbkpnR0Q3SEVjcjl2K1ZjRmxxMnBZUGtKejVL?=
 =?utf-8?B?bm5wVVo3TXYraU82SDBody9ZMCtwb1RyWjBpVDhZNzR3c3hqbHN5Rko2cGJQ?=
 =?utf-8?B?UGRCNHhRWTZIRngzMk5YSmZVS3NmWkh4dlVpR0h4ejR4WW03RngvU2pKeFdi?=
 =?utf-8?B?bndMUXJld2dsUGZkU2xDR251L2tuL1A3VDFkb1ovUmsyM2xmR0RiSnVpSHhN?=
 =?utf-8?B?ZUppTTdRVHNISXJUb1E0dDhrYVFkUE1KdW5mZ3ZUamM2cGJRMWFaNFYvM1RM?=
 =?utf-8?B?SFRFd200UkdCL3RSbFJDczRYTDJ3VlZwdW5HWlRETURGUzNPdnFDcEVtUXBS?=
 =?utf-8?B?TUxhby8yWjAzWDlaZXBodlJQdytDbzRyQkRWSkU5UnVnQ1d2cnZnWWhiREFv?=
 =?utf-8?B?UWh5eTUxK0N1cURtUlhIMTkvRUJsNWZibU5wL292Uk9VemQzcDBINWs0OTl1?=
 =?utf-8?B?R3p2Qll1akI3OXdtS3RuemVIMjVidjF5L1lnMGZVd1dFS1ZTeXhjeVpoNXBm?=
 =?utf-8?B?dnhTMXRYTHFFQTBPZGVoeFNpQWxtWlpYdm1iRTcvRS9HK2Iyc0JvdWtSbFJJ?=
 =?utf-8?B?aWxySmxHNEU2Rm9UVi9CbkxVMnJBOXRSRCtCTlpyZTZLTVRkL3IyTDVUUVIr?=
 =?utf-8?B?N0JnM2R2ZWJ4SDIzMW9JNjRjcUkzWVZoT2N1bm9wMVE3d3pzM05TRm9UV01S?=
 =?utf-8?B?aWY3bUxxc1ZxdnJuazV5d0RNWGR1ZXlITE15MW5RYUo4dFkyd0lQOCt0WStC?=
 =?utf-8?B?SVVFMVA0SGg0RnJTdDlaenM2dlhYTjZXV3EyRlhzbk5hR0gwRGt1YUdSN21W?=
 =?utf-8?B?Rm1PWGJNTy90ZzVwT2pabXZNbUdLd1MzL1JHaWlNWSt0QU1Da3UwV2VLbDRS?=
 =?utf-8?B?bm5WdDU3OUw0U2VTcUZVUWh4MS9HRFdsVTRyUUZRMGp6TjVDOFhodVVjME9s?=
 =?utf-8?B?bG9FU01WNXpza2grZk9QdGN3TXNWZ2dPMTgxQk9qSUIxQXprYXM1eWFBZjh3?=
 =?utf-8?B?OWY4cjJ2V25hUmE5QVQ1ZXlYQzNyYkxacGRyQUQ0S1ZzRGRNSU10RVkveFhG?=
 =?utf-8?B?Y0g2NWxWRGg0dEhMbkxZbEJlV1R6TjdTdzUzb1ZaRXo0SlgvbXdoTURYRjkv?=
 =?utf-8?B?Z092aHYrT1hYZHIyOFZKb3lNUHRXeFJneGMvQ1VxSm1mN21sd2M2TUJCYjZD?=
 =?utf-8?B?UU9jZVRjZUIzV1paaFk2WDhtblpXYlhNbHNXVEo2REthSGdRK0V4ampWR2FZ?=
 =?utf-8?B?SHZkRkNBeWhJSS9sSERQSXlHWVFxWWN6aCt0cDBZdTFlVy92UVRQZWdXOHds?=
 =?utf-8?B?a2lKZ2g3S1M0TkNMWmlHS3VNMjFKanAwT1BXTEFsZ3hkc3V6c1RZM2RFYkgr?=
 =?utf-8?B?WUNPems5Yms1Vm1kUzBROWxqbS91T1lJOSszVVhiTzJtak9zU1ZQcDcvL2Jr?=
 =?utf-8?B?dVNmTDEzekN1M20zT2o0WThML0RONy9ob1JDaTBPSnZTUWV5TXJOUXFhb2pG?=
 =?utf-8?B?bmFWeEErVnBLTGZEV3pjTDl1ZjloTitXMGVRZ2E3UWc3cXRWMTRFejFaZURM?=
 =?utf-8?B?OXVwU2hSSW9NY2ZPOHI0WEo3dHZRRm4yUUN1NDZCWWFLN3ZGalBpSVFlVlFu?=
 =?utf-8?Q?Et4k=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b2863d-bc29-4e29-6bae-08d9bb065d5c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:23:46.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxTi8ockoaexUsPqbL9mThBSL+ecO0lydgVI6HoI0nGSa7RTIsF3OuC2GQ+1R0et
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-12-08 17:28, Andy Shevchenko wrote:
> On Wed, Dec 8, 2021 at 4:51 PM Alexander Dahl <ada@thorsis.com> wrote:
>> Am Tue, Dec 07, 2021 at 12:32:03AM +0100 schrieb Peter Rosin:
>>> If no line name is given (by not having a gpio-line-names property,
>>> or by having empty "" strings for some lines), fall back to the
>>> existing pioC12-style line name scheme.
>>>
>>> It is useful to be able to explicitly name lines from the schematics
>>> or its function, rather than having the MCU names forced upon every
>>> user.
>>
>> +1 from me.
>>
>> I asked about this some months ago, but I saw no clear
>> direction in the discussion. So for reference:
>>
>> https://lore.kernel.org/linux-gpio/946021874.11132.1615900079722@seven.thorsis.com/
> 
> Thanks for the reminder. AFAICS from that discussion we kinda agreed
> on the names being excluded from the ABI path. Hence there is good and
> bad news.
> 
> Bad one: NAK to this patch.
> Good one: Please, fix this in the gpiolib respective functions to make
> it once for all.
> 
> Disclaimer, I'm not a maintainer of this subsystem, I might be
> perfectly wrong in my understanding of the state of affairs, let's
> hear what Linus and Bart can tell us about the subject. Above are just
> my wishes as a contributor to and consumer of this subsystem on how
> things should be done.

Understood, I'll send a new patch for gpiolib.c instead.

Cheers,
Peter
