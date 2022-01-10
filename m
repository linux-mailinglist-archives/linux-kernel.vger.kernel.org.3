Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563748A063
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbiAJTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:45:49 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39903 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiAJTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:45:47 -0500
Received: by mail-oi1-f173.google.com with SMTP id r62so13406703oie.6;
        Mon, 10 Jan 2022 11:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+rUH2Bw7JdmQp0ELIJp4FXZOGNg4nqfe1WUgvTcejF8=;
        b=17fh9QrRqFn2jAJrbAbakA6bGWxYIn3MMVhyGZstTKpPfN15BF8Cgja8LtFrhVIUsB
         YW5wVTKTY633OPAiuSAz6HEPWMAXO31sZBxxrTj8QBgJgNNFsNDnglekjamiL5jJWiBj
         79sr1KhWufor5zU3R6TxJo1az3obLKtb6oTJWECTo4uDTvgvsmvgbLHI7i2harCOj7Gt
         WKGTlDQ8HC+WdPj8sgeWjDDiy+aHZa2BgszNr68m2L4K8By/Ji3rfdDnTxfkTc2EERJH
         nFY2ICPnlRYXeNgl1L7ooJwGTUnqhOo7z6LcX0wdKefFYxl29mYRRyOO7qOdylDi4a82
         LHwg==
X-Gm-Message-State: AOAM531V+iGW5dKMrikX1IlUKcgDBvHY9tokkjDBzqAAAM2Y2RHX06Ib
        HO+g+2FzwxqPmWg/CUhlnQ==
X-Google-Smtp-Source: ABdhPJzVEWjIXJ8MMN0dd8KKjN2BiOpuWDUv+vvFANJSidkB/vdhoZbY14Xbo+ZjySetFCFDzYfolQ==
X-Received: by 2002:aca:a84b:: with SMTP id r72mr19390246oie.14.1641843946416;
        Mon, 10 Jan 2022 11:45:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d3sm1341207oiw.52.2022.01.10.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:45:45 -0800 (PST)
Received: (nullmailer pid 1377109 invoked by uid 1000);
        Mon, 10 Jan 2022 19:45:44 -0000
Date:   Mon, 10 Jan 2022 13:45:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Andy Gross <agross@kernel.org>, ~okias/devicetree@lists.sr.ht,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: phy: convert Qualcomm USB HS phy to yaml
Message-ID: <YdyM6KlzCBZBvXHg@robh.at.kernel.org>
References: <20211230000740.103869-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230000740.103869-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 01:07:40 +0100, David Heidelberg wrote:
> Conversion of Qualcomm USB HS phy documentation to yaml.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - changed uint8 array to matrix
>  - improved clock-names check
>  - move reset-names items, adjust DTS files later
>  - added clocks and resets min and maxItems
>  - if'ed resets, since apq8064 doesn't have phy reset
> ---
>  .../bindings/phy/qcom,usb-hs-phy.txt          |  84 --------------
>  .../bindings/phy/qcom,usb-hs-phy.yaml         | 108 ++++++++++++++++++
>  2 files changed, 108 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
