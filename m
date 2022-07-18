Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67F578527
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiGRORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:17:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC310D13C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:17:37 -0700 (PDT)
Received: from [IPV6:2804:14c:137:a261:c39e:574c:1421:5266] (unknown [IPv6:2804:14c:137:a261:c39e:574c:1421:5266])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: padovan)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 066CA66019FD;
        Mon, 18 Jul 2022 15:17:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658153856;
        bh=X11xN3vFeOABvtsJsmWIq8i6v0cajRPr7dedlaIvdFg=;
        h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
        b=CByK9J/lZ+P6iDBQAxV1B78VKGCAMsbWeABFLGrCqNQzRKO21Im/UOWLohSzQwNI2
         2K1/bnSPTmJ6ZIdcVvAnkFps4LH83T2davXI2qnztcEICf/2YFLLesm5OKD5vgJqJ/
         Bn+ZqNoftfdB4kI6JalY1RVCtXsvG5/Fp29qEr6SNO6bF0MYbrzFgGbmM+fAEV+DUZ
         VXUL+T79xKRZikRQWMEC6XMyREy4sYHbJkaQOTnN/NlHpiCm3XKrrkffi1qB9KBAi3
         x+Utt5HJUwH+Rc9NA2w7l3D6fsDPq2PlsUVMtZ53+tykhcBoenwZ5osXU36dQqr0Xw
         9dYHoy3M7ihXg==
Message-ID: <3bbebb1b-c205-e789-d37e-6d016260685c@collabora.com>
Date:   Mon, 18 Jul 2022 11:17:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [kernelci-members] KernelCI working group: Web Dashboard
Content-Language: en-US
From:   Gustavo Padovan <gustavo.padovan@collabora.com>
To:     kernelci-members@groups.io,
        "kernelci@groups.io" <kernelci@groups.io>
Cc:     automated-testing@lists.yoctoproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>,
        Simon Xiao <sixiao@microsoft.com>,
        Carlos Cardenas <Carlos.Cardenas@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sharath George John <sgeorgejohn@microsoft.com>,
        "Alain Gefflaut (HE/HIM)" <agefflaut@microsoft.com>,
        Johnson George <Johnson.George@microsoft.com>
Reply-To: kernelci-members@groups.io
References: <f3874e7d-ccfe-4a2d-d054-9b7bf9e8b44d@collabora.com>
 <16F4479F76A8C807.11895@groups.io> <16F65ECD601264EC.15470@groups.io>
In-Reply-To: <16F65ECD601264EC.15470@groups.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

In our last Web Dashboard meeting[1] where we reviewed the User Stories 
document[2]. Then, after that we worked offline to incorporate the 
feedback on doc, so it is time for our next meeting to further discuss. 
Please answer the poll with your time availability on the link below. I 
added dates from 21th to 28th of July.

https://doodle.com/meeting/participate/id/eX6vyY5b

Thank you,

Gus
—
[1]https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#bookmark=id.6ok0ufne9shj
[2]https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit#heading=h.wjoxi4s5pxzl 


On 6/7/22 10:46, Gustavo Padovan wrote:
>
> Hello,
>
> Our next meeting has been scheduled for this Thursday at 3pm UTC. 
> Invite was sent to the kernelci-members list, but here goes the 
> instructions to join as well:
>
> This event has a video call.
> Join: https://meet.google.com/yyz-jzjy-yfu
> (US) +1 254-227-6870 PIN: 188509910#
> View more phone numbers: 
> https://tel.meet/yyz-jzjy-yfu?pin=5882595078642&hs=7
>
> Regards,
>
> Gustavo
>
> Le 31/05/2022 à 15:34, Gustavo Padovan a écrit :
>>
>> Hello everyone,
>>
>> **
>>
>> *From our first meeting back in October[1], we took the action of 
>> organizing our user stories that you were spread as a comments in the 
>> the github issue{2} and, converting them into User Stories document[3].*
>>
>> *
>>
>> In the next meeting, we want to study the current User Stories and 
>> start discussions to progress on development. The proposed slots are 
>> for next week. Please answer the doodle by the end of this week:
>>
>> https://doodle.com/meeting/participate/id/egJ12A9d
>>
>> Best regards,
>>
>> Gustavo
>>
>> [1] 
>> https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit# 
>> <https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#>
>>
>> [2] https://github.com/kernelci/kernelci-project/discussions/28 
>> <https://github.com/kernelci/kernelci-project/discussions/28>
>>
>> {3} 
>> https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit 
>> <https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit>* 
>>
>> Le 27/07/2021 à 11:54, Guillaume Tucker a écrit :
>>> Last year's KernelCI Community Survey[1] showed the importance of
>>> having a good web dashboard.  About 70% of respondents would use
>>> one if it provided the information they needed efficiently.
>>> While other things are arguably even more important, such as
>>> testing patches from mailing lists, replying to stable reviews
>>> and sending email reports directly to contributors in a "natural"
>>> workflow, the web dashboard has been a sticking point for a
>>> while.
>>>
>>> There have been several attempts at solving this problem, using
>>> Elastic Stack and Grafana among other things, but there isn't a
>>> single framework able to directly provide an off-the-shelf
>>> solution to the community's needs.  In fact, the first issue is
>>> the lack of understanding of these needs: who wants to use the
>>> web dashboard, and how?  Then, how does one translate those needs
>>> into a user interface?  Doing this requires skills that engineers
>>> who regularly contribute to KernelCI typically don't have.  As
>>> such, a dedicated working group is being created in order to fill
>>> this gap.
>>>
>>> The aim is to coordinate efforts and try to follow best practices
>>> to make steady progress and avoid repeating the same mistakes.
>>> Most likely, we will need some help from proper web developers
>>> who aren't part of the usual KernelCI community.  This may be
>>> facilitated by the KernelCI LF project budget if approved by the
>>> governing board.
>>>
>>> In order to get started, we would need to have maybe 3 to 5
>>> people available to focus on this.  It doesn't necessarily mean a
>>> lot of hours spent but actions to be carried out on a daily or
>>> weekly basis.  So far we have Gustavo Padovan as our new KernelCI
>>> Project Manager and a few people have expressed interest but we
>>> still need formal confirmation.
>>>
>>>
>>> Here's a GitHub project dedicated to the new web dashboard:
>>>
>>>    https://github.com/orgs/kernelci/projects/4
>>>
>>> I've created a couple of issues to get started about user
>>> stories, and some initial milestones as a basic skeleton:
>>>
>>>    https://github.com/kernelci/kernelci-project/milestones
>>>
>>>
>>> This is ultimately a community-driven effort to address the needs
>>> of the kernel community.  Please share any thoughts you may have
>>> on this, whether you want to add some user stories, share some
>>> expertise, be officially in the working group or take part in
>>> this effort in any other way.
>>>
>>> Best wishes,
>>> Guillaume
>>>
>>> [1]https://foundation.kernelci.org/blog/2020/07/09/kernelci-community-survey-report/
>>>
>>>
>>>
>>>
>>>
> _._,_._,_
> ------------------------------------------------------------------------
> Groups.io Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#404) 
> <https://groups.io/g/kernelci-members/message/404> | Reply To Group 
> <mailto:kernelci-members@groups.io?subject=Re:%20Re%3A%20%5Bkernelci-members%5D%20KernelCI%20working%20group%3A%20Web%20Dashboard> 
> | Reply To Sender 
> <mailto:gustavo.padovan@collabora.com?subject=Private:%20Re:%20Re%3A%20%5Bkernelci-members%5D%20KernelCI%20working%20group%3A%20Web%20Dashboard> 
> | Mute This Topic <https://groups.io/mt/84484922/6162449> | New Topic 
> <https://groups.io/g/kernelci-members/post>
> Your Subscription 
> <https://groups.io/g/kernelci-members/editsub/6162449> | Contact Group 
> Owner <mailto:kernelci-members+owner@groups.io> | Unsubscribe 
> <https://groups.io/g/kernelci-members/leave/10351275/6162449/983346018/xyzzy> 
> [gustavo.padovan@collabora.com]
>
> _._,_._,_

-- 
Gustavo Padovan
Kernel team Lead

Collabora Ltd.
Platinum Building, St John's Innovation Park
Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

