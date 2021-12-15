Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6954762C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhLOUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:10:35 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44794 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhLOUKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:10:32 -0500
Received: by mail-oi1-f180.google.com with SMTP id be32so33188603oib.11;
        Wed, 15 Dec 2021 12:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjmmctmjdtE24e8GmxPRgAEj7fEXozFNmPQ9y5j52Y4=;
        b=HDed3fZnaXm3B7ezeBFjimG5pL2VYK7k1xrQzQfXJ1WRbRvOP05YJIoZvk2Y+JHsFW
         ef9FVf5ZJLIipEZdOzlfRuE32iwsfacrOH2uIrByKG787fvwus5x1z4VqUJedrq3ZQJH
         6vRBVGIKDFKXhwdFwWdNefx2wGdHP932LsO5QEkMVr2/pTpcebmpfdl6B5BmNpIitpBB
         zHaPtrV9bLG9wxADBtoc94P0VSAlF65G+++8eJ/Iz0KTN55C4GrnKcq1NwbkXyNevCu2
         DJGwOrSrIHNVrNjuNPPk6aYJQzfV9krKUEJulUssVbqf6nKDQq6o6PljlnPAqFB80lOk
         DaTg==
X-Gm-Message-State: AOAM533D+ud1TtRizVQiT0fzzbpINjEtjP7ADnAcGPsUTzWa7MIj7BzU
        A25wFuBEPr4xkmWRCZpipg==
X-Google-Smtp-Source: ABdhPJypIod++IRLv7s5qykdwZLybQkBhOU5kHB2WghYmMYXLTvfB28d2tOzZcO0JUn0eDATagml6A==
X-Received: by 2002:aca:d6cb:: with SMTP id n194mr1433394oig.60.1639599031562;
        Wed, 15 Dec 2021 12:10:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm626889oiw.23.2021.12.15.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:10:30 -0800 (PST)
Received: (nullmailer pid 1755052 invoked by uid 1000);
        Wed, 15 Dec 2021 20:10:29 -0000
Date:   Wed, 15 Dec 2021 14:10:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Manu Gautam <mgautam@codeaurora.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] dt-bindings: usb: qcom,dwc3: Add SM6350 compatible
Message-ID: <YbpLtcOGXts14dbK@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-7-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-7-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:07 +0100, Luca Weiss wrote:
> Add devicetree compatible for dwc3 on SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
