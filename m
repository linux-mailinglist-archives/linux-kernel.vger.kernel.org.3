Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D44F13E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbiDDLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiDDLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:40:10 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35413C73F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:38:13 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nbL2A-0006hG-J7; Mon, 04 Apr 2022 21:38:10 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mk32laOtKmhwV25OaU3fIRl06hTmfZozGU3WrhVPQG4=; b=LB/xqPftm8BqKuULvDw3M5IJp5
        Z8x7tP4ITptRSHVSfzVfWJP1Zh54SfIpd4C//qhIR7p0LntQ02TCxTVzgwnIlkenZ6oeNR+J36SH8
        vL14rUCjpJKaG3DTqbaAt0lkhj2tESxm69lvwnDaRYOnBpjCDH0cPhu+EQjNznRgzRYo=;
Message-ID: <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
Date:   Mon, 4 Apr 2022 19:38:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YkrEE0uh9EVCchfl@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/22 18:10, Mika Westerberg wrote:
> On Fri, Apr 01, 2022 at 11:05:27PM +0800, Brad Campbell wrote:
>> On 1/4/22 22:30, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Fri, Apr 01, 2022 at 01:48:13PM +0800, Brad Campbell wrote:
>>>> That I can do. I didn't crop or grep as I wasn't sure what might be additionally relevant.
>>>> 2 machines, 2 ports, 4 cold boots. Each time just the Thnuderbolt displays chained.
>>>
>>> Thanks for the logs! It looks like the Apple EFI CM always uses the lane
>>> 1 adapter.
>>
>> Thanks for sticking with me. This must be a minuscule corner case that
>> is buried in a dark room behind a filing cabinet.
> 
> Well, it is just that nobody else reported the issue before ;-) I don't
> have Light Ridge or Falcon Ridge based Apple hardware anymore so these
> won't show up in my regular testing.

This iMac has > 90,000 power on hours, so I'm not sure how much longer I'm going to have it either.

I've been waiting for the GPU to flake out for a couple of years now. It gives the odd set of "sparklies" 
under OSX but it's fine on Linux.

>>> Can you try the below patch? Fingers crossed that it solves the
>>> chaining issue for both ;-) I had to patch the test.c because otherwise
>>> unit tests fail to compile when enabled.
>>>
>>> This should now setup the second tunnel always through the lane 0
>>> adapter and thus share the bandwidth equally between the two lanes.
>>>
>>> @@ -1604,7 +1604,7 @@ static void tb_test_tunnel_3dp(struct kunit *test)
>>>   	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 3);
>>>   	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 3);
>>> -	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 0, 0);
>>> +	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0);
>>>   	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
>>>   	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_DP);
>>>   	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, in2);
>>> @@ -1612,7 +1612,7 @@ static void tb_test_tunnel_3dp(struct kunit *test)
>>>   	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 3);
>>>   	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 4);
>>> -	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 0, 0);
>>> +	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0);
>>>   	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
>>>   	KUNIT_EXPECT_EQ(test, tunnel3->type, TB_TUNNEL_DP);
>>>   	KUNIT_EXPECT_PTR_EQ(test, tunnel3->src_port, in3);
>>
>> These 2 chunks don't apply.
>> I can't find a tb_test_tunnel_3dp in any of the trees I have (either
>> head or stable). In any case I've updated to current head and applied
>> without those chunks.
> 
> Indeed, I forgot to drop that hunk. It is based on my local branch that
> has some additional code but good that you managed to work it around.
> 
>> This fixes *all* cases on the MacBookPro. Cold boot on either port, and hot plug likewise
> 
> That's great!

Yes, I reckon that one is ready to go. 

>> On the iMac it cold boots on either port. If I boot with the displays plugged in, then unplug-replug we get :
>>
>> Apr  1 22:49:41 bkmac kernel: [   24.480306] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
>> Apr  1 22:49:41 bkmac kernel: [   24.481309] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
>>
>> The last head on the chain comes up, the first doesn't.
>>
>> If I plug the displays in *after* the chime and before the kernel starts up, then both heads come up and hotplug works fine excepting after the second unplug we get lots of this :
>>
>> Apr  1 22:52:54 bkmac kernel: [   37.313493] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
>> Apr  1 22:52:54 bkmac kernel: [   37.313513] thunderbolt 0000:07:00.0: 0:c: DP IN available
>> Apr  1 22:52:54 bkmac kernel: [   37.763482] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
>> Apr  1 22:52:54 bkmac kernel: [   37.763489] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> Apr  1 22:52:54 bkmac kernel: [   37.763491] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
>> Apr  1 22:52:54 bkmac kernel: [   37.763495] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
>> Apr  1 22:52:54 bkmac kernel: [   37.763496] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
>> Apr  1 22:52:54 bkmac kernel: [   37.763498] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
>>
>> And the thunderbolt ports then fail to respond to any plug event until rebooted.
> 
> This makes me suspect that there is something else still going on with
> the Light Ridge controller that we are missing in the Linux driver.

I expect you're right. 
 
>> Feels like it's nailed excepting some DP routing on the Radeon, but
>> I've not been able to put my finger on how that works.
>> With your very first patch, hotplug works on the iMac.
> 
> Hm, you mean you don't see the timeout errors and stuff with the first
> patch applied?

I see the config timeout errors and the controller locking up after a couple of unplugs, but when it does configure the DP channels, they both come up every time.

So, with the original patch when thunderbolt discovery works, displays both work. With the latest patch, whether or not the hotplug works, the radeon driver fails to bring up the parent head.

Both suffer from the controller config timeout reads on unplug causing it to become unresponsive after a couple of re-plug cycles (3 if I'm lucky).

> I think I will make this current one a proper patch and submit upstream
> later this week (will CC you too). For the iMac issue we may need to
> debug it further. Not sure if you answered this one already but on iMac
> on macOS does it work always when you plug in the whole chain?
> 
Yes, MacOS works fine in any order on any port.

There is a difference in the way something is set up between what the EFI does and what Linux does.

If I wait for the Chime, then a bit longer and plug the chain in (before the bootloader starts), Linux sets up both heads and hotplug / replug works.

If I cold boot with the chain plugged in, the EFI sets up one head and Linux configures the other. Replug fails with the clock-recovery error in that case.

The difference seems to be when EFI sets up, on re-plug it sets up the child display first (303 vs 3) and that causes the issue. Repeated tests can get difficult as often on the second or third plug (or unplug) the controller locks up and no longer responds to events.

I'll try and get a couple of clear dmesg with your last debug patch because it appear the chain is being discovered in a different order depending on whether or not the EFI set it up.

I received my brand new Titan Ridge board today (Gigabyte B550 Vision-d-p) and with a modified Thunderbolt rom and the last patch it detects and runs both Thunderbolt displays from a cold boot. Hotplug fails, and there are other issues related to warm boot, but they'll all have to wait until I get a serial console up.

Appreciate the persistence with this.

Regards,
Brad
