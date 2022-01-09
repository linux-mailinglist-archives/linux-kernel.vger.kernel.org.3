Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433D9488BE5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiAITCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:02:02 -0500
Received: from relay026.a.hostedemail.com ([64.99.140.26]:60567 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229582AbiAITCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:02:02 -0500
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 08E33604A7;
        Sun,  9 Jan 2022 19:01:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 5772F20024;
        Sun,  9 Jan 2022 19:01:53 +0000 (UTC)
Message-ID: <9011348fd53b35857afb6a65f5d3163adec9a923.camel@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
From:   Joe Perches <joe@perches.com>
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Sun, 09 Jan 2022 11:01:52 -0800
In-Reply-To: <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
References: <m3czl9eylt.fsf@t19.piap.pl> <m34k6leyb1.fsf@t19.piap.pl>
         <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.87
X-Stat-Signature: 6bg6f45dt746mue5c8rib6zi6pe6efb6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5772F20024
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/BA1xNhmFMhCYZ8dmyxVvDk5TbaYHhH3E=
X-HE-Tag: 1641754913-479941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-01-09 at 16:34 +0100, Jacopo Mondi wrote:
> Hi Krzysztof

Hi Jacopo

Can you please trim your replies to just the sections that
you are commenting on?

Finding the reply in the duplicated reply content isn't easy.

> > +	// access the sensor only if it's powered up
> > +	if (!pm_runtime_get_if_in_use(&sensor->i2c_client->dev))
> 
> As you correctly do not access the chip's registers if it's powered
> off, you have to call __v4l2_ctrl_handler_setup() at power on time to
> make sure controls are actually set.

It was 25 pages down in the reply to find this.


