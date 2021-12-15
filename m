Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0984762DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhLOUNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:13:43 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41846 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLOUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:13:42 -0500
Received: by mail-ot1-f51.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so26300944otl.8;
        Wed, 15 Dec 2021 12:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPQ87d8QvmM6qxdlruPSM0k5IOysfGIQENHR+EofinE=;
        b=lqOzMI7XKSeuiuwNv+qmIGNQ2w8a8aaGEVCvaLYH61NSicviZHtsgmytL4ZFxcznKK
         sl2WyrNvz7z29oK6K7W9XNUUVZQqMkzrMWUcIkeLMZPqMfOfy57whzkTP2IXxbLpGHDF
         gO/XYbUvAEBp3WYYK4xG/ihoRpRUowzkaweOS4Mz644G5fQCWXd+NYUIteZSXeH9c7sl
         0HYd9cRG5aeK7D698H4D1dq8KZggTWQdlqCYfGLzYLCBmZyC7rVNvc4IKOD/J/wydXsR
         1bBkMgk6zbi0+9CHuchEQLfw8oZRpD6YT5yv0jDbDYRO45RC3RnsgrzWKgXy738TNO4W
         nmTA==
X-Gm-Message-State: AOAM531NwpitQFz1CG97fkBSVR5mFzqYi4smJVprK5u+UkYU7zmT+4ah
        oenw/4kFZW7EY09AWQOeHg==
X-Google-Smtp-Source: ABdhPJwC1tIXdQafpPW2w+DI5hIKTJcUxGWJ0nBo+2J2/MJcrTpbq1kQ5CzII3k4Decz26ON0nmmdA==
X-Received: by 2002:a05:6830:3110:: with SMTP id b16mr10290669ots.212.1639599221490;
        Wed, 15 Dec 2021 12:13:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm526349oig.15.2021.12.15.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:13:40 -0800 (PST)
Received: (nullmailer pid 1759973 invoked by uid 1000);
        Wed, 15 Dec 2021 20:13:39 -0000
Date:   Wed, 15 Dec 2021 14:13:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wesley Cheng <wcheng@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 bindings for SM8450
Message-ID: <YbpMc095FkeEAO9T@robh.at.kernel.org>
References: <20211213131450.535775-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213131450.535775-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 18:44:48 +0530, Vinod Koul wrote:
> Document the compatible string for USB phy found in Qualcomm SM8450 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
