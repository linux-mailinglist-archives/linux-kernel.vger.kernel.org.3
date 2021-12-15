Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8B47631A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhLOUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:21:43 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36549 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhLOUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:21:41 -0500
Received: by mail-ot1-f45.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so26350304otl.3;
        Wed, 15 Dec 2021 12:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdIFuSso44hrhd8nXmN6Y3wbJps6MIRzHFW57KgL+Q8=;
        b=pixbfaZA4YbhEPrcPeChyP+wcLWA5ai6TlDsTZpcnzrWJq3wJs8/QC2tdFdZQYx0Sf
         9+I4sM+AxmoK00xz0eFEgPLMhsMh3FBMWDQJNY2pgfVyt1YjBYRBkW8XzGuOtl+7wqvL
         yzWgMMjBlYW+9YFb96eHluNwnPzOUXRvoE+GZzrTsm19bYa355J9euoo90NiAVQxOl5i
         E1s0zhEx9i0JYRlK5OQXz7977Rg8tXjlwLyGpdyvkvmABPo5fjuawYMBu6+JneLcbQxB
         nxgBYEYmzdBKeS0KES9JSZe17CNdE7ItuKKzMGZ26JdxwpGGTu4Cr5LLpE2x8T5hh/d6
         IvPQ==
X-Gm-Message-State: AOAM530gPyqJ8ISIDuxzw9TiklFVsfIqgD87JhRNJYF1NbrRbmi51Kcm
        46y1/Us398llPooOQhPtxA==
X-Google-Smtp-Source: ABdhPJxGdUPqJQCMWMFcp5PgXBllnOaxCxFH1D3ewEYWT+NUYoyWaZoVi7w6Ws9a5AInQ8A2Bhx+Ow==
X-Received: by 2002:a9d:17cc:: with SMTP id j70mr9865104otj.313.1639599701365;
        Wed, 15 Dec 2021 12:21:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x13sm627605otr.58.2021.12.15.12.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:21:40 -0800 (PST)
Received: (nullmailer pid 1772584 invoked by uid 1000);
        Wed, 15 Dec 2021 20:21:39 -0000
Date:   Wed, 15 Dec 2021 14:21:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-katsu
Message-ID: <YbpOU0VL2SxJhSr9@robh.at.kernel.org>
References: <20211213162856.235130-1-hsinyi@chromium.org>
 <20211213162856.235130-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213162856.235130-3-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 00:28:55 +0800, Hsin-Yi Wang wrote:
> Katsu is known as ASUS Chromebook Detachable CZ1.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
