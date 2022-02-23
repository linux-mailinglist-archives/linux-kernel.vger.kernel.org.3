Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA964C1022
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiBWKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBWKTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:19:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F259A433B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:18:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE96C1042;
        Wed, 23 Feb 2022 02:18:56 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62EF63F70D;
        Wed, 23 Feb 2022 02:18:55 -0800 (PST)
Date:   Wed, 23 Feb 2022 10:18:51 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>, carsten.haitzler@foss.arm.com
Cc:     dri-devel@lists.freedesktop.org, brian.starkey@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, steven.price@arm.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/arm: arm hdlcd select DRM_GEM_CMA_HELPER
Message-ID: <20220223101851.46423dcf@donnerap.cambridge.arm.com>
In-Reply-To: <Ye/vEilz6j8gX3wu@e110455-lin.cambridge.arm.com>
References: <20220124162437.2470344-1-carsten.haitzler@foss.arm.com>
        <Ye/vEilz6j8gX3wu@e110455-lin.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 12:37:38 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

Hi,

> On Mon, Jan 24, 2022 at 04:24:37PM +0000, carsten.haitzler@foss.arm.com wrote:
> > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > 
> > Without DRM_GEM_CMA_HELPER HDLCD won't build. This needs to be there too.
> > 
> > Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
> > 
> > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>  
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> I will add Steven's reviewed-by as well when pushing it.

Did this go anywhere? I see my .config just selecting HDLCD still failing
with -rc5. Any chance this can be taken now, as this is a regression
introduced with -rc1?

Cheers,
Andre

> > ---
> >  drivers/gpu/drm/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> > index 58a242871b28..6e3f1d600541 100644
> > --- a/drivers/gpu/drm/arm/Kconfig
> > +++ b/drivers/gpu/drm/arm/Kconfig
> > @@ -6,6 +6,7 @@ config DRM_HDLCD
> >  	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
> >  	depends on COMMON_CLK
> >  	select DRM_KMS_HELPER
> > +	select DRM_GEM_CMA_HELPER
> >  	help
> >  	  Choose this option if you have an ARM High Definition Colour LCD
> >  	  controller.
> > -- 
> > 2.30.1
> >   
> 

