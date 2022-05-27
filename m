Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946AE535802
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiE0DPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiE0DPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:15:05 -0400
Received: from mail.students.cs.ubc.ca (mail.students.cs.ubc.ca [142.103.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5376994DA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:15:00 -0700 (PDT)
Received: from [128.189.138.235] (host235-138.resnet.ubc.ca [128.189.138.235])
        by mail.students.cs.ubc.ca (Postfix) with ESMTPSA id 03EAA60FE796;
        Thu, 26 May 2022 20:15:00 -0700 (PDT)
Message-ID: <ce57b6a1-83d4-d984-0c44-fdf78d237901@students.cs.ubc.ca>
Date:   Thu, 26 May 2022 20:14:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: iwlwifi keep crashing the kernel
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8322144e-db5b-e82d-a3f5-c09ace7a6340@students.cs.ubc.ca>
 <96fccaa4-9416-65c3-2d6c-a7f5b9f13f1b@infradead.org>
From:   Tommy Zhang <va7tch@students.cs.ubc.ca>
In-Reply-To: <96fccaa4-9416-65c3-2d6c-a7f5b9f13f1b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy and other developers,


First, let me express my appreciation to Randy for forwarding my message
to the mail list. However, given the mail list forwarded message doesn't
have the correct log file attached, I uploaded the content of the log
file to an online pastebin[1]. I hope this would help.


Sincerely,

Tommy Zhang


[1] 
https://privatebin.net/?2979a1a54678734a#B1RS2ZnEKiNtMKfShJxung5LtodEyGbBStQTp23T9J6C

On 5/26/22 15:41, Randy Dunlap wrote:
> [CAUTION: Non-UBC Email]
>
> [add linux-wireless]
>
> On 5/25/22 21:33, Tommy Zhang wrote:
>> Hi folks,
>>
>> I hope this email finds you well. I'm running ArchLinux with kernel
>> 5.17.9-arch1-1 #1 SMP PREEMPT on ThinkPad T440 with product code
>> 20B6002XCD. The OEM wireless adapter malfunctioned previously;
>> therefore, I have upgraded it to Intel AC-7260, the latest FRU-capable
>> wireless adapter I could find on the market. However, the iwlwifi module
>> recently kept causing kernel panics which freezes the system incurring
>> disruption and data loss. It reads from the kernel log that there is a
>> kernel BUG at line 379 of mm/slub.c, which is attached to this email.
>> Before filing a bug in Bugzilla, I'd like to hear advice and comments
>> from Linux-wireless. Please feel free to reply to this thread if
>> anything is worth sharing.
>>
>> Sincerely,
>> Tommy Zhang
> --
> ~Randy
