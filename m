Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2847D6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbhLVSge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:36:34 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37698 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhLVSgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:36:33 -0500
Received: by mail-qk1-f182.google.com with SMTP id m186so3198866qkb.4;
        Wed, 22 Dec 2021 10:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wDzO3Ad6lSocQgHWVJpmiNVxeeGd17gp3zvJdJeX/e4=;
        b=M6vPnIA4haXnBpLKtPOuUWcwV/kf9SmcI5LTOE2MaQ+b7Gd+X3HRBg6rU5LNVQ2s6Y
         PHzf6pCUTWoNhwTNs6v8JNM4bprbum2aOamE14Oqyn0bdrLvsn9KUWqncG2ozANOZPst
         HvqUiv6Q0/JWZ/l3JIGJv5AR9iDz+DoEOxdY75wxrmaYBIujaNzd8OrReCFiinFVrzTC
         aSCI/H2CqumlVWomllVsTygoTqs3ovohkp6a6oRgGvvRbHhpUJabhymqPlHiToiyh5KX
         9N9ns4lI1MhhzacoEIsDvWOwE2QeJhCXJZkQa1oneyfsWlJLP9Z4bh7Y/EkaRdTqTXU+
         z+TA==
X-Gm-Message-State: AOAM5338kama3CIQSTamfmrpOQlS5kUXBgOw3zSPI43/kwo3SLbPfd7c
        s5uePoG9o4BBDUSM/gvtVg==
X-Google-Smtp-Source: ABdhPJyxpmkjjBfT4ceoTMEnWifcuMUn6R8s3AWzbnMnABxL7BM8/d1xSlbRPS7YeMdTafAGlXwpJA==
X-Received: by 2002:a37:315:: with SMTP id 21mr2935974qkd.52.1640198193055;
        Wed, 22 Dec 2021 10:36:33 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id d5sm2363866qte.27.2021.12.22.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:36:32 -0800 (PST)
Received: (nullmailer pid 2477388 invoked by uid 1000);
        Wed, 22 Dec 2021 18:36:31 -0000
Date:   Wed, 22 Dec 2021 14:36:31 -0400
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] dt-bindings: display: novatek,nt36672a: Fix unevaluated
 properties warning
Message-ID: <YcNwL7lgncq7balH@robh.at.kernel.org>
References: <20211221125125.1194554-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221125125.1194554-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 08:51:26 -0400, Rob Herring wrote:
> With 'unevaluatedProperties' support enabled, the novatek,nt36672a
> binding has a new warning:
> 
> Documentation/devicetree/bindings/display/panel/novatek,nt36672a.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('vddi0-supply', '#address-cells', '#size-cells' were unexpected)
> 
> Based on dts files, 'vddi0-supply' does appear to be the correct name.
> Drop '#address-cells' and '#size-cells' which aren't needed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/panel/novatek,nt36672a.yaml   | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Applied, thanks!
