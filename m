Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DD5681F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiGFImi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiGFIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:42:34 -0400
X-Greylist: delayed 67941 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 01:42:33 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8D24BCC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:42:32 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4LdCj06PlGz9snb;
        Wed,  6 Jul 2022 10:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1657096948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaMdZ5ijAhH8MOqzd9LdmX606cpTE3BFadjMMV7IX2g=;
        b=YCIQvUuRusPMheXGI40WYog7Cl52ziMWnF2ndMapbTsgdUo8YGqLm0cjRr7iLymu4hf0jW
        e4XktQ+G140SZsKQqR9EP/3uEXenj3CSlOPe4ksz7eIAN9XAFK4A4TR1QAN5Zq4iSzkQLM
        mkPs/QT/sWhJCpZWne3kKXQVTeAIkIfkRp3ULF3Mv66uEmoO+//ZgCYa4jQOYAoXZGpQsV
        OfmgQ/PU2bFpugKxRxQa3dU9ZGheR/TorybF8vEnYD0uULh3DIe32hq/KDbmxqKT4awh5n
        mI7NUizcKB0DPuO8Etjc/ouU8qsUohtWSodjDSQ805N3KZisL7m7fZcqahRvHA==
Date:   Wed, 6 Jul 2022 10:42:28 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <72419963.329229.1657096948079@office.mailbox.org>
In-Reply-To: <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <272584304.305738.1657029005216@office.mailbox.org>
 <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
 <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
Subject: RE: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: tn9od3ka6gzpbd6tkbqzccaouc7uzbo7
X-MBO-RS-ID: 421a68c2a5210c8bd90
X-Rspamd-Queue-Id: 4LdCj06PlGz9snb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Limonciello, Mario <mario.limonciello@amd.com> hat am 05.07.2022 17:10 GMT geschrieben:
> 
>  
> [Public]
> 
> > -----Original Message-----
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Sent: Tuesday, July 5, 2022 11:40
> > To: Tor Vic <torvic9@mailbox.org>
> > Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> > Hans de Goede <hdegoede@redhat.com>; Jani Nikula
> > <jani.nikula@intel.com>
> > Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
> > 
> > On Tue, Jul 5, 2022 at 6:50 AM <torvic9@mailbox.org> wrote:
> > >
> > > Linux 5.19-rc5 does not boot on my Kaby Lake Thinkpad.
> > > rc3 and rc4 were still fine, so I guess something between rc4 and rc5
> > > introduced a regression.
> > 
> > Sounds that way.
> > 
> > > Unfortunately, there are no errors or warning messages.
> > > It gets stuck quite early on boot, about the time USB is initialized,
> > > so less than 1 second into post-bootloader boot.
> > > It then just sits there doing nothing - SysRq still works though.
> > 
> > There aren't all that many changes in rc5, and your hardware looks
> > *very* standard (all intel chipset, and a Samsung SM961 SSD).
> > 
> > And with the lack of details, we'll either need a bisect:
> > 
> > > I don't have time for a bisect, but I thought I'll let you know about
> > > this issue, and maybe someone already has an idea.
> > 
> > or we'll need more reports..
> > 
> > > Some system information below. Root filesystem is f2fs.
> > 
> > Ok, f2fs is certainly unusual, but there are no f2fs changes in rc5.
> > 
> > There's some PM changes for i915 ("drm/i915/dgfx: Disable d3cold at
> > gfx root port") and a couple of thinkpad-acpi platform driver updates,
> > so I'm adding a few random people to the cc in case somebody goes
> > "ahh..."
> > 
> 
> If a bisect isn't possible for you the kernel command line should be pretty
> helpful to isolate which area the problem is introduced.
> I'd say start out with "nomodeset" on the kernel command line to prevent
> i915 from loading.  If that fixes it, hopefully it's a small number of commits
> to peel back like the one Linus mentioned.

Good advice!
Using "nomodeset" makes the computer boot again.
I will now try to revert the commit Linus mentioned above and report back.

> 
> For thinkpad_acpi you can try modprobe.blacklist=thinkpad_acpi.
> 
> > But otherwise I think we'll just need more reports or info to even
> > start guessing.
> > 
> >               Linus
