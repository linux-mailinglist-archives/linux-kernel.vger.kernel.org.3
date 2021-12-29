Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100D94815A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhL2RNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:13:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34986 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhL2RNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:13:44 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25D7B71;
        Wed, 29 Dec 2021 18:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640798022;
        bh=+GoLFlShimUPmotDVHXML+tvcBX4Qdq5wGOanFJynoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzvVQ4l5+jfdGLDxPAv48qHXCY3Nb6Re8qFKu/gAkVcr6Tk5ZnR8KValwP9RVuFGi
         qOloBJ/AToz2Jl2EPffoixwcuRuikrgkNv28+TxmC/Lq41plBYam4hzMKSzFX11Um5
         IcUVFKeFLj2Us0A68nwjEsyQrbNOY/s0vs0VXJ5U=
Date:   Wed, 29 Dec 2021 19:13:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Message-ID: <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
 <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Dec 29, 2021 at 08:04:18PM +0300, Nikita Yushchenko wrote:
> Hi.
> 
> Thank you for looking at this.
> 
> >> +				port@1 {
> >> +					reg = <1>;
> >> +					lvds0_out: endpoint {
> >>   					};
> > 
> > Endpoints must have a remote-endpoint property. Let's drop the endpoint
> > here and keep the port only, the endpoint can be declared in board
> > files.
> > 
> > If you're fine with this change I can make it when applying the patch.
> 
> This empty endpoint is currently defined in dtsi files for other r-car
> gen3 SoCs.
>
> Goal here is to define lvds0_out label that is then used in extension
> board dtsi files to link to the port.
> 
> In this patch I just used the same approach as in files laying nearby.
> 
> If this approach is not appropriate, then perhaps need to fix it in
> files for all SoCs, to make it possible for extension board dtsi to be
> compatible with all of them.

I'm writing a patch to drop those right now :-) I'll CC you.

-- 
Regards,

Laurent Pinchart
