Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF4473758
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhLMWQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:16:59 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38568 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbhLMWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:16:52 -0500
Received: by mail-oi1-f175.google.com with SMTP id r26so25029815oiw.5;
        Mon, 13 Dec 2021 14:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jBPFWLatnriXFCvj3w344POA1/0vKxUfWpn0sfzvfE=;
        b=qgh9CJKHvjlmGKPpTGThjmFGYaUa2+aSG/8IVLS2eX4B8pFuRlV25W9CL4+YyhJjNd
         ZGtwITCYfQdevv9/HK5+7HKItUmBiYAijlu6ZsV0VSMK6Vy4/zqjarJfDGD9HKvsV3Tk
         ukNRUkn1tPq/V+n/z+sEH+vguI2282QHIHZrjwSucQpBJYNuuRIKoD7iU/YaFWgR6vl4
         gTbj1mPBmayQQtm8JbbP+xtdv6oN22sE/bzJInKdGAlL/i+RHpdMmmWKVxASzMfA+BL5
         TtaFCLvfaB2UbFcAgWcGAyvFxWzf6zohl1qIdeOrVcWOoJ3mEhyTXyj0h3bfJebhLdha
         NbDQ==
X-Gm-Message-State: AOAM5321TT5idGoIxK8fvvZBJ2ugvrsNtlPhw3pAJhl/Qr1HsHzLT4o7
        JVSaXFohnbu5jN6KCoy73XgQbVRA5Q==
X-Google-Smtp-Source: ABdhPJyWPNiljtqQ49VPuUiFYMtAr9XnIX7dCsGeyJyUvJqziPIIDVs9bziDMydJLRfH6lh99DUbrw==
X-Received: by 2002:a05:6808:14ce:: with SMTP id f14mr29240216oiw.162.1639433812044;
        Mon, 13 Dec 2021 14:16:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r26sm2377051otn.15.2021.12.13.14.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:16:51 -0800 (PST)
Received: (nullmailer pid 1676039 invoked by uid 1000);
        Mon, 13 Dec 2021 22:16:50 -0000
Date:   Mon, 13 Dec 2021 16:16:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     alexandre.torgue@foss.st.com, gregkh@linuxfoundation.org,
        amelie.delaunay@foss.st.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, robh+dt@kernel.org,
        hminas@synopsys.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: document role-switch-default-mode
 property in dwc2
Message-ID: <YbfGUrn/fFN2RSmi@robh.at.kernel.org>
References: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1638806203-6624-2-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638806203-6624-2-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 16:56:41 +0100, Fabrice Gasnier wrote:
> role-switch-default-mode property may be used with usb-role-switch
> property to define the default operation mode (by forcing the a-valid or
> b-valid) at init.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
