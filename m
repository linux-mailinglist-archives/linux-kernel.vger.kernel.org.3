Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54147C728
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbhLUTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:00:23 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:43859 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhLUTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:00:23 -0500
Received: by mail-qt1-f178.google.com with SMTP id q14so13767889qtx.10;
        Tue, 21 Dec 2021 11:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIOkU2R7q53s30poXB6wKE9nB8lhIyVZh0GpeEte98E=;
        b=p8+1nAfqBpzSZGBRRnQSrhUteuQuFkXDqBnXGRTfy6nUPKKE6knk1M5LM3Z7ix52gz
         vl3ldZPJqysUiL6AGz3M40+e7YH41a7Qfk/y6emxfL2PcDXd+JZN0Q6LGWAhLElqdDMg
         Qp+eO05lkb/NZmYaIfb7W7Se2+GfyQjegBTAtT7yi/tttu8zcgf+RMLlA09Pe32fwgrJ
         s9iwnEsfsTy4okL2SgiRd4Wj+Q6NpIwhTe3mZ/i3XeqyMrdA2JEt0p0BkvSKS3XE8+Z4
         lgKb4yeH1PrPD02vLsIeDNiSWfm2iaD3VsD/dd6kMSS4KvuUIaCTZMpmTKVqvg8sFKS2
         +Xvg==
X-Gm-Message-State: AOAM532gxBvYjc2wc42qaObM2sR9u6yqP8oSbis6pyuKry4fMcHDalE9
        kV7H3qqfgV2wMsMh+1S59Q==
X-Google-Smtp-Source: ABdhPJxl9dMQ4zuv5cXtQpPzSLb/VzWpP+JvgACX0GJhdIcKn21JJ1AOh0MCSUEPJjJKV/nGWher3A==
X-Received: by 2002:a05:622a:394:: with SMTP id j20mr3415270qtx.562.1640113222382;
        Tue, 21 Dec 2021 11:00:22 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id u17sm10060282qko.133.2021.12.21.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:00:21 -0800 (PST)
Received: (nullmailer pid 1573222 invoked by uid 1000);
        Tue, 21 Dec 2021 19:00:20 -0000
Date:   Tue, 21 Dec 2021 15:00:20 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: regulator: tps65090: Convert to
 json-schema
Message-ID: <YcIkRMWAFLdiRiDC@robh.at.kernel.org>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
 <20211217170507.2843568-6-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170507.2843568-6-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:05:07 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments TPS65090 bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/ti,tps65090.yaml       | 199 ++++++++++++++++++
>  .../bindings/regulator/tps65090.txt           | 126 -----------
>  2 files changed, 199 insertions(+), 126 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/tps65090.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
