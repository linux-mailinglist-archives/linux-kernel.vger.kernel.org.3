Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E492146BE19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhLGOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:51:19 -0500
Received: from relay030.a.hostedemail.com ([64.99.140.30]:20730 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231565AbhLGOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:51:18 -0500
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 7494860943;
        Tue,  7 Dec 2021 14:47:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 6F0FE23;
        Tue,  7 Dec 2021 14:47:46 +0000 (UTC)
Message-ID: <f02e4204284af7ea848027a67cb1e907fb7d4403.camel@perches.com>
Subject: Re: [PATCH] media: i2c: ov8865: Neaten unnecessary indentation
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Dec 2021 06:47:45 -0800
In-Reply-To: <Ya9SlGo5HZpOXTmZ@valkosipuli.retiisi.eu>
References: <c6189daaac183ddf51da1444c597d8577c1ac416.camel@perches.com>
         <Ya9SlGo5HZpOXTmZ@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.46
X-Stat-Signature: dipi1pjbdm7m4be6zftskaoawejm7guy
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6F0FE23
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19b0PVynjlIVKtiQEFFQec/mlRK1V6C5ew=
X-HE-Tag: 1638888466-210967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-07 at 14:24 +0200, Sakari Ailus wrote:
> Hi Joe (and Paul),

> I guess this patch is fine as such but there seems to be a problem in error
> handling here: all regulators are disabled if there's a problem enabling
> one of them.
> 
> Would it be possible to fix this as well?

I've no hardware to test, so I've no idea if that's the right thing to do.


