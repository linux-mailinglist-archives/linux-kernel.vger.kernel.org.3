Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB14A91B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356264AbiBDAit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiBDAiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:38:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A63C061714;
        Thu,  3 Feb 2022 16:38:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC42049C;
        Fri,  4 Feb 2022 01:38:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643935124;
        bh=x79wgQfEJfv0EeWkYy8ffcc5rx2aj3gmAeMONQ+Np/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5+J636Wda49VRNBpSSjR+A/VLEcBvD1SFFqaokXvyGm+pm46ytwdiGWKRdThgNH6
         fAQc92e0dLU1r4nLHlbq8gmMLluY5JdjZ3s8DY9Vz+5fYQ7qzb/f8KjBzvbpXAiB/l
         VecmrJIa921C3wgEfe9AB9nQshfyAspSA9aeMlyY=
Date:   Fri, 4 Feb 2022 02:38:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v4 00/12] Add support for BCM2835 camera interface
 (unicam)
Message-ID: <Yfx1fDmf4NajOpXq@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <d72273ca-664c-3eb2-74d0-845d956b0672@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d72273ca-664c-3eb2-74d0-845d956b0672@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, Feb 03, 2022 at 08:55:42PM +0100, Stefan Wahren wrote:
> Am 03.02.22 um 18:49 schrieb Jean-Michel Hautbois:
> > Hello !
> >
> > This patch series adds the BCM2835 CCP2/CSI2 camera interface named
> > unicam. This driver is already used in the out-of-tree linux-rpi
> > repository [1], and this work aims to support it in mainline.
> >
> > The series is based on top of:
> > - Rebased on top of 5.16 Tomi Valkeinen's multiplexed stream work, on
> >   his multistream/work branch [2] which has been submitted as v10 at the
> >   time of this writing. The objective is to demonstrate the use of
> >   multiplexed streams on a real world widely used example as well as
> >   supporting unicam mainline.
> > - The "Add 12bit and 14bit luma-only formats" series [3] is partly
> >   applied (the Y10P format bug) the new formats are now part of this
> >   series.
>
> i understand, that you want to have this integrated fast but you send v3
> of this series yesterday. This is not enough time for reviewers. Usually
> 1 to 2 weeks.

v3 was incorrectly based on the out-of-tree ISP driver, which caused
some patches to not apply correctly on top of mainline. I've asked
Jean-Michel to fix this and send a v4, as it was difficult to review v3.

-- 
Regards,

Laurent Pinchart
