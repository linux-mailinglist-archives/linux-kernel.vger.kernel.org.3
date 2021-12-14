Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795A147474D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhLNQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:15:34 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43587 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhLNQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:15:31 -0500
Received: by mail-ot1-f43.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so21356806otu.10;
        Tue, 14 Dec 2021 08:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lsmMAdH+An2Dh+fjwu4HAFz0gVF5gV5ItKVtgfV1m8=;
        b=5BCtbK8Oqr0ZyukRL/fr02pLZtAzsAY0S9W2cRI+JNA5WT/y4gTkvQDJPrTwUjpAnb
         r33tsc3E7B7jNqwbNlzaPW7Kn/10oroYBvV2cbMeXOtRsWN8ufCoFU36goP4PQLHIm1K
         HF+rtKDQuEr9BUDl4FBdjVm4Worq+3LrxicYslcFnVsRcMn6vSJeI9+wnhAvbD2X0ou7
         8fN9amMAp8Ccqk+WY0pZh/cmZWaTqmA/c0NQ7jA1NpglDOQy+hwtDomO1y8q7zveSPGZ
         PF71JjxdvOBqqcT71e0vEvl9aktjpEcANVGENELfGiI16HCWxvI4pX+V6Sbnzus6sxqJ
         loHA==
X-Gm-Message-State: AOAM533aShlkjBZAeEXTb+MymV07UOUqv3oTa5a6uzPxqYFJG6nRLgxZ
        JOt50O6FoB4X+w3OjmUtymU+gpLDaQ==
X-Google-Smtp-Source: ABdhPJwnbpug1eJO8ZQ8DAXWLA5qjPewBfQmB+TUTb5hi8x5hDwJnuqK8HvM6KL8yI+sA5YRqtE1Zw==
X-Received: by 2002:a9d:6c14:: with SMTP id f20mr5110440otq.141.1639498531167;
        Tue, 14 Dec 2021 08:15:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t11sm42961otj.24.2021.12.14.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:15:30 -0800 (PST)
Received: (nullmailer pid 3488247 invoked by uid 1000);
        Tue, 14 Dec 2021 16:15:29 -0000
Date:   Tue, 14 Dec 2021 10:15:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, nuno.sa@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        dragos.bogdan@analog.com
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Message-ID: <YbjDIbXXoTV4Qu1D@robh.at.kernel.org>
References: <20211213110825.244347-1-mihail.chindris@analog.com>
 <20211213110825.244347-2-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213110825.244347-2-mihail.chindris@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 11:08:24 +0000, Mihail Chindris wrote:
> Add documentation for ad3552r and ad3542r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad3552r.yaml         | 217 ++++++++++++++++++
>  1 file changed, 217 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
