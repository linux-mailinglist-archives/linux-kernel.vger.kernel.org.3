Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2818148423A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiADNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:19:50 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43580 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiADNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:19:49 -0500
Received: by mail-ot1-f44.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so47289657otu.10;
        Tue, 04 Jan 2022 05:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vXJyG+aPQT4HJZIu9rC6Yx2sQSwHLG6CbDytEKM/K3U=;
        b=OpssVjPPVNfEF6naElg34t384t5IcJEe8dtkVwWRwL8ysd2VuvgKZVtDqQaTZ65frS
         R7MxByKwoFsnh3kAJ6xy/gUFRtw8jfUCZ/Uu6+m2HU15wQugnglzaR7sJCdGvPBsx4CI
         PxzC7aG2EyalNJXBEHYWbmvbTzOK8G7V7G0YmzChDdVYP04TIwGoxF06+2HoKWes8xTZ
         2SCPslRLx0fAFopIMKqaqeqQizHTKDK8s8d4SnCT9NfKILMHs58y7Pa8P2zPL4wRlTHG
         HhEDMCy9/mzMVazI5nslicgfXiXl7KfCQksyVuTMkCu1k7cswYXmVMvbSKN9phyFE3Ez
         CVQg==
X-Gm-Message-State: AOAM531xllQ62wraBY9b66IAxInZ2/TaFwx1krAqLB37Gwthb5+aANtF
        R7KEeoWhILDYsYPbgGzGYw==
X-Google-Smtp-Source: ABdhPJyF7XLC4a3OI784NyDanuYxfo3XEVhHBTQqEEE2GI42KrC8UhKs7BNtbpJ+vumVDLD0mMpcww==
X-Received: by 2002:a05:6830:40b0:: with SMTP id x48mr35045276ott.279.1641302388237;
        Tue, 04 Jan 2022 05:19:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e4sm9619556oiy.12.2022.01.04.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:19:47 -0800 (PST)
Received: (nullmailer pid 656049 invoked by uid 1000);
        Tue, 04 Jan 2022 13:19:46 -0000
Date:   Tue, 4 Jan 2022 07:19:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <YdRJcv2kpp1vgUTb@robh.at.kernel.org>
References: <20211227170151.73116-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227170151.73116-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 18:01:50 +0100, David Heidelberg wrote:
> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v2:
>  - add #address and #size-cells
>  - add reg and remove spmi include from example
> v3:
>  - fix doc reference error (make refcheckdocs)
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |   2 +-
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
