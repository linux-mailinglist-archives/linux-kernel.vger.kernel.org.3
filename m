Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C60529B05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbiEQHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiEQHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:36:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60107.outbound.protection.outlook.com [40.107.6.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC649686
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IemlUrG+kLwV/qowQwgBVXeFZAPdRsHm3lQfiPDr5A3JB7lyovM/iSqLCagyaiEC45QwHhtMXCRjL2UDriIh3HxdcEvgLIzlmjl5iA0v8TW2YZkve+yvEzjJr9EgTegqFj5d/ALF3k7aWbhQySTVnOT6ewf3wx5fm30PiU4MBS2bWaNjpifDA1QYk1u7ARtW8hg/RyZ+531Qb1hXK0Cti1HYJMgnGzccO8GSJvIFFxbmt2I0VocBqRgDb59sNcBKsiYcNnhYeGC88KpJy7Z3Qdzo8CqLrALiNFfEhJsZd73LnFhpw1VcTNcNsjfsJLq6hQXl1q4tH2UwNJAelZsYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCdkG/79eGK1JEbAgJuqk1kb5+y1aJ8yzEI/BlNG+ww=;
 b=cEA01jxGvL0+aOCQRNTjFoP1n/VFYVgsyWiHXTM6Bmo2fWRKoQ8+ardbbY3mqkFrHBM+kMnhDbi6am7X4sGv4JagTK8EYqhOWk00jingc9mrM1rTWLzC2wiAcujfqGJvz4Xcf6Wr3dR+d5/2LBsYVa9qTfvFC+XSodQ6LdNCo8fU4Ap6ZAW8rUOh1gCOABdz7/L4MlnP6IX3p5DKeCjnMoKn0LtTNH9q7fs40KNYtu484pSJ2Olu52LWCd7bpNXsnGwVqxYy6v1+3arIu60+4GX1qqRNwQPV5ynUtOY1Uga0/whGYuOov7TuF/LH76CxQMMowoQ00O5iQeshalbiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCdkG/79eGK1JEbAgJuqk1kb5+y1aJ8yzEI/BlNG+ww=;
 b=FLx3jEJ8/piNnxXhxXw4Fy1nx3ZlJL04mkZBXj8kwLD9s8wfW//vUqrknaPQYGE4GvEx6JkBga5r4X7syXSYH7jH5g5F+jkQ/H7ZRA5HPRALm/p3+nsx4JOnIrxvxqPvrZr+oKvlFKruz82XDmxVuGhyuyUDEe2CyU/Y1LcRu4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PRAPR10MB5424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:35:53 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d0e:eb72:973:1e71]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d0e:eb72:973:1e71%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:35:53 +0000
Message-ID: <e883bc7d-7553-3064-27c3-6dfe23b0e0cf@kontron.de>
Date:   Tue, 17 May 2022 09:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] mtd: spinand: add support for detection with param
 page
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220414143426.723168-1-gch981213@gmail.com>
 <20220414143426.723168-2-gch981213@gmail.com>
 <05966ece-65c8-ff7c-cb44-55c4d5a5542e@kontron.de>
 <CAJsYDVJ=WRT270mj2jNc+yy0v_XRpyH8N+GOmkNJv1zAh76rDA@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAJsYDVJ=WRT270mj2jNc+yy0v_XRpyH8N+GOmkNJv1zAh76rDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0058.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::35) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaaf2edf-209b-478c-d542-08da37d7df2e
X-MS-TrafficTypeDiagnostic: PRAPR10MB5424:EE_
X-Microsoft-Antispam-PRVS: <PRAPR10MB5424A00B870E26CC528E2080E9CE9@PRAPR10MB5424.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/JbDVbF7egTZFexUTxJviVgrpK6Eco4OUiWiKd7zRZPloLJyhOkTJen2FWZjkd6phvuuj7C1kkgLJKeTGufPLgBC66eFtJVZgV+SXWK26jdXYX+QsIelMBKsnm6yfZ1juO5R8y3KoLYiDIF8ATJ+Lo6bGWRmGiftJouXpbw5V5H06Ml/R4uC1ylV2MUEwcIKJfL4F0J5mZuEBN65iI+aOQH9t5gKsyvcHFq/wagV+fVUOCMv+ZgwZpRKDMVh/vae/EJRYUi9KEOP74Qh38X1qHb4pAHGDyBY77sVQjYW0+6VQfJOo26zU2bvxbUmkyhPlZi+qcl+JmPpwmQ3e3BIMDVppr8fDYa0/WETuRWrzoVIpF7JCzK6QfbNc/WtAIILvbpMsprDQXy6E9K8YCfewcPfAmEytKJ7EXyFHWDBemJXzd3+asY5OecaQX5ZA5Eieihlm/7wiFhFHXdIj4lMLr+gJn9My0ssaMNyDmX3KODuYeIOhgj767vgZa8qhCb0NCqbXFVgvir/y1m0SZ8DYwXN7Pm2J6RIv8fN1IjLoLLMJsJ2kUesFJliFUPdjvFspkCgCj/h8o3oXYujHpLO5rHFfZOUjGAXucEgbKxXwXNaUkL21z4egktCCM/9GfNDvX7maswQmk1dsvSKT/ArtdG0MTbBkbC2m5Etia8wdFpahjIvBo5UwTEj0KUTFNzAitDH2OyZe738qPEdjTTQwamRKeyUDrQWnsXvjgWHZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(66946007)(6916009)(31696002)(83380400001)(31686004)(66556008)(4326008)(86362001)(36756003)(38100700002)(6506007)(53546011)(5660300002)(2906002)(7416002)(6512007)(186003)(8936002)(508600001)(316002)(66476007)(8676002)(44832011)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHlZcmlBYnBUSDJiR0FEc0NwYTdnNkZtb2ZzN3IxVGtzaGlnL2J6d3FjNElF?=
 =?utf-8?B?aGNObXVQZUJlazBEcTRrSE42Y1RPNllJOUM4VmZraWd6cUtmRXpGZ2hTbk9t?=
 =?utf-8?B?dFJ4aGg0TVVHaUxLR3E1YnZ6RndPN1MwYnRjRThkOW96Zis1NWlkVmFTL0pL?=
 =?utf-8?B?aWxwSFhNUlEzcDlmd041SUU5eHc5MUF5Wk11elRUd250Mkx1aWc2SzV0K1hi?=
 =?utf-8?B?K043SG9MWGNTZEZDRnV0MmVCV3NZSWhoU3dUcG04cGMxYy81eWo0VVZ1OUFN?=
 =?utf-8?B?b2laUW5UYUNFYmkwYW1uZXFENHFnNW9rTDRSRTVuNE04RTF3YVJmdkdFeUIy?=
 =?utf-8?B?SG9LemZoTHRkK3NjUitqR2pWd0FVTVdXV1JNSFFXdzdGd2FVUTdYN1FUbitN?=
 =?utf-8?B?RExhM0V0c3FmdDRHWkIvMVcvdEdja29BMnZkSFFoY2pMZW1TTXI3WkxqUVor?=
 =?utf-8?B?alRTZmp1eUIxL2dXejdzMlNkZkhEZmdFL3lzVjhoQkt2Q2FES3I4ZzRiNzVY?=
 =?utf-8?B?bk9oRkp1WnBPR1U5UFlWZlJDOWJ3S0xZOFd3a1c3dzU3YktnSzMvU1pwb2xw?=
 =?utf-8?B?RUNHQmU4enQzSUdldFVYUEZEVElnS0FNM2ZlUkF4bGcwS05xNHQ2UVY3Z1dF?=
 =?utf-8?B?cUZYYnlpcVNNZ05Lc040dGtrQ2drMU5NYjlPdHFTUWJNK0hEMzhFV2tHNG8w?=
 =?utf-8?B?WUtMaG9HRUlkTHN4SmxnQkwvTzZLZUVMQzcvNHFsZEhTK2MvazgyVS9SaDBp?=
 =?utf-8?B?dHJGNzN6cHVxSUhQSlQrbXJuV3c0TnpYZkdraGlEKzMwaktSaGE1a2RWL1Av?=
 =?utf-8?B?MCtxVFJXU3c2cjVjcGFVeUpTbTYva2RPVStrNkkwaHBOOHFYeDd5RWh3Y3Ey?=
 =?utf-8?B?Z09uSmJuQmRUenhtQUtUbEVvendoSlBHZmxRYkRmdFh0UVdueDU3MzI3cnZP?=
 =?utf-8?B?N1NRVU5vQUJKREhvNjJCSVBXQ1RtM1NtQzlzbm9OWHVuak9GcHFRQ1RrQ3FE?=
 =?utf-8?B?eXJSY01Uc3lJN2FvVWdMQVJHL2I5eDNzTFFjVldRWlVxd2o2UUtsVzBjN3Jr?=
 =?utf-8?B?Yk03R2JpMWJOeW16alEyNmhJbjBPN0dhNVZ4aGgvR0dxZ1ozSkNoOGcrUjZW?=
 =?utf-8?B?K09od1l4eHkwcFc2SzdaakNHV0I4LzVNWTQ4bDZLcytxcGlrelBZVTI3V0U3?=
 =?utf-8?B?NElyOFpSdUF0aEtrTHR0cVduaytMOTBoOVIzQU1DUEpMVXdxN281QzdSdVd3?=
 =?utf-8?B?ZGVmeDlXVzFQUU0rdXU1SVNHQnFkaU1ydkhTK3ZwTjJxQnJkdWR3aHBlc0NE?=
 =?utf-8?B?clNvWXU2eWhURllMOVdHcisyMXV5K045SVdRZ3lrdmFVcUMzejl0T1ZTVXkz?=
 =?utf-8?B?anVzNGg0ZWEyUW54ZEY3MXZRNTJVSGVQM044TUkrZkR6ODcyejdGcUxnK3BV?=
 =?utf-8?B?dDQrWVdiNHppVE11MWxEVmJRSERhV2JSMWFzQWtuVmY3blVoRUNnTklUR1B5?=
 =?utf-8?B?VGxFSjA4OGRIRTZzS2ZUU2ZlZXFDVFJybCttT1FVVHdvSmdTMUJ4TG5zZThN?=
 =?utf-8?B?eC83SnQ2Vy84NmRzN1lxSitiRUdVYzh2OXZUaVZSaWRyVkF5clZpYmNpZG5h?=
 =?utf-8?B?V1NzM25TYjVmR3luekFQR2M5Z25PMG9nTHBmd0VralVDczhZMEdmbUdLVHlj?=
 =?utf-8?B?aDVmd3BJRnJvSDd6L2lEVmVTZ0xlL21uNjdjU1Fud2J3ZVBUV0duWGxNYWl3?=
 =?utf-8?B?WllaMnFPV1FPTTdONjVPNHd1cGVneDEyNzNoM0x5dmFsL1pWN00wTzRVemd0?=
 =?utf-8?B?bzcvVHNEQlNYU2tJZlQrc0JDZmhoT2R1bitPRjBvdUZ0UzVmdm1RTXpmZ0F4?=
 =?utf-8?B?bG9BeXhoTW9sQkd6OFd4NEE5c2F0WXZuYzNMVHVmTk1XUVB3TUNFNGlNRUpN?=
 =?utf-8?B?dHhPUkhwTThpUStvckFwYThYdHRQdUFpK1hqSC9Jb1RxQjFXNFVlcWdhTi9r?=
 =?utf-8?B?bkgybmJDVllMWitaMUlyTnJBcENNUERGY2NmeGpnVlZkTVNQbFpKTHdvTnBh?=
 =?utf-8?B?MFl2TjlKemNSNGlXZEJxRWFIK0hMQkovb2pTbkxKMVlCaTJKTGY3ZHFhRFhE?=
 =?utf-8?B?VHBmSGFFM0czVUlVcm5MbFI1eTVpSnRUVEY1NUk0RS81anlNN1V6eDE3b3JD?=
 =?utf-8?B?MTVSR0h5bzZUc3NMZkhiMFR4SDRxekVKTVVvMkNXN1pBNnBUc3JSVWUvZy9O?=
 =?utf-8?B?TEh4ZVdzYis4RTJMbWpFaW9YTGptcmQ5c1hDb25mSlZsUExwRHVLYUZTZ0JD?=
 =?utf-8?B?Y2hnbG5JcWlmbVJkd05LckdSWW40SzgxOWZKMU9VajhCZE5CZk02TmZ6TW1Z?=
 =?utf-8?Q?3JlTYg4jJ+mNEEcM0BTX0nwwcrZw/PAZEP7Zf4hlCF+N4?=
X-MS-Exchange-AntiSpam-MessageData-1: lveBU+rY6Q9DZVfocRA+oa6AUHJY3tYwTkY=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf2edf-209b-478c-d542-08da37d7df2e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:35:53.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiS0OtU2KDKOvvD70XwV4Hr+AUw83F3BeLNqlwW5cI+jJJgJsIdZQDv95x12SzysZBFJSeYKCfEokRZxeQKIwsp6/U6i36Ut2IfNVXk1uqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5424
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.05.22 um 16:10 schrieb Chuanhong Guo:
> Hi!
> 
> On Mon, May 16, 2022 at 3:38 PM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> Hi Chuanhong,
>>
>> Am 14.04.22 um 16:34 schrieb Chuanhong Guo:
>>> SPI-NAND detection using chip ID isn't always reliable.
>>> Here are two known cases:
>>> 1. ESMT uses JEDEC ID from other vendors. This may collapse with future
>>>    chips.
>>> 2. Winbond W25N01KV uses the exact same JEDEC ID as W25N01GV while
>>>    having completely different chip parameters.
>>
>> I think they share the same first byte of the JEDEC ID, but the second
>> byte actually differs and would allow to differentiate between them, right?
> 
> No. For the 128M version, all 3 bytes are the same between
> W25N01GV and W25N01KV.
> 
>>
>> I have this patchset [1] that I didn't manage to send upstream yet which
>> adds support for the W25N02KV. I added the second ID byte to detect them.
>>
>> Still your approach using the ONFI data is more flexible of course and
>> probably a better way to handle this. I will see if I can find some time
>> to add support for the W25N02KV based on your patches.
> 
> Don't do that. I abandoned this patchset because I later found that
> some early W25N01GV doesn't contain a parameter page at all,
> which means detecting W25N01GV/KV using only the parameter
> page is unreliable.
> I think what Boris proposed earlier in v1 (use parameter page
> just to distinguish the two chips) is the correct way to go.
> 
> BTW I was making this patchset for a potential future ID conflict
> between ESMT and GigaDevice, and I don't actually need to
> deal with the W25N01GV/KV nonsense now, so I don't have a
> plan for send a new version of this atm.

Ok, what a mess. Thanks for the explanations. I will try to send my
original patches for supporting W25N02KV then.
