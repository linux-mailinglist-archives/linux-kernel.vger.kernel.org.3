Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B856A477DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbhLPUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:33:38 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:47015 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhLPUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:33:34 -0500
Received: by mail-ot1-f41.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so288066oto.13;
        Thu, 16 Dec 2021 12:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfg8ACYlikMDDEUu3EXFo+9JtNm0KhnPtElu4BGn4Jw=;
        b=jGFDubQtTgLbgdk6gzHkhzpvhVTbIbfuaBdqJtUAwUnJYEd5gjLYZhonq8EuRFneng
         ci1f/jmL4ZgMWUlbTFkAwr5teyPgODGmQT8ZWzSR/pKRSBMzrcNYYNiUwV7ZXNEpEXIr
         JydPaVGAhMLmDnYtEvQz52NNFLBffAlQYoN/YXUhT9Th6uWLDGoK+uRGDuzXlR8Ms5j1
         Ra9KLhP88KRHnfKjsgsugJTRqpymFCN0ebLsz/fCV0QN/qEDTR+D5pTgNhoFeXI2K/px
         7tkTmw2gXF/Rm9Dw3IvFiLKcW9Dj+h7mS1TLbUU5T2CZ1HpWGfgUMKRjO6tfMW/aBMUo
         OKSw==
X-Gm-Message-State: AOAM531OEs+oz/ic1DjxlQA1IEC4x8QNbB8+qiTUrsJYAv50wGzz6Br6
        0u7tdAPVcxR9KDWC3bWc9mwODlb10w==
X-Google-Smtp-Source: ABdhPJyFHwjvpklpQVesYfYXxrlFzdhuIejqiguu1DyewZF/CSRFpeDC3+bPOv0TWVjolIjQnoArTg==
X-Received: by 2002:a05:6830:4389:: with SMTP id s9mr14117622otv.97.1639686813783;
        Thu, 16 Dec 2021 12:33:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t11sm1227217otj.24.2021.12.16.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:33:33 -0800 (PST)
Received: (nullmailer pid 708667 invoked by uid 1000);
        Thu, 16 Dec 2021 20:33:32 -0000
Date:   Thu, 16 Dec 2021 14:33:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 mux-states property
Message-ID: <YbuinMnaJHW/hUVQ@robh.at.kernel.org>
References: <20211216041012.16892-1-a-govindraju@ti.com>
 <20211216041012.16892-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216041012.16892-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:40:11 +0530, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceivers,
> muxes might need to be set. This can be implemented using mux-states
> property. Therefore, document the same in the respective bindings.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
