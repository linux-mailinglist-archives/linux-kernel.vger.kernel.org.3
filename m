Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D794FAE63
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiDJPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiDJPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:13:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29513E2A;
        Sun, 10 Apr 2022 08:10:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62E4D482;
        Sun, 10 Apr 2022 17:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649603447;
        bh=EKSMvEVT58fRaDQ4LBXr1wUTIvlA9+5BdMvHsDAnBD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZas+GC+obmTLs0yI6Py/zm7x3J4R2OibbPyVjU5b74Vwk+KxvPMxC5r0lfBa9DKc
         bk4RuynoHGr7s2E22Rj8pfYG/nkdsqbw7P9hZDBIA8NNfnY9434Ppyyp1S063YJBck
         ee9SnAZ6izOotUJtPCb8VSYFiwHIdaYlHaBaJzTk=
Date:   Sun, 10 Apr 2022 18:10:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Ian Jamison <ian.dev@arkver.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: media-entity.h: Fix documentation for
 media_create_intf_link
Message-ID: <YlLzdbHTaQu01HKJ@pendragon.ideasonboard.com>
References: <21f190a8bb9ddaa43949b4455983bd66b4e11798.1649440397.git.ian.dev@arkver.com>
 <164953234079.22830.17385702287665697579@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164953234079.22830.17385702287665697579@Monstersaurus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 08:25:40PM +0100, Kieran Bingham wrote:
> Quoting Ian Jamison (2022-04-08 18:53:45)
> > The documentation comment was inserted between the return type
> > and the function name. Reunite the lines.
> > 
> > Signed-off-by: Ian Jamison <ian.dev@arkver.com>
> > Fixes: db7ee32aa185 ("[media] media-device.h: Improve documentation and update it")
> > ---
> >  include/media/media-entity.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> > index 742918962d46..9bc9a55df71e 100644
> > --- a/include/media/media-entity.h
> > +++ b/include/media/media-entity.h
> > @@ -1030,7 +1030,6 @@ __must_check media_devnode_create(struct media_device *mdev,
> >   * removed.
> >   */
> >  void media_devnode_remove(struct media_intf_devnode *devnode);
> > -struct media_link *
> 
> Eeep. I guess that was some sort of merge conflict resolution that
> didn't quite get it right sometime.
> 
> But definitely a good fix.
> 
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Indeed.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >  /**
> >   * media_create_intf_link() - creates a link between an entity and an interface
> > @@ -1061,6 +1060,7 @@ struct media_link *
> >   *    the interface and media_device_register_entity() should be called for the
> >   *    interface that will be part of the link.
> >   */
> > +struct media_link *
> >  __must_check media_create_intf_link(struct media_entity *entity,
> >                                     struct media_interface *intf,
> >                                     u32 flags);

-- 
Regards,

Laurent Pinchart
