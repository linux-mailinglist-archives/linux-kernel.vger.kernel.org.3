Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC847C27F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhLUPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:36 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:33513 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhLUPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:34 -0500
Received: by mail-qv1-f42.google.com with SMTP id kk22so12725192qvb.0;
        Tue, 21 Dec 2021 07:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lxRUlH5h/qkv1tobdHsPH57fFy4Diy7QuwKWL1/vEoQ=;
        b=BsnWd+rwJHVBeX6agf9xIOPihCQ8JAIimqi6IyVYliQgWuyAUULGO2Id/mYWOqn/0c
         cCu1BM1ZkDK+Nbt7QMjGuh7cM9VRbDlXwT64ZdSquR+kHCDoVNTNM/YdzRMERX3ys7Ph
         S9USxDWloz7pHNiV06g97fGSKIgl2Kbi3ZOnpe0XoEfKcmE9SHzEI4clsX4j0GwG7VIY
         JWnTGgYgf4gvMbUoo5yMncLIraX8LrnxW92D0S3dC489T5xYzqaGxp/1qzYOIRoFmCCI
         foRZjbHCD2p6iifa3gSOXzmb42qlk6UdH49AKvh/oJ0HysZe/KgyO2OePsBPuHeNHvEg
         Ds6w==
X-Gm-Message-State: AOAM53115CGrUVbbjE+VdoPSm514aO64ZLfOXwS2BD0qroby1wBwwJco
        l5El9hj+x5kCH2jdLcmDGPBxwvvWsXWl
X-Google-Smtp-Source: ABdhPJydyCAqNGPYKeMB0L9W8qCxQa6hrAkDshFQNsFWPIBXuplQgSGjlC1ix1Oj6GXcjvQ1jDgYmQ==
X-Received: by 2002:a05:6214:2482:: with SMTP id gi2mr926320qvb.21.1640099614062;
        Tue, 21 Dec 2021 07:13:34 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id s126sm13493408qkf.7.2021.12.21.07.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:13:33 -0800 (PST)
Received: (nullmailer pid 1427874 invoked by uid 1000);
        Tue, 21 Dec 2021 15:13:31 -0000
Date:   Tue, 21 Dec 2021 11:13:31 -0400
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <YcHvG8osxExNYfGJ@robh.at.kernel.org>
References: <20211221112206.97066-1-antoniu.miclaus@analog.com>
 <20211221112206.97066-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221112206.97066-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 13:22:05 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v7.
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

