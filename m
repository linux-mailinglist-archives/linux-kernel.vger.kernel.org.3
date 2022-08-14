Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4C591D6F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 03:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiHNBTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiHNBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 21:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9F15813
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 18:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD421B80ADA
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A8C433D7;
        Sun, 14 Aug 2022 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660439971;
        bh=lVnMgDezkLSQTfmf4iQ0SkVg6u16Zbg/ddRb3RwOQm8=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=AVkIxX3rGYfcI7VHGPtzE9+vUN5FS6tbnN4EuBhZqjPSbtfOLP3Z0PG11JWGh01B9
         HWMYNRm4uwb+eyIYf3qiKo21xJ1yb0Js47qytYwYmSv+a3Zfh/Szfl6JDQcXwyaIIj
         HVkOJy1/AyWVyHTokMhyEGkBEt+1o/az1oixF4lUnNeGumbCWOrX/z+l/tLsxqZD2b
         cApWAalFIDnn5SQShjsqlwPZ4jpnfNYRmqJnf+8t+0N9LKMnQ5NleunYxdZHDAQK3w
         usJkqWUCwHSooNWHQgRA2EOYwNFcxAEaHN72mCo+RG8ETJTWIkl3+aDo+2jCvoKTVS
         BvE6ihJz46bWg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C015F27C0054;
        Sat, 13 Aug 2022 21:19:29 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 21:19:29 -0400
X-ME-Sender: <xms:oU34Yh230Cp4tosnCtAoupyuQ2Dc83b9sENeHpXsJ3oPhuD5ywit0g>
    <xme:oU34YoEhFPxRlS5Mv3ehMZPDXhtHN8KE8ibqjOpazwaeBZvW1F20HNQKGDl8d1dxk
    q8X5vJKyn2Z5asHmK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegledggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:oU34Yh6C-CLLpxkn4E4mAXLg1WZ4n94vi9ML4_ukWgV6PImYAbB2qg>
    <xmx:oU34Yu3GQWUJs66jVZhmrpXyQUz5NHjnhiRQfJAQmIRZLMeVpDkjoQ>
    <xmx:oU34YkFlelrqGAcF_wOLJ2ZNM55ilyTj26K5fSmK4KaQva9mq12Rjg>
    <xmx:oU34Yv0NPapKEHJNzhT4oWN3iQ2tZJD4CE1igbxxlf_9ElGtq1hyRg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01D0731A0062; Sat, 13 Aug 2022 21:19:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <1471edba-ccb9-4568-85da-bf69f55d02c8@www.fastmail.com>
In-Reply-To: <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-6-ashok.raj@intel.com>
 <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
Date:   Sat, 13 Aug 2022 18:19:04 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Raj Ashok" <ashok.raj@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022, at 5:13 PM, Andy Lutomirski wrote:
> On Sat, Aug 13, 2022, at 3:38 PM, Ashok Raj wrote:
>> Microcode updates need a guarantee that the thread sibling that is waiting
>> for the update to finish on the primary core will not execute any
>> instructions until the update is complete. This is required to guarantee
>> any MSR or instruction that's being patched will be executed before the
>> update is complete.
>>
>> After the stop_machine() rendezvous, an NMI handler is registered. If an
>> NMI were to happen while the microcode update is not complete, the
>> secondary thread will spin until the ucode update state is cleared.
>>
>> Couple of choices discussed are:
>>
>> 1. Rendezvous inside the NMI handler, and also perform the update from
>>    within the handler. This seemed too risky and might cause instability
>>    with the races that we would need to solve. This would be a difficult
>>    choice.
>
> I prefer choice 1.  As I understand it, Xen has done this for a while 
> to good effect.
>
> If I were implementing this, I would rendezvous via stop_machine as 
> usual.  Then I would set a flag or install a handler indicating that we 
> are doing a microcode update, send NMI-to-self, and rendezvous in the 
> NMI handler and do the update.
>

So I thought about this a bit more.

What's the actual goal?  Are we trying to execute no instructions at all on the sibling or are we trying to avoid executing nasty instructions like RDMSR and WRMSR?

If it's the former, we don't have a whole lot of choices.  We need the sibling to be in HLT or MWAIT, and we need NMIs masked or we need all likely NMI sources shut down.  If it's the latter, then we would ideally like to avoid a trip through the entry or exit code -- that code has nasty instructions (RDMSR in the paranoid path if !FSGSBASE, WRMSRs for mitigations, etc).  And we need to be extra careful: there are cases where NMIs are not actually masked but we just simulate NMIs being masked through the delightful logic in the entry code.  Off the top of my head, the NMI-entry-pretend-masked path probably doesn't execute nasty instructions other than IRET, but still, this might be fragile.

So here's my half-backed suggestion.  Add a new feature to the NMI entry code: at this point:

        /* Everything up to here is safe from nested NMIs */

At that point, NMIs are actually masked.  So check a flag indicating that we're trying to do the NMI-protected ucode patch dance.  If so, call a special noinstr C function (this part is distinctly nontrivial) that does the ucode work.  Now the stop_machine handler does NMI-to-self in a loop until it actually hits the special code path.

Alternatively, stop_machine, then change the IDT to a special one with a special non-IST NMI handler that does the dirty work.  NMI-to-self, do the ucode work, set the IDT back *inside the handler* so a latched NMI will do the right thing, and return.  This may be much, much simpler.

Or we stop messing around and do this for real.  Soft-offline the sibling, send it INIT, do the ucode patch, then SIPI, SIPI and resume the world.  What could possibly go wrong?

I have to say: Intel, can you please get your act together?  There is an entity in the system that is *actually* capable of doing this right: the microcode.
