Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA74762E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhLOUNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:13:52 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34761 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhLOUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:13:50 -0500
Received: by mail-oi1-f169.google.com with SMTP id t19so33287917oij.1;
        Wed, 15 Dec 2021 12:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zfzCek+ThaUW2uLQZROAUPM08wNkZ0c6WaVCXgKjYT0=;
        b=I8sYa9cIIqlErhk9uqqN7KiZ0YFTwF/sQvPzfVDDsg+lkmCSj4UAhTntCgnwR1xhV3
         YIiElT3qsHGUHw51fsKgTWVTgM+y3HRowES/rPdhGFKgTqNcKEtR5BsVqQYEc25gYK/t
         Sg7mrjnpQXdq34lLq1b4pPbpL18KAKhvRNgYrz+Bb8O7BxVgp2+ID0moktlXUDKdlMsi
         YcOJKOVAbdQ3fgStjmYWNedo7oDtSCBV1TW3Szxs/qNAaA3AZjERPhbgBGxLy5IxHRvx
         5EaQPZSjBR/ilLLwHDmaTgKrPADokN5hgNxZp2F8zND7c5wRqVNvaD4UErvlTr8UNI1T
         hK0g==
X-Gm-Message-State: AOAM5316E6s1GynFiQGLzbclGyj9cAszeYnPmODbyzYSdFXxPWBdrtsU
        FAPUoQoqiNbT0qfxxJYQ+w==
X-Google-Smtp-Source: ABdhPJzH8sjIBRBD/RV+Nn1jaJ95hQaD+3JUT+OhxcwHxcR2WIARiwZiHckydCgjgoiRR6MhcpVSog==
X-Received: by 2002:aca:280d:: with SMTP id 13mr1426751oix.61.1639599230059;
        Wed, 15 Dec 2021 12:13:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s6sm576796ois.3.2021.12.15.12.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:13:49 -0800 (PST)
Received: (nullmailer pid 1760271 invoked by uid 1000);
        Wed, 15 Dec 2021 20:13:48 -0000
Date:   Wed, 15 Dec 2021 14:13:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: phy: qcom,qmp: Add SM8450 USB3 PHY
Message-ID: <YbpMfKh4uAjRj5Ua@robh.at.kernel.org>
References: <20211213131450.535775-1-vkoul@kernel.org>
 <20211213131450.535775-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213131450.535775-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 18:44:49 +0530, Vinod Koul wrote:
> Add compatible string for USB QMP phy in Qualcomm SM8450 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
