Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5483847E8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbhLWUNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:13:16 -0500
Received: from relay033.a.hostedemail.com ([64.99.140.33]:57442 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233073AbhLWUNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:13:15 -0500
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id EB32A801BB;
        Thu, 23 Dec 2021 20:13:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 22B9920018;
        Thu, 23 Dec 2021 20:13:07 +0000 (UTC)
Message-ID: <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
From:   Joe Perches <joe@perches.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Thu, 23 Dec 2021 12:13:10 -0800
In-Reply-To: <20211223184856.v34ecibwzepahsju@uno.localdomain>
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
         <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
         <20211223184856.v34ecibwzepahsju@uno.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.29
X-Stat-Signature: ehpk47q155tcy3dg1zb1njgji99ohwrb
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 22B9920018
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18saZhjlvDXBc4d99IBoWG3sawjnxcJ5v8=
X-HE-Tag: 1640290387-824412
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 19:48 +0100, Jacopo Mondi wrote:
> The media subsystem requires to validate patches with
> 
>         ./scripts/checkpatch.pl --strict --max-line-length=80
> 
> We longly debated this and I believe it's now generally accepted to go
> over 80 when it makes sense, but not regularly span to 120 cols like
> in the previous version.

Where is this documented and do you have a link to the debate?

The archive for the i2c mailing list doesn't show much debate:

https://lore.kernel.org/linux-i2c/?q=%2280+columns%22
https://lore.kernel.org/linux-i2c/?q=%22line+length%22

Perhaps there should be a MAINTAINERS P: entry for this requirement.

From MAINTAINERS:

	P: Subsystem Profile document for more details submitting
	   patches to the given subsystem. This is either an in-tree file,
	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
	   for details.


