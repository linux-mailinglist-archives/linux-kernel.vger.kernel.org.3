Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A63475C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbhLOPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:55:22 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46851 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhLOPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:55:20 -0500
Received: by mail-ot1-f47.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so25349191oto.13;
        Wed, 15 Dec 2021 07:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1uN/AqHq/16fmWso+ckRBZMPm8uIk1S05gPTw3SpmPY=;
        b=5wSByh36Ux6JGZav4koolC2t0qCKOK6ljaTp3ugb1FZ36dTXpykQLIh7zSlo3xDJM3
         5seQCfFtOdOAFGUNYONb6MHWRvWbJNqhHnFkbCctt5dJNsmQdgfJKbuHkGpBQ64v+7ar
         9axrimLhQ8X2d7BXOJfo2c+gu2dsmMMp4OgFEN4FF90b1GxecqBeOplB6Sk83DbMx2II
         CA8lBFeG5tbf9WEDXRNLSezMq5VvJM4UlixnoBvjYYw+PauOLDS/RUQaqoDLNE7NWGCv
         2+NbCDfOXfimLciifMQHVlcs+17GmSL+c3gn4k7rIuDGQNRy89DWoXm0gBw6QDkUrH4k
         /xdQ==
X-Gm-Message-State: AOAM530+FMxp5dm5iVy+h3sjBUkN2WtxntCVqpUCvQdEIel1WKu14Zsk
        rpf6bVlBX1dWvxUe2lLmICEQJc/yAA==
X-Google-Smtp-Source: ABdhPJz+BdqqYA7oiWw+kTcTRG+9z9GLCeD0Vi6YlvvtrKR1sMRLQfp3H7e/ZuYhjZ7GDhGlHaYmag==
X-Received: by 2002:a05:6830:5a:: with SMTP id d26mr9044542otp.316.1639583720233;
        Wed, 15 Dec 2021 07:55:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 69sm496716otf.33.2021.12.15.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:55:19 -0800 (PST)
Received: (nullmailer pid 1385017 invoked by uid 1000);
        Wed, 15 Dec 2021 15:55:18 -0000
Date:   Wed, 15 Dec 2021 09:55:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add SM8450 GCC clock bindings
Message-ID: <YboP5r3BeImwIsQB@robh.at.kernel.org>
References: <20211207114003.100693-1-vkoul@kernel.org>
 <20211207114003.100693-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207114003.100693-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 17:10:02 +0530, Vinod Koul wrote:
> Add device tree bindings for global clock controller on SM8450 SoCs.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/clock/qcom,gcc-sm8450.yaml       |  85 ++++++
>  include/dt-bindings/clock/qcom,gcc-sm8450.h   | 244 ++++++++++++++++++
>  2 files changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8450.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
