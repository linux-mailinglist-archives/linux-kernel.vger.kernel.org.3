Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181F646C6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhLGVkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:40:15 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39773 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbhLGVkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:40:14 -0500
Received: by mail-oi1-f180.google.com with SMTP id bf8so1089231oib.6;
        Tue, 07 Dec 2021 13:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rV8/EZVpS27BBn3eDa1EnMOMGAc5YPoChctOsXPNFRs=;
        b=tgC7+X2sr7+EXGrQI1cMkMzcxOxonICFVZ285nN8Ue/UBV+CGgXhGeyyYMW93JUzvc
         4V3uq/iK4zs7RveJEKWXewrUqxP8JKWYPJGyBJh9XhW9XAFvf1RtNL/2Wq+v9Q3Fhu6t
         lEKzKUuU+DkJFtv8Q0D8IP+XsJNAfX/QN6PuawKUIZBjrMxPS8PUCqZn1L0MG5XU107X
         iyUzes4by/M483w+Zd5myynqE/61yYyfjwaLGfe7DrfNWUTeQav+3Ndgmw2YYfTeQWyf
         6T0F1rc1cTo87zjgsBw59NftrIIx0cnObCFP4NMs7Q/JdgHiZeVDBS8r38y07lC39Dxr
         3Mug==
X-Gm-Message-State: AOAM530XR7av5sbMEr3t1fK6bXIOYFT2ZedLtPuAheRiaGWjIMGRFsNX
        Y2x8Z5yEU1jvFg29ZS5f9w==
X-Google-Smtp-Source: ABdhPJxJ2x3IC1MLNO++M4/ykFszjb71cGqWolgS952n8AM/f7lnxRD3xy9m+oSfLhwlH/ZJpICLLw==
X-Received: by 2002:aca:6146:: with SMTP id v67mr7752591oib.82.1638913003400;
        Tue, 07 Dec 2021 13:36:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bk41sm215528oib.31.2021.12.07.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:36:42 -0800 (PST)
Received: (nullmailer pid 876796 invoked by uid 1000);
        Tue, 07 Dec 2021 21:36:41 -0000
Date:   Tue, 7 Dec 2021 15:36:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SM8450 pinctrl
 bindings
Message-ID: <Ya/T6SsYRD9T0wE/@robh.at.kernel.org>
References: <20211201072434.3968768-1-vkoul@kernel.org>
 <20211201072434.3968768-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072434.3968768-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2021 12:54:33 +0530, Vinod Koul wrote:
> Add device tree binding Documentation details for Qualcomm SM8450
> TLMM device
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
