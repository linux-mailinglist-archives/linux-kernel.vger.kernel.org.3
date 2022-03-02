Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7314CA0E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiCBJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbiCBJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:32:46 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE36BDE63;
        Wed,  2 Mar 2022 01:31:53 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru E268D20C4F7F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] sh: avoid using IRQ0 on SH3/4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
 <63f06bf0-fc7b-3c5c-8af9-5adfd7628354@omp.ru>
 <dde846f0-1324-7fde-ef92-eb72d4200b50@physik.fu-berlin.de>
 <e4c1aec0-e8a0-4577-d12b-8e4efedbf7e6@omp.ru>
 <9671b75b-d0c4-7967-a543-5eebdf942b35@omp.ru>
 <c7d6d986-f6b4-3200-f2c5-761ac39b9c87@physik.fu-berlin.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <5f1b5b0b-8924-c704-eb47-ad806f031754@omp.ru>
Date:   Wed, 2 Mar 2022 12:31:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c7d6d986-f6b4-3200-f2c5-761ac39b9c87@physik.fu-berlin.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/26/22 11:07 AM, John Paul Adrian Glaubitz wrote:

[...]
>>>> I can test your revised patch next week on my SH7785LCR.
>>>
>>>    Please do, although testing on the AP-SH4A* bords would be a bit more
>>> interesting, as they actually use IRQ0 for the SMSC911x chip...
>>
>>    So, were you finally able to test it?
> 
> Not yet, sorry. Machine is currently offline due to a power outage and I cannot
> turn it back on remotely, I'm not home until tomorrow. I will be able to test
> it tomorrow, however.

   And? :-)

> Adrian

MBR, Sergey
