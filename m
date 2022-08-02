Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0358820B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiHBSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHBSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:47:51 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B6474F9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:47:49 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Iwvio9xK7nnjOIwvjoZh45; Tue, 02 Aug 2022 20:47:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 02 Aug 2022 20:47:47 +0200
X-ME-IP: 90.11.190.129
Message-ID: <f0faa492-e619-ee32-c8eb-fca7a35d2cde@wanadoo.fr>
Date:   Tue, 2 Aug 2022 20:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] HID: wacom: Simplify comments
Content-Language: en-US
To:     Ping Cheng <pinglinux@gmail.com>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <bb1df380b64dd708f480261548fb303046352878.1659296372.git.christophe.jaillet@wanadoo.fr>
 <CAF8JNhJBwaxUqWXLEejirRRoFo7mM2y99cPTByCpgba0cDjOFg@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAF8JNhJBwaxUqWXLEejirRRoFo7mM2y99cPTByCpgba0cDjOFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/08/2022 à 20:41, Ping Cheng a écrit :
> Hi Christophe,
> 
> Thank you for cleaning up the driver code.
> 
> On Sun, Jul 31, 2022 at 12:51 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Remove a left-over from commit 2874c5fd2842 ("treewide: Replace GPLv2
>> boilerplate/reference with SPDX - rule 152").
>> An empty comment block can be removed.
> 
> While you are here, can you update your patch to include the removal
> of the empty comment blocks and paths in the other three files:
> wacom.h, wacom_wac.h, and wacom_wac.c?

I'll send a v2.
Thanks for pointing it out.

CJ


> 
> Thanks,
> Ping
> 
>> While at it remove, also remove what is supposed to be the path/filename of
>> the file.
>> This is really low value... and wrong since commit 471d17148c8b
>> ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/hid/wacom_sys.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 194a2e327591..21612fdae9c3 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -1,13 +1,8 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * drivers/input/tablet/wacom_sys.c
>> - *
>>    *  USB Wacom tablet support - system specific code
>>    */
>>
>> -/*
>> - */
>> -
>>   #include "wacom_wac.h"
>>   #include "wacom.h"
>>   #include <linux/input/mt.h>
>> --
>> 2.34.1
>>
> 

