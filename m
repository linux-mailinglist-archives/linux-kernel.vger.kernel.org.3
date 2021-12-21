Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0606447C955
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhLUWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:45:39 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:43543 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhLUWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:45:37 -0500
Received: by mail-qt1-f177.google.com with SMTP id q14so275237qtx.10;
        Tue, 21 Dec 2021 14:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+8wGUqAhe1nVbE36vIQoglJAafwXDPNIila4d3ObDt0=;
        b=7Gk6TS+FOu/+TzUb6+EHrzbtvoBi9ZY0Q7sD49Ce8SArEz3mlH593iENjWP7it/rgs
         5Jo3gnECg2W4at4oNX14IB4iFyZ3NYhzcAqYDCoY5aITeKnoBHmuiUMq6nLTNNGkPF4N
         y66VXr/tRzUklBBIXinIuN8yeWlX5WEEUvvA4QTYLX7Yq/8gpv3NX2bhXw0CDRtjpb8h
         IUvVjQ77eUCCx3AhiBAl736ncrN2FjdT2qLlfPUxOrPFGZpHDCJL52LsSm0VFPCjqJej
         GFVCaopsOBPfDsr7rUHw4AEA8ntlXco+VfP1q2AOV9BuMgz89J4EK07QjkaXnQ4+/0T/
         K6vQ==
X-Gm-Message-State: AOAM530XKhrlApmBHGPNBX8Lk8kWwGD+me9WfspsL1HYXPovqsPGFPgJ
        OB9Y1mJr4aDQlbK0yzmRdw==
X-Google-Smtp-Source: ABdhPJx7XnHqD02k7pcnlKqo319KL/urrR33NOLRHEfJUbq0Q6OHKDLMbUngPtjWYfaKQrz6w9oy3Q==
X-Received: by 2002:ac8:5f13:: with SMTP id x19mr295848qta.475.1640126736776;
        Tue, 21 Dec 2021 14:45:36 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q30sm268645qkj.3.2021.12.21.14.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:45:35 -0800 (PST)
Received: (nullmailer pid 1654440 invoked by uid 1000);
        Tue, 21 Dec 2021 22:45:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Jarrett Schultz <jaschultz@microsoft.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>, bjorn.andersson@linaro.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
In-Reply-To: <20211221182826.2141789-2-jaschultzMS@gmail.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com> <20211221182826.2141789-2-jaschultzMS@gmail.com>
Subject: Re: [PATCH RESEND v4 1/4] dt-bindings: platform: microsoft: Document surface xbl
Date:   Tue, 21 Dec 2021 18:45:31 -0400
Message-Id: <1640126731.378625.1654439.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 10:28:23 -0800, Jarrett Schultz wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Introduce yaml for surface xbl driver.
> 
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> 
> ---
> 
> Changes in v4:
>  - Addressed small formatting changes
>  - Removed unnecessary lines
> 
> ---
> 
> Changes in v3:
>  - Updated description to only pertain to the hardware
>  - Updated the required field to properly reflect the binding
>  - Removed the first example
>  - Fixed the size of the reg field in the second example
> 
> ---
> 
> Changes in v2:
>  - Removed json-schema dependence
>  - Elaborated on description of driver
>  - Updated example
> ---
>  .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/platform/microsoft/surface-xbl.example.dt.yaml:0:0: /imem@146bf000/xbl@a94: failed to match any schema with compatible: ['microsoft,sm8150-surface-duo-xbl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1571914

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

