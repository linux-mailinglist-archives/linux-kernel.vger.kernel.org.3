Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF84046232D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhK2V0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:26:05 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:46741 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhK2VYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:24:04 -0500
Received: by mail-oo1-f47.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso6063339ood.13;
        Mon, 29 Nov 2021 13:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2T9EgPmfc0rNPgsjPNUuNg/QqPEADj/Yw0On3FhXaUI=;
        b=vC/Uz/3SGcGf7QCrK5NEdWjNplvOz2Dypw3lgS8MEwKR26MVt1fheJ8tBxzZwpQvqR
         uoMMM5tvG1iXOQ/ro4hhg0geHdpDVWdPyuDXJMffGpQBkh4sK9dC/vyqi0apqOovnGOH
         UfoCC+OXP4X2sK2CdS1nQ2nUMAEvUaeg33ifLgSN6DwyUDh1dzAd/OebA9I8Vg6pOgGX
         8ONcGOwr6kHolN1eAOLL7gtG3pYblDI33lVUzMjtIE2pR82ZrdPQBcwE5RXeh1Dr6Dbi
         qtQMCEcXpu+bOjssI3GACXhD7n4RFBq1Fpv/lL5TaFdHCL6lMFRq4F/kNIR6McvZ+yYn
         /Kow==
X-Gm-Message-State: AOAM533X/ucxbM9tLoZ7YsBHtds6x69QsdLiVZ6J59k+EcK64XDEoPuY
        q0+RojcX93SfPOchYs+HOQ==
X-Google-Smtp-Source: ABdhPJxhu1Qh5Ryd9R7DQN6WpTcyEVLDn9OZtNuxT5MBjG9L1uKXGq8kU2IQaUG6/fDtCIoB6/Kesw==
X-Received: by 2002:a4a:a44b:: with SMTP id w11mr14751523ool.66.1638220845673;
        Mon, 29 Nov 2021 13:20:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o26sm2836315otj.14.2021.11.29.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:20:44 -0800 (PST)
Received: (nullmailer pid 630005 invoked by uid 1000);
        Mon, 29 Nov 2021 21:20:43 -0000
Date:   Mon, 29 Nov 2021 15:20:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add support for the MSM8226 mmcc
Message-ID: <YaVEK0Gyd16sYD/m@robh.at.kernel.org>
References: <20211113015844.92762-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113015844.92762-1-bartosz.dudziak@snejp.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 02:58:43 +0100, Bartosz Dudziak wrote:
> Document the multimedia clock controller found on MSM8226.
> 
> Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> ---
>  Documentation/devicetree/bindings/clock/qcom,mmcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
