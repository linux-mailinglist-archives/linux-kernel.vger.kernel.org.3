Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D454C1B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbiBWSi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243976AbiBWSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:38:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597E48381
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:38:25 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C28F51EC0494;
        Wed, 23 Feb 2022 19:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645641499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ig+HgNxWjJgXASHFx0Eo0Cv/xBwjLhIfqzkOKH8oZL8=;
        b=aoa6o+GB573FOU1Yz2rwNgdk0B5PctOgEt+lND/OrCeZGM0bc2h87e4u0VbtYxby21P+G2
        mPGCDoGgpSUdOWg9IjT/QwPlvF8BcvdxjYN8UwNPlm7gdG9APhG23w4ApzoxGvEAZ8wEO3
        5gEdFVswsXkZzbMKgiYvsBy4NwHfQ3s=
Date:   Wed, 23 Feb 2022 19:38:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        David Herrmann <dh.herrmann@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-video@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Message-ID: <YhZ/H9Ra+w7JC32g@zn.tnic>
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
 <49f0642d-7078-8fba-c851-6e33658180ff@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49f0642d-7078-8fba-c851-6e33658180ff@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:51:35AM +0100, Thomas Zimmermann wrote:
> Thanks for the patch. I'll wait a bit for additional reviews before merging
> it.

for the x86 bits:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
