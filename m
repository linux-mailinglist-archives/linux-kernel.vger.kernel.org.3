Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E040B48492D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiADUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:19:55 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40683 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiADUTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:19:54 -0500
Received: by mail-oi1-f178.google.com with SMTP id t204so55125748oie.7;
        Tue, 04 Jan 2022 12:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JU3YxFB52PXiaktroyfFxCwFiWKwaJLFZ+J4SpulZrY=;
        b=h5qv3FSnlL+mU1HA+vglBQVyhKBU0a1FypwVqV/flaeqq1/Mg6A66LWqJ3CXVXXXBc
         xSEb1ljIu8ylhp3FyESbdGKRwLHscRY5IlrCyp42KAKxh3/uOSfFxyiQcqJbRUrpKFzA
         SQJZB/eyOIrbKK981HVAYADZYvkTjQMml+yLvQJxU0QU4q9JrrCrHp1jy1nOx1a/VN6M
         y270nj2YKqhH/koFLA59wyCW1yhVmnFvjdN1xreNa9NGUZHp5wzk+kG5kZXI3BiqvHeI
         5jVaFpY3UMP3QeCVaqosVDVwaGA/vU16VK2eues14EiXwCnQpFZRaVvLQj7NoUCX1FG5
         1sDg==
X-Gm-Message-State: AOAM530eCzwbq9P1dzKfhlWwywTEssWyzKQ6Irp2FniUuJPROxktjL3I
        2xuixP+rDhgK7kkPu9i6IQ==
X-Google-Smtp-Source: ABdhPJzg/5ZbwfBsBd3FVkUulGU27IW4zZa7wXzlxLvhJNuLo5tj2ccHZmRvMMKYadsGKx+lV3oOkQ==
X-Received: by 2002:aca:44c1:: with SMTP id r184mr35857oia.15.1641327594065;
        Tue, 04 Jan 2022 12:19:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k10sm9924883oil.36.2022.01.04.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:19:53 -0800 (PST)
Received: (nullmailer pid 1351192 invoked by uid 1000);
        Tue, 04 Jan 2022 20:19:52 -0000
Date:   Tue, 4 Jan 2022 14:19:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/3] dt-bindings: display: bridge: renesas,lvds: Document
 r8a77961 bindings
Message-ID: <YdSr6PuKvL3JOc6O@robh.at.kernel.org>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-4-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224052309.1997096-4-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 08:23:09 +0300, Nikita Yushchenko wrote:
> Document the R-Car M3-W+ (R8A77961) SoC in the R-Car LVDS encoder
> bindings.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  .../devicetree/bindings/display/bridge/renesas,lvds.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
