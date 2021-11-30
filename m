Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C923A4628E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhK3AOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:14:07 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34524 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhK3AOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:14:06 -0500
Received: by mail-ot1-f41.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso27869701otj.1;
        Mon, 29 Nov 2021 16:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HjBj/jKHWaPQjFVKBigK4YEQASVtPjYk7XYlAt0lGg=;
        b=c0a4vv9PNoe8fm1OL1hy9fT++D8HtVLejt11l164UmA4/qZawf/LoZvg+fMcksFitB
         avFdXb+zcujg544Pf4WYseI+yoi5fTZskLvNKMOavDvjnK1Qhm/3+Awh2k5PAugspfHI
         +vbbzAN/RNCpKan2g7fYUiKN5OJ8qMp6i0Bu348NsklbTL6irwRrSllpT3qdXRGVTF0A
         fRP/O9tyssMuojKZAjI2qoJ0Pzpda24NbdWu7j8ciSGjNboFHfYLQdUCBOYWvJMmHCW3
         Frycn1gWfMsOs1pfy1ZrwvDCtTOklSRcVsFmz/ftkqBwgQHSq/6GY8c8bqzLaAM8iXiW
         HyQQ==
X-Gm-Message-State: AOAM530JZhbmaOAB20/hTwVeK0OYvaaVLgNy+uvpDekqElPd3/g3C2kq
        B5gz+f+JCd0Jpc1Oh8Ya0Q==
X-Google-Smtp-Source: ABdhPJwJXBfBLL+8ZLBSSa9s9id8tGVQrAxeNCVao8sQfHBRSZDV1GAI8sTnPp44HtPYEI+/9h/vPg==
X-Received: by 2002:a9d:2077:: with SMTP id n110mr46214953ota.261.1638231048213;
        Mon, 29 Nov 2021 16:10:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm2598918oog.43.2021.11.29.16.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:10:47 -0800 (PST)
Received: (nullmailer pid 868376 invoked by uid 1000);
        Tue, 30 Nov 2021 00:10:46 -0000
Date:   Mon, 29 Nov 2021 18:10:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: arm: ti: Add bindings for J721s2 SoC
Message-ID: <YaVsBk2CQf7FwnJq@robh.at.kernel.org>
References: <20211119133052.17793-1-a-govindraju@ti.com>
 <20211119133052.17793-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119133052.17793-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 19:00:46 +0530, Aswath Govindraju wrote:
> Add binding for J721S2 SoC
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
