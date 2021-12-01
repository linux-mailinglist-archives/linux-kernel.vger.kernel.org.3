Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF346599E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbhLAXGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:06:16 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42531 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhLAXGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:06:08 -0500
Received: by mail-oi1-f180.google.com with SMTP id n66so51770887oia.9;
        Wed, 01 Dec 2021 15:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmWSdfj3pk1v9k2p/I9G2Yz9bEtTwxCQSWC3JUHSCUk=;
        b=qvBU16akuTm4e4hgXGfGvi4+bNCe3b5EWGJAWQS6B1Ln6f1nJkQgSoNmkCEinGjYzN
         l6QWHR9rm0zQnKduBCSy9KZ3fsjUKZrwVaNlQDgvQAhxjyyBYJvOIARKhI5hYubgl7e+
         +byfdZbvUOM4RQ4VId3BYC12b+zRnu6CJxbL0Q/8O1VONhy9WmTXXZ394+mgRSO3Vd+H
         lnYMNCWeDoVkr6k5KLFWJodkCsYo/MAdS5gPb5ZaVH8Fr0QimKMoqg+qbbaYOus041cR
         O3AVzCEKNrkGUtARS/C2AtclMZoDqreDZfKcdvOjiUXJe/lI2dm43gCxZpHNjj765tC8
         Fyrg==
X-Gm-Message-State: AOAM531lIxL8PCRMAwLPDl3cC22/iIBLjI5m+QmyeuJHzmckwfJA8vrP
        HztIzH7THBxqy17d33THNQ==
X-Google-Smtp-Source: ABdhPJxw6AJBgv5NvOcV3cStwouXiPEbR5D9qFNthWuDFgP6CtYgtPhZASLYd9Nt892qK7LhQbUrUA==
X-Received: by 2002:a05:6808:1381:: with SMTP id c1mr1265757oiw.129.1638399766218;
        Wed, 01 Dec 2021 15:02:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm416557oon.34.2021.12.01.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:02:45 -0800 (PST)
Received: (nullmailer pid 3060681 invoked by uid 1000);
        Wed, 01 Dec 2021 23:02:44 -0000
Date:   Wed, 1 Dec 2021 17:02:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add Qualcomm
 MPM support
Message-ID: <Yaf/FOynvYBDZySt@robh.at.kernel.org>
References: <20211126093529.31661-1-shawn.guo@linaro.org>
 <20211126093529.31661-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126093529.31661-2-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 17:35:28 +0800, Shawn Guo wrote:
> It adds DT binding support for Qualcomm MPM interrupt controller.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../interrupt-controller/qcom,mpm.yaml        | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
