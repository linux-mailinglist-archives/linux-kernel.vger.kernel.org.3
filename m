Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74D4F4D69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582098AbiDEXl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457541AbiDEQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:08:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C022825CD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:06:27 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 752E21EC0502;
        Tue,  5 Apr 2022 18:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649174782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+l8x0npVHQPxXN8Jiw+gTLW632Eoh0dwy+8lcfQVWk8=;
        b=gegC6rwLvXB2k5OYbibB7lCieya+klwRoI9ayiojrjzhL5+dgOrStUCrd9Zuge5TiWA+qx
        hqxZKJiVM/6bxN5fLDL7xISUUDmvsibLMFEtFzQRUT65RwM/EvUdZwy97j0+8nhQmrqrwS
        9mOhd7Kerbl6Tv7wZS6hITMkaS4j51Y=
Date:   Tue, 5 Apr 2022 18:06:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 02/11] ALSA: usb-audio: Fix undefined behavior due to
 shift overflowing the constant
Message-ID: <Ykxo+0p5IeeM7mge@zn.tnic>
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-3-bp@alien8.de>
 <s5hwng35yvz.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s5hwng35yvz.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 05:32:48PM +0200, Takashi Iwai wrote:
> > +#define USB_ID(vendor, product) ((((unsigned int)vendor) << 16) | (product))
> 
> Parentheses are needed around vendor (as usual for a macro).
> Could you resubmit with it?

Or you can fix it up while applying. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
