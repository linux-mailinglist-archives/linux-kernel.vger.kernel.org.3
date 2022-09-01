Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5D5AA000
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiIATcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIATcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:32:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744E7C533
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:32:12 -0700 (PDT)
Received: from [10.0.0.188] (modemcable081.74-201-24.mc.videotron.ca [24.201.74.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: padovan)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5792B6601EAE;
        Thu,  1 Sep 2022 20:32:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662060730;
        bh=aXFkSTUVr6ByaFtV0pFOjl80AzhsvEdHaE/OzpeLp3s=;
        h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
        b=CztI3Ro8Nm2RdCuyAtaSpXl7CLARJjE/e7KyynFYV5u+Q4hempnzsg6tRDSyHloMx
         k/7AWY7kZXXFB0cCkBBv+UgcBN63qDAPMHVQbF0Rphi91fOsg9ZMutm5A4ApU6MXn5
         bK/3uAXvhCoV3G2NIFb7Eb8KtAllshFPO3N70UsINtgZWgOcNe06pOElqXVvFW7iL1
         Gvm9am9xYnqNHtiuxZVcLyaATJjfsakdMsS/fq1lWTqBBA22tLRT08sGOAQi5Ed/qV
         ixHUSHl1Af/YSWVG9HstNsq7CGFd9aBJ+3wu3/6W8Xjf7heQJwBFKH6GCgsNf1KnO0
         EFw7o50zaTFvw==
Content-Type: multipart/mixed; boundary="------------9zxYN0ml4XwR0YZdYFUfBlf6"
Message-ID: <3116ef32-140a-88a7-e929-98eaf2f3f357@collabora.com>
Date:   Thu, 1 Sep 2022 15:32:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
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
 <1706557437ACCB9C.25939@groups.io> <170FD91B51709B41.16609@groups.io>
Organization: Collabora Ltd.
In-Reply-To: <170FD91B51709B41.16609@groups.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9zxYN0ml4XwR0YZdYFUfBlf6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

The next meeting is next Monday September 5th at 12:00pm EDT. Invite 
sent to those who answered the poll and the the members and tsc mailing 
list. In any invite ics is attached.

Best regards,

Gustavo

Le 29/08/2022 à 11:04, Gustavo Padovan a écrit :
> Hello,
>
> The previous tentative below didn't work due to vacation season. 
> Here's a new pool with dates from 1st to 8th of September. Please 
> answer it until this Wednesday August 31th.
>
> https://doodle.com/meeting/participate/id/dG5v423a
>
> See the email below for meetings notes and current User Stories document.
>
> Regards,
>
> Gustavo
>
> On 7/18/22 10:17, Gustavo Padovan wrote:
>> Hi everyone,
>>
>> In our last Web Dashboard meeting[1] where we reviewed the User 
>> Stories document[2]. Then, after that we worked offline to 
>> incorporate the feedback on doc, so it is time for our next meeting 
>> to further discuss. Please answer the poll with your time 
>> availability on the link below. I added dates from 21th to 28th of July.
>>
>> https://doodle.com/meeting/participate/id/eX6vyY5b
>>
>> Thank you,
>>
>> Gus
>> —
>> [1]https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#bookmark=id.6ok0ufne9shj 
>>
>> [2]https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit#heading=h.wjoxi4s5pxzl 
>>
>>
>> On 6/7/22 10:46, Gustavo Padovan wrote:
>>>
>>> Hello,
>>>
>>> Our next meeting has been scheduled for this Thursday at 3pm UTC. 
>>> Invite was sent to the kernelci-members list, but here goes the 
>>> instructions to join as well:
>>>
>>> This event has a video call.
>>> Join: https://meet.google.com/yyz-jzjy-yfu
>>> (US) +1 254-227-6870 PIN: 188509910#
>>> View more phone numbers: 
>>> https://tel.meet/yyz-jzjy-yfu?pin=5882595078642&hs=7
>>>
>>> Regards,
>>>
>>> Gustavo
>>>
>>> Le 31/05/2022 à 15:34, Gustavo Padovan a écrit :
>>>>
>>>> Hello everyone,
>>>>
>>>> **
>>>>
>>>> *From our first meeting back in October[1], we took the action of 
>>>> organizing our user stories that you were spread as a comments in 
>>>> the the github issue{2} and, converting them into User Stories 
>>>> document[3].*
>>>>
>>>> *
>>>>
>>>> In the next meeting, we want to study the current User Stories and 
>>>> start discussions to progress on development. The proposed slots 
>>>> are for next week. Please answer the doodle by the end of this week:
>>>>
>>>> https://doodle.com/meeting/participate/id/egJ12A9d
>>>>
>>>> Best regards,
>>>>
>>>> Gustavo
>>>>
>>>> [1] 
>>>> https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit# 
>>>> <https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#> 
>>>>
>>>>
>>>> [2] https://github.com/kernelci/kernelci-project/discussions/28 
>>>> <https://github.com/kernelci/kernelci-project/discussions/28>
>>>>
>>>> {3} 
>>>> https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit 
>>>> <https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit>* 
>>>>
>>>> Le 27/07/2021 à 11:54, Guillaume Tucker a écrit :
>>>>> Last year's KernelCI Community Survey[1] showed the importance of
>>>>> having a good web dashboard.  About 70% of respondents would use
>>>>> one if it provided the information they needed efficiently.
>>>>> While other things are arguably even more important, such as
>>>>> testing patches from mailing lists, replying to stable reviews
>>>>> and sending email reports directly to contributors in a "natural"
>>>>> workflow, the web dashboard has been a sticking point for a
>>>>> while.
>>>>>
>>>>> There have been several attempts at solving this problem, using
>>>>> Elastic Stack and Grafana among other things, but there isn't a
>>>>> single framework able to directly provide an off-the-shelf
>>>>> solution to the community's needs.  In fact, the first issue is
>>>>> the lack of understanding of these needs: who wants to use the
>>>>> web dashboard, and how?  Then, how does one translate those needs
>>>>> into a user interface?  Doing this requires skills that engineers
>>>>> who regularly contribute to KernelCI typically don't have. As
>>>>> such, a dedicated working group is being created in order to fill
>>>>> this gap.
>>>>>
>>>>> The aim is to coordinate efforts and try to follow best practices
>>>>> to make steady progress and avoid repeating the same mistakes.
>>>>> Most likely, we will need some help from proper web developers
>>>>> who aren't part of the usual KernelCI community.  This may be
>>>>> facilitated by the KernelCI LF project budget if approved by the
>>>>> governing board.
>>>>>
>>>>> In order to get started, we would need to have maybe 3 to 5
>>>>> people available to focus on this.  It doesn't necessarily mean a
>>>>> lot of hours spent but actions to be carried out on a daily or
>>>>> weekly basis.  So far we have Gustavo Padovan as our new KernelCI
>>>>> Project Manager and a few people have expressed interest but we
>>>>> still need formal confirmation.
>>>>>
>>>>>
>>>>> Here's a GitHub project dedicated to the new web dashboard:
>>>>>
>>>>>    https://github.com/orgs/kernelci/projects/4
>>>>>
>>>>> I've created a couple of issues to get started about user
>>>>> stories, and some initial milestones as a basic skeleton:
>>>>>
>>>>>    https://github.com/kernelci/kernelci-project/milestones
>>>>>
>>>>>
>>>>> This is ultimately a community-driven effort to address the needs
>>>>> of the kernel community.  Please share any thoughts you may have
>>>>> on this, whether you want to add some user stories, share some
>>>>> expertise, be officially in the working group or take part in
>>>>> this effort in any other way.
>>>>>
>>>>> Best wishes,
>>>>> Guillaume
>>>>>
>>>>> [1]https://foundation.kernelci.org/blog/2020/07/09/kernelci-community-survey-report/ 
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>
>
--------------9zxYN0ml4XwR0YZdYFUfBlf6
Content-Type: text/calendar; charset=UTF-8; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFy
IDcwLjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6
UkVRVUVTVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjIwOTA1VDE2MDAwMFoNCkRURU5E
OjIwMjIwOTA1VDE3MDAwMFoNCkRUU1RBTVA6MjAyMjA5MDFUMTkyOTA0Wg0KT1JHQU5JWkVS
O0NOPWtlcm5lbCBib3Q6bWFpbHRvOmJvdEBrZXJuZWxjaS5vcmcNClVJRDo1OWUxMzRhNXY4
MTF0cGxxcHIxajhjMmdjbkBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWd1aWxsYXVtZS50dWNrZXJAY29sbGFib3JhLmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86Z3VpbGxhdW1lLnR1Y2sNCiBlckBjb2xsYWJvcmEuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtS
U1ZQPVRSVUUNCiA7Q049a2VybmVsIGJvdDtYLU5VTS1HVUVTVFM9MDptYWlsdG86Ym90QGtl
cm5lbGNpLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1raGlsbWFuQGJh
eWxpYnJlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a2hpbG1hbkBiYXlsaWJyZS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bmlrb2xhaS5rb25kcmFzaG92QHJl
ZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm5pa29sYWkua29uZHJhcw0KIGhvdkBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtlcm5lbGNpLXRz
Y0Bncm91cHMuaW87WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtlcm5lbGNpLXRzY0Bncm91cHMu
aW8NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049a2VybmVsY2ktbWVtYmVyc0Bn
cm91cHMuaW87WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtlcm5lbGNpLW1lbWJlcnNAZw0KIHJv
dXBzLmlvDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWpvaG5zb24uZ2Vvcmdl
QG1pY3Jvc29mdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpvaG5zb24uZ2VvcmdlQG0N
CiBpY3Jvc29mdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZGVueXMu
ZkBjb2xsYWJvcmEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkZW55cy5mQGNvbGxhYm9y
YS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Z3VzdGF2by5wYWRvdmFu
QGNvbGxhYm9yYS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmd1c3Rhdm8ucGFkb3Zhbg0K
IEBjb2xsYWJvcmEuY29tDQpYLUdPT0dMRS1DT05GRVJFTkNFOmh0dHBzOi8vbWVldC5nb29n
bGUuY29tL2FqZy1xeHN6LXVqZQ0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi0xMTg0
MjcyNzE4DQpDUkVBVEVEOjIwMjIwOTAxVDE5MjkwM1oNCkRFU0NSSVBUSU9OOjxicj5JbiBv
dXIgbGFzdCBXZWIgRGFzaGJvYXJkIG1lZXRpbmdbMV0gd2hlcmUgd2UgcmV2aWV3ZWQgdGhl
IA0KIFVzZXIgU3RvcmllcyBkb2N1bWVudFsyXS4gVGhlblwsIGFmdGVyIHRoYXQgd2Ugd29y
a2VkIG9mZmxpbmUgdG8gaW5jb3Jwb3JhdA0KIGUgdGhlIGZlZWRiYWNrIG9uIGRvY1wsIHNv
IGl0IGlzIHRpbWUgZm9yIG91ciBuZXh0IG1lZXRpbmcgdG8gZnVydGhlciBkaXNjdQ0KIHNz
IHRoZSBuZXh0IHN0ZXBzPGJyPuKAlDxicj5bMV0gbWVldGluZyBub3RlczombmJzcFw7PGEg
aHJlZj0iaHR0cHM6Ly9kb2NzLmdvDQogb2dsZS5jb20vZG9jdW1lbnQvZC8xeXAtMkw1NHRu
cndrWi0tNTl0MkdlWHVxMWd0NWREbnNGeTA4b2RpemwxWS9lZGl0I2Jvb2ttDQogYXJrPWlk
LjZvazB1Zm5lOXNoaiIgY2xhc3M9InBhc3RlZERyaXZlTGluay0wIiBpZD0ib3c2OTgiIF9f
aXNfb3duZXI9InRydWUiDQogPmh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2Qv
MXlwLTJMNTR0bnJ3a1otLTU5dDJHZVh1cTFndDVkRG5zRnkwOG9kDQogaXpsMVkvZWRpdCNi
b29rbWFyaz1pZC42b2swdWZuZTlzaGo8L2E+IDxicj5bMl0gVXNlciBzdG9yaWVzJm5ic3Bc
OzxhIGhyZWY9DQogImh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMV9yZk1w
YXM0bl9ndzJHdlVUUlU2M3ZJWGs5NVZvdEp1aXR0YWxYDQogN3RyUDgvZWRpdCNoZWFkaW5n
PWgud2pveGk0czVweHpsIiBjbGFzcz0icGFzdGVkRHJpdmVMaW5rLTEiIGlkPSJvdzcwNSIg
X19pDQogc19vd25lcj0idHJ1ZSI+aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQv
ZC8xX3JmTXBhczRuX2d3Mkd2VVRSVTYzdklYDQogazk1Vm90SnVpdHRhbFg3dHJQOC9lZGl0
I2hlYWRpbmc9aC53am94aTRzNXB4emw8L2E+XG5cbi06On46fjo6fjp+On46fjp+On46DQog
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjp+On46On46fjo6LVxuVGhpcyBlDQogdmVudCBoYXMgYSB2aWRlbyBjYWxsLlxuSm9pbjog
aHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vYWpnLXF4c3otdWplXG4oVVMpICsxDQogIDMxNC0z
MjUtMjMyNSBQSU46IDU2MDY5NDU2NiNcblZpZXcgbW9yZSBwaG9uZSBudW1iZXJzOiBodHRw
czovL3RlbC5tZWV0L2FqDQogZy1xeHN6LXVqZT9waW49ODQxNTA2MjY4MDQ5MiZocz03XG5c
blZpZXcgeW91ciBldmVudCBhdCBodHRwczovL2NhbGVuZGFyLmdvDQogb2dsZS5jb20vY2Fs
ZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlkPU5UbGxNVE0wWVRWMk9ERXhkSEJzY1hCeU1X
bzRZekpuWTI0DQogZ2EyVnlibVZzWTJrdGJXVnRZbVZ5YzBCbmNtOTFjSE11YVc4JnRvaz1N
VFlqWW05MFFHdGxjbTVsYkdOcExtOXlaekU0TkdOaE1HDQogUXpPRFpqWVROa05XWXlPR1pp
TWpVNU5tVmhZalU0TlRGaU9XUm1NV000T1RNJmN0ej1BbWVyaWNhJTJGTG9zX0FuZ2VsZXMm
aGw9DQogZW4mZXM9MS5cblxuRG8gbm90IGVkaXQgdGhpcyBzZWN0aW9uIG9mIHRoZSBkZXNj
cmlwdGlvbi5cbi06On46fjo6fjp+On46fjp+DQogOn46fjp+On46fjp+On46fjp+On46fjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6LQ0KTEFTVC1N
T0RJRklFRDoyMDIyMDkwMVQxOTI5MDNaDQpMT0NBVElPTjoNClNFUVVFTkNFOjANClNUQVRV
UzpDT05GSVJNRUQNClNVTU1BUlk6S2VybmVsQ0kgV2ViIERhc2hib2FyZCBXRw0KVFJBTlNQ
Ok9QQVFVRQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K

--------------9zxYN0ml4XwR0YZdYFUfBlf6--
