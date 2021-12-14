Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0F474BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhLNTaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:30:20 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39785 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbhLNTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:30:19 -0500
Received: by mail-ot1-f51.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso22052819ots.6;
        Tue, 14 Dec 2021 11:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxadU1/B3hG1ERlyc6s8PV2oHrL3i2+weA1380zY5gg=;
        b=c4AliRva6SzNam7NAiOBgRjZTRI3La4mIPnUrTgN2p2AihBWEK1cMxlkeR/hsCfXTi
         jo24vNERh6+Vswk3JS+57Mvu9yylCmD5FcSvs0iH1kcu1iShIR9znjQHm71fS+5V//iq
         agHmAjbIztY5WCvTyDOyDjfsQI/EU+IsoGbJaNrjubEWx2Wiw/nE+AOTN5ss1+PZ5MMh
         8xgLYu6CrYArlm2AdcCHpOp6QcUeAl1yc+Gaf4b0mI2tIl7q/Y2oReWTHY4lUFjELQdT
         EmaDz+NdxdwAUoloYfBr/Bu+anJrqafIEpZhQY/PU5q6zdIdHLLvMacZH0mS6qFCrTNb
         7z5A==
X-Gm-Message-State: AOAM533vAgd/Q3jR5UEORBgkZZPtji5J8g0keFqWYSkJmyS0IfxGn0e0
        Z7gZHDWzq9SaCIlBTafhHw==
X-Google-Smtp-Source: ABdhPJyy83QBBDa63Zn4SC3BXDh425tvhOE4LY1Lv9kN+26nFmi8Y4MBIQ6lGz6Bl/CP6sNRGA1Vyw==
X-Received: by 2002:a05:6830:3113:: with SMTP id b19mr5874123ots.9.1639510218587;
        Tue, 14 Dec 2021 11:30:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d12sm130694otq.67.2021.12.14.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:30:18 -0800 (PST)
Received: (nullmailer pid 3771282 invoked by uid 1000);
        Tue, 14 Dec 2021 19:30:16 -0000
Date:   Tue, 14 Dec 2021 13:30:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, viveka@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT
 bindings
Message-ID: <YbjwyGArB/aqsjpW@robh.at.kernel.org>
References: <20211209084842.189627-1-vkoul@kernel.org>
 <20211209084842.189627-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209084842.189627-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:18:41 +0530, Vinod Koul wrote:
> The Qualcomm SM8450 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>  .../dt-bindings/interconnect/qcom,sm8450.h    | 171 ++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
> 

Acked-by: Rob Herring <robh@kernel.org>
