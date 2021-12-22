Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8064E47D63D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbhLVSHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:07:46 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:42705 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbhLVSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:07:44 -0500
Received: by mail-qk1-f176.google.com with SMTP id r139so2224520qke.9;
        Wed, 22 Dec 2021 10:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PZT+442yryoIyAnTgfkKE3INejgOanJ0gZBKWAWh5S0=;
        b=bgHaX3MUJWWeLEdhqA0Ts0sGzM6XI6TXfExugrW3VVvZ9sPXPA/c+EjvZH7iT1+Y7e
         MVm9kJjl5Gp40sVpZ1KRUfwZtqdg4P80zUqJio8KD6uhhy52IdlNIBr78sAZi+Gg3vtX
         AP2BvY4Aphuqs0mymYbNMi4uHGbv9Ob5uzWuZLva59muh1aVTRJ06Hc31x2OyOQZLpn4
         vaBANwcc4kUJ0m1yYB/zpneQF2LsQWc4EEQ0TNywCJUGfFrz1LQkGWRPf44+sS6U8U3p
         f5j4Ev5+5bAQ6/zZa9WMO9N53z8inXTCtB8fBn1kaORACRPUUvnq5gHgtqxrfu2dCJ9W
         mOYw==
X-Gm-Message-State: AOAM533s6+EPwdBV6327psECn1rMfBpW2KIFkRxkAoB3sOHfKuyn4290
        afzx1bKbHmBndCkhirVURg==
X-Google-Smtp-Source: ABdhPJyJC96os9VsgB6XT66xXHqKpdFgHISt8Maa/ibE4MzoOiNuO46peBDi0wJyk+XRb+grY1slKA==
X-Received: by 2002:a05:620a:f0e:: with SMTP id v14mr2825574qkl.365.1640196464048;
        Wed, 22 Dec 2021 10:07:44 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id de13sm2455085qkb.81.2021.12.22.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:07:43 -0800 (PST)
Received: (nullmailer pid 2429602 invoked by uid 1000);
        Wed, 22 Dec 2021 18:07:41 -0000
Date:   Wed, 22 Dec 2021 14:07:41 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, ~okias/devicetree@lists.sr.ht,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH] dt-bindings: msm: disp: remove bus from dpu bindings
Message-ID: <YcNpbeN2Hjs+ipWv@robh.at.kernel.org>
References: <20211220184220.86328-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220184220.86328-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 19:42:20 +0100, David Heidelberg wrote:
> Driver and dts has been already adjusted and bus moved out of dpu, let's
> update also dt-bindings.
> 
> Fixes warnings as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: mdss
> @ae00000: clock-names: ['iface', 'core'] is too short
>         From schema: Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
> 
> Ref: https://lore.kernel.org/all/20210803101657.1072358-1-dmitry.baryshkov@linaro.org/
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/display/msm/dpu-sdm845.yaml          | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Applied, thanks!
