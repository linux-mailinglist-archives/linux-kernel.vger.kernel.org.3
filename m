Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CC589E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiHDPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHDPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:04:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36652FF0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659625439; x=1691161439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ukSKkk3/YC92EwP7zNPR0oYfAoK2rd3CaBCqjv6+/WQ=;
  b=tCtiAPuWKsZ3NTm3z2ZlZf9+CTzy+qtgo3j0CZS/qwP0mr1m2EQN7taB
   ZhS4JzSq4B1V+Xd4u2D32E5DR6OluH+SHHJAeq9uBBEkR6UaaiV4bqB0v
   XGdJJ/8i7hZlmsNwTGqAAWRrtg7nziGdeF3qFhFSK7ROuaux6MAgNCP+Q
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Aug 2022 08:03:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 08:03:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 4 Aug 2022 08:03:59 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 4 Aug 2022
 08:03:58 -0700
Message-ID: <a869ef99-9cc6-d3a0-ddcc-7257eac32f01@quicinc.com>
Date:   Thu, 4 Aug 2022 09:03:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: New subsystem for acceleration devices
Content-Language: en-US
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiho Chu <jiho.chu@samsung.com>
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <e9250ec3-1e29-5b38-c4eb-7e380f1eed4f@linux.intel.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <e9250ec3-1e29-5b38-c4eb-7e380f1eed4f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2022 6:00 AM, Tvrtko Ursulin wrote:
> 
> On 04/08/2022 00:54, Dave Airlie wrote:
>> On Thu, 4 Aug 2022 at 06:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
>>>
>>> On Wed, Aug 3, 2022 at 10:04 PM Dave Airlie <airlied@gmail.com> wrote:
>>>>
>>>> On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> 
>>>> wrote:
>>>>>
>>>>> Hi,
>>>>> Greg and I talked a couple of months ago about preparing a new accel
>>>>> subsystem for compute/acceleration devices that are not GPUs and I
>>>>> think your drivers that you are now trying to upstream fit it as well.
>>>>
>>>> We've had some submissions for not-GPUs to the drm subsystem recently.
>>>>
>>>> Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.
>>>>
>>>> why is creating a new subsystem at this time necessary?
>>>>
>>>> Are we just creating a subsystem to avoid the open source userspace
>>>> consumer rules? Or do we have some concrete reasoning behind it?
>>>>
>>>> Dave.
>>>
>>> Hi Dave.
>>> The reason it happened now is because I saw two drivers, which are
>>> doing h/w acceleration for AI, trying to be accepted to the misc
>>> subsystem.
>>> Add to that the fact I talked with Greg a couple of months ago about
>>> doing a subsystem for any compute accelerators, which he was positive
>>> about, I thought it is a good opportunity to finally do it.
>>>
>>> I also honestly think that I can contribute much to these drivers from
>>> my experience with the habana driver (which is now deployed in mass at
>>> AWS) and contribute code from the habana driver to a common framework
>>> for AI drivers.
>>
>> Why not port the habana driver to drm now instead? I don't get why it
>> wouldn't make sense?
>>
>> Stepping up to create a new subsystem is great, but we need rules
>> around what belongs where, we can't just spawn new subsystems when we
>> have no clear guidelines on where drivers should land.
>>
>> What are the rules for a new accel subsystem? Do we have to now
>> retarget the 3 drivers that are queued up to use drm for accelerators,
>> because 2 drivers don't?
> 
> Isn't there three on the "don't prefer drm" side as well? Habana, 
> Toshiba and Samsung? Just so the numbers argument is not misrepresented. 
> Perhaps a poll like a) prefer DRM, b) prefer a new subsystem, c) don't 
> care in principle; is in order?

I'll chime in with my opinions.  Take them for what you will.

I would say I fall into the C category, but I'm targeting DRM and will 
be the 5th(?) accel device to do so.

I'll say that the ksummit (from what I see in the LWN article) made me 
very happy.  Finally, the community had clear rules for accel drivers. 
When I targeted misc in the past, it seemed like Greg moved the goal 
post just for me, which stalled our attempt.  It was even more 
frustrating to see that the high bar Greg set for us was not applied to 
other devices of the same "class" in following submissions.

However, the past is the past, and based on ksummit, we've spent a 
number of months retargeting DRM.  In a week (or two), I plan to post 
something to start up the discussions again.

As far as the DRM userspace requirements, unless we've misunderstood 
something, they've been easier to satisfy (pending review I suppose) 
than what misc has set.

I would say that Dave Airlie's feedback on this discussion resonates 
with me.  From the perspective of a vendor wanting to be a part of the 
community, clear rules are important and ksummit seemed to set that. 
Oded's announcement has thrown all of that into the wind.  Without a 
proposal to evaluate (eg show me the code with clear guidelines), I 
cannot seriously consider Oded's idea, and I'm not sure I want to sit by 
another few years to see it settle out.

I expect to move forward with what we were planning prior to seeing this 
thread which is targeting DRM.  We'll see what the DRM folks say when 
they have something to look at.  If our device doesn't fit in DRM per an 
assessment of the DRM folks, then I sure hope they can suggest where we 
do fit because then we'll have tried misc and DRM, and not found a home. 
  Since "drivers/accel" doesn't exist, and realistically won't for a 
long time if ever, I don't see why we should consider it.

Why DRM?  We consume dma_buf and might look to p2pdma in the future. 
ksummit appears clear - we are a DRM device.  Also, someone could 
probably run openCL on our device if they were so inclined to wire it 
up.  Over time, I've come to the thinking that we are a GPU, just 
without display.  Yes, it would have helped if DRM and/or drivers/gpu 
were renamed, but I think I'm past that point.  Once you have everything 
written, it doesn't seem like it matters if the uAPI device is called 
/dev/drmX, /dev/miscX, or /dev/magic.

I will not opine on other devices as I am no expert on them.  Today, my 
opinion is that DRM is the best place for me.  We'll see where that goes.

> More to the point, code sharing is a very compelling argument if it can 
> be demonstrated to be significant, aka not needing to reinvent the same 
> wheel.
> 
> Perhaps one route forward could be a) to consider is to rename DRM to 
> something more appropriate, removing rendering from the name and 
> replacing with accelerators, co-processors, I don't know... Although I 
> am not sure renaming the codebase, character device node names and 
> userspace headers is all that feasible. Thought to mention it 
> nevertheless, maybe it gives an idea to someone how it could be done.
> 
> And b) allow the userspace rules to be considered per driver, or per 
> class (is it a gpu or not should be a question that can be answered). 
> Shouldn't be a blocker if it still matches the rules present elsewhere 
> in the kernel.
> 
> Those two would remove the two most contentions points as far as I 
> understood the thread.
> 
> Regards,
> 
> Tvrtko
> 

