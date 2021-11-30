Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61BB464136
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhK3WVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:21:25 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43637 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhK3WVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:21:22 -0500
Received: by mail-oi1-f173.google.com with SMTP id o4so44208849oia.10;
        Tue, 30 Nov 2021 14:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64PSQYR4mrOg5NMVu2GtkuhPXarpcvAI5FbGR86CFuE=;
        b=A4bdvBFH+yR8xi2w4FL8IOYD/+bzSFp9rnTtK8MuKAX0q7O4fPuTwQt1MKlzSHoUdF
         jo0o9Z3R/g2HxO2m9DfB6aLSe3qUy4x42KdmdCplMI4WuovtyvdBjnh8s/XKXcd0h6my
         FLQ1zv6NEqOFoJBNEXDH+MZ1Spl7XMHhOTFhbwhvNDegK/3I3zKl3BNjFgluVK+Bz35Z
         xp5tk7i2crBDZP/m0tB+w21AGL80gUXTivdZL1dFQTUNKiBjCmssZIjWxEatSj5RYvcA
         iPbMbQBP4ic7o6Ce2FKXiZ7nF1WSKJmPox8kf+f/+Pa5IJT6y3UB89kEyF8Xp85+m/RT
         /40g==
X-Gm-Message-State: AOAM531GlaISKleutbtE9tVaFV13BNz7QTUzxC7ReJyXWPCAsCZtlzvx
        rH6IlK1BnToBAA0SGGjRNw==
X-Google-Smtp-Source: ABdhPJyEmRnCsSlO1MohjwD4S1U5XA1oYI4iwehAhMwrbMQZkaRGhcGfaYXjL4uP3BRncVX7qt7vKw==
X-Received: by 2002:a05:6808:118a:: with SMTP id j10mr1902823oil.101.1638310682423;
        Tue, 30 Nov 2021 14:18:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf17sm4305466oib.27.2021.11.30.14.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:18:01 -0800 (PST)
Received: (nullmailer pid 3110035 invoked by uid 1000);
        Tue, 30 Nov 2021 22:18:01 -0000
Date:   Tue, 30 Nov 2021 16:18:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings:iio:filter: add admv8818 doc
Message-ID: <YaajGXF36Db1WurY@robh.at.kernel.org>
References: <20211123133900.133027-1-antoniu.miclaus@analog.com>
 <20211123133900.133027-3-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123133900.133027-3-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 15:38:59 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV8818 Filter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - remove `bw-hz` dt property
>  .../bindings/iio/filter/adi,admv8818.yaml     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
