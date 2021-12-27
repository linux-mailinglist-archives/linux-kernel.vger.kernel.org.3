Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5C48027D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhL0Q50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:57:26 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43707 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhL0Q5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:57:25 -0500
Received: by mail-qv1-f53.google.com with SMTP id fq10so14239193qvb.10;
        Mon, 27 Dec 2021 08:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9MD2ILL8cJCsMX2TWi0ZW0BbPKpv24auuKjJHOTHVE=;
        b=6jm1S5sdS+ZFdzQeiJT0HdBUJDuhFRHygGaVLHfCSFEP3Xj0S5DC9nyy9iYmMJfUGk
         lADbA68ojpDf4shvA+f5ZyaMnMQXuCANEVoFHwvDvK6mJeBA+ne26lE94E8T3/+74sAA
         +YiuPdmITbtEmDgzUxdugBD0e1oB4gid9NWUPlKeMZ/z3U5rTbKOhYVRgIl90Y9gizPP
         Pyy6zE363DkB/os7yWBEYuxCcifJUt9WxauaewZKp3gRB4cHOg9vAlzIzZcYqUvaRTyk
         SsUTeGmhgvHaXb48ImuwoJLVjxH57GE5df7mj2W/KIi1ulpbdAouk0feQkPu5zDEJoj7
         Wuww==
X-Gm-Message-State: AOAM530N/5v9sPfPKwoBrXkKidtQrtacqz6JNXbxAs65kxucCFaxCrN/
        dd+4tHvMcbfXXXLBFN2FSA==
X-Google-Smtp-Source: ABdhPJxKexGLS6oGqUfy3flP+Go9wPBi6+ZdDc6jbPj363M5hgtTre+ACko+KJJCU7CnuveKZggnfQ==
X-Received: by 2002:ad4:5aad:: with SMTP id u13mr16025862qvg.46.1640624245151;
        Mon, 27 Dec 2021 08:57:25 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id c7sm14263292qtx.67.2021.12.27.08.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 08:57:24 -0800 (PST)
Received: (nullmailer pid 653619 invoked by uid 1000);
        Mon, 27 Dec 2021 16:57:22 -0000
Date:   Mon, 27 Dec 2021 12:57:22 -0400
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v7 4/4] phy: dt-bindings: Add Cadence D-PHY Rx bindings
Message-ID: <YcnwcpPdOOJ7WgSe@robh.at.kernel.org>
References: <20211227105545.4852-1-p.yadav@ti.com>
 <20211227105545.4852-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227105545.4852-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 16:25:45 +0530, Pratyush Yadav wrote:
> The Rx mode DPHY is different from Tx mode DPHY. Add a separate binding
> for it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> (no changes since v6)
> 
> Changes in v6:
> - Add a new binding for DPHY Rx.
> 
>  .../devicetree/bindings/phy/cdns,dphy-rx.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

