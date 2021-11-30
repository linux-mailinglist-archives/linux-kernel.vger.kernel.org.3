Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CC4628F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhK3AQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:16:57 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37647 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhK3AO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:14:59 -0500
Received: by mail-oi1-f182.google.com with SMTP id bj13so37855314oib.4;
        Mon, 29 Nov 2021 16:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAmENX5WwPEUlnW4HT79iWxJtSuJ4dQoo2QH6SactbY=;
        b=KzFmBURoJQLr/c511cgvO8Nt1ducbffmn3p6Ifxq0jte6FahIgwjJRx65cmIyJrwGp
         bVojpg/5uRCRjSldb5XOasXJ8rpWUulqR0Z2t2kY/ugZOxnUZOjg+iChInTXYraPmUKL
         LJwt7Jjx7WwvIPriaunUQJuNZvIwUVHGE8bxfvnPjJNs+sXzMULoZRLGBPWMWZAzfnp1
         j0qqTmkZ+C1/OSGVd7lkiCmOA6Da0dhw1mulmR+em5AG2EQ6Ru2CFhifgkEZ/lHXFaT2
         OPaRYwPkDMmz5Mz4+X6qyjbsYT5j2aG/VCzIz1B9+oGy1kb5bo6wp09k8Vfxt+78xK3K
         w8cQ==
X-Gm-Message-State: AOAM531AB6kwIvcJHwPuLEfs4tL4pMGwuZJDTzHkXNt1AmG0lSOjk9a7
        hJ7V+BSyARurQ/O6HU+WvfwaWh8F3A+V
X-Google-Smtp-Source: ABdhPJxwSyIlDv4FYelBdHSpqNlX8viBTUOYT5829wUHn6ArhX4nrlvDcIlX1GI1ms+0Bo9PAFWpVQ==
X-Received: by 2002:a05:6808:e8e:: with SMTP id k14mr1210704oil.25.1638231100403;
        Mon, 29 Nov 2021 16:11:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a16sm2906462otj.79.2021.11.29.16.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:11:39 -0800 (PST)
Received: (nullmailer pid 869764 invoked by uid 1000);
        Tue, 30 Nov 2021 00:11:39 -0000
Date:   Mon, 29 Nov 2021 18:11:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for J721S2
Message-ID: <YaVsO9qbX5J8uuEn@robh.at.kernel.org>
References: <20211119133052.17793-1-a-govindraju@ti.com>
 <20211119133052.17793-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119133052.17793-3-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 19:00:47 +0530, Aswath Govindraju wrote:
> Add pinctrl macros for J721S2 SoC. These macro definitions are
> similar to that of J721E, but adding new definitions to avoid
> any naming confusions in the soc dts files.
> 
> checkpatch insists the following error exists:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> However, we do not need parentheses enclosing the values for this
> macro as we do intend it to generate two separate values as has been
> done for other similar platforms.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  include/dt-bindings/pinctrl/k3.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
