Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB14EE0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiCaSoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiCaSoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:44:21 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 11:42:33 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B8235771
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:42:33 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8D26922C342
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:36:20 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 171B92A0070;
        Thu, 31 Mar 2022 18:36:19 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF8F36800B0;
        Thu, 31 Mar 2022 18:36:18 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2AC8413C2B1;
        Thu, 31 Mar 2022 11:36:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2AC8413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1648751778;
        bh=7tfGHrlAnRgG/rLJYtABw1GI3id/djlcHI+xb4+pfNc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KR4/jyXErLL5Rb8fsTDTHx5Ra99AVrMavG4NeS/BUib92Wmcl5Ay4mRss3YjGWO0F
         /qkcJfJciQnv5itw6rs08016zG3MWlrni66XuqlXf4uBvHb6FzI4qGMXBH5BH2ul9C
         Mehdmy1yFKP4RfDt4HkXScKoXcfsTazR44h+Tz7Q=
Subject: Re: Kernel panic - not syncing: Attempted to kill init!
 exitcode=0x00007f00 since 5.17
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bbf2d268-a93d-afdc-a836-0fdb878be10e@candelatech.com>
 <20220331034343.GC23200@1wt.eu>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <794a9c23-d3b9-c454-8f78-760060f0b9f2@candelatech.com>
Date:   Thu, 31 Mar 2022 11:36:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220331034343.GC23200@1wt.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1648751779-uDdA1DL08JXg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 8:43 PM, Willy Tarreau wrote:
> Hi Ben,
> 
> On Wed, Mar 30, 2022 at 02:27:56PM -0700, Ben Greear wrote:
>> Run /init as init process
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>> /init: error whitsc: Refined TSC clocksource calibration: 2903.996 MHz
>> le loading shareCPU: 2 PID: 1 Comm: init Not tainted 5.17.0+ #12
>> d libraries: libclocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc020bb13, max_idle_ns: 440795273180 ns
>> rt.so.1: cannot Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>> open shared objeCall Trace:
>> ct file: No such <TASK>
>>   file or directo dump_stack_lvl+0x47/0x5c
>> ry
> 
> The coincidence between this error about your userland "libclocksource"
> and the messages about the clock sources being refined makes me wonder
> if there could be an error experienced during this lib's initialization
> at a moment where the list of clocksources appears empty or opening one
> of the /sys file is temporarily refused. I suspect that making a much
> larger or much smaller initrd could change the initialization order
> enough to prevent such an event from happening, but that sounds a bit
> odd :-/
> 
> Willy

For whatever reason, it was quite reproducible yesterday.  I notice that it
often (50+% of the time) failed on soft reboot, but I don't think it failed
a single time when I then went and powered it down fully and powered it back on.

So possibly it is some un-initialized memory somewhere that is exacerbating
some problem.

I will keep a watch on these errors and see if they always related to libclocksource.
Looks like 'rt.so.1' is what it cannot find though?  So maybe nothing particular to
do with /sys?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

