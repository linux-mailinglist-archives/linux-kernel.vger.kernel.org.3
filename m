Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9410D49673F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiAUVTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:19:44 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37863 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiAUVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:19:42 -0500
Received: by mail-ot1-f52.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so13345350oto.4;
        Fri, 21 Jan 2022 13:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rwc9GxUTej2WnJMc0e3ALPik20sHOJTxdJgSjedRgYM=;
        b=U6YEnpJZiqg1PM1YZVt2OTnGtBR2T4CbKPkGFv7ZQLvrwRxOFK+1aoGkyt35MA+Kv6
         pBXEzSDZZomYvU4gZLDlr7VyQ6PzyRE3M36Z4L2nBwxOpqxjdn4l5WFc93qiHjIt6brs
         heoHIWbtjw7KmA8cI0W662h1Y0i05EMTFYmq6vVrgF+GzGJGZkQDii1MpswoGcjl9LVn
         h3GUo8HcHD0Swhg/6nNUQNhvEq+bfC0AFKKD9mtZsLffnLy+EcVVHq8Vdi1yU6ucNMkg
         cDUcZ7K1WF7Y3vLgKA9wuU4R05fU1eiZYTwfxGCKWAlf2gexguZIHYbA8ZfVHjr3dTUg
         WUCQ==
X-Gm-Message-State: AOAM5312vrCNAcb42qhQY7maVNEdPe5MO6SuLaYOpE0dXGouJdl4QjQv
        qQ+cORA6AyjKnuuc4XHweQ==
X-Google-Smtp-Source: ABdhPJzbNnH7DDBGJ2KNG4hBF2gFhO9Qk8NiQerrT9EGNcWyi7kzEHZbIoK+YEXVUQe0ZMgoi4p0gg==
X-Received: by 2002:a9d:57ca:: with SMTP id q10mr4195836oti.180.1642799982173;
        Fri, 21 Jan 2022 13:19:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g2sm1614084oic.40.2022.01.21.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:19:41 -0800 (PST)
Received: (nullmailer pid 1602431 invoked by uid 1000);
        Fri, 21 Jan 2022 21:19:40 -0000
Date:   Fri, 21 Jan 2022 15:19:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     robh+dt@kernel.org, miquel.raynal@bootlin.com, vigneshr@ti.com,
        richard@nod.at, chenshumin86@sina.com,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 1/3] dt-binding: mtd: nand: Document the wp-gpios property
Message-ID: <YesjbOzh+B00dKIh@robh.at.kernel.org>
References: <20220105135734.271313-1-christophe.kerello@foss.st.com>
 <20220105135734.271313-2-christophe.kerello@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105135734.271313-2-christophe.kerello@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jan 2022 14:57:32 +0100, Christophe Kerello wrote:
> A few drivers use this property to describe the GPIO pin used to protect
> the NAND during program/erase operations.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
