Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E049C0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiAZBmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:42:18 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:3433 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiAZBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:42:17 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20Q1Y3Zk090248;
        Wed, 26 Jan 2022 09:34:03 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 09:41:26 +0800
Message-ID: <8681fe29-69c2-f701-aff4-c27cef2d32d7@aspeedtech.com>
Date:   Wed, 26 Jan 2022 09:41:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/2] Fix incorrect resolution detected
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220118100729.7651-1-jammy_huang@aspeedtech.com>
 <c3202b1f-ff8f-8108-e8a3-8710c8c74d10@xs4all.nl>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <c3202b1f-ff8f-8108-e8a3-8710c8c74d10@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20Q1Y3Zk090248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/1/25 下午 06:43, Hans Verkuil wrote:
> Hi Jammy,
>
> On 18/01/2022 11:07, Jammy Huang wrote:
>> This series fixes incorrect resolution detected.
>> We found this problem happened occasionally in the switch between bios
>> and bootloader.
> Can you rebase this on top of:
>
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=for-v5.18f
>
> This series doesn't apply cleanly.

OK, I will update patch based on this code base.

Regards,

	Jammy

>
> Regards,
>
> 	Hans
>
>> Changes in v4:
>>   - Correct the subject of patch
>>
>> Changes in v3:
>>   - In v2, we tried to increase the min-required-count of stable signal
>>     to avoid incorrect transient state in timing detection. But it is
>>     not working for all conditions.
>>     Thus, we go another way in v3. Use regs, which can represent the
>>     signal status, to decide if we needs to do detection again.
>>   
>> Changes in v2:
>>   - Separate the patch into two patches
>>
>> Jammy Huang (2):
>>    media: aspeed: Add macro for the fields of the mode-detect registers
>>    media: aspeed: Fix unstable timing detection
>>
>>   drivers/media/platform/aspeed-video.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
-- 
Best Regards
Jammy

