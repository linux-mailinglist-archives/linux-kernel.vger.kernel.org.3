Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF95A6BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiH3SIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiH3SI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:08:29 -0400
Received: from p3plwbeout26-03.prod.phx3.secureserver.net (p3plsmtp26-03-2.prod.phx3.secureserver.net [216.69.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E819D7AC23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:08:27 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id T5exoqiHwUn6tT5eyoW1tx; Tue, 30 Aug 2022 11:08:24 -0700
X-CMAE-Analysis: v=2.4 cv=b9V3XvKx c=1 sm=1 tr=0 ts=630e521a
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=biHskzXt2R4A:10 a=QyXUC8HyAAAA:8
 a=jgZ1YHje5GoJlr7bozsA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  T5exoqiHwUn6t
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp07.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oT5ew-0003UF-M4; Tue, 30 Aug 2022 19:08:23 +0100
Message-ID: <74fb0469-e593-ed0e-3f9b-5ec535969c78@squashfs.org.uk>
Date:   Tue, 30 Aug 2022 19:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: ping //Re: [PATCH v2 0/2] squashfs: Add the mount parameter
 "threads="
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org
Cc:     wangle6@huawei.com, yi.zhang@huawei.com, wangbing6@huawei.com,
        zhongjubin@huawei.com, chenjianguo3@huawei.com
References: <20220815031100.75243-1-nixiaoming@huawei.com>
 <20220816010052.15764-1-nixiaoming@huawei.com>
 <8d139f03-7845-9c96-fffc-74fdf8b5d78d@huawei.com>
 <60b24133-234f-858b-8e71-e183fe72d2bb@squashfs.org.uk>
 <9c5bddc3-fc93-d76a-1163-0278c8d31dc5@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <9c5bddc3-fc93-d76a-1163-0278c8d31dc5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfGO7VA9pQTxtgo8Nd9/r6iz5C4bUiYW9YnYQz8qXqzgg+soqw+Uqh/N64GjTGvGm3lEwJ06hNnHCAikXxT2l1A66LUXdc/3rq8ISQgUMGDxcTyVphK+F
 GAXrnuZw5pN7DzUH0zpa+6jokwk+UZ2C6FoQoc1x3djS0qlxH+RT6pRoAvsBXgisVqdveLA5+98+NqCdd8C4pq/JHVQp7cgH980=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 14:38, Xiaoming Ni wrote:
> On 2022/8/29 7:18, Phillip Lougher wrote:
>> On 26/08/2022 07:19, Xiaoming Ni wrote:
>>> ping
>>>
>>>
>>> On 2022/8/16 9:00, Xiaoming Ni wrote:
>>>> Currently, Squashfs supports multiple decompressor parallel modes. 
>>>> However, this
>>>> mode can be configured only during kernel building and does not 
>>>> support flexible
>>>> selection during runtime.
>>>>
>>>> In the current patch set, the mount parameter "threads=" is added to 
>>>> allow users
>>>> to select the parallel decompressor mode and configure the number of 
>>>> decompressors
>>>> when mounting a file system.
>>>>
>>>> v2: fix warning: sparse: incorrect type in initializer (different 
>>>> address spaces)
>>>>    Reported-by: kernel test robot <lkp@intel.com>
>>
>> I have made an initial review of the patches, and I have the following
>> comments.
>>
>> Good things about the patch-series.
>>
>> 1. In principle I have no objections to making this configurable at
>>     mount time.  But, a use-case for why this has become necessary
>>     would help in the evaluation.
>>
>> 2. In general the code changes are good.  They are predominantly
>>     exposing the existing different decompressor functionality into
>>     structures which can be selected at mount time.  They do not
>>     change existing functionality, and so there are no issues
>>     about unexpected regressions.
>>
>> Things which I don't like about the patch-series.
>>
>> 1. There is no default kernel configuration option to keep the existing
>>     behaviour, that is build time selectable only.  There may be many
>>     companies/people where for "security" reasons the ability to
>>     switch to a more CPU/memory intensive decompressor or more threads
>>     is a risk.
>>
>>     Yes, I know the new kernel configuration options allow only the
>>     selected default decompressor mode to be built.  In theory that
>>     will restrict the available decompressors to the single decompressor
>>     selected at build time.  So not much different to the current
>>     position?  But, if the CONFIG_SQUASHFS_DECOMP_MULTI decompressor
>>     is selected, that will now allow more threads to be used than is
> No more threads than before the patch.
> 
>>     current, where it is currently restricted to num_online_cpus() * 2.
> After the patch is installed, the maximum number of threads is still 
> num_online_cpus() * 2.
> 
> [PATCH v2 2/2] squashfs: Allows users to configure the number of 
> decompression threads
> 
> +#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
> +    opts->thread_ops = &squashfs_decompressor_multi;
> +    if (num > opts->thread_ops->max_decompressors())
> +        num = opts->thread_ops->max_decompressors();
> +    opts->thread_num = (int)num;
> +    return 0;
> +#else
> 

I missed that the maximum number of threads is still limited
to num_online_cpus() * 2.

You should make it clear in the patch commit message what the
thread maximum is (and that it is unchanged).

This means some of my reservations go away.

>>
>> 2. You have decided to allow the mutiple decompressor implementations
>>     to be selected at mount time - but you have also allowed only one
>>     decompressor to be built at kernel build time.  This means you
>>     end up in the fairly silly situation of having a mount time
>>     option which allows the user to select between one decompressor.
>>     There doesn't seem much point in having an option which allows
>>     nothing to be changed.
> When multiple decompression modes are selected during kernel build, or 
> only SQUASHFS_DECOMP_MULTI is selected during kernel build, the mount 
> parameter "threads=" is meaningful,
> However, when only SQUASHFS_DECOMP_SINGLE or 
> SQUASHFS_DECOMP_MULTI_PERCPU is selected, the mount parameter "threads=" 
> is meaningless.
> 
> Thank you for your guidance
> 
> 
>>
>> 3. Using thread=<number>, where thread=1 you use SQUASHFS_DECOMP_SINGLE
>>     if it has been built, otherwise you fall back to
>>     SQUASHFS_DECOMP_MULTI.  This meants the effect of thread=1 is
>>     indeterminate and depends on the build options.  I would suggest
>>     thread=1 should always mean use SQUASHFS_DECOMP_SINGLE.
> 
> SQUASHFS_DECOMP_MULTI and SQUASHFS_DECOMP_SINGLE are selected during 
> construction. Thread=1 indicates that SQUASHFS_DECOMP_SINGLEI is used.
> 
> If only SQUASHFS_DECOMP_MULTI is selected during construction, thread=1 
> indicates that SQUASHFS_DECOMP_MULTI is used, and only one decompression 
> thread is created.

That is wrong.  It violates the principles of KISS (keep it simple) and 
least surprise.

I will spell it out for you.

thread=1 meaning either SQUASHFS_DECOMP_SINGLE or SQUASHFS_DECOMP_MULTI
depending on the built, adds an ambiguity which cannot be determined
unless you know how the kernel was built.  This violates KISS.

SQUASHFS_DECOMP_MULTI is for parallel decompression - it's in the name.
Over-loading it to do single decompression again violates KISS and
it also violates the principle of least suprise.  Many people will not
think single decompression should be possible with only 
SQUASHFS_DECOMP_MULTI built in.

SQUASHFS_DECOMP_SINGLE is for doing single decompression - again it's in 
the name.

So

SQUASHFS_DECOMP_MULTI for threads >= 2
SQUASHFS_DECOMP_SINGLE for thread = 1

This keeps it simple and follows the principle of least suprise.

If you want single threaded operation as a choice, then build the 
SQUASHFS_DECOMP_SINGLE decompressor.

> 
> Would it be better to provide more flexible mount options for images 
> that build only SQUASHFS_DECOMP_MULTI?
>  >> 4. If SQUASHFS_DECOMP_MULTI is selected, there isn't a limit on the
>>     maximum amount of threads allowed, and there is no ability to
>>     set the maximum number of threads allowed at kernel build time
>>     either.
> After the patch is installed, the maximum number of threads is still 
> num_online_cpus() * 2.
> 
> [PATCH v2 2/2] squashfs: Allows users to configure the number of 
> decompression threads
> 
> +#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
> +    opts->thread_ops = &squashfs_decompressor_multi;
> +    if (num > opts->thread_ops->max_decompressors())
> +        num = opts->thread_ops->max_decompressors();
> +    opts->thread_num = (int)num;
> +    return 0;
> 
> Did I misunderstand your question?
> 
> 
>>
>> All of the above seems to be a bit of a mess.
>>
>> As regards points 1 - 3, personally I would add a default kernel
>> configuration option that keeps the existing behaviour, build time
>> selectable only, no additional mount time options.  Then a
>> kernel configuration option that allows the different decompressors
>> to be selected at mount time, but which always builds all the
>> decompressors.  This will avoid the silliness of point 2, and
> Would it be better to allow flexible selection of decompression mode 
> combinations?

I told you I don't like that (*).  I also told you I want the default 
behaviour to be the current behaviour.

Feel free to disagree, but that isn't a good way to get your patch
reviewed or accepted by me.

Cheers

Phillip

(*) Adding options to select the decompressor at mount time, but,
     also allowing only 1 - 2 decompressors to be built is a waste of
     time.  It has the effect of giving something with one hand and
     taking it alway with the other.  Build the lot, this also
     keeps it simple.


