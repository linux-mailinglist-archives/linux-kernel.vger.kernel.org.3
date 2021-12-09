Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5946F172
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhLIRTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:19:37 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46907 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbhLIRTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:19:36 -0500
Received: by mail-oi1-f182.google.com with SMTP id s139so9505316oie.13;
        Thu, 09 Dec 2021 09:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJCW62x3onBcBzA0Avsq6dkT2NmwvIY0nnwCLojME8o=;
        b=6avTJJ/uMovZe273+z+vkDsEIr8/978IEbbactbaxEmrwEuhYsIUIn2ToOqVCcXCBD
         4A43/aABw8Qkn6aQ/e50qcZsOfpvai91tRfD/sPsOwZYUq1yqZLIJFksG2VKI+uYQiTe
         fd7NHwR4Dz+/yXwpG3f2Sqm8j0baawRLtgudeLfvul/yFzXvuxqsWvsAAj1Ly4NI9p8P
         aFSvfM2x5e4U8Q6oAsE8BnKRVpsw+iiywJvBW6ix0NYTXMpLkYMRyf0J5XSdmp1t6v0/
         B5pIxKauQfLv+E2d87yr8K9FjNKjkCUtarUPAjmb2xwVJzRop56k3572s3vSYuN8gTLC
         0Ufw==
X-Gm-Message-State: AOAM5311m/10haqy37+OcuBQPjadENA0H6NAIJmlczJ25sQd7oyDyJOB
        qecc5JP9fIwj5sK4/Hou0cZwiQBAvg==
X-Google-Smtp-Source: ABdhPJzF2oVhniuWDtFTM8NyNEbNV55E/dfyOIDuyw3i9Ju503xU3rvXvpyop+tJdpRoA9zMACTNnA==
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr7200694oiw.68.1639070162382;
        Thu, 09 Dec 2021 09:16:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm65676oon.34.2021.12.09.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:16:01 -0800 (PST)
Received: (nullmailer pid 3115487 invoked by uid 1000);
        Thu, 09 Dec 2021 17:16:01 -0000
Date:   Thu, 9 Dec 2021 11:16:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t6000-pinctrl compatible
Message-ID: <YbI50T2dDww3nVf/@robh.at.kernel.org>
References: <20211209051001.70235-1-marcan@marcan.st>
 <20211209051001.70235-5-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209051001.70235-5-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:10:01 +0900, Hector Martin wrote:
> This new SoC uses the same pinctrl hardware, so just add a new per-SoC
> compatible.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
