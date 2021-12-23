Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFE47E8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350236AbhLWU1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:27:43 -0500
Received: from relay034.a.hostedemail.com ([64.99.140.34]:59301 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234114AbhLWU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:27:42 -0500
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 02B37217FD;
        Thu, 23 Dec 2021 20:27:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 6C5576000D;
        Thu, 23 Dec 2021 20:27:34 +0000 (UTC)
Message-ID: <2135f71822711698ecfdaa5f0267e0324e424248.camel@perches.com>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
From:   Joe Perches <joe@perches.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Thu, 23 Dec 2021 12:27:36 -0800
In-Reply-To: <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
         <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
         <20211223184856.v34ecibwzepahsju@uno.localdomain>
         <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6C5576000D
X-Spam-Status: No, score=-3.40
X-Stat-Signature: oryznni7orai4xz5hpb9rarsuzeeq18h
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/LvrMcnUh7u0lsb7sYPZ7gbjNPuYXMEfA=
X-HE-Tag: 1640291254-457205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 12:13 -0800, Joe Perches wrote:
> On Thu, 2021-12-23 at 19:48 +0100, Jacopo Mondi wrote:
> > The media subsystem requires to validate patches with
> > 
> >         ./scripts/checkpatch.pl --strict --max-line-length=80
> > 
> > We longly debated this and I believe it's now generally accepted to go
> > over 80 when it makes sense, but not regularly span to 120 cols like
> > in the previous version.
[]
> Perhaps there should be a MAINTAINERS P: entry for this requirement.
> 
> From MAINTAINERS:
> 
> 	P: Subsystem Profile document for more details submitting
> 	   patches to the given subsystem. This is either an in-tree file,
> 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
> 	   for details.

Perhaps:
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd55b83878e05..bbfcb8e7eef06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11977,6 +11977,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	https://linuxtv.org
 Q:	http://patchwork.kernel.org/project/linux-media/list/
+P:	https://linuxtv.org/downloads/v4l-dvb-apis-new/driver-api/maintainer-entry-profile.html
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/
 F:	Documentation/devicetree/bindings/media/


