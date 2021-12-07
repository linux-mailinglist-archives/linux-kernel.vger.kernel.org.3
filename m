Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FB46C6D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhLGVmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:42:16 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44915 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhLGVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:42:15 -0500
Received: by mail-oi1-f175.google.com with SMTP id be32so1040570oib.11;
        Tue, 07 Dec 2021 13:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+4scMpKlorEfecXfIyjMNntgDoSTsSLYkuMuIZG5oA=;
        b=LHsWDz9s02eiRSEyYMFa6HlN4ml1nKpwH9wBRuKLNkgGSWgyB57CgTLFk9PnRn0ECl
         e9atXI2ewpRKABFlRXfri9LiPeSiMT2ZilIzOCMzWLLU4acJy33JznrDIGw2eBWh1Ahc
         6iFtCJOngvecxHt2WivMcLm2LDvjCaqTfTXdlNsmE4X8iOeL81LPBL1vw5bi2F41dH2l
         FTfXrX36RlWcBKECSP7Y/WopD5aXV5XkvwLxbOJYjLC/XmqONt5iszzOwqN5PrrRW0Up
         +D76S/APSkklfqG1oFp1xQ/6U2PLSV0BEACxkBCRFIVB6Pq7WCoXnBjuvTaXLobDee0S
         V46A==
X-Gm-Message-State: AOAM531dzbqys+kXe4Su7xOzOkSFRizBlJNxcKP64kwgsT7me5GSzqYx
        hW9LJBujOfkcw1BtvoN7tg==
X-Google-Smtp-Source: ABdhPJyeMeo0jAJgqjF3nNjZegjyF6sJDflZLG4JagphLxqUNXVFM6Wa9AO0OVVfEHXbcV/SJ8Jq7w==
X-Received: by 2002:aca:674a:: with SMTP id b10mr7901866oiy.66.1638913124407;
        Tue, 07 Dec 2021 13:38:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u13sm177920oop.28.2021.12.07.13.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:38:43 -0800 (PST)
Received: (nullmailer pid 879929 invoked by uid 1000);
        Tue, 07 Dec 2021 21:38:42 -0000
Date:   Tue, 7 Dec 2021 15:38:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT
 bindings
Message-ID: <Ya/UYuHYD+Uc2B+F@robh.at.kernel.org>
References: <20211201072557.3968915-1-vkoul@kernel.org>
 <20211201072557.3968915-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072557.3968915-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:55:56PM +0530, Vinod Koul wrote:
> The Qualcomm SM8450 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>  .../dt-bindings/interconnect/qcom,sm8450.h    | 171 ++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 3fd1a134162d..cbb24f9bb609 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -104,6 +104,17 @@ properties:
>        - qcom,sm8350-mmss-noc
>        - qcom,sm8350-compute-noc
>        - qcom,sm8350-system-noc
> +      - qcom,sm8450-aggre1-noc
> +      - qcom,sm8450-aggre2-noc
> +      - qcom,sm8450-clk-virt
> +      - qcom,sm8450-config-noc
> +      - qcom,sm8450-gem-noc
> +      - qcom,sm8450-lpass-ag-noc
> +      - qcom,sm8450-mc-virt
> +      - qcom,sm8450-mmss-noc
> +      - qcom,sm8450-nsp-noc
> +      - qcom,sm8450-pcie-anoc
> +      - qcom,sm8450-system-noc
>  
>    '#interconnect-cells':
>      enum: [ 1, 2 ]
> diff --git a/include/dt-bindings/interconnect/qcom,sm8450.h b/include/dt-bindings/interconnect/qcom,sm8450.h
> new file mode 100644
> index 000000000000..786fce091c84
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm8450.h
> @@ -0,0 +1,171 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.

Can Qualcomm/Linaro please get their licensing in order.

Rob
