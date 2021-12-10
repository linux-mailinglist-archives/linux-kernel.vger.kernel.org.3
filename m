Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85404705E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbhLJQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:42:00 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38701 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbhLJQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:41:58 -0500
Received: by mail-oi1-f174.google.com with SMTP id r26so13940441oiw.5;
        Fri, 10 Dec 2021 08:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7t0xxkQq4dvEg89M2pLQwLR7F/DdLFsPTuqlvZl+6Lo=;
        b=OsWJdskyZeZeocj8jwNhE9h96X80dAgrJhV9LD9Kf07n5i8MnmXMYiGw7RgUENifDe
         JDdhPjXsYYd5Pe8kjHRbaOXP4V2uVdi1IEYGCnSjh2V/hRUVZLcCswU2Ot9kafBdEHRg
         5F8q7sTI4868GD1ipmaFZUUlnAs5OUL7oxWk8dVZcP2DIZ68S3UOo6xwT+uw3Moor/gI
         +J2hN6aOYcf4qEij6r52J/Lnev95KTMBBwKsorUOxoOcL6zzimFT3zbKii9cfS06zZHa
         CRNU1WPFW+NaFMWxWxgvLMMRn7iSWopMMIEaK6fyCwUfooD1qBz/0YlvInfQY4WWQ40G
         MGaw==
X-Gm-Message-State: AOAM532B+56X3SQCr7+tV6aKvsdzdhB8+1EhhzoBN9fCOXS0U1adClYx
        GvgEf4+1U6SaSPNXHROj+5LG6VR2JA==
X-Google-Smtp-Source: ABdhPJw4qx+vlwG4ihilVW8fP+eVFFfTfUZ7fYCsAYIgP0kZhTRiYhSxk7TScDqQEUjM2gn8ZhFiGA==
X-Received: by 2002:a05:6808:1811:: with SMTP id bh17mr12837135oib.105.1639154302623;
        Fri, 10 Dec 2021 08:38:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm761131oig.28.2021.12.10.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:38:22 -0800 (PST)
Received: (nullmailer pid 1488787 invoked by uid 1000);
        Fri, 10 Dec 2021 16:38:21 -0000
Date:   Fri, 10 Dec 2021 10:38:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings:iio:filter: add admv8818 doc
Message-ID: <YbOCfcMS+tlSqgT5@robh.at.kernel.org>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
 <20211207155445.247444-3-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207155445.247444-3-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 17:54:44 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV8818 Filter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - remove clock from `required` since it is optional.
>  .../bindings/iio/filter/adi,admv8818.yaml     | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
