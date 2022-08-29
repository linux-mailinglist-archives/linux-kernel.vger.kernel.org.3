Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC95A4FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiH2PEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiH2PEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:04:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451458D3D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:04:31 -0700 (PDT)
Received: from [192.168.42.144] (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: padovan)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A4BC660036C;
        Mon, 29 Aug 2022 16:04:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661785470;
        bh=zQrJBqu8D8yQ6EMK5HMuX9D6RuD9Hr5OLic3O4LfX+E=;
        h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
        b=AE0JegUBQW9as0diIv4K376AHI9UFKcIKpZR5xdphx5y6Vahi+m7w4rFd2c6rSeKC
         6TqmdsUPDMfwfsMGf+XgJWl2uFi3pcQNKWtHX4YOxN8BIpvjEKgdX9aBuH7SKfcTO+
         6K79H58UApaw6K1Zkokk15dKQD9Tf7yfkWr+Pa/Ffqdh+wgWto9KeeQNoRSc3wXca3
         a0BVpMbgVqxvEMpgbnwaPwqZpUZOt+zLcXJCaukMlNUMUZUEL5kEugbGpVlwO9FXjC
         ZxXKV5i7NsDjQjKEKJeK4k0JNBCjy4G2+8/aB8w4g0DzT6cbxQ6QLonUtSeTheC4yj
         xKyTDLqv5RCOA==
Message-ID: <ce17e20b-b60d-baaf-15af-1e3c8157df7b@collabora.com>
Date:   Mon, 29 Aug 2022 11:04:26 -0400
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
 <1706557437ACCB9C.25939@groups.io>
In-Reply-To: <1706557437ACCB9C.25939@groups.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The previous tentative below didn't work due to vacation season. Here's 
a new pool with dates from 1st to 8th of September. Please answer it 
until this Wednesday August 31th.

https://doodle.com/meeting/participate/id/dG5v423a

See the email below for meetings notes and current User Stories document.

Regards,

Gustavo

On 7/18/22 10:17, Gustavo Padovan wrote:
> Hi everyone,
>
> In our last Web Dashboard meeting[1] where we reviewed the User 
> Stories document[2]. Then, after that we worked offline to incorporate 
> the feedback on doc, so it is time for our next meeting to further 
> discuss. Please answer the poll with your time availability on the 
> link below. I added dates from 21th to 28th of July.
>
> https://doodle.com/meeting/participate/id/eX6vyY5b
>
> Thank you,
>
> Gus
> —
> [1]https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#bookmark=id.6ok0ufne9shj 
>
> [2]https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit#heading=h.wjoxi4s5pxzl 
>
>
> On 6/7/22 10:46, Gustavo Padovan wrote:
>>
>> Hello,
>>
>> Our next meeting has been scheduled for this Thursday at 3pm UTC. 
>> Invite was sent to the kernelci-members list, but here goes the 
>> instructions to join as well:
>>
>> This event has a video call.
>> Join: https://meet.google.com/yyz-jzjy-yfu
>> (US) +1 254-227-6870 PIN: 188509910#
>> View more phone numbers: 
>> https://tel.meet/yyz-jzjy-yfu?pin=5882595078642&hs=7
>>
>> Regards,
>>
>> Gustavo
>>
>> Le 31/05/2022 à 15:34, Gustavo Padovan a écrit :
>>>
>>> Hello everyone,
>>>
>>> **
>>>
>>> *From our first meeting back in October[1], we took the action of 
>>> organizing our user stories that you were spread as a comments in 
>>> the the github issue{2} and, converting them into User Stories 
>>> document[3].*
>>>
>>> *
>>>
>>> In the next meeting, we want to study the current User Stories and 
>>> start discussions to progress on development. The proposed slots are 
>>> for next week. Please answer the doodle by the end of this week:
>>>
>>> https://doodle.com/meeting/participate/id/egJ12A9d
>>>
>>> Best regards,
>>>
>>> Gustavo
>>>
>>> [1] 
>>> https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit# 
>>> <https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#> 
>>>
>>>
>>> [2] https://github.com/kernelci/kernelci-project/discussions/28 
>>> <https://github.com/kernelci/kernelci-project/discussions/28>
>>>
>>> {3} 
>>> https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit 
>>> <https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit>* 
>>>
>>> Le 27/07/2021 à 11:54, Guillaume Tucker a écrit :
>>>> Last year's KernelCI Community Survey[1] showed the importance of
>>>> having a good web dashboard.  About 70% of respondents would use
>>>> one if it provided the information they needed efficiently.
>>>> While other things are arguably even more important, such as
>>>> testing patches from mailing lists, replying to stable reviews
>>>> and sending email reports directly to contributors in a "natural"
>>>> workflow, the web dashboard has been a sticking point for a
>>>> while.
>>>>
>>>> There have been several attempts at solving this problem, using
>>>> Elastic Stack and Grafana among other things, but there isn't a
>>>> single framework able to directly provide an off-the-shelf
>>>> solution to the community's needs.  In fact, the first issue is
>>>> the lack of understanding of these needs: who wants to use the
>>>> web dashboard, and how?  Then, how does one translate those needs
>>>> into a user interface?  Doing this requires skills that engineers
>>>> who regularly contribute to KernelCI typically don't have. As
>>>> such, a dedicated working group is being created in order to fill
>>>> this gap.
>>>>
>>>> The aim is to coordinate efforts and try to follow best practices
>>>> to make steady progress and avoid repeating the same mistakes.
>>>> Most likely, we will need some help from proper web developers
>>>> who aren't part of the usual KernelCI community.  This may be
>>>> facilitated by the KernelCI LF project budget if approved by the
>>>> governing board.
>>>>
>>>> In order to get started, we would need to have maybe 3 to 5
>>>> people available to focus on this.  It doesn't necessarily mean a
>>>> lot of hours spent but actions to be carried out on a daily or
>>>> weekly basis.  So far we have Gustavo Padovan as our new KernelCI
>>>> Project Manager and a few people have expressed interest but we
>>>> still need formal confirmation.
>>>>
>>>>
>>>> Here's a GitHub project dedicated to the new web dashboard:
>>>>
>>>>    https://github.com/orgs/kernelci/projects/4
>>>>
>>>> I've created a couple of issues to get started about user
>>>> stories, and some initial milestones as a basic skeleton:
>>>>
>>>>    https://github.com/kernelci/kernelci-project/milestones
>>>>
>>>>
>>>> This is ultimately a community-driven effort to address the needs
>>>> of the kernel community.  Please share any thoughts you may have
>>>> on this, whether you want to add some user stories, share some
>>>> expertise, be officially in the working group or take part in
>>>> this effort in any other way.
>>>>
>>>> Best wishes,
>>>> Guillaume
>>>>
>>>> [1]https://foundation.kernelci.org/blog/2020/07/09/kernelci-community-survey-report/ 
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>
>

-- 
Gustavo Padovan

Collabora Ltd.
Platinum Building, St John's Innovation Park
Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

