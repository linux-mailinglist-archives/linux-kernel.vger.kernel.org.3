Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D756C9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiGIN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGIN7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:59:46 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F54B49C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=qmSXrQqQPnUeVixSZnTwQsHAv2zMlHF8R2fXz2Y+WvY=;
        b=VZjAkbqiqT97vm4Mjs1Jtdo6B4pu9X3K4Iex3icvx8Kwb0NXpurwO6wYzlj2Ij8DpBaD/9s8lRZSH
         xaO95rTMAeNknAi4zH5sflAdAhrL9LK24LcfXX/SvcymMYIwBrdup+NKw2+2ydcsU27P+/rV0khH4R
         kNLGXh1UgHIdOM8/W2EFA8lq6RexLK+GUw+zTalZzEaWhsgJci2ocYDbGsYn1IiHAJ8oSdYxTY6Eag
         XtQTDm7JyIWQcFSsvljHIodTdEchRrPtChvfFbjbNAZqC3bvMKkV0w0iAGN/el2JJSURAS6WjMOcV+
         sWCav05b99IO8pw8FLCcMPhCb3CVW+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=qmSXrQqQPnUeVixSZnTwQsHAv2zMlHF8R2fXz2Y+WvY=;
        b=MaA0fkVFc3cjNqi60JC5wVUEJ0E0/EWST7AdiwaxdpUysrELN2WElO1VWCznd9Q7lLRs142GioXmo
         Dw95vlWAA==
X-HalOne-Cookie: 2d696c14001945be91871b78f5f38f0aa678b7d9
X-HalOne-ID: 61abb408-ff8f-11ec-a6c6-d0431ea8a283
Received: from mailproxy2.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 61abb408-ff8f-11ec-a6c6-d0431ea8a283;
        Sat, 09 Jul 2022 13:59:42 +0000 (UTC)
Date:   Sat, 9 Jul 2022 15:59:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/fb: Improve drm_framebuffer.offsets documentation
Message-ID: <YsmJzeCfv/rXESwT@ravnborg.org>
References: <33fda13b500b39645e7363806c6e458e915b581e.1657113304.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fda13b500b39645e7363806c6e458e915b581e.1657113304.git.geert@linux-m68k.org>
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

On Wed, Jul 06, 2022 at 03:16:18PM +0200, Geert Uytterhoeven wrote:
> Fix various spelling and grammar mistakes in the kerneldoc comments
> documenting the offsets member in the drm_framebuffer structure:
>   - s/laytou/layout/,
>   - Add missing "is",
>   - s/it/its/.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Simon Ser <contact@emersion.fr>
More doc improvements - good!
Applied to drm-misc (drm-misc-next).

	Sam
