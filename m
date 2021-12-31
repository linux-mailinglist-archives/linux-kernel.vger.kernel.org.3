Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5154823F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 13:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhLaMSH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Dec 2021 07:18:07 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46505 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhLaMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 07:18:07 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9405A1BF206;
        Fri, 31 Dec 2021 12:18:04 +0000 (UTC)
Date:   Fri, 31 Dec 2021 13:18:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 2/2] memory: omap: drivers for v5.17
Message-ID: <20211231131803.08fb5d49@xps13>
In-Reply-To: <20211230164901.4fbf8cc3@xps13>
References: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
        <20211224111124.6097-2-krzysztof.kozlowski@canonical.com>
        <20211230164901.4fbf8cc3@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

miquel.raynal@bootlin.com wrote on Thu, 30 Dec 2021 16:49:01 +0100:

> Hi Krzysztof, Arnd, Olof,
> 
> krzysztof.kozlowski@canonical.com wrote on Fri, 24 Dec 2021 12:11:24
> +0100:
> 
> > Hi Arnd and Olof,
> > 
> > Separate topic branch for omap-gpmc driver. This includes changes to
> > mtd-nand-omap2 driver (acked by Miquel) *which will conflict NAND tree*:
> > 
> > 1. The "of_device_id omap_nand_ids" is moved to header
> >    ../platform_data/mtd-nand-omap2.h.
> > 2. New compatible is added to above "of_device_id omap_nand_ids".
> > 
> > One way to avoid pushing this conflict to Linus, would be if Miquel would
> > actually pull this request instead of soc tree.  
> 
> Sorry for the mess, I didn't spot the conflict when sending my Ack to
> Krysztof.
> 
> I will pull this to simplify the handling.

Pulled into nand/next, thanks!

Miquèl
