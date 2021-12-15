Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6446475414
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbhLOIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:07:19 -0500
Received: from relay036.a.hostedemail.com ([64.99.140.36]:4968 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236140AbhLOIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:07:17 -0500
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 536E0220BF;
        Wed, 15 Dec 2021 08:07:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 3DB5F3B;
        Wed, 15 Dec 2021 08:07:15 +0000 (UTC)
Message-ID: <8541216a98a1a68fe6c339096e5e148a40b414e2.camel@perches.com>
Subject: Re: [PATCH] media: i2c: ov8865: Neaten unnecessary indentation
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Dec 2021 00:07:14 -0800
In-Reply-To: <Ybmgwo/6bQXtaT35@valkosipuli.retiisi.eu>
References: <c6189daaac183ddf51da1444c597d8577c1ac416.camel@perches.com>
         <Ya9SlGo5HZpOXTmZ@valkosipuli.retiisi.eu>
         <f02e4204284af7ea848027a67cb1e907fb7d4403.camel@perches.com>
         <Ybmgwo/6bQXtaT35@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3DB5F3B
X-Spam-Status: No, score=-4.88
X-Stat-Signature: km5npprd61ewifgnwhqgxggaz4ngo19e
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+1G938b2DUMZ6I57iIh8PxrMvSJ4wkvwo=
X-HE-Tag: 1639555635-293209
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 10:01 +0200, Sakari Ailus wrote:
> Hi Joe
> 
> On Tue, Dec 07, 2021 at 06:47:45AM -0800, Joe Perches wrote:
> > On Tue, 2021-12-07 at 14:24 +0200, Sakari Ailus wrote:
> > > Hi Joe (and Paul),
> > 
> > > I guess this patch is fine as such but there seems to be a problem in error
> > > handling here: all regulators are disabled if there's a problem enabling
> > > one of them.
> > > 
> > > Would it be possible to fix this as well?
> > 
> > I've no hardware to test, so I've no idea if that's the right thing to do.
> 
> I don't have the hardware either.
> 
> But I can tell that you shouldn't disable a regulator you haven't enabled
> to begin with. Bugs (fixes of which probably should go to stable trees)
> need to be fixed before reworking the code.

I'm just fixing the ugly code.
You are welcome to fix what you believe to be logical defects.


