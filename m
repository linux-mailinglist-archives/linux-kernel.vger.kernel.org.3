Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64A48BCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiALBwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:52:10 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41521 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiALBwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:52:09 -0500
Received: by mail-ot1-f46.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso898146otj.8;
        Tue, 11 Jan 2022 17:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kEVlVJ4Edkop0dSQY1nK7II8j1hgTuqgH87pIrg722Q=;
        b=esJaHB7pRlek/c55CmZ6kHUY/JYlW/oR3n06t8z6nROaVpfpJ++Hfma+gsZnhmsJPW
         RRRY5l3G6f4DjcYMbODk45uU/svpLZXfHPX0Yp9L1WlkcG0DB6U579rvUYENSFbbiehT
         LuP2XLEnsFbZ7ZOoQJmVPCuow9GhuJxCL+P1iJrUfEgrIyTwE4XhcQuFSOzilnFU+kvP
         DaXv4R9G2/x3/FEH7RYkvsYBPpmT1bVDMaDPEXsops/I5VoY+D3DUv87DhzmdVHBc0dU
         LAce9VGPrKKPUpIxI1VMyKvmh9ByzZcM+12nn+tIGyyITS1ayNB/KsmA7OtKssrCK3eN
         QSfQ==
X-Gm-Message-State: AOAM5322xutbdRpXFPLSZguSAMrqntICweF6hX84RkDjoUsrUiHcfmjL
        sAnF7tYFjexSZEFpG2Bpgw==
X-Google-Smtp-Source: ABdhPJz/lHZhoExKw+pEmYSTX9nMuZgv/vMzKp7Pn+A4p1zM//uhs61WzkSapB1XYHIPnLOJcX/J0w==
X-Received: by 2002:a9d:60db:: with SMTP id b27mr5245119otk.154.1641952328708;
        Tue, 11 Jan 2022 17:52:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g2sm2293859oos.47.2022.01.11.17.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:52:08 -0800 (PST)
Received: (nullmailer pid 3900875 invoked by uid 1000);
        Wed, 12 Jan 2022 01:52:07 -0000
Date:   Tue, 11 Jan 2022 19:52:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, hsinyi@chromium.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, sam@ravnborg.org,
        devicetree@vger.kernel.org, airlied@linux.ie,
        thierry.reding@gmail.com
Subject: Re: [PATCH v2 2/2] dt-bindings: display: Add STARRY
 2081101QFH032011-53G
Message-ID: <Yd40Rxt3p7Dzuc4u@robh.at.kernel.org>
References: <20220107122208.3893-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20220107122208.3893-2-xiazhengqiao@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107122208.3893-2-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 20:22:08 +0800, xiazhengqiao wrote:
> Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
> QFH032011-53G.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/innolux,himax8279d.yaml     | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
