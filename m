Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9405463F84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbhK3U5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:57:43 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44949 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbhK3U4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:56:16 -0500
Received: by mail-oi1-f178.google.com with SMTP id be32so43730118oib.11;
        Tue, 30 Nov 2021 12:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HlsKHoix406Bz1fj7Ez//AslfGn8j8E55KC5dF2WDG8=;
        b=dt9bkkjiq01A1ZgH8NFC1OyqtpwMwk7PuUHYeMwAC7sfcbbHddT+YFY7GIzorCWq77
         m6MoG52jgcGhXJVinv9GJsW+H6xB9jG/L/6ReKV3J3OARhKrsJW8I1UcqvtQoSGnUWfT
         fHmaFKOmAb+7a3HifDX++V7SFqnl2LBmUdehfldn3yR7FLkPCcOCWqIBQrZhzZU8VYmy
         PHYkWHbAh4c+4jVB84fT4W5UMLzS+cBIsMIGlS6OyASsCMS2SIvRM/dopKbSCT7+vtrY
         tJi4ogAJJTC4nyO9k/AwHzvh4jA3/zs+WHHJJbmLfWyq0AN8Kpzj/fi+ns+kTcsGO/eG
         7TMw==
X-Gm-Message-State: AOAM532/rUSJXljX8F4wQqcNdcsmsGZa/QIwHC6MlvcyYgGDsR4aFKiq
        GjQHKAkHzEXoxPsc8NoB0w==
X-Google-Smtp-Source: ABdhPJzKPfTvoIGTUR7A+JSklYueOPXoIH7lvFav4AkVhEUXUVdHDV5yssMtjICrOjb3lQTMY4iW4w==
X-Received: by 2002:a05:6808:11c1:: with SMTP id p1mr1468996oiv.113.1638305575830;
        Tue, 30 Nov 2021 12:52:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc7sm3024385oob.35.2021.11.30.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:52:55 -0800 (PST)
Received: (nullmailer pid 2994549 invoked by uid 1000);
        Tue, 30 Nov 2021 20:52:54 -0000
Date:   Tue, 30 Nov 2021 14:52:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, a-govindraju@ti.com
Subject: Re: [PATCH 2/4] dt-bindings: remoteproc: k3-dsp: Update bindings for
 J721S2 SoCs
Message-ID: <YaaPJrqtU7Ifoe8M@robh.at.kernel.org>
References: <20211122122726.8532-1-hnagalla@ti.com>
 <20211122122726.8532-3-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122122726.8532-3-hnagalla@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 06:27:24 -0600, Hari Nagalla wrote:
> The TI K3 J721S2 SoCs have two TMS320C71x DSP subsystems, and does not
> have any TMS320C66x DSP subsystems. The C71x DSP subsystem in J721S2
> SoCs is a similar to the C71x DSP on J721e with some minor core IP updates.
> 
> Compatible info is updated for intuitvely matching to the new J721S2
> SoCs.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
