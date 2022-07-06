Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2525756874C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGFLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiGFLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:50:44 -0400
X-Greylist: delayed 11289 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 04:50:42 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38980286E2;
        Wed,  6 Jul 2022 04:50:42 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4LdHt53CyRz9sWy;
        Wed,  6 Jul 2022 13:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1657108237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4wqxoMq5oR8WkvTArbbG1sxY1bReFEEjrwDGNLdXas=;
        b=dxyQbe93rW3+y0ijBIAK8fWQHkSfmwz01/hLaCPeTK/37mShVNU59E70jutpBIcXDmF3hK
        MTP8dxh4tddo70cZsSHAVz+U2wBBRiZkzvlvit+8snXOqN+1umZth1Le+ORp3Zpvkw9+Fx
        PtA55w7U12dLXNO3JK0VzCL4p20f1SMY/O4L8dsAPPEpqJ0iNXOTSsIIYunc9X8jUJlmoM
        JvSjs4d5OjMUP8Gb5Gq4WOGG8dXBdzGITPqDmsRgIUQZ+rb+7VuEYZsTCz01L2S4325NdE
        KLo6aNZU+lvDKNmyAlvTdMnAel2ESQ2YuuvMRLK3b7SSiPFB9kgwOzDovPa0hg==
Date:   Wed, 6 Jul 2022 13:50:36 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <404021154.598.1657108236295@office.mailbox.org>
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
X-MBO-RS-ID: b1a714af9c1f0358d8e
X-MBO-RS-META: 6zsa5ug3yrfakz3br9dnuoxmu8jjz41c
X-Rspamd-Queue-Id: 4LdHt53CyRz9sWy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> 
> For thinkpad_acpi you can try modprobe.blacklist=thinkpad_acpi.
> 
> > But otherwise I think we'll just need more reports or info to even
> > start guessing.
> > 
> >               Linus

Reverting the three i915 and the two thinkpad_acpi commits introduced with rc5
does not solve this problem. Maybe I missed something else...

Tor
