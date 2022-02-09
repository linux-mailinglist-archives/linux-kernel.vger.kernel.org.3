Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF74AEC77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiBIIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:33:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiBIIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:32:54 -0500
X-Greylist: delayed 94 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:32:54 PST
Received: from julia1.inet.fi (mta-out1.inet.fi [62.71.2.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9C1CC05CBBA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:32:54 -0800 (PST)
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrheekgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfhlkhhkrgcurfhruhhsihcuoehilhhkkhgrrdhprhhushhisehpphdrihhnvghtrdhfiheqnecuggftrfgrthhtvghrnhepfffgheegudehffejtefgvdelhfffgfejueekkeetveehgeegudffieeujeegffehnecukfhppeekgedrvdehuddrudelgedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudeftdgnpdhinhgvthepkeegrddvhedurdduleegrdduieegpdhmrghilhhfrhhomhepoehprhhushhilhdqudesmhgsohigrdhinhgvthdrfhhiqecuuefqffgjpeekuefkvffokffogfdpnhgspghrtghpthhtohepvddprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeophhhvghonhhigidrshhjrgesrghtthdrnhgvtheq
Received: from [192.168.1.130] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 61E9A0DF0071E8DE; Wed, 9 Feb 2022 10:31:12 +0200
Message-ID: <e2032720-b977-24cc-435d-76d23025fd47@pp.inet.fi>
Date:   Wed, 9 Feb 2022 10:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: amd apu crashes
Content-Language: en-US
To:     Steven J Abner <pheonix.sja@att.net>, linux-kernel@vger.kernel.org
References: <1644355058.23272.0.ref@smtp.mail.att.net>
 <1644355058.23272.0@smtp.mail.att.net>
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
In-Reply-To: <1644355058.23272.0@smtp.mail.att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've seen random crashes during booting (Vega 56/64) after kernel 
switches to DRM driver. The display is corrupted and after that system 
crashes or freezes. This is not always reproducible for me as next boot 
may succeed (or not). Kernel logs don't survive the crash.

Do you have boot log on display or a splash screen (plymouth)?

-- 
  - Ilkka


On 8.2.2022 23.17, Steven J Abner wrote:
> Hi
>   I've been trying out kernel 5.16. Lots of amdgpu upgrades? However it 
> seems to be
> getting worse :(
>   On AMD Ryzen 5 2400G, elementary OS 5.1.7, Ubuntu 18.04.6 LTS, Linux 
> 5.15.5-051505-generic, GTK 3.22.30. Background: Was using 5.16.6 when it 
> started it's triple threat, so went back to 5.15 in panic. Previously, 
> back in November, my first triple threat, I was on system with btrfs 
> which destroyed my hard drive.
> Rebuilt with ext4 and still trying to recreate the losses. Cant use 
> higher Ubuntu due to still need afp to connect with mac for transfer, 
> and elementary went even heavier with gtk, so crawls. I did find better 
> workaround to afp, but not happy with Ubuntu's treatment of bug.
>   The triple threat is when monitor flashes 3 times before total lockup. 
> The last may have been but I was ready, hit reboot before third flash, 
> so no test on it killing my hard drive.
>   Guessing, it's not a true kernel problem, but gtk exploiting a 
> weakness. Probably uninitialized pointer. But with new kernels, the 
> crashes seem to be more frequent.
> Here are the last few:
> $ journalctl -o short-precise -f -k -b -3
> -- Logs begin at Mon 2022-01-03 17:21:50 EST. --
> Feb 05 08:37:32.229754 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:32.230639 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:32.273370 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:32.668947 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:32.794231 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:32.919503 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:33.044753 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:33.169986 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:33.295263 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> Feb 05 08:37:33.420514 steven-ryzen kernel: AMD-Vi: Completion-Wait loop 
> timed out
> 
> $ journalctl -o short-precise -f -k -b -2
> -- Logs begin at Mon 2022-01-03 17:21:50 EST. --
> Feb 07 06:11:47.495092 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> RW: 0x0
> Feb 07 06:11:47.495199 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> [mmhub0] retry page fault (src_id:0 ring:0 vmid:7 pasid:32782, for 
> process WebKitWebProces pid 5037 thread WebKitWebP:cs0 pid 5101)
> Feb 07 06:11:47.495304 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> in page starting at address 0x000080010e24d000 from IH client 0x12 (VMC)
> Feb 07 06:11:47.495413 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> VM_L2_PROTECTION_FAULT_STATUS:0x00000000
> Feb 07 06:11:47.495520 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> Faulty UTCL2 client ID: MP1 (0x0)
> Feb 07 06:11:47.495631 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> MORE_FAULTS: 0x0
> Feb 07 06:11:47.495766 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> WALKER_ERROR: 0x0
> Feb 07 06:11:47.495875 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> PERMISSION_FAULTS: 0x0
> Feb 07 06:11:47.495987 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> MAPPING_ERROR: 0x0
> Feb 07 06:11:47.496108 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> RW: 0x0
> 
> $ journalctl -o short-precise -f -k -b -1
> -- Logs begin at Mon 2022-01-03 17:21:50 EST. --
> Feb 07 16:49:00.229782 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> RW: 0x0
> Feb 07 16:49:00.229898 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> [mmhub0] retry page fault (src_id:0 ring:0 vmid:3 pasid:32769, for 
> process Xorg pid 2061 thread Xorg:cs0 pid 2062)
> Feb 07 16:49:00.230010 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> in page starting at address 0x0000800101955000 from IH client 0x12 (VMC)
> Feb 07 16:49:00.230114 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> VM_L2_PROTECTION_FAULT_STATUS:0x00000000
> Feb 07 16:49:00.230220 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> Faulty UTCL2 client ID: MP1 (0x0)
> Feb 07 16:49:00.230425 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> MORE_FAULTS: 0x0
> Feb 07 16:49:00.230535 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> WALKER_ERROR: 0x0
> Feb 07 16:49:00.230646 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> PERMISSION_FAULTS: 0x0
> Feb 07 16:49:00.230771 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> MAPPING_ERROR: 0x0
> Feb 07 16:49:00.230910 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
> RW: 0x0
> 
> I haven't dealt with kernel debug for years, so please if more info 
> needed, I probably don't remember how to get it.
> If this is a bother, sorry I troubled you.
> Per 'Do I have to be subscribed to post to the list?':
> I wish to be personally CC'ed the answers/comments posted to the list in 
> response to your posting, please.
> Thanks Steve
> 

