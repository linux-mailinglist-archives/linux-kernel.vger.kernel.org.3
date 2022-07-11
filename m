Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028255DD54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiF1KFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiF1KFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:05:52 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE032E9E1;
        Tue, 28 Jun 2022 03:05:48 -0700 (PDT)
Received: from [192.168.1.103] (31.173.81.16) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 28 Jun
 2022 13:05:26 +0300
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
Date:   Tue, 28 Jun 2022 13:05:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [31.173.81.16]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/28/2022 09:48:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171392 [Jun 28 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 491 491 a718ef6dc942138335b0bcd7ab07f27b5c06005e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.16 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.16 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;31.173.81.16:7.7.3,7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.16
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2022 09:52:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2022 8:55:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/28/22 11:59 AM, Damien Le Moal wrote:
[...]
>> x86_64 allmodconfig build with W=1 gives these warnings:
>>
>> drivers/ata/pata_cs5535.c: In function ‘cs5535_set_piomode’:
>> drivers/ata/pata_cs5535.c:93:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
>>   u32 reg, dummy;
>>            ^~~~~
>> drivers/ata/pata_cs5535.c: In function ‘cs5535_set_dmamode’:
>> drivers/ata/pata_cs5535.c:132:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
>>   u32 reg, dummy;
>>            ^~~~~
>> cc1: all warnings being treated as errors
>>
>> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
>> stubbed, which is the same as what we already do in pata_cs5536.c .
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>


Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

> Looks good, but I wonder why I am not getting this warning. I always do
> W=1 and C=1 builds. I tried allmodconfig now and I am not getting the
> warning...

   I can confirm the (fatal) warnings with RedHat gcc 10.3.1... but somehow they only
occur on x86_64 with allmodconfig indeed (which is strange)...

[...]

MBR, Sergey

