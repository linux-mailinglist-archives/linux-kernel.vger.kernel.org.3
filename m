Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A34B9276
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiBPUgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:36:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBPUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AE2AE2A3;
        Wed, 16 Feb 2022 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dOT/1aOyaiDsVJvJU3JA5EooJNZncoACyNyR31PUbGw=; b=gHB55gRMUKJvsWEOn23DNCXR0+
        9dNBp4Q3bo8fg63YX3+Xk0+2ry3W7Q7+4pjbCCFfBdR463dYXX9JacOAA0GKvh9AhOvJ5426FuLox
        /6O6pV+BpWpodsyl4Ypjv3AyWxrG5Z2Bf0gMIibP2HDBkh79Xj3BgtKcJK4YEYe9H1AcXHSHCpogo
        waGKjsR9DUcQ8eEjXLKCUD0DKQ8P88iNlK5K/64bZ/3BZkjZWyBdUBVxyEs7Z2OE3fMK3LQlDpF8F
        KMSfXwHLTrF0y5abn6XMg/vq1CX2uHzNKlOfT+fvxU5dRPP+yngH/QB9vmNQsURUDJmumISikp0Qq
        3qTkJmpw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKR1L-00F1Wz-DL; Wed, 16 Feb 2022 20:35:27 +0000
Message-ID: <6da7a555-61e9-4a66-be18-1bcaa6cdbc53@infradead.org>
Date:   Wed, 16 Feb 2022 12:35:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] Docs: printk: add 'console=null|""' to
 admin/kernel-parameters
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220215005615.11244-1-rdunlap@infradead.org>
 <YgviYXNc6zo2V+35@alley>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YgviYXNc6zo2V+35@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 2/15/22 09:26, Petr Mladek wrote:
> On Mon 2022-02-14 16:56:15, Randy Dunlap wrote:
>> Tell about 'console=null|""' and how to use it.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: John Ogness <john.ogness@linutronix.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> --- linux-next-20220214.orig/Documentation/admin-guide/kernel-parameters.txt
>> +++ linux-next-20220214/Documentation/admin-guide/kernel-parameters.txt
>> @@ -724,6 +724,12 @@
>>  		hvc<n>	Use the hypervisor console device <n>. This is for
>>  			both Xen and PowerPC hypervisors.
>>  
>> +		{ null | "" }
>> +			Use to disable console output, i.e., to have kernel
>> +			console messages discarded.
>> +			This must be the first (or only) console= string
>> +			used on the kernel command line.
> 
> It must be the only console= parameter on the command line. Otherwise,
> the other consoles get enabled as well.
> 
> It might make sense to detect this situation and print a warning or
> so. Nobody has sent a patch for this so far.
> 
> But there is even bigger problem. The default console is also used
> as stdin/stdout/stderr for the init process. It might fail when there
> is no console driver associated with it.
> 
> The problem with stdin/stdout/stderr does not happen when
> CONFIG_NULL_TTY is enabled and ttynull driver is available.
> Unfortunately, it can't be enabled by default because it can
> be used by mistake, see the commit a91bd6223ecd46addc71e
> ("Revert "init/console: Use ttynull as a fallback when there
> is no console").
> 
> And there is still a mystery that has not been explained yet,
> see https://lore.kernel.org/r/a46e9a26-5b9f-f14c-26be-0b4d41fa7429@roeck-us.net
> 
> On the positive note. console=null mostly works. All the problems are
> hard to reproduce.
> 
> 
> Now, what to do with this patch. I would suggest two changes:
> 
> 1. Replace "must be the first (or only)" with "must be the only"
> 
> 2. Mention that it is suggested to enable CONFIG_NULL_TTY that
>    will avoid problems with stdin/stdout/stderr of the init process.
>    But it might cause the ttynull might be used even when a real
>    console is configured. And that more details can be found
>    in the commit a91bd6223ecd46addc71e ("Revert "init/console:
>    Use ttynull as a fallback when there is no console").
> 
>    It might be enough to mention this in the commit message.

Thanks for the history summary and suggestions.
I'll send a v2...

-- 
~Randy
