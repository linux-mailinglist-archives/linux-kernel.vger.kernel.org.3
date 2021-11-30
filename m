Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE13462A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhK3CJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:09:13 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33498 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhK3CJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:09:12 -0500
Received: by mail-ot1-f48.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso28278842otf.0;
        Mon, 29 Nov 2021 18:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhAgexOmZMDDxfzkKgbtUTePe6rrT5DljeoNkZtD8IE=;
        b=V9MIUZiv6WebLVJFZZTuBVU/qnSx2YmdvJNRH46T/FxvFCQxF32AXwDuudM0Pe0BY7
         lpf+gccUGyPx5t53bUAObFwTIx8XrG2I11oEBT7iB992E8mi+PrYdFobpTq0GVcK1xC4
         5J9DJNfHK+uGqx4lhuoaPBidvG9iejIjz/2RXgP5ifBdIXEStkCaydzZAZim5bXAooE6
         4wYOdVCijnh+hllKs/aCAilq9s849DkYNlROUztkmWNKUOk0M65Zp0QtsoRxmo0R5cSf
         Z9HdRXqITfAkmlQYbIkjmAkuTVUCC5yZZBFoL0VyGMwLB0ZZt7/GPF2HfyYX8BUfq0zr
         +xNA==
X-Gm-Message-State: AOAM531PgxI7LbhuGL4vLZoYXbRHhR083f/4iwPt/dEofrXKqhXrUgyZ
        RV7AJKq0nt7KOOL4nlJLpQ==
X-Google-Smtp-Source: ABdhPJzjK0J0CuEyOvQA7bsdS2+lN+Mm7FUS431r2AY8xZwSG33aoMLzfJCIAec8v3V8JsjOH/L6XQ==
X-Received: by 2002:a9d:f04:: with SMTP id 4mr47936802ott.326.1638237953515;
        Mon, 29 Nov 2021 18:05:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u136sm3333317oie.13.2021.11.29.18.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:05:52 -0800 (PST)
Received: (nullmailer pid 1028193 invoked by uid 1000);
        Tue, 30 Nov 2021 02:05:51 -0000
Date:   Mon, 29 Nov 2021 20:05:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        jamipkettunen@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, martin.botka@somainline.org,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@somainline.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: llcc-qcom: Add SM8350
 compatible
Message-ID: <YaWG/6mreCruTuMG@robh.at.kernel.org>
References: <20211121002050.36977-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121002050.36977-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 01:20:45 +0100, Konrad Dybcio wrote:
> Document the compatible string for SM8350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - Move the .h defines to the second patch
> 
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
