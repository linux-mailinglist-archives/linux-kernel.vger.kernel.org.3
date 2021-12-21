Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9632047C274
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhLUPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:19 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:45843 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhLUPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:18 -0500
Received: by mail-qt1-f181.google.com with SMTP id p19so13074463qtw.12;
        Tue, 21 Dec 2021 07:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1fNNiIzdcwL+Db50I0q/iIpBeZkAzHJTsHOgv2ACbY=;
        b=QhNJPulGIWp+y+l4Pvi7qJRj/Wn2ZIyY7X5kCjW8CMbQiTMtZFhnsibRP+yxFdvaBF
         Ddp1BZyfVvaa/zAv9/ALPy2oqH8htYH7buNhc9yRD6IPZVRMVrKgsLZYye2xjiYDk+3g
         XiirT52zpellG0qxyviA0zbKi83YtrjvseUwmDrHUsaGr24FAdXwZJkjJZi+jdfSw6Pa
         VftS9lZF8dRRoDxdjo/xQb2ovi4q9eH6zzAtOanVR71UAUyr4MrRo61TTFNemgHZmOjK
         iOhL3w/enYu4x0hYBzswbbu+MbmHFvDiEkw2n48Yxp5GaoIk9AE8DfX8gJHvMuBfM0p6
         dc1g==
X-Gm-Message-State: AOAM531TWc3qoGw+ZOmNh1CkwJNaEBMIfAHkLfI/+TpA6g1iEAUumu99
        dibDwjIfT0oJkoQDL2dLqAaK6t/raTdp
X-Google-Smtp-Source: ABdhPJxiLSaJ+dpK55CmiMdb3Q/0uiCKhk9UqwrzogLb5reN/Pqzkqi5lUNQYO4Qa/9DskKf3EfGkQ==
X-Received: by 2002:a05:622a:d3:: with SMTP id p19mr2663490qtw.37.1640099596384;
        Tue, 21 Dec 2021 07:13:16 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id n13sm15368990qkp.19.2021.12.21.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:13:15 -0800 (PST)
Received: (nullmailer pid 1427383 invoked by uid 1000);
        Tue, 21 Dec 2021 15:13:13 -0000
Date:   Tue, 21 Dec 2021 11:13:13 -0400
From:   Rob Herring <robh@kernel.org>
To:     reinhold.mueller@emtrion.com
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: Add emtrion hardware emCON-MX8M
 Mini
Message-ID: <YcHvCagnKi8l1CYf@robh.at.kernel.org>
References: <20211220072332.81072-1-reinhold.mueller@emtrion.com>
 <20211220072332.81072-2-reinhold.mueller@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220072332.81072-2-reinhold.mueller@emtrion.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 08:23:31 +0100, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.com>
> 
> This patch presents the yaml patch for the emtrion GmbH
> emCON-MX8M Mini.
> 
> Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

