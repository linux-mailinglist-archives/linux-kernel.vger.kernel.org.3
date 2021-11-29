Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4168E462377
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhK2Vmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:42:40 -0500
Received: from meesny.iki.fi ([195.140.195.201]:35944 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhK2Vkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:40:39 -0500
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 70C8720225;
        Mon, 29 Nov 2021 23:37:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1638221839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKKX3vFttQ5v+UXIzen9N9yuqDMc3m8ScyaP2x4aMhw=;
        b=t4t+YJxbXt/UVDkHTC70AvE72123XPCjYb11CQBuBdFrjXHtx2u0FvyhV2jQ17xMpV29qT
        NPqD5vosh1fO2Z/Zcu54YHQ081AzLGeLEix6W+qUS1qS6NEok8gwkQIU3r+c2/RDGI19Fz
        9EC1j5/T+PDX5vII05wxdxWz1dZTFZ0=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id E2313634C90;
        Mon, 29 Nov 2021 23:37:18 +0200 (EET)
Date:   Mon, 29 Nov 2021 23:37:18 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Rob Herring <robh@kernel.org>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jacopo@jmondi.org, laurent.pinchart@ideasonboard.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 02/25] dt-bindings: media: atmel: csi2dc: add bindings
 for microchip csi2dc
Message-ID: <YaVIDgn1d2BHv6XZ@valkosipuli.retiisi.eu>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-3-eugen.hristev@microchip.com>
 <YaVBwjtEI3xcL551@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaVBwjtEI3xcL551@robh.at.kernel.org>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1638221839; a=rsa-sha256; cv=none;
        b=uYeGf2vGyBLXQ3U7bSdPwhvq3WEmLGE9ESl89yK2x6/LYQSzVkW7Ya+j0giPxfJxWBC2XZ
        qMiG6ugoswRz2yjF810ggEJVP6Krm85TdlhWPW8+RBsV9OFgfC+2LP0sF+5IkTZMYmyROX
        3R+RM+VG0o7pmYqEjPdP16m1QrRaths=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1638221839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKKX3vFttQ5v+UXIzen9N9yuqDMc3m8ScyaP2x4aMhw=;
        b=JET/nEPi2ZU4kIef16GHzK6YQA8PLL+yLDmzbAaDfYiIsA39g17ar2XzzGfm5hbReRRWHn
        5S91Ub81+QTvS3Wpq5JpVmRzQiR+jNPh0mih5oCw6QLVeNIq++UYd53EXDpLT5pWKvldaD
        ytgwTMIphOTB0qHyU1d9rrpvp/xsdpk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Eugen,

On Mon, Nov 29, 2021 at 03:10:26PM -0600, Rob Herring wrote:
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> 
> But what properties from this do you use? It doesn't look like you need 
> this?

I'd expect to see data-lanes at least --- unless the number of lanes is
really fixed.

-- 
Sakari Ailus
