Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0966846C43B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhLGUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:13:56 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46888 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbhLGUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:13:53 -0500
Received: by mail-ot1-f44.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so301156oto.13;
        Tue, 07 Dec 2021 12:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wg+IGbddll2fMnXGRuVqNBbMG+6kF82iJVi4DrDHSKU=;
        b=0yKJqU/9CrVlYUY/xMkHxsOrC1cBSB61v8SZtfdpBDA2xIXf/f42dlxoMvkWcW1aA+
         mrRWh+5rozexOhtYyKvOGyZ8Sb1h5UQp6liAatmx3iQ+MhbrcTLCD+re9bOPGhBjMeVB
         77wPY9P5aSuJ5n/iBegKxXh2qMT8U6XynIbPhfIAaxzfd2WDY28wemBJDx7XQqtUjysZ
         /F9xfSZLmMpgm0W/jThZAYTfGwoWAKUKPyMNpBWa2ElDQnoAisCeBVbCr66aFVmXFQwe
         zfjS0PPYnJ0BUN6INucg9f0BRr0PkKPJWAP6sHdQyGgkBlA7kRhapQUJOZ2pi/EUsD/D
         eSsw==
X-Gm-Message-State: AOAM530K3IgpuNuawhTLaETlwYn4G7wNFAebWjUko3uR/2wjydliXESJ
        y5AM0mdKdWsHPvY09sKmFFR7gNjqfA==
X-Google-Smtp-Source: ABdhPJxrUMdU3y7xeNlvEKAR4bK3/bh7Z7+XwKqmdvuKOiYTnQfFyfn/LwnMPflyZUx4Ut6fLKRQ6Q==
X-Received: by 2002:a9d:7855:: with SMTP id c21mr37764796otm.167.1638907822325;
        Tue, 07 Dec 2021 12:10:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u13sm136131oop.28.2021.12.07.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:10:21 -0800 (PST)
Received: (nullmailer pid 748298 invoked by uid 1000);
        Tue, 07 Dec 2021 20:10:20 -0000
Date:   Tue, 7 Dec 2021 14:10:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <Ya+/rORPqHC/3Xwz@robh.at.kernel.org>
References: <20211206154845.268445-1-antoniu.miclaus@analog.com>
 <20211206154845.268445-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206154845.268445-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 17:48:44 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - add `input-mode` property
>  -
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
