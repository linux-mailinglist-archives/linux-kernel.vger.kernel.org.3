Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531AB4762CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhLOULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:11:05 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44710 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLOULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:11:04 -0500
Received: by mail-ot1-f44.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso26256420otj.11;
        Wed, 15 Dec 2021 12:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qVaJO/5MfbAvvlhFGg3nSevyFof/ioLFiAZ2wARtMM=;
        b=eiJ3OPuSJ20dz667cIKWP85p/GHQka2OJvgr9ayGrz5W/2741iX5WDMsiMcjJXI2A7
         E8ILNIW+z5gshWeoIAeUwI88hxkaKS0RrQjJO4n61GvUVjG179cAASIOA0r1AZyCLnp6
         8f7e20+lRDvMVOJxg8xsisIb9hdi7IFd5o83t2vecM38Auz0WxssZob/rt6FDBIuqIkQ
         0uuf29SwfVs2CCnpbyhtGAzZK960q5KUrOfUIq0LGaCs1d/G5A4VcX/bQ5VCBWeXYLcU
         kAYCrjC9wxoKeyShttE5D1toDHrbECvaee9i2XHdeb7+nRzd4DOOxjiXPZZHf86qPdKh
         q7hQ==
X-Gm-Message-State: AOAM533vRc0Wm3ZcAmXS5Yr7H0aZcAOiyJ9sfelbY0bO/d6CaFrfIxGc
        4SfxytTb2i6s/FZPVR+SWw==
X-Google-Smtp-Source: ABdhPJzPfRyuf46sG0u6LDBT3FRO/L5ko6NHR9tQs/c0RANwuC3H3ipxtM6tlzmlneqHIUQpfli81A==
X-Received: by 2002:a9d:6653:: with SMTP id q19mr10401271otm.116.1639599064166;
        Wed, 15 Dec 2021 12:11:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s6sm575430ois.3.2021.12.15.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:11:03 -0800 (PST)
Received: (nullmailer pid 1755863 invoked by uid 1000);
        Wed, 15 Dec 2021 20:11:02 -0000
Date:   Wed, 15 Dec 2021 14:11:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        phone-devel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 08/10] dt-bindings: arm: msm: Don't mark LLCC interrupt
 as required
Message-ID: <YbpL1uZfVJogKqZX@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-9-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-9-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:09 +0100, Luca Weiss wrote:
> Newer SoCs like SM6350 or SM8250 don't provide an interrupt for LLCC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
