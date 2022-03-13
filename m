Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698EE4D75D7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiCMO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiCMO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:27:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D5C6242;
        Sun, 13 Mar 2022 07:25:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DF2C475;
        Sun, 13 Mar 2022 15:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647181552;
        bh=+R31GasfFNJAvD+168Wfu9KCxUt7oNMiXPUAQ5qTUCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQFVMPw8Z0kHghFhPjQi4iGGP0Z/JhlDlzdE7Xw05g0Pl19fb5Zhwq3rfV0JaWe6f
         L9hFk8OBhNubi+iig69qXIidMRBYCi5gh/1m77Ae6uLcU05X4//k6dessh2RV+7hlY
         YnWFHa7h479/XV8uXERiFZB4R/CimgGBQbo5k0x8=
Date:   Sun, 13 Mar 2022 16:25:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-uvc-devel@lists.sourceforge.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: media: uvcvideo: Update mailing list address
Message-ID: <Yi3+33EysD/JqCdr@pendragon.ideasonboard.com>
References: <20220312203323.626657-1-j.neuschaefer@gmx.net>
 <Yi0F6mUm7iCRGvCt@pendragon.ideasonboard.com>
 <Yi0IH48oA8ztvX8K@latitude>
 <164716363247.3407360.2736836911812651199@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164716363247.3407360.2736836911812651199@Monstersaurus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 09:27:12AM +0000, Kieran Bingham wrote:
> Quoting Jonathan Neuschäfer (2022-03-12 20:52:47)
> > On Sat, Mar 12, 2022 at 10:43:22PM +0200, Laurent Pinchart wrote:
> > > Hi Jonathan,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Sat, Mar 12, 2022 at 09:33:22PM +0100, Jonathan Neuschäfer wrote:
> > > > The mailing list address for UVC development has changed a while ago,
> > > > but it was only updated in MAINTAINERS, not in the documentation.
> > > > Update it there, too.
> > > 
> > > Thanks for bringing this to my attention, I didn't know we were still
> > > referencing that old list.
> > > 
> > > How about moving to the linux-media@vger.kernel.org mailing list instead
> > > ? I don't see many reasons to treat this driver with a special mailing
> > > list anymore.
> > 
> > Fine by me, but I'll wait for the opinion of others who more regularly
> > contribute to the media subsystem.
> 
> Being subscribed to the linux-uvc-devel list, and seeing that it's a
> black hole where people post, and unfortunately get very little to no
> response I certainly concur that it needs to be changed.
> 
> I don't think we can guarantee a better response with linux-media, but
> at least it's the right place, where the driver is actually maintained.
> 
> So I also believe it should be moved to linux-media.

Jonathan, would you send a v2 that references the
linux-media@vger.kernel.org list ?

-- 
Regards,

Laurent Pinchart
