Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A204F0FF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377673AbiDDH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiDDH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:27:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5180E3616D;
        Mon,  4 Apr 2022 00:25:36 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nbH5i-0006xr-Om; Mon, 04 Apr 2022 09:25:34 +0200
Message-ID: <0a33735c-dd43-4305-ff92-7b9ac2c6a0d9@leemhuis.info>
Date:   Mon, 4 Apr 2022 09:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17
Content-Language: en-US
To:     Basavaraj Natikar <bnatikar@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Marco <rodomar705@protonmail.com>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
 <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com>
 <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info>
 <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649057136;58c1d5bd;
X-HE-SMSGID: 1nbH5i-0006xr-Om
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.22 09:18, Basavaraj Natikar wrote:
> 
> 
> On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
>> On 01.04.22 21:47, Basavaraj Natikar wrote:
>>> Committed patch is disabling the interrupt mode and does not cause any
>>> functionality or working issues.
>> Well, for the reporter it clearly does cause problems, unless something
>> in testing went sideways.
>>
>>> I also cross verified on 3 system and working fine on 5.17 and not able
>>> to reproduce or recreate.
>>> [...]
>>> ------------------------------------------------
>>>
>>> Looks like this is not regression. May be some hardware/firmware bug.
>> Well, from the point of the kernel development process it afaics is a
>> regression, unless the testing went sideways. It doesn't matter if the
>> root cause is in fact a hardware/firmware bug, as what matters in the
>> scope of the kernel development is: things worked, and now they don't.
>> For details please check this file and read the quotes from Linus:
> 
> can you help to answer the below questions:

Me? No, I'm just the Linux kernels regression tracker trying to make
sure all regressions are handled appropriately. :-D

Marco, can you help out here?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

> Did you attempt to test it multiple times on the tip of the git to see
> if the problems goes away?
> 
> if same test is performed multiple times with or without reverting patch
> on same platform (laptop/hardware/firmware) on which issue is observed
> we may see same working/issue behavior. if it is regressing then always
> it should work with or without reverting patches on same laptop. is this
> the case here?
> 
> I don't see any regression here. I requested to retest with other
> hardware/platform/system also as per my above test (output) all working
> fine in 3 different platforms and not able to reproduce or recreate for
> my side on 5.17.
> 
> Thanks,
> 
> Basavaraj
> 
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nv4ZzNeRgRCrjnEgh5wHGcqSAHaCffdWxGm%2BsjiPu0Y%3D&amp;reserved=0
>>
>> Ciao, Thorsten
>>
>>> Just curious reverting this patch how it is working just suspecting
>>> firmware undefined behavior.
>>>
>>> If possible, please check on other platform/system also if same behavior
>>> occurs.
>>>
>>> Could you please provide me platform/system details so that I can check
>>> this behavior?
>>>
>>> Thanks,
>>> Basavaraj
>>>
>>> On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
>>>> Hi, this is your Linux kernel regression tracker.
>>>>
>>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>>> acted upon since it was reported about a week ago, that's why I decided
>>>> to forward it to the lists and all people that seemed to be relevant
>>>> here. It looks to me like this is something for Basavaraj, as it seems
>>>> to be caused by	b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
>>>> all command"). But I'm not totally sure, I only looked briefly into the
>>>> details. Or was this discussed somewhere else already? Or even fixed?
>>>>
>>>> To quote from https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=jXu50hKBHkHzjOrfEQ0sXme3%2BdliBd%2FleA%2F9oE61EpI%3D&amp;reserved=0 :
>>>>
>>>>>  Marco 2022-03-25 15:22:19 UTC
>>>>>
>>>>> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3Db300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=o443EB8xRW%2BwEi7pxB82A8B0oty64pBSQwAEU4sF2UA%3D&amp;reserved=0. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
>>>>>
>>>>> Marco.
>>>> Anyway, to get this tracked:
>>>>
>>>> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
>>>> #regzbot from: Marco <rodomar705@protonmail.com>
>>>> #regzbot title: input: hid: input from the accelerometer disappeared due
>>>> to changes to amd_sfh
>>>> #regzbot link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7Ca64876e42c174bf2df5608da16054550%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846509153638366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=jXu50hKBHkHzjOrfEQ0sXme3%2BdliBd%2FleA%2F9oE61EpI%3D&amp;reserved=0
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>
>>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>>> reports on my table. I can only look briefly into most of them and lack
>>>> knowledge about most of the areas they concern. I thus unfortunately
>>>> will sometimes get things wrong or miss something important. I hope
>>>> that's not the case here; if you think it is, don't hesitate to tell me
>>>> in a public reply, it's in everyone's interest to set the public record
>>>> straight.
>>>>
>>>
> 
> 
> 
