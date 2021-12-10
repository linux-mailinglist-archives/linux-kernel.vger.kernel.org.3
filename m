Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D270D470C68
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbhLJVWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:22:01 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35462 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhLJVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:22:00 -0500
Received: by mail-ot1-f48.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso10927508otr.2;
        Fri, 10 Dec 2021 13:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Sqw8tLXZ7NhyqIz42DAJGxWZBL50vbOTyJH5mqt2+E=;
        b=CHsjP6mQE4P+Q6e/1Qjad+kcNfh8QacCq8dRiGyTcHzfX+rnUmbPOCqBtCnfzAjam5
         qh2R8x+Lh2GwNvrCovhMb1yixgqtFW/kCdGd4xZfNMaZixFeGa+cBNtPa0bd0v2OklfG
         Rf+omRm1APk3G744NhjFFqVBtvJVAerM8TK0k5r74sbEPgQPdqkHFnXFmlwgVwF0+f8h
         /+7daV0mdTCP6inuhWndk65BvE5T3zYnmqCXJ2i36Osxr/oHtmooZkRgJcj37PPRF00X
         EGmFZMQKxUL0qfKTC96wmKBbwyh9d0vL4jI1krjvTGX/2TNzEC/SvAikmQY3vK/MNqwP
         vxzg==
X-Gm-Message-State: AOAM532aNx5iMRJgf9fTPPIJNLJ+OKKCxvrqLiG9Na44AAWadFv1qLy7
        pfDJTEfP5ajHllQ3D6CzdA==
X-Google-Smtp-Source: ABdhPJyJEpLusuj8i+CYQoGtrRtr3OG05BtAkAjqpcqi8XpwiO0rNK6rvnucUKeoSEvSOkQeI9S5dg==
X-Received: by 2002:a9d:70d4:: with SMTP id w20mr13178427otj.154.1639171104789;
        Fri, 10 Dec 2021 13:18:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm1070226oiw.23.2021.12.10.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:18:24 -0800 (PST)
Received: (nullmailer pid 1915698 invoked by uid 1000);
        Fri, 10 Dec 2021 21:18:23 -0000
Date:   Fri, 10 Dec 2021 15:18:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, tiwai@suse.com, plai@codeaurora.org,
        perex@perex.cz, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org,
        Linus Walleij <linus.walleij@linaro.org>, agross@kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-gpio@vger.kernel.org, bgoswami@codeaurora.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        judyhsiao@chromium.org
Subject: Re: [PATCH v5 2/5] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi
 pinctrl bindings
Message-ID: <YbPEHzDdz3Nag1VB@robh.at.kernel.org>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 21:05:36 +0530, Srinivasa Rao Mandadapu wrote:
> Add device tree binding Documentation details for Qualcomm SC7280
> LPASS LPI pinctrl driver.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 +++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
