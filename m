Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4F56C9B1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGINxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGINxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:53:02 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908C3CBE7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=NQ+Zwi2Q9/fCClfU3sukRpl2ejgpU77vzKaL4tBUEjw=;
        b=ME3WDeR29M6SMHqQOM+ikF5SvR2BBDrlmBZceQIb9nqXOTaBIKuo/N9txDvC1fFJVczTVHErFsFlf
         DQrHq3cHKLyTD1tJbdi/ziIVhqIXIlACJSNaV2j9Hqc6tNN00IP2ITGFBsWpm+4GRAEByln+2kMCzI
         0wDcySZ5JiyhRblWlVch4zqwNFkNUYbXMdbsKGneEPryB9UB7oydzyHUiF/waCCdOFHz4Lsr/VViAu
         DjS5U9qMftQ2dRU+dRQgMupbCr+oSoGbhkUKq+5iouDaTR7ZhmQhZFcM8ERw7X0Slgega+vgkOPQ3S
         Hwolkfq3FnonWooY9XzaSkGhpDWYJCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=NQ+Zwi2Q9/fCClfU3sukRpl2ejgpU77vzKaL4tBUEjw=;
        b=k3r4EraXV5lgTmKhrPZJGhkFQY+ryKHT591eXbjuSaONqK8U+EomVBs4dxYD3vXyrRfUR6n3FF5yW
         O0fXJkkAA==
X-HalOne-Cookie: 94693e2b6d199659f5373a004bd3d3b9dbebd666
X-HalOne-ID: 7082032f-ff8e-11ec-823c-d0431ea8bb10
Received: from mailproxy4.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 7082032f-ff8e-11ec-823c-d0431ea8bb10;
        Sat, 09 Jul 2022 13:52:58 +0000 (UTC)
Date:   Sat, 9 Jul 2022 15:52:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3] drm/mode: Improve drm_mode_fb_cmd2 documentation
Message-ID: <YsmIOG7o5lgyJptW@ravnborg.org>
References: <536de72eab09242e1faf22fa58d91c9005d6ea51.1657113597.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536de72eab09242e1faf22fa58d91c9005d6ea51.1657113597.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Jul 06, 2022 at 03:20:18PM +0200, Geert Uytterhoeven wrote:
> Fix various grammar mistakes in the kerneldoc comments documenting the
> drm_mode_fb_cmd2 structure:
>   - s/is/are/,
>   - s/8 bit/8-bit/.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Simon Ser <contact@emersion.fr>

Thanks, documentation updates are always good.
Applied to drm-misc (drm-misc-next).


	Sam
