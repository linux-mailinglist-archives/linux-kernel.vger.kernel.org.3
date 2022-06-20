Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7A552598
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbiFTUMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245663AbiFTUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:12:05 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108C21828;
        Mon, 20 Jun 2022 13:09:18 -0700 (PDT)
Received: from [192.168.1.103] (178.176.78.78) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 20 Jun
 2022 23:07:40 +0300
Subject: Re: linux-next: build warning after merge of the libata tree
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220620103400.6b03f8d9@canb.auug.org.au>
 <20220620182108.5efb3107@canb.auug.org.au>
 <387885f0-999f-3746-0238-77052f10b25c@opensource.wdc.com>
 <8e0717c2-d3c0-c81c-3a33-afdc045d123c@omp.ru>
 <71cca7ed-6409-3066-8878-cdc647b17057@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <54db2644-aa04-82cc-88cd-1cb40a2b2d77@omp.ru>
Date:   Mon, 20 Jun 2022 23:07:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <71cca7ed-6409-3066-8878-cdc647b17057@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.78]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/20/2022 19:47:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171243 [Jun 20 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 490 490 64947c9fe6ec4170c45683de1592f92a9c3bac07
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.78 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.78 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.78
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/20/2022 19:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/20/2022 5:27:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 2:07 PM, Damien Le Moal wrote:

[...]
>>>>> After merging the libata tree, today's linux-next build (powercp
>>>>> ppc64_defconfig) produced this warning:
>>>>>
>>>>> In file included from include/linux/device.h:15,
>>>>>                  from arch/powerpc/include/asm/io.h:27,
>>>>>                  from include/linux/io.h:13,
>>>>>                  from include/linux/irq.h:20,
>>>>>                  from arch/powerpc/include/asm/hardirq.h:6,
>>>>>                  from include/linux/hardirq.h:11,
>>>>>                  from include/linux/highmem.h:11,
>>>>>                  from include/linux/bvec.h:10,
>>>>>                  from include/linux/blk_types.h:10,
>>>>>                  from include/linux/blkdev.h:9,
>>>>>                  from drivers/ata/pata_macio.c:18:
>>>>> drivers/ata/pata_macio.c: In function 'pmac_macio_calc_timing_masks':
>>>>> drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
>>>>>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>>>>
>>>> 	.
>>>> 	.
>>>> 	.
>>>>
>>>>> Introduced by commit
>>>>>
>>>>>   f0a6d77b351c ("ata: make transfer mode masks *unsigned int*")
>>
>>    Oops, sorry about that!>
>>>> This turned into a build failure in my powerpc allyesconfig build, so I
>>>> reverted the above commit for today.
>>>
>>> I pushed the fix already. It is in ata for-next branch.
>>
>>    Thank you!
>>    Note that your Fixes: tag doesn't look right -- the asterisks are missing
>> in the summary...
> 
> Fixed. Copy-paste from the mailer (build failure report email), the
> asterisks are gone and "unsigned int" shown with bold font. Please stop

   Strange, I'm seeing both asterisks and bold font there. What kind of MUA
you use? :-)

> with the markdown style emphasis. That creates problems.

   Mhm, OK...

MBR, Sergey
