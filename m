Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966F0590F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiHLKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbiHLKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:17:18 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06FAB413
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:17 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oMRj8-00066k-Aj; Fri, 12 Aug 2022 20:17:14 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NIeJklYroDHGuxxQyA3yoB5THfvxK2VaJufAJwgRnqM=; b=SeFSwudevgKSh8GoiD9+bLegih
        XbXxqCoDdCrvrZmBCDTkEZQo2hcZecl8ZbDgtSsYXpjy0wnWFqaEAnaVavbZ4n1mr1OAnWg1Lh7eW
        l5xV2Oaur5bHWO4JLz7EhyWrihMLF9aMXIB87QVxmL6M0LDkJuAc+xuB/UwpK9TsLZT4=;
Message-ID: <6f399ffb-6f82-de7c-c114-b71c86d41c5c@fnarfbargle.com>
Date:   Fri, 12 Aug 2022 18:16:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
 <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
 <YvKCRPtoN6m2rMr2@lahna>
 <2c4420ac-d988-9dd8-c223-4243b9a6881e@fnarfbargle.com>
 <YvTQ0N2Py4rc4k3Z@lahna>
 <baf0f38a-27ac-ec2c-129d-c9430fc40dd0@fnarfbargle.com>
 <YvYe+5AyI3aD6Q5V@black.fi.intel.com>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YvYe+5AyI3aD6Q5V@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Mika,

On 12/8/22 17:35, Mika Westerberg wrote:
> Hi Brad,
> 
> On Thu, Aug 11, 2022 at 10:17:02PM +0800, Brad Campbell wrote:
>> G'day Mika,
>>> Okay, do you see in the dmesg whether the DP tunnels are actually
>>> created when you see the issue?
>>>
>>
>> Yes, the DP tunnels appear to be created. Xorg sees them and believes they are there :
>>
>> brad@bkd:~$ grep -A1 EDID  /var/log/Xorg.0.log.old 
>> [    29.377] (II) AMDGPU(0): EDID for output HDMI-A-0
>> [    29.377] (II) AMDGPU(0): Manufacturer: DEL  Model: a19d  Serial#: 810240841
>> --
>> [    29.377] (II) AMDGPU(0): EDID Version: 1.3
>> [    29.377] (II) AMDGPU(0): Digital Display Input
>> --
>> [    29.377] (II) AMDGPU(0): Number of EDID sections to follow: 1
>> [    29.377] (II) AMDGPU(0): EDID (in hex):
>> [    29.377] (II) AMDGPU(0): 	00ffffffffffff0010ac9da1494b4b30
>> --
>> [    29.377] (II) AMDGPU(0): EDID for output DisplayPort-0
>> [    29.377] (II) AMDGPU(0): Manufacturer: APP  Model: 9227  Serial#: 354616281
>> --
>> [    29.377] (II) AMDGPU(0): EDID Version: 1.4
>> [    29.377] (II) AMDGPU(0): Digital Display Input
>> --
>> [    29.378] (II) AMDGPU(0): Number of EDID sections to follow: 1
>> [    29.378] (II) AMDGPU(0): EDID (in hex):
>> [    29.378] (II) AMDGPU(0): 	00ffffffffffff0006102792d9032315
>> --
>> [    29.378] (II) AMDGPU(0): EDID for output DisplayPort-1
>> [    29.378] (II) AMDGPU(0): Manufacturer: APP  Model: 9227  Serial#: 437126968
>> --
>> [    29.378] (II) AMDGPU(0): EDID Version: 1.4
>> [    29.378] (II) AMDGPU(0): Digital Display Input
>> --
>> [    29.378] (II) AMDGPU(0): Number of EDID sections to follow: 1
>> [    29.378] (II) AMDGPU(0): EDID (in hex):
>> [    29.378] (II) AMDGPU(0): 	00ffffffffffff000610279238070e1a
>>
>> This test was done with thunderbolt compiled in just to demonstrate,
>> but any load sequence or combination
>> winds up with the same issue.
> 
> I went through your log but could not find anything out of ordinary from
> TBT perspective. The tunnels get cleaned up by the discovery code and
> then re-created after the reset completes and they seem to be fine. You
> may try to add some sort of delay like 100ms or so after the DPR reset
> but I doubt it changes anything.
> 

I'll have a bit more of a play. I compiled both thunderbolt and amdgpu as modules
and played with them both blacklisted and then loading both manually from the console
after boot to see if there was any timing interaction with the DP tunnels. I normally
have to force the DP links up and provide the EDID on the kernel command line, but
if I give it sufficient time between thunderbolt discovery and amdgpu load it picks up
the links *and* manages to load the EDID from both without anything having to be forced.

I think with your diagnostic assistance I've learned enough about how the architecture
works to keep futzing around to see if I can find some determinism in the system and
figure out what is going on. I'll keep cracking at it and try not to bother you unless
I really can't figure it out.

I'm beginning to think as I'm the only person that seems to be running this hardware
it's some perverse combination that anyone else is highly unlikely to run into. Worst
case I still have my existing workarounds.

I really, _really_ appreciate your assistance.

Regards,
Brad
