Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E076059F719
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiHXKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiHXKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:06:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A449B58;
        Wed, 24 Aug 2022 03:06:25 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C13E31C000B; Wed, 24 Aug 2022 12:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1661335583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBTZqk3XG4I0DIew+BbIPdIsYk961dnj2iB7RR+Va8U=;
        b=PEVBdtiHzfTeRIrxPTbAJvKWpyCGDFNhUYuh3fwTt95t0ardN/tpplcP5y9e/GaFh8gE7q
        oTyWiMrRdM7FiqeRFayvCLiQQmCcloLNDnmLyfKU3d/S5wSOaWwgOmeby7OTTUP9IUNCLR
        XQa/C59LXTIMIzbv/wvZf685+0pNfCg=
Date:   Wed, 24 Aug 2022 12:06:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     PaddyKP_Yao <ispaddy@gmail.com>, PaddyKP_Yao@asus.com,
        acpi4asus-user@lists.sourceforge.net, andy.shevchenko@gmail.com,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220824100622.GB1049@bug>
References: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
 <20220711115125.2072508-1-PaddyKP_Yao@asus.com>
 <e120ac7c-7abb-4999-efe8-6b3b697d12d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e120ac7c-7abb-4999-efe8-6b3b697d12d6@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
> > mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
> > it. The binding of mic-mute LED controls will be swithched with LED
> > trigger.
> > 
> > Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>
> > ---
> > V1 -> V2: fix typo for 'present' and remove unnecessary pr_info() log
> > V2 -> V3: resend patch again by gmail to avoid Asus legal in the mail
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

> > +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MICMUTE_LED)) {
> > +		asus->micmute_led.name = "asus::micmute";

It would be good to get the API right before it hits mainline release.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
