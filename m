Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8E5A8742
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiHaUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiHaUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:08:43 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6416CE319
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=myn8K7Qi8/yOzqs+Jb5il5/Psm+bREokbxVOA5/xdl0=;
        b=I4Xa9Fv768l8bcDgM4yTM9p/zK1ch2r5XyV8+nWrnYMRb4gvRWzs1r/0ZEEi/YR68Q7Mvkrtc0cUx
         KLjUAjtWdl95P5AJRPIZE7tcGzdTIGZw7IvT2enDNpAMAgUGm68ipAWnhirOmlkhCnZYyXgsIbcRJ/
         YZP0Fbrw68cIyU8XSngrkVQbyFdn2r/wLTHaknGVcl/ZyOWUip1V+eoWQrKdgVfL7OLjPOwkX1g/Qo
         aag8bERWsAjagIgHHg7Nyum2WABrphp8O5V44XlxdGgLMvXFXYaBEDaxr9+g+QGVtVIKhUl95t3Sxx
         +QxmVpTxMvFkxuy3FiqJ0GQbXL7xiZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=myn8K7Qi8/yOzqs+Jb5il5/Psm+bREokbxVOA5/xdl0=;
        b=BnKUVLaqh4cS8vfudhOXPmvL/+IJdnLCDCYkf0pl9ZUwxE2eExuWLq8B29jBRNsYV/H5i+KoIfn8s
         8wDjUvTBQ==
X-HalOne-Cookie: 6f714c8eedd12f07f61baf5246cf3974683ecdd7
X-HalOne-ID: b31eff44-2968-11ed-be88-d0431ea8bb03
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b31eff44-2968-11ed-be88-d0431ea8bb03;
        Wed, 31 Aug 2022 20:08:38 +0000 (UTC)
Date:   Wed, 31 Aug 2022 22:08:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/panel-edp: Fix typo in kerneldoc comment
 (appers=>appears)
Message-ID: <Yw+/xRdODPBl26Eh@ravnborg.org>
References: <20220720162314.1.Ieef5bc3848df40b71605b70bb571d6429e8978de@changeid>
 <CAD=FV=WC0QUaZsHQHhc+TAV2JXT64rnxDh9OvskpVrZAXzfz=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WC0QUaZsHQHhc+TAV2JXT64rnxDh9OvskpVrZAXzfz=Q@mail.gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Wed, Aug 31, 2022 at 08:03:11AM -0700, Doug Anderson wrote:
> Sam,
> 
> On Wed, Jul 20, 2022 at 4:23 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Ever since I got the spell-check working in my editor this one has
> > been bugging me. Fix it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index e6645d6e9b59..07a383dff548 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -53,7 +53,7 @@ struct panel_delay {
> >          * before the HPD signal is reliable. Ideally this is 0 but some panels,
> >          * board designs, or bad pulldown configs can cause a glitch here.
> >          *
> > -        * NOTE: on some old panel data this number appers to be much too big.
> > +        * NOTE: on some old panel data this number appears to be much too big.
> >          * Presumably some old panels simply didn't have HPD hooked up and put
> >          * the hpd_absent here because this field predates the
> >          * hpd_absent. While that works, it's non-ideal.
> 
> Maybe you'd be willing to give me an "Ack" for this stupid little
> patch so I can land it? ;-)
Certainly.
Acked-by: Sam Ravnborg <sam@ravnborg.org>
