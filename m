Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80C0470C56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhLJVTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:19:18 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45716 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhLJVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:19:16 -0500
Received: by mail-ot1-f50.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso10856390otf.12;
        Fri, 10 Dec 2021 13:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rz+f4jxcorJhG5xhkcaE/Z8zmcaXPwrM4bIXAQx1u7s=;
        b=WQaz9phGx0yyEKHvlXSpX4iCuQKuIuGIQ86vTfqgsQFnlzmE+pUxfE5MVISDGC7cYC
         g47Bg8k2m14dRHG9KV+tCzWtjicnFWDkSLCOLtC6rjvJ+DmjpBcGs0Xua7WxRW+iNtFx
         czfP+hatcim7ZQdC9601Dxxubk3kIqpS5R/SMxSh9QR0cUGdLC42qUVrAZtxjTBZQOC0
         kXZbmOqlwH2m4yzV5rdBPDcx+147S7Ps8HUEB2UcfTxjEFQlE5mrv8LI/lXxPFCGpJjG
         cNfm5uKPqQeI1OULt7AJqzBI8kxmCMjKRffvLJ68cfjIyrGirbnKgZAP38vYJ/pJEuCr
         Lmew==
X-Gm-Message-State: AOAM531kBzHqszlz3MLFe2A3AGgcfvxapjuRwMjxKWZxEq62W3Jc1lUW
        +h6HD8aWq6RfcchUMOPZ0A==
X-Google-Smtp-Source: ABdhPJyF0GaaJsZV1wR3zOSFn48M6x1bOCOHkCw6T0wcpl8sQFfIcxANMa3TuO+iZUTD231D2SKtUA==
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr12956753oto.312.1639170940576;
        Fri, 10 Dec 2021 13:15:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm718190oom.32.2021.12.10.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:15:39 -0800 (PST)
Received: (nullmailer pid 1911427 invoked by uid 1000);
        Fri, 10 Dec 2021 21:15:38 -0000
Date:   Fri, 10 Dec 2021 15:15:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     judyhsiao@chromium.org, linux-gpio@vger.kernel.org,
        broonie@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        plai@codeaurora.org, agross@kernel.org, bgoswami@codeaurora.org,
        bjorn.andersson@linaro.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, srinivas.kandagatla@linaro.org, perex@perex.cz
Subject: Re: [PATCH v5 1/5] dt-bindings: pinctrl: qcom: Update lpass lpi file
 name to SoC specific
Message-ID: <YbPDesOMfpoiQFIa@robh.at.kernel.org>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638891339-21806-2-git-send-email-quic_srivasam@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 21:05:35 +0530, Srinivasa Rao Mandadapu wrote:
> Change generic lpass lpi pincotrol bindings file to SoC specific file,
> to distinguish and accomadate other SoC specific dt bindings.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 130 ---------------------
>  .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 130 +++++++++++++++++++++
>  2 files changed, 130 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
