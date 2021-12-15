Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12121476255
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhLOT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:56:40 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39873 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhLOT4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:56:39 -0500
Received: by mail-ot1-f49.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso26220695ots.6;
        Wed, 15 Dec 2021 11:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rc75QnNGJmNS7Cbebb+pY8RDy1d28+BSSxCtW4SecuI=;
        b=gEizBTR33a1S3bh2Zt7v2sHpuCPXzc86v5+CZm0YUxHqRyW8z5GPIbvHpz0Ki3zNXM
         2Uw/3pTaM5+XccsawKq33kNfF4vZKI+gzDbwV9qOmPZKt89Hq6PwS8oq4k+6gzKsVhNP
         sXMmTGAtw8/FLOBFHj104YxCTGVxbRqhH6AnBaOShjuJk6RESE9JCCMnat9uqKCiJENi
         dNo/FuZrpF6TjWSxAYvBFbnhebdoeg6JnNQYft25K9T/u5+BmeszcF+KySZw5e3bbWuB
         UziQJTu0iGpJmScRJ6vPWXiaYsFJWEh0jsCV9AUhhu4vBw4j7JMDEokbxcvjMrWlfUgi
         iceQ==
X-Gm-Message-State: AOAM530feeJ6KAuqy+H+XGb7FPsIzI+m3Gl2DR8IYpS4kUueQTbUU0cB
        YNXmSmfsS2jCdWiKboexwrAq2jCcWA==
X-Google-Smtp-Source: ABdhPJzrQNwX1PWtVKEQVvXrLOMZ8C9c+duQoIn7Gf9bM82Fcc1FZELEJd5svYbn2v5KVWFulAvMXQ==
X-Received: by 2002:a05:6830:2431:: with SMTP id k17mr10212639ots.220.1639598198475;
        Wed, 15 Dec 2021 11:56:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o2sm602213oik.11.2021.12.15.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:56:37 -0800 (PST)
Received: (nullmailer pid 1733483 invoked by uid 1000);
        Wed, 15 Dec 2021 19:56:36 -0000
Date:   Wed, 15 Dec 2021 13:56:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     linux-iio@vger.kernel.org, amit.pundir@linaro.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, john.stultz@linaro.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, sumit.semwal@linaro.org
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document qcom-spmi-rradc
Message-ID: <YbpIdF/z3w6DAKH3@robh.at.kernel.org>
References: <20211211022224.3488860-1-caleb@connolly.tech>
 <20211211022224.3488860-3-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211022224.3488860-3-caleb@connolly.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 02:22:19 +0000, Caleb Connolly wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
> PMI8998 and PMI8994
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
