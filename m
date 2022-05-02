Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69DE517782
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351078AbiEBTpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiEBTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:45:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5863F6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:41:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E27C1484;
        Mon,  2 May 2022 21:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651520489;
        bh=7fS1iDiQS0BFHXb6Blv7uJsVuEU2kQ6EnwifQcIZAzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6vTOnaYs7l4Xlv3+utCAZq5wLz1L8z9dE5E8+De/yg2+Pma+zdmoo/867c5Ze76+
         exCdf2KgzXrGOkXEsHqhG4eyuJpbCE1tqzVXQPVbHV8+oMRr0hcpp/eZbX9GD6wYiL
         rZ001sxYlJkkZ4F/yveoIbAQI0FZ6+DVNlid2hh0=
Date:   Mon, 2 May 2022 22:41:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Message-ID: <YnAz6HPPfWpYcZvF@pendragon.ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
 <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
 <5dd80287-1b09-d02c-9f67-5a0bb0a4566c@redhat.com>
 <bc6b6598-0e09-1a43-4086-e4164ab42a20@redhat.com>
 <YnAkwRL7b++a0omG@pendragon.ideasonboard.com>
 <21db3772-b85a-59ff-df17-9056b3099977@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21db3772-b85a-59ff-df17-9056b3099977@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:28:45PM +0200, Javier Martinez Canillas wrote:
> On 5/2/22 20:36, Laurent Pinchart wrote:
> > On Mon, May 02, 2022 at 07:15:16PM +0200, Javier Martinez Canillas wrote:
> >> On 5/2/22 18:55, Javier Martinez Canillas wrote:
> >>
> >> [snip]
> >>
> >>>> drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
> >>>> comment in drm_fbdev_generic_setup() that could be related.
> >>>
> >>> A FIXME makes sense, I'll add that to when posting a v3.
> >>
> >> There's actually a FIXME already in drm_fbdev_generic_setup(), so it's
> >> a documented issue [0]:
> > 
> > That's what I meant by "there's a FIXME" :-) It doesn't have to be
> > addressed by this series, but it would be good to fix it.
> 
> doh, I misread your original email. Yes, it's the same issue as you
> said and something that I plan to look at some point as a follow-up.
>  
> I hope that we could just replace fbcon with a kms/systemd-consoled/foo
> user-space implementation before fixing all the stuff in the DRM fbdev
> emulation layer :)

If you can do that, I'll provide champagne :-)

-- 
Regards,

Laurent Pinchart
