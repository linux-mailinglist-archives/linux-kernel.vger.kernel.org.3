Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33AD4627EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhK2XOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:14:47 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39472 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhK2XOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:14:37 -0500
Received: by mail-ot1-f53.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso27659159ots.6;
        Mon, 29 Nov 2021 15:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CI0eUCmLQSzhgrbo5fWAeYCuyAN+7MXOdPkvLupzvQ=;
        b=5GOdlMBkK2UOK2g6fqh511Pl1eV49XtHFM36fTgW8BCev59f7q8nmHST0T/A8zPQeK
         B8qef+KSAi1OU902eGRpyqR+eW4M5XJozG4qbQEJQ4aq71WjI2bUrIQBEJyNclNg4CeP
         S+g2WHjXoIffyGO8TzDQyJ9gdzu1kjkUGS3ngw3EWBWWTsUYksOFBQapxnomvnrzaNmv
         11qJVC97tVeMQ4CWFL09RQBa+bCPA9px4/87eq2y4IMkRaHE0Eq6kh3z12ET6OJawRHX
         vZE9nAcu9nsV6r/kmi3Q7mjwVGhB9uWutVZoxTo24VJImgr5edy2+Xcz+1RMT2DPZaww
         K6Ng==
X-Gm-Message-State: AOAM530UN5ITOpnA2z2fvzXXCf9eFZ5S/sAA2mlOdTMHk/Pdl2+ASrOA
        G3Ag+omDGytsCMhGmElr7Q==
X-Google-Smtp-Source: ABdhPJyn5bH/NkhCl4fBrap5C9QP/YwnwzPvEx86qJHULHBAR1eU2SZOhwU/cmcgv3daAIYgboM+Rw==
X-Received: by 2002:a9d:6e06:: with SMTP id e6mr46384951otr.381.1638227478517;
        Mon, 29 Nov 2021 15:11:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o2sm3502336oik.11.2021.11.29.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:11:17 -0800 (PST)
Received: (nullmailer pid 786264 invoked by uid 1000);
        Mon, 29 Nov 2021 23:11:16 -0000
Date:   Mon, 29 Nov 2021 17:11:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 5/7] dt-bindings: phy: qcom,usb-hs-phy: add MSM8226
 compatible
Message-ID: <YaVeFFOyX8mbiNNZ@robh.at.kernel.org>
References: <20211118210210.160895-1-luca@z3ntu.xyz>
 <20211118210210.160895-5-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118210210.160895-5-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 22:02:08 +0100, Luca Weiss wrote:
> Add a compatible for MSM8226 which also uses the USB HS PHY.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
