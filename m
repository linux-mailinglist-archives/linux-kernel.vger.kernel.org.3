Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E824CC154
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiCCPcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:32:30 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0E192CB8;
        Thu,  3 Mar 2022 07:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WccnO/WQo2OBufZ8VhQKOENhRtsJ8tYXoOA5O8w/N0i72AGMaSXWzC8KXpzkyarZWGe8wSb72HeKQp+ioXrF76KsZmCsRpDr2ahnpsFouidTb/i8R/Ywe9gEoxG1KfEg6kbVYco1D2O/viUDOWjjFRsqugfKTlPHU9RCewWGQacDZ78PCyGKuXJESpJJIMHdZHDCNEOI7B5KvIyctvjjk9GLnq0bgoEmhqcTia5pdOgEjLaXpWK2umB8Pfn8uk81AHxXSytQaIy8bitfD474vlaCLJjpylUDvRneH4oB/Nl0udh3kRX+2KjqKPIBbOZbu0aQgA1osIx2BJX1kAB+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o56XKuWgB4Aih4vQQvSPcN4h0dUPaRsbB7/GLmC2gbA=;
 b=eZFN59ZJmBX4QaVEFIhYRxdZf9Pr0lxfQsIHsgyDF6Ki5EwN/ac5Ymc1Rk5KTEEXpTK9nDUcJ9zYk8uriOCEvBgrBjWo+WNKdoAesr/qvTiHkcvgW6vxsNTRAmL/jvkW9qabTGeBBbVCjpfs6kYfrg13EDxDdwTH0S6MY0eRFwhvTVpnbGcMXk1QVofEOFcYPsUOhOJ/TvszEwDZGiKoBo1Rpsnh/Xza3l1RLK4EdCGvNmytttK3gv0J0RBeKocJEEhSf9ak7auonrkctQ3dk+35wn4VDhAOJ3jkCyx5F1gN4tuo7LNOO6rd48shvMkS15VkpV2ydHNFmqbrBh+GDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o56XKuWgB4Aih4vQQvSPcN4h0dUPaRsbB7/GLmC2gbA=;
 b=UAPzdLk2Cnw7cuKzxqkae0AUQ3MJmlPURdiGH2RvJ4xwx0T3UZF8o3SBAD4D47NKyzc3WaJDF5MaVyU79axwe4K6VZ18HfsKt8i/MjKGx/KYblkkZza2Ae4gwN+NE9+dXczDhGGXsiH72scnPmFn11AguqjGIr2vyqsakh83hf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::19)
 by AS4PR07MB8434.eurprd07.prod.outlook.com (2603:10a6:20b:4e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.11; Thu, 3 Mar
 2022 15:31:42 +0000
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::e14c:59c6:7109:de9]) by AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::e14c:59c6:7109:de9%5]) with mapi id 15.20.5061.006; Thu, 3 Mar 2022
 15:31:42 +0000
Message-ID: <c3a9b340-34b1-4bed-4810-4c5f39a8554b@nokia.com>
Date:   Thu, 3 Mar 2022 16:31:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <20220302175941.GA2523098@roeck-us.net>
 <9e868438-c0ad-464f-358c-5ee77bfb7f4f@nokia.com>
 <abde8dce-810b-fd39-b0aa-4f1b2ec8f8d7@roeck-us.net>
From:   Agathe Porte <agathe.porte@nokia.com>
In-Reply-To: <abde8dce-810b-fd39-b0aa-4f1b2ec8f8d7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM7PR07MB6916.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8344dec-6678-45a7-4e5d-08d9fd2aeaf9
X-MS-TrafficTypeDiagnostic: AS4PR07MB8434:EE_
X-Microsoft-Antispam-PRVS: <AS4PR07MB8434B6E682D83161DA7D37309B049@AS4PR07MB8434.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek8+jzN9N9EgktwEFZNXekHwgF5kJWMH9zh52xjJPlxlHRUW0SRzCmCIQrrOfF0tSC60u18n0T2N45BnvMhL8hv62UeTnCnoUDiBRF3zMU78gnNCgDgmyxVe9uFS3VS6QzD2JL2XCbUhC/b/l88UOsMEchYy03Ae+O/ewgewUEyuZ8qm0LvgYxQzoco7T72BDJ80hxVpuce4wyXixN47y2IB1oFhJFRuH+4uus5lopz5FRW5kw/0oSpLKImFvemDKd1COeM1Lib1btWP1EP3b3GM2RJnZJ+9HeRvGx8zdCTOI1kwxUSRrm0jlKVBx49YEd1d7OOVGGYuHlqxEpWn4QKOFMUJDiPLDoqXWG3T4kD32T9Aqtl/vl0triy4zdxRUgKw3UObQnq1ZUVjTvyWR37TTWQ8HCT+HQpqPKAJV1Rtl1RfJRtXu7V+qKnnjCqQ2n+YDXiefHbKbIISiVCLouBpB9E4oc+T61JtwOySnDpyUCB8li8svV6EewgaQ2BPHwKxeMdk6WPsVHdMD4teBS2DCNL2cVrEHByKjobexzzgMBAz03z2yUV2305B8ZSoIuU7w3qqCCQfezPgT5I8MfqjT9fp/YQ0KJ7Afq+WqXPYgwDH2+qkb5nBBJNoemStUwfx0ouiqViZNn3ozx5LYqz562Q1xvN6sa531SYq5K8wl2fsQbQmg9kqcfKMeoIZElluATjUa0/qCFdt5nPynXOYb+FIxQF4N2RYVxATpmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6916.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(5660300002)(82960400001)(26005)(186003)(44832011)(31686004)(36756003)(6486002)(2906002)(83380400001)(107886003)(2616005)(508600001)(54906003)(31696002)(8936002)(53546011)(86362001)(6506007)(6666004)(38100700002)(66574015)(316002)(66556008)(66476007)(4326008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGcvTE51T1k4TzMzTEVYN25KbjFldXB0YXdld2p0WXJBNnBZc1gyTE40YjBQ?=
 =?utf-8?B?SXM1SWtSc3htQ09iQ0Qxck9YRENUUE9kUjZTQVllV0Q2KzdKRVRoNTd3SXNy?=
 =?utf-8?B?T1BxNkFkb0g4ckxDTVAvbWtnazlUREhXSWgrOTZvZERTUjBySkpEaUkvY3Nu?=
 =?utf-8?B?dDYwTHBTMVppWDdDeGVVUzNuZjNDV0lWd0xJNElkMk1vN1RkMUVLL2ZwcGtQ?=
 =?utf-8?B?R2FMeWNmYzlPSm9peXhCVWlkRmt4aFY3RzRHR3A3dW9QSTlzQVNmVFgxK3B0?=
 =?utf-8?B?L2t0UEdMZ2FvcGtCejk4ZnBiZTJGd3o2bGNVNEI3bDZvWEQ2RnkwN2tTbE5V?=
 =?utf-8?B?Y2hicGlaaElPMlZlNzVtazh6YjNWOUFhY1p0N0FrVTBHbGpGNDJibkpWMlZV?=
 =?utf-8?B?WWd4YjZ5OEVrUEdRNmkyRXdFTDM4SE1IRHpERFQrYXMxOGdYbFBndGxjY1Iz?=
 =?utf-8?B?bk1GN2p3VkpmTTFyWjB6WlY5d3VTRW05QlZYNFBreXY3RU5xTFIzaFZlNWNK?=
 =?utf-8?B?TDVvSHVpMW5wRVdHdWhWSzljdHdTUFArS2U4aE5Lc21FMDc3aVB6czdLWHQv?=
 =?utf-8?B?eHQ3aXBTelhvYVJMVWxWeVdwZXlBSEZuc0xmV0toYkMrMzZoMXNwMzg1TFh1?=
 =?utf-8?B?QlhNVk5ld01YWi9QcnhFTWdxVnJiSHhTVzVzaFpIYktJWVFsOWkycEl2amhQ?=
 =?utf-8?B?MkJjRlRBRUFyaFlqd2p4cGd3Rm9icUxFRDNiam1Kcm9LK01QUS9SSm5Wakgy?=
 =?utf-8?B?cWhGdlo2cDkveXd4NisycUV4Q0pSTEhqM1JOZkhJU0xJNDdMbTA1RTVvdUxx?=
 =?utf-8?B?NDZYZ0RyOWpxWXBkLytQbW8yTFN1YnFDa2FtYUthaHBzb1JPNWJmRW55WHVq?=
 =?utf-8?B?WjN0bWtQL00vVVFCblFLWTkrbWI5dGRJSDZpL0s1U2VZQWY3bTkreVBOZkhB?=
 =?utf-8?B?UkNPOEhQU0R6cjlkbXh4d0gwVzBuZjdCU0tWcmN4dU1aUG5IaGVLMEZrTEpR?=
 =?utf-8?B?S3Q0YS9iMlA4S0RKOVg2UmVYTTlBK1hXZmZWTGdJaDFlY2FheXNMT0Q1RVZz?=
 =?utf-8?B?c0NVK094Q3Jjc1dBNGlKTzk3WWNHdmhRSWsvZUFCSnNna0JuZGwrWFUyVlp2?=
 =?utf-8?B?NmlKSnBmT1dpN0pSTW5aWkxtOE5ZSzBSYy9LV1ZzNzhLaXUxeGJGa2pyL1R0?=
 =?utf-8?B?Q3k5eXpNZEsxVk5NeVJ4UWhVOWFydXVKbjlVSU9GOTNKR1AycW8xUFYwWFJI?=
 =?utf-8?B?TW1IeU9sMW1obHN5ZUl2L1R2UFV6RTFSai8rby9aa0NaVDNGUEtxM0FLZVF2?=
 =?utf-8?B?d0lnRWdqOFFOcmlKemZrWmg5TjZSSDhqQ21WV3M0aFllT1RnVkFZeW90SUp6?=
 =?utf-8?B?dVJ5V3VBeTkvWmF5ZCtkckJNNzJ2NUtDVTc2N0VKTEFuL09pQTJ0YXg5RjQ0?=
 =?utf-8?B?QzBDSG42Z0pXaFZNY0hQMWRMbkFrcm5MV1djM0RFRndaUjhqME1BVTU4TGJG?=
 =?utf-8?B?T05nRThkSktFNGs1Szd4Ulkxbit4THJsTGR2c0wvMmVZZkhVZFRHTml1NzB4?=
 =?utf-8?B?SU5iMFU3MmhpVFM1ZENqdXRld0I1WlFTL0VKZ0I1MU1xbWpzaWc0RW90aGZT?=
 =?utf-8?B?ZEs2bWlob3FmRHlWemFja2tNMjZ2QzlnUGt2SVlDSTh6a3NXVkFYQk9jK0pS?=
 =?utf-8?B?SUNYSjFiYlBwTWw2eThwNG9uR0tUL0laQzFYRk1FQW5kd3BDZ1pKVmhGb3Rw?=
 =?utf-8?B?NWMrWUFUMENncGt3U29lRmh3aEMvRDdaelRDamRLdjE1ZmFFZnhlYjdtb1hR?=
 =?utf-8?B?WkZXa3UwZkszUkt3c2cwWHpQNWgrZjBlc3ZHVXZXd2UzVHNSUWtTb29mbG5m?=
 =?utf-8?B?YnJ0aStxTUNVT2xmWWRDRU9rMkllb1U1bDJYa3lCV1ZEWXl1M01yN3ovOEFY?=
 =?utf-8?B?SDhNbE1nOTIxZytKMzV1TktkcUhBVFB2UW9nRHlGSWJKeDc4N1NqUWd3MC9u?=
 =?utf-8?B?OWlPWmxxMDRUaWQxYUw1RlFMVWhvUW9FNUxybUxvbnpSVWlMRE1kSU0vdUow?=
 =?utf-8?B?S3VJRThzT2lSNGt1SkU3bXhOQ3AyT3NlVDFwcE9CMjJtN1VkMjMzTFlRRVZG?=
 =?utf-8?B?K1FnY3BxZW5pdklnTFN3SzEwMFlJc1U0VEJPdlZ4U0R6aXlnSDVtY0VremhS?=
 =?utf-8?Q?/5v4OV1Dsm/YOQCpEDna0Pc=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8344dec-6678-45a7-4e5d-08d9fd2aeaf9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6916.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:31:42.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buWWmROuLvDg0RdlyfnPIVuPCRQrLS2jkqKzAoi3d5BfHeCafHoyL/lBQWiivZYP1k/yP8BGlGufGWrdlvlhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8434
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/3/2022 à 4:00 PM, Guenter Roeck a écrit :
> On 3/3/22 00:57, Agathe Porte wrote:
>> Hi Guenter,
>>
>> Le 02/03/2022 à 18:59, Guenter Roeck a écrit :
>>> Any review / test feedback on this patch ? I would like to apply it
>>> before the commit window opens, but the time is getting short.
>>
>> I thought that you did receive the TMP464 samples and had the 
>> opportunity to test on it. I will test v7 on our hardware equipped 
>> with TMP464, verify that DT support works fine, and will reply to 
>> this email with my findings.
>>
>
> Yes, I did, and thanks a lot for it! I even wrote a qemu emulation
> for the chip to be able to test the devicetree code.

Great!

> Still, I need to have someone else confirm that I didn't mess up.

I tested v7 on our hardware and the behavior seems to be the same as our 
previous, in-house driver, if that gives you a point of comparison. We 
only use temp*_input sysfs though.

No compilation warnings.

I can disable and enable sensors fine at runtime:

> # cat temp*_input
> 43063
> 35813
> 34938
> 39313
> 29125
> # echo 0 | tee temp*_enable
> 0
> # cat temp*_input
> cat: temp1_input: No data available
> cat: temp2_input: No data available
> cat: temp3_input: No data available
> cat: temp4_input: No data available
> cat: temp5_input: No data available
> # echo 1 | tee temp*_enable
> 1
> # cat temp*_input
> 43063
> 35750
> 34875
> 39313
> 29188

For what it's worth:

Tested-by: Agathe Porte <agathe.porte@nokia.com>

Bests.

