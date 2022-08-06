Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E458B5AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 15:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHFNBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiHFNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 09:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E832624
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 06:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3D160FF8
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F60C433C1;
        Sat,  6 Aug 2022 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659790872;
        bh=5peAmtKMXJyhjk3Ikcna/7MxHype35JlKnLitLn80H0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fF+eCnZNW3CsOsJJXyywZX8EKpjpJqDhMzQwrZL4AMvPqx4xTGj1Ln6Ja9fOLRx/8
         HMiPRhheDdGS17Ak0Ej3iTWxkKjQ3J5hysokQD/RN8w7z5RVGYMZ1qREoN9H0rXYAW
         11MZZxYi/nr4S+zivK44Vrbyagu1n5ashUVCjdGoA0dtZNSiRDGneQCA0pfTqDQ0up
         gnxh5mHNufA4MEwoyTGyRtavlhMvFtoVdv2k10LtLPBhryT/JoDJ68t//C840si2aP
         mPl4bsI+6k7NUngrPHb/MsjHN74hl12EXiAdrGJPU6pqAeuhCZaK0oPH8p+9R2Pzh1
         OXvQl0ccHBXJA==
Message-ID: <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
Date:   Sat, 6 Aug 2022 15:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
References: <20220803104936.7df810fd@gandalf.local.home>
 <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
 <20220805124701.4b44195d@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220805124701.4b44195d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 18:47, Steven Rostedt wrote:
> On Fri, 5 Aug 2022 09:40:25 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Wed, Aug 3, 2022 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> Changes to RTLA:  
>>
>> Btw, I note that the error messages for missing libraries got fixed
>> (already some time ago, not this pull), but didn't get around to
>> actually building until now.
>>
>> It says to do
>>
>>     e.g., 'dnf install libtraceevent' on Fedora
>>
>> but it's actually the devel packages that are needed for building, not
>> the bare libraries.

right!

>> So it should be libtraceevent-devel, and libtracefs-devel.
> 
> Thanks for the report (I obviously have them installed, and thus didn't see
> this :-/). Not to mention, I always forget to add the -dev/-devel appendix
> to my packages.
> 
> Daniel,
> 
> Can you send a fix?

Yes, I will do that. I will also do minimal fedora install and cross-check this further.

Thanks!
-- Daniel
