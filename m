Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D43533C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiEYMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiEYMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:24:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F86D3A9;
        Wed, 25 May 2022 05:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fgx4ekumkYyipmK38XcOuopY80cBRqnc0CFKhpQ3V1K9CNeDuDgviWSmSxk4y7DyGpfyPfkY6TF58h1Hf8VnhNoJ0buKB1IBg7olYq8mmJJlypl3dlzIei4Ohozk9ebb1HH0jM9YxRxmNEgU0CynpA4TyF1pYTprSPpwYdBRG8UjuOAitDJpv7yGXvzZFP8fEk+TNZarNfw9NtN4HJN/JZAilygLhiSLlNdCxh2x6gEn7QTPfih2g21Tr9W0ktlcU8yh6TBqaiv9jZAaF0rvzb/XGq3mzO0xwgVzpvOzRtA11XvWjX/ZMJTx6k/OvnlUoxQjVFS6r83bB8x5mE7xKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk+qOOqrm0QTXsWeTWGSAo1kiOCn4MxMXPa3CkNOtD0=;
 b=TbHU5+/9WjFGrEFktuW2Cug51ndIQpIjtu+RaAGVAZIliv0afIvYV/Kq4R0b4D866lVLjh6d/8gJzjhYGEa5BOKP7UziiyhCKRIMyIX4YES/PKCFNDYHqH4NM6P7WaTq2KFijeqKwap9H3Je42dLey0nCfZhW9DktTHHjdLGZrAU2XaJihtjbB2+DuGvJQwHQFed8MrO5ONxKOMHaxBwtOSmn9Jy2rR4n9O3D9Ct6ntwgITbab9Ia5iXqa5lvDCZuTPIqtiHz56reoDmzL0s4klJ6uzTLPx94FYDlNegXl5wFhe8WL+cxKNsrizprP7RT3XlFGTRJM5sxga7MQFVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk+qOOqrm0QTXsWeTWGSAo1kiOCn4MxMXPa3CkNOtD0=;
 b=GcuF5OXAW2qJc5zerv25zU4z5mQD9sMUH0NN8P9uCjdkg7eyuxkGut+VUKdsQbWdAGphmxYIXCRzM1zKU2FVxWVA1E5UcdqCb+TbvH3tbtYx3rl4TMGVqXdtXkTGH5a8tzgH9ZOjVM40dB2QhfiDwfIX3e5wBm1nkK9W5sgm4GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6)
 by AS8PR04MB8674.eurprd04.prod.outlook.com (2603:10a6:20b:429::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 25 May
 2022 12:24:37 +0000
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::4c85:560b:2f85:7522]) by DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::4c85:560b:2f85:7522%8]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 12:24:37 +0000
Message-ID: <d599e48c-1821-164e-619d-dcfd8a689192@theobroma-systems.com>
Date:   Wed, 25 May 2022 14:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/4] media: ov5675: add device-tree support and support
 runtime PM
Content-Language: en-US
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-2-foss+kernel@0leil.net>
 <20220510094607.2ijaw6we6jml2bv7@uno.localdomain>
 <49e53ae4-1be9-fae1-6c93-3ce7c16f3ada@theobroma-systems.com>
In-Reply-To: <49e53ae4-1be9-fae1-6c93-3ce7c16f3ada@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:203:91::33) To DB9PR04MB9378.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4923f759-4f36-4b40-d337-08da3e49887f
X-MS-TrafficTypeDiagnostic: AS8PR04MB8674:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8674EA7F9EEED8F9CE605B48C2D69@AS8PR04MB8674.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0p2fMJ8qHmJztmefdGqzet+KRapIMqXplOtC7B1UNy8suyZPwbMuLnDs+/nNZ9icMmTMviagTrM7X1W5WJSf1rRYK0UZSEHptNmKJtd6gloUsudGzMaAsuVfxng6NKbpCyXZ/j4oQMWi/JX16usZ1q3OKB5hINxq1Ou+eA6dmnXHW31iWtp8PmWnsSywzPfZ9+ybyIHQgAM4/YA8ql7WAD8bY4aiXD5qjfyEobNza7xEOSashG3dmwhAGhbHDa7skFmdwyJk1E8uFFtz5UOtcvLH0LuFeUBilv28xnLNzI+g1kgM0uAC9aGWcsEmlapPPCxKx5LY4utr4/ARaY7NY1ru1+ZWg1XGtEVKZzADXbAeMky7vFPegBWKje2984hCgXVxtmBpm2A1qNOkxTAgoGevj3vi3fZ+NATqacmiYT0J10gZKWKHheoTD11DRFFWe12m+z83Tmu33qOxDZxAAvoNrrbyvSoPTmT6kSFEmNUIIxOKQ+fli0zBAC5NnoXjWmlfOZhquoA8nlITfP+j/7dhpvAw5d/wwRg+TXiSlklsxraEUAxmplCKzhcUn2fIKbUzEgoCOqNxmDtiVpDr8xGPVGtMoIuyb/e+ISu4RRJs8izy2pqcx3io1P434QYTndvTbFWUVTj+aKRqwzCBlWmGQouF1wxWIYQw1CjprCGziEHo1bjk6KRK9EcpaRLkAmUT7t9yqAejWjhBdzJF+jDFZgzcI6Ix+Hpv9fChjcZiH8wj1DbrkvefumH1612
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9378.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(8936002)(508600001)(8676002)(4326008)(31696002)(26005)(2906002)(86362001)(6486002)(66476007)(36756003)(186003)(316002)(38100700002)(83380400001)(6506007)(31686004)(44832011)(2616005)(53546011)(6512007)(66556008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEw3aVFYR0VRNjZySmEyaEpWSUs3Mjcya1NMcXUzc3N6eFJRYk9ySGlCZ25F?=
 =?utf-8?B?dkEwREs1N3pWeS9MTU91SGNGa2swSlo5S0hCNGN4ZWtQWnNlNmZzOGozSWhP?=
 =?utf-8?B?dzdRUXQrMVJoWllwdTY4bW0yaEdYa1g4SHE1Ris0NEYwVS9zMnd2d255UjAx?=
 =?utf-8?B?dEFsdHBVSnhrbmtwbEtGU0w1TmYwWkYyRk9iOHNvUnR5aXJjTHo3U0NoakRw?=
 =?utf-8?B?OTlqOVV3cWtSaDBZN1RtUndpYjJIVzhxRE5tNCtONHRWRWVaWjVtZjhXZE9P?=
 =?utf-8?B?cGVTcnVtRVV5UWNwdTZtNE91bnVtZGg1Z0NyeVlYVitIc1p2RmRBOU5qM2FG?=
 =?utf-8?B?L2dxcGZadXV0ZHJ2ZHFHSnp3UlR6dDlzRDhTMVc5Y1ppUFhWaHhNQzEycExH?=
 =?utf-8?B?Mm9Yd3NBdFdFY1YzZndSWVIza1dtNUpuWkdGNkh1SFBTajIzdFlxOE9iKzNs?=
 =?utf-8?B?a1hmZlV2TEw5OEZGV2MzMm5zdyttcEsyMTZNWTltOW91S2ZYUm5MSjRyazcr?=
 =?utf-8?B?S2hWVjl1TDNxYVI1UytMeEVsTTZYbFVvZE1IcG5yU0Z3VXBZdW52SzFEUWpV?=
 =?utf-8?B?MDdjekZqTkZxWjB6Q1lvSEEzZE9pQVoxa2ZQdVo5SEszZlBpOWVuYVd0T3Ns?=
 =?utf-8?B?TEZ3OXorOGNkSTk1elpnN0FWV0NUb0pOMnYvWnhwU2JHdnFRaTc2V1ZLVFhQ?=
 =?utf-8?B?QURrak9kdXFXS1pRZmJLZzY3aGNSWjlVVXhIZ3ZXNnFCUGhTVVdzMmMwMDhx?=
 =?utf-8?B?UlBHbXhnV1N5cUhic0xuRHdwcXNVNzNsK3VLRFI1RndURldQd01lUjVrWWdI?=
 =?utf-8?B?djJCNC9ZRnJMTU8vYzdkYm4wTTczaXlReGZjZFc3S2NzZUo0dEI5c0NaTjlh?=
 =?utf-8?B?NTZYclpwK0JJOXFCTFAxQVBPTmdOMVV1NTBKckJPTWUrL05JT0RFTmxxMnk2?=
 =?utf-8?B?YzQvSnU4VXZxMlJXamJ1M3BZWjdHaEYrdWM4TjRaT0lxSHUwRGw1T1ZBWUdU?=
 =?utf-8?B?UzY4YndDNFAzbldtZkdiL3djUkJJeSs3UE5ibkJJYmFaOHZPSlF2ZEYrOGdG?=
 =?utf-8?B?bnNsMGRxcFM1c2JxTHpVQ3ZXMGxCK3FyeExVRDB3a0V1VnVjZFJIMHBzZVFB?=
 =?utf-8?B?MVBnMFlxU09RY3RUUUt5cDdVbEV6TVZtdGlEOGx0cHB6YlRnTmZ2Sm9sbldX?=
 =?utf-8?B?UGt6Y3dIYk1PQ0NiNk04MTBkZURzdFFvL3lJUUFaZmQ1ZTJTWlVnNFhUa1NW?=
 =?utf-8?B?L1ZvY0pnbXFUeFlVQ3N1aGRqRFlXUU9wc0QvNDB0TytycVlVLzl4ZUFndHRk?=
 =?utf-8?B?a2NYdHJlYkV1bjBlMmh1T0F6bWlGbmQ3ZVU4NXRzcVFUd2RxYng2dXlCM2xB?=
 =?utf-8?B?NjZFc2srdVBVYkpwU04ySkVSQTd0VUdlem5oOTRHWDdhSlpuOFhBK2dSTVlZ?=
 =?utf-8?B?UzBvN1N3eDFDbmZwSitIelRGemZnMlkwdU5GVVVrQjhoWVdweit5VFhmV2h0?=
 =?utf-8?B?OWZhUHBGY2tBUzJHYlJJWW5yWVFBd1VLL0w0OFpvKzl0bExpMFovMWZ3cWhk?=
 =?utf-8?B?TENWZmtSWVV4S0JHaGNGVzUxbkF4SWNjTSs1UUk2SkM1UUFiSmdKTGwrb1la?=
 =?utf-8?B?TVZTWGRpWS8vVU1wUlQ3bXA4SkRqOXg2aUowMGNZUDVaUFBlWS9ZMFl6Tkdv?=
 =?utf-8?B?SlpQYVdnTkFiQmphS2lsL1Y5dWJsM2pROTYzUTdXalVsa2g5WnA1TzNmV2JF?=
 =?utf-8?B?SGJyWkNlY1VubCtzTnY5VlhMOFdzTkErcDJCb2lTekhJOHY5RnBZWjVUOGV3?=
 =?utf-8?B?ZnROSjF0VmdJQ0xQdXhuQ2VNNUxUM25KMlhMODhVN2FPNEJaTTFlaWkvNnMr?=
 =?utf-8?B?THhDR2NKdmIxeHl4NUdCK1NJMEtIRDhGb0JDWldKYnRmblNVQy9KTGxNanR2?=
 =?utf-8?B?YlYrTVh2NVVQdkU3bnJvcENnVm01eUgzTVFiYlREYmU2a0tnOS9lUkx6Nytu?=
 =?utf-8?B?eTVrejlnbGZzcTVHekhFVjU1ZHc0V0l4ZkZHQkFla0NMdjZFeFZQWmJLcjNT?=
 =?utf-8?B?VmdnUGh6bGtrYVJNMjlSQ2hDa0ZlZnZ0cDVTeFJjZExxVzltNzlFUXBVUzZh?=
 =?utf-8?B?MVdwQVlwbnRqR3p4anFrU096Q1NtVk1taTB1ckU2MnRLbHRPY1VwQ2VqMUd4?=
 =?utf-8?B?dlp0bkFkRHphek9UVzVUai94V3cvaHJyMlFoT3lKeXZwckh3b2lJUXRnOG9q?=
 =?utf-8?B?WFMwZzVVcDlWSk1aR2RCSlIyVEIyc014Q0F2bUwyYzhsUy9pZUdBWTlrSTdU?=
 =?utf-8?B?Y2ZaLzRMTURmaE1Ca1NxbDB0YmcrOERTcWhYSFpoK2pzbHVMTFNDNDYvS3FV?=
 =?utf-8?Q?kDSzgNGNGCMFVhI23DRYj5xHbz7w7RvCo+UAH?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4923f759-4f36-4b40-d337-08da3e49887f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:24:37.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXn9fu+s4zVzB5XAaZeShKiWG6hSwHkr/8qvylU8nZkf6/UpT7bp0QgU0kfL09gOHNeoR7CNklEiV9SyB8/51lVDR7RkkG/D0VBjfG9RYRNCwxOA+bNWdSMlaNg4uU4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8674
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 5/10/22 15:42, Quentin Schulz wrote:
> Hi all,
> 
> On 5/10/22 11:46, Jacopo Mondi wrote:
>> Hi Quentin,
>>
>> On Mon, May 09, 2022 at 04:32:24PM +0200, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> Until now, this driver only supported ACPI. This adds support for
>>> Device Tree too while enabling clock and regulators in runtime PM.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Thanks for addressing all comments on the previous version.
>>
>> Looks good to me!
> 
> Unfortunately the sensor disagrees :/
> 
> For some reasons, the first three power-on + power-off are successful 
> (sometimes only the first two) and then the sensor is not working until 
> next cold boot. I got lucky when I tested the patch before sending, much 
> less now. >

For your information, there were actually two issues:

  - the MCLK of our camera sensor is connected to a pin on a Rockchip 
PX30 SoC whose iodomain is not enabled prior to booting the Linux 
kernel. This means that the whole block was not supplied with power 
(something around 100-150mV instead of the expected 1.8V) and the i2c 
transfers during some device probing were broken because the iodomains 
driver could be probed after the OV5675 driver (and also, since it 
persists on CPU reset, a reboot would fix this too since the iodomain 
would have been configured by the preceding boot). We currently handle 
this the hackish way by configuring the iodomain in U-Boot before 
booting the kernel. I have talked with Heiko, the Rockchip maintainer, 
who mentioned there's no way to explicit a dependency to an iodomain in 
Device Tree right now but suggested we expose regulators from the 
iodomain driver. I'll come up with something to fix this properly in the 
kernel in the next few months. This is not related to the camera driver 
in any way but wanted to mention it.

  - the camera sensor was actually faulty. After many attempts at HW 
reworking, looking at the scope, re-reading the datasheet, trying to 
read between the lines, etc... we swapped the camera sensor for a 
fresh-out-of-the-box one and it worked for 30min (then we stopped it) 
with a runtime/suspend every few seconds. I tried with two different 
camera sensors and it worked fine.

Cheers,
Quentin
