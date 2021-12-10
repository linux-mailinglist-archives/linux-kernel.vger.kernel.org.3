Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8BE470C18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbhLJU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:57:26 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36795 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhLJU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:57:24 -0500
Received: by mail-oi1-f180.google.com with SMTP id t23so14901985oiw.3;
        Fri, 10 Dec 2021 12:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPa2sUzI1TTogWtVdv+gqxLQMcc0yIn4ajlG/Yv+sKg=;
        b=k3Iex8DpJXq/I5gjvjAEiqYNenoB/gZ6AONQo+Ha0XMLOxCY/7rp15ze4pR7vnrv54
         B5BH4ki/62zW+YZsgTsoWh5MVb1oYFNuwY00duzklXFk4yEdghzzjX9UVfcEPypXPwJ2
         VIEoIFte7+ks/Y055YkX72kXcpSQqIBrLHPIKPq55Vo744iGExemrZUAsqc7vluNiElG
         UH5eiKdvbQtiIHCOva/XLwXiLUMQKBE9TrBOrIlUuOefGIaeAPaQwov5dgvSy4H44Yk8
         zlNIjbslBYxUnP3IukC9ZygN4LMdR5hfzyp0WcY3J0fql5jqWp4cB9CDXr8X2GJEf56P
         /20w==
X-Gm-Message-State: AOAM532JASvIMewDquFV7zbpHEiZ0JjAsyOtM9QTF5olF9bWC7fuLbfL
        qHFW1k9HU6+UItxJCVKDAw==
X-Google-Smtp-Source: ABdhPJw/WAZcAWnbMK5d5NnkzoKQPi02VZoijHmfZDlRJbNYKZ9ZQMfcdBwUsO71COLL2fOqFKGMkA==
X-Received: by 2002:a05:6808:1814:: with SMTP id bh20mr14303276oib.31.1639169628833;
        Fri, 10 Dec 2021 12:53:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r10sm782013ool.1.2021.12.10.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:53:48 -0800 (PST)
Received: (nullmailer pid 1878574 invoked by uid 1000);
        Fri, 10 Dec 2021 20:53:47 -0000
Date:   Fri, 10 Dec 2021 14:53:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Pavel Dubrova <pashadubrova@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: clk: qcom: Document MSM8976 Global
 Clock Controller
Message-ID: <YbO+WxSGYfMDY5RM@robh.at.kernel.org>
References: <20211208091036.132334-1-marijn.suijten@somainline.org>
 <20211208091036.132334-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208091036.132334-2-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 10:10:35 +0100, Marijn Suijten wrote:
> Document the required properties and firmware clocks for gcc-msm8976 to
> operate nominally, and add header definitions for referencing the clocks
> from firmware.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/clock/qcom,gcc-msm8976.yaml      |  97 +++++++
>  include/dt-bindings/clock/qcom,gcc-msm8976.h  | 240 ++++++++++++++++++
>  2 files changed, 337 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8976.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
