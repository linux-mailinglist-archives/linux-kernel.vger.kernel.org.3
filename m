Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975C7475E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbhLOQ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:59:16 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42827 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbhLOQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:59:13 -0500
Received: by mail-oi1-f173.google.com with SMTP id n66so32491278oia.9;
        Wed, 15 Dec 2021 08:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cbc23CHvOO/hrY6F5fcgLo7QAAPlU+LeICq8wMKeevE=;
        b=kfZPbYlb3lDNkC1U0ZX301F6el1rZRUtX4mQiMKBIiJ1arjymfCe2w+Lfvx5QzFyEH
         ZIFJ93Z2vgy2HkBqeOs6qDOP3kBWBK7tadRg/BKYbCnpkfj7J+3z7ufxS/apt+Rqgqj/
         puaAwLQlJXvK/iJQrUMW6SzvLXWMFN61v3BHNKJBDkQbB4eCLHXDP1w5FXcEFUjGRgpv
         xdB/ZmTpJabtplxliPSx96hEHTMkN9VR+RC1N+/knwIlBTDbzaWOkUav1hkepITj063g
         mBIs9Zi+pbeqHtCv3s5xuMFbthZAs/cfNf1tJHCKhlLMUmuQ1JEgrleDWRd1mSUY/eXs
         uSDg==
X-Gm-Message-State: AOAM532VUqU28ie5elmXOzs7hntAbbaCt4jL75zgCVtXHV7dXFQQaW8y
        DUqb717qftyPg7dF6eF4ZQ==
X-Google-Smtp-Source: ABdhPJwkfI7bvwnOd5dMrWSJ3QTZAM2+Xi/DKoZlYn797z0bfbyJlXXzA0tMt27AzZ7OMFMq8i5ojw==
X-Received: by 2002:aca:1104:: with SMTP id 4mr632378oir.143.1639587553250;
        Wed, 15 Dec 2021 08:59:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z2sm519600oto.38.2021.12.15.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:59:12 -0800 (PST)
Received: (nullmailer pid 1470552 invoked by uid 1000);
        Wed, 15 Dec 2021 16:59:11 -0000
Date:   Wed, 15 Dec 2021 10:59:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: apple,mailbox: Add generic and
 t6000 compatibles
Message-ID: <Yboe3wGh8ccfenSy@robh.at.kernel.org>
References: <20211209055049.99205-1-marcan@marcan.st>
 <20211209055049.99205-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209055049.99205-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:50:48 +0900, Hector Martin wrote:
> Much as we've done with other blocks, let's introduce generic
> compatibles so drivers can bind to those and still work with future
> SoCs, as long as the hardware remains the same. Also go ahead and add
> compatibles for the new t600x SoCs (we group those as t6000).
> 
> Note that no DTs instantiate devices with this binding yet.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
