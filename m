Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19234A9C22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359796AbiBDPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiBDPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:41:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 108A0B837EE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE15C004E1;
        Fri,  4 Feb 2022 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643989311;
        bh=GkwaM++Cb1f0h4lj1C4y87jTmDMs+beC7xUIl2GD/QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1Msp/kKQeVaBUeJ3sjJ25M9iOxYSdS3VNGsGQ+pbc1x3DLRfhvy0Ksi7f0S+Lc7u
         ffStc+iYl2foM+rokVeUNG8Wu08bkEenQsdRGxzbfLrnxihSoAIx0Hh+iHiscZ/K0Q
         P5K7yDRe7ZUo3HNDIDkI/S8NhE3EhOa7MdxVXtoU=
Date:   Fri, 4 Feb 2022 16:41:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, bp@suse.de,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Subject: Re: [PATCH v2] drivers/firmware: Add missing platform_device_put()
 in sysfb_create_simplefb
Message-ID: <Yf1JPCD1L4qt0T2c@kroah.com>
References: <735d2b47-227f-f09d-ddd6-28bc82a066a5@redhat.com>
 <20220116121654.7730-1-linmq006@gmail.com>
 <259abc88-58ac-9101-21a1-5130168fcdac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <259abc88-58ac-9101-21a1-5130168fcdac@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 06:31:09PM +0100, Javier Martinez Canillas wrote:
> On 1/16/22 13:16, Miaoqian Lin wrote:
> > Add the missing platform_device_put() before return from
> > sysfb_create_simplefb() in the error handling case.
> > 
> > Fixes: 8633ef8 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > Changes in v2:
> > - Use goto label to avoid duplicating the error code logic.
> > ---
> >  drivers/firmware/sysfb_simplefb.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Does not apply to my tree :(
