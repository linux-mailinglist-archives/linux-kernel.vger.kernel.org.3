Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FA4735E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhLMU2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:28:46 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42741 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhLMU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:28:42 -0500
Received: by mail-oi1-f176.google.com with SMTP id n66so24695481oia.9;
        Mon, 13 Dec 2021 12:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YFmay6qUpHi3+z9VRDi7SedXp1pOMgySV5sTOcIXTYc=;
        b=mPOc3aV9KlujCXM76iIgy5Awzwtwq3DvhuFJmx23CXFJYpIGoQqxT3Ph2ykQOIqTqu
         lQ8QRgMcSfwQtAyuqxIjEWHF9HMbnLNlzUesVvEKKwD0L+Q9WO9z8pf1Ud5CxLDKQBTJ
         4Vn1ErEC8RxEnuopHpZnpaiMC4ZNnOKDEUvnCIQI8iiVbX+IKvxKmj1symYhS79VN+3c
         JEhrSR3QNuR068pCFT/QM2Jpgdrzm9wVMTnGW9r2dITeS0m+4VWS+q5dMD0d3jvNY6d7
         bIeUJMXt2EC7TiQoueKRcRl/WnCiIsFoFOzjhc/22ESHOVdKEuqvXTfl91ypFdGLR7kY
         8kHA==
X-Gm-Message-State: AOAM533DniMKl9zDS3DiQN5K2uToVbXG2wCAY32qoxFuSlB69ULV+Zi+
        Z6UX+5EXsBKRr3MWaIJlCw==
X-Google-Smtp-Source: ABdhPJzV1TjYgGt5HxFT08kuKYUZ33IRI7ikDFlxvtgdvwydt7/UvUj+lBOHF0s4EiHBTWBMJA/uHg==
X-Received: by 2002:a54:4707:: with SMTP id k7mr28530003oik.163.1639427321464;
        Mon, 13 Dec 2021 12:28:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t5sm2342755ool.10.2021.12.13.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:28:40 -0800 (PST)
Received: (nullmailer pid 1516363 invoked by uid 1000);
        Mon, 13 Dec 2021 20:28:40 -0000
Date:   Mon, 13 Dec 2021 14:28:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     robh+dt@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: thermal: Add sm8150 compatible string
 for LMh
Message-ID: <Ybes+EIOpXWiDyJH@robh.at.kernel.org>
References: <20211202223802.382068-1-thara.gopinath@linaro.org>
 <20211202223802.382068-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223802.382068-4-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 17:38:02 -0500, Thara Gopinath wrote:
> Extend the LMh dt binding document to include compatible string
> supporting sm8150 SoC.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
