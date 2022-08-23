Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6659EF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiHWWdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiHWWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:33:13 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE012D33;
        Tue, 23 Aug 2022 15:33:10 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aec8f.dynamic.kabel-deutschland.de [95.90.236.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B9D961EA192D;
        Wed, 24 Aug 2022 00:33:08 +0200 (CEST)
Message-ID: <33c2a495-13ad-97ac-f2c2-4096cf8f5b58@molgen.mpg.de>
Date:   Wed, 24 Aug 2022 00:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
 <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
 <beabe16c-b28b-cd65-f6b6-4242bc74926d@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <beabe16c-b28b-cd65-f6b6-4242bc74926d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave,


Thank you for your reply.

Am 23.08.22 um 18:32 schrieb Dave Hansen:
> On 8/23/22 06:48, Paul Menzel wrote:
>>>> I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
>>>> might be a case of the SGX initialization getting a bit too far along
>>>> when it should have been disabled.
>>>>
>>>> We had some bugs where we didn't stop fast enough after spitting out the
>>>> "SGX Launch Control is locked..." errors.
>>
>> Let’s hope it’s something known to you.
> 
> Thanks for the extra debug info.  Unfortunately, nothing is really
> sticking out as an obvious problem.
> 
> The EREMOVE return codes would be interesting to know, as well as an
> idea what the physical addresses are that fail and the _counts_ of how
> many pages get sanitized versus fail.

Is there a knob to print out this information? Or way to get this 
information using ftrace? I’d like to avoid rebuilding the Linux kernel.

> But, I don't really have a theory about what could be going on yet.

Kind regards,

Paul
