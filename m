Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB70598168
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiHRKUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiHRKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:20:16 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134B71BC3;
        Thu, 18 Aug 2022 03:20:14 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27IAK98G072182;
        Thu, 18 Aug 2022 19:20:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Thu, 18 Aug 2022 19:20:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27IAK9M8072179
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Aug 2022 19:20:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0c65db46-ec21-a3e5-87a8-6b3f2fadb607@I-love.SAKURA.ne.jp>
Date:   Thu, 18 Aug 2022 19:20:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [linux] [5.19.0] task hung for indefinite time with call traces
 when rebooted with Kexec
Content-Language: en-US
To:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc:     abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com,
        sachinp@linux.vnet.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <4c93ce0b-8e04-1f03-e4ce-7c763719169c@linux.vnet.ibm.com>
 <6b5267ee-9372-3862-614a-298f7bd9ae60@I-love.SAKURA.ne.jp>
 <0d1621b1-6654-34f1-9630-7cf5881a8eaf@linux.vnet.ibm.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0d1621b1-6654-34f1-9630-7cf5881a8eaf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check https://elinux.org/images/1/14/Linuxkerneldebugging.pdf for example.

e.g. ./scripts/faddr2line vmlinux scsi_remove_target+0x314/0x390

On 2022/08/18 18:43, Tasmiya Nalatwad wrote:
> Please find the location in source code from where i am seeing the call traces generating
> 
> On 8/6/22 15:30, Tetsuo Handa wrote:
>> On 2022/08/05 15:54, Tasmiya Nalatwad wrote:
>>> Greetings,
>>>
>>> [linux] [5.19.0] task hung for indefinite time with call traces when rebooted with Kexec, A restart is required to recover the machine.
>>
>> kexec is waiting for workqueues ("kworker/3:1" and "kworker/3:0") to complete.
>> If this problem happens only when rebooting with kexec, something in kexec path
>> might be preventing these workqueues from completing.
>>
>> Anyway, please repost with locations in source code like syzbot report does.

