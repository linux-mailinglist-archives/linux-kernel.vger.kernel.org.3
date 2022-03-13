Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7690B4D73F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiCMJ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiCMJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:28:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A7FA22D;
        Sun, 13 Mar 2022 01:27:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DA62492;
        Sun, 13 Mar 2022 10:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647163634;
        bh=5fzYKPeKVvCjG/8w4Q5PwtknY0GBcf3hhFb+xSV4Duo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pqxofatWVI8GVPkQ0HFaYe4BvJ0C/aENfgfajKDN1vDh3Yo92r/8D6W8OeduuRIrv
         gDc99C1vX1orqCtnI1z44XT5J7QQVe9A1aBCF61RdvV5R0qUg99F0WetZU2frbp9Br
         4+MLCsPgv7AMnDfXoF/7uADBpvkx3Gfa7sCmkxDA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yi0IH48oA8ztvX8K@latitude>
References: <20220312203323.626657-1-j.neuschaefer@gmx.net> <Yi0F6mUm7iCRGvCt@pendragon.ideasonboard.com> <Yi0IH48oA8ztvX8K@latitude>
Subject: Re: [PATCH] docs: media: uvcvideo: Update mailing list address
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-uvc-devel@lists.sourceforge.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Sun, 13 Mar 2022 09:27:12 +0000
Message-ID: <164716363247.3407360.2736836911812651199@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-03-12 20:52:47)
> On Sat, Mar 12, 2022 at 10:43:22PM +0200, Laurent Pinchart wrote:
> > Hi Jonathan,
> >=20
> > Thank you for the patch.
> >=20
> > On Sat, Mar 12, 2022 at 09:33:22PM +0100, Jonathan Neusch=C3=A4fer wrot=
e:
> > > The mailing list address for UVC development has changed a while ago,
> > > but it was only updated in MAINTAINERS, not in the documentation.
> > > Update it there, too.
> >=20
> > Thanks for bringing this to my attention, I didn't know we were still
> > referencing that old list.
> >=20
> > How about moving to the linux-media@vger.kernel.org mailing list instead
> > ? I don't see many reasons to treat this driver with a special mailing
> > list anymore.
>=20
> Fine by me, but I'll wait for the opinion of others who more regularly
> contribute to the media subsystem.

Being subscribed to the linux-uvc-devel list, and seeing that it's a
black hole where people post, and unfortunately get very little to no
response I certainly concur that it needs to be changed.

I don't think we can guarantee a better response with linux-media, but
at least it's the right place, where the driver is actually maintained.

So I also believe it should be moved to linux-media.

--
Kieran


>=20
>=20
> Jonathan
