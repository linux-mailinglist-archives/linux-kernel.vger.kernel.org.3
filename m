Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B183470B99
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbhLJUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:15:08 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35761 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbhLJUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:15:06 -0500
Received: by mail-oi1-f169.google.com with SMTP id m6so14747880oim.2;
        Fri, 10 Dec 2021 12:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AIgIhmMESH4FjIJ34+1ORZDQ3lYypzCaTtbkFwa/xAY=;
        b=yjchkiDhKDaRMyVMxixe/pta/puwmSpi1NQeiwC935C+o1Acy+4fQBkbQgB7yTHXyR
         IuRliEN4UO224ZRR2Y6bYCeLjFTvJkCxfmQMfzFT19tu7fi4C8KxjktagjWlbNG63WMk
         UDt32DpLXL5mxEJw7glnP9W3hAq+qLYdZeYN63KG1F/Cs9l4zEihSJoasV0sP4SGGcVm
         4FxCDQ8GDuemaju2IvFg/bL+iRY/RQuLQ+2fSAPkyikr2XZw26kg5HGHdsQ9aLOJfGY9
         N0bLB+zo7tZ17e6q+Lrer2hZeGgrvmS+bhCGo9o1PW1+GrG2tdoJoqaMZWCqqKuszL6K
         h86A==
X-Gm-Message-State: AOAM533O9F+1OsEZJJF6eyQIqH8kpzudUSYp6D2R02TPSXjZXb4x5K3+
        SAJgsyeHMWrZwlC7v7w3eZQ17axQdw==
X-Google-Smtp-Source: ABdhPJyUF6S3BHq6kagxqU7F/ujngmftOIXv6P1mFAJL840F4X3rpva//gPw21G8+PIAT7r055b85Q==
X-Received: by 2002:aca:30c5:: with SMTP id w188mr13759572oiw.35.1639167091003;
        Fri, 10 Dec 2021 12:11:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg38sm972401oib.40.2021.12.10.12.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:11:30 -0800 (PST)
Received: (nullmailer pid 1815088 invoked by uid 1000);
        Fri, 10 Dec 2021 20:11:29 -0000
Date:   Fri, 10 Dec 2021 14:11:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings:iio:dac: add ad7293 doc
Message-ID: <YbO0cauDANNaPiGV@robh.at.kernel.org>
References: <20211202150819.24832-1-antoniu.miclaus@analog.com>
 <20211202150819.24832-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202150819.24832-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 17:08:19 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the AD7293 Power Amplifier.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v6.
>  .../bindings/iio/dac/adi,ad7293.yaml          | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
