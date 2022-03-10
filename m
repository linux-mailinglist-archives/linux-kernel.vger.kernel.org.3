Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3B4D47F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbiCJNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiCJNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:23:48 -0500
Received: from m228-6.mailgun.net (m228-6.mailgun.net [159.135.228.6])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id A3032255B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:22:46 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1646918566; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: References: Cc: To: To: From: From: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=vsCYinTDmsDFUE7f5prX02vMGrGhK6+P5tm1gFAQzgA=; b=A7lyiUOXYwZ8mHJUhX7L6GJkT95eRMEHYqYTf/wjdL3pbksRNMOeR3IJnXYTlViw8gnWUh/R
 Y9SS51RRPivriwiBY/PeJ/IeNHZamRf6ONCbcjwABY5aBibmvql0pBe/LH9P2/rZZWhIsSNc
 idLpsIcPqC3gcSy7HRFDPjqdzbw=
X-Mailgun-Sending-Ip: 159.135.228.6
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6229fba5ea5f8dddb581e09c (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 10 Mar 2022 13:22:44 GMT
Sender: Michael@michaelkloos.com
Received: from [192.168.0.103] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 942D340176;
        Thu, 10 Mar 2022 13:22:43 +0000 (UTC)
Message-ID: <3db8c258-cc62-29d1-c64f-31f3c4e2aa07@MichaelKloos.com>
Date:   Thu, 10 Mar 2022 08:22:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
Content-Language: en-US
From:   "Michael T. Kloos" <Michael@MichaelKloos.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-08a28047-b563-41f4-b705-f27b88554f2c@palmer-mbp2014>
 <8f06a08e-c1b3-066f-bd9e-1f2d686492fa@MichaelKloos.com>
In-Reply-To: <8f06a08e-c1b3-066f-bd9e-1f2d686492fa@MichaelKloos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some other thoughts:
It sounds like I am not the first person to want this feature and I
probably won't be the last.  I created the change for my own reasons, the
same as any other contributor.  I think we all know that I can not pull
out some chart and say, "This many people want this and here is why."  I
live in central Ohio and have been doing this as a hobby.  I don't even
know anyone else who knows about systems and operating system development.
If the justification that you are looking for is that I as some
hypothetical developer at a major tech company is about to release a new
RISC-V chip without M support but we want it to run Linux, I can not
provide that answer.  It sounds a bit like some software or hardware,
chicken or the egg anyway.  Trying to maintain my own fork if people
start contributing patches with incompatible assembly scares me.

	Michael

On 3/10/2022 4:31 AM, Michael T. Kloos wrote:

> As far as I can tell, it's simply a compiler flag to enable or disable it.
> The only complicating issue that I found was the BPF JIT.  That is a
> special case amounting to a compiler within the kernel itself and can be
> patched or set to depend on M.  There is still the BPF interpreter.  The
> kernel doesn't depend on the C-extension.  I have grepped through the
> source code where that symbol is referenced, the checking of instruction
> alignment constraints, and various checks used to make that work are much
> more extensive than I expected, yet that is supported.  To quote the
> commentary from the beginning of chapter 2 (Base-I) of the RISC-V spec:
>> "RV32I was designed to be sufficient to form a compiler target and to
>> support modern operating system environments. The ISA was also designed
>> to reduce the hardware required in a minimal implementation. RV32I
>> contains 40 unique instructions, though a simple implementation might
>> cover the ECALL/EBREAK instructions with a single SYSTEM hardware
>> instruction that always traps and might be able to implement the FENCE
>> instruction as a NOP, reducing base instruction count to 38 total.
>> RV32I can emulate almost any other ISA extension (except the A extension,
>> which requires additional hardware support for atomicity).
>> In practice, a hardware implementation including the machine-mode
>> privileged architecture will also require the 6 CSR instructions.
>> Subsets of the base integer ISA might be useful for pedagogical purposes,
>> but the base has been defined such that there should be little incentive
>> to subset a real hardware implementation beyond omitting support for
>> misaligned memory accesses and treating all SYSTEM instructions
>> as a single trap."
> This is all a noble goal of RISC-V, to create a minimal, yet robust ISA.
> I'm not arguing to support no-A, as stated in the commentary, atomic can
> not be emulated (I mean, maybe you could by taking over sscratch) and
> the atomic properties of the CSR instructions.  But that does seem hacky.)
> and everything else is handled in the Base-I (Not including Zicsr).  The
> kernel supports rv(32/64)ima so to draw the line in the sand that
> rv(32/64)ia is unacceptable seems silly.
> One of my concerns here is that if support is not added, that people may
> start writing assembly that uses M instructions and other non-portable
> stuff.  This will make a future port more difficult.
> I do not have real hardware like this but I do have an emulator that
> implements rv32iasu.  Eventually I want to build a HART implementation
> out of real hardware logic chips.  Adding M, adds hardware complexity and
> I think that it is better to do in software for such a minimal case.
> Sure it will be slower than having native hardware M support.  Firmware
> emulation will be even slower than that.  I'd much rather have the option
> in the kernel to switch this on or off.
> I am not trying to argue that the kernel should bend over to support my
> pet projects, but it seems quite strange and arbitrary to draw the line
> here over such a beautifully modular and minimal ISA.
>> there's an infinite amount of
>> allowable RISC-V implementations, we'll all go crazy chasing them
>> around.
> 2 points on that:
> 1) Then it would seem logical to have the kernel target the most minimal
> implementation to get the widest support.
> 2) I actually don't think this is entirely true, or at least not in the
> sense that it is relevant to the kernel.  Atomics are needed for a modern
> system.  The kernel needs to know about the floating-point support because
> it needs to handle the clean-up and context-switching of the additional
> floating point registers.  The kernel needs to know about the C extension
> because of the ramifications to alignment.  Everything else is just gravy.
> If sometime in the future the L-extension or the B-extension are finished
> and implemented in future hardware, unless they make some very strange
> decisions, I don't see why a kernel built today couldn't run on that
> hardware with userspace software taking advantage of those native features.
> Sure, in that situation, the kernel binary wouldn't be taking advantage of
> them.  But then wouldn't you want to add CONFIG_RISCV_ISA_L and
> CONFIG_RISCV_ISA_B in said future kernel so that the compiler is passed an
> -march value such that the kernel can take advantage of these new native
> hardware features?
> It seems to me that this is the grand vision in the modularity of both the
> RISC-V ISA and the C programming language.  We aren't writing everything in
> assembly for a reason.  I don't think it makes sense to stop one extension
> away from what the RISC-V spec documents themselves state is the intended
> minimal system capable of running a full modern operating system.  I think
> it is an arbitrary limit to the portability of the kernel.
>      Michael
> On 3/10/2022 2:34 AM, Palmer Dabbelt wrote:
>> On Wed, 09 Mar 2022 23:06:22 PST (-0800), Christoph Hellwig wrote:
>>> Why?
>> I have no idea, but this has come up a few times before.
>> IIRC the original port had a no-M flavor (don't remember if it even made
>> it to the original patch submission, but it was around for a bit).  We
>> decided to drop this under the theory that nobody would use it:
>> essentially, if you can afford the handful of MiB of memory required to
>> run Linux then you've probably got a multiplier.
>> If someone has hardware that lacks M and users care about running Linux
>> on that then I'm happy to support it.  I'll still point out the
>> silliness of that decision, but if it's too late to change things then
>> I'd rather support the hardware.  If it's one of these "fill out every
>> possible allowed ISA flavor, even if nobody has one that runs Linux"
>> then I don't see a reason to bother -- there's an infinite amount of
>> allowable RISC-V implementations, we'll all go crazy chasing them
>> around.
>> FWIW: to a first order, that applies to the no-A stuff as well (though
>> that got dropped because the Arm folks pointed out a way to support that
>> was way better than ours).
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
