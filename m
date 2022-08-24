Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B259F716
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiHXKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiHXKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:06:20 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC56476;
        Wed, 24 Aug 2022 03:06:18 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 54E4B1C0005; Wed, 24 Aug 2022 12:06:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1661335577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXUI0ef9HtUxemcBiVDr4UCtjaKADZSxWJ0IxdOzU1Y=;
        b=RrOYGMu6vFus1kjdfs/BNP5QZgymLMo+Xw8k//d57RcyoJmjiSzgDq0V0ewj3TGMGR/xq4
        RwmwNPJTkfBP17JwN9aD/ZxgFpxDma+N2Q8/lC++dviYlm/JQyb9bZgbby/LVDyjtSCFkD
        lAxH251do62v22lO8phVUhOWld2aQHU=
Date:   Wed, 24 Aug 2022 12:06:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     PaddyKP_Yao@asus.com
Cc:     andy.shevchenko@gmail.com, hdegoede@redhat.com,
        acpi4asus-user@lists.sourceforge.net, corentin.chary@gmail.com,
        ispaddy@gmail.com, linux-kernel@vger.kernel.org, luke@ljones.dev,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220824100615.GA1049@bug>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
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

> In some new ASUS devices, hotkey Fn+F13 is used for mic mute. If mic-mute
> LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
> mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
> it. The binding of mic-mute LED controls will be swithched with LED
> trigger.
> 
> Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>
> ---
> V1 -> V2: fix typo for 'present' and remove unnecessary pr_info() log
> 
>  drivers/platform/x86/Kconfig               |  2 ++
>  drivers/platform/x86/asus-wmi.c            | 25 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  3 files changed, 28 insertions(+)
> 
> asus->micmute_led.name = "asus::micmute";

Please see/modify well-known-leds.txt file. We want this consistent on all devices.

Best regards,
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
