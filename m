Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D74D212C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiCHTOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCHTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:14:19 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9335865;
        Tue,  8 Mar 2022 11:13:22 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 12so231921oix.12;
        Tue, 08 Mar 2022 11:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2AXhz92YfR+Z3ouxiGrl7g4uvz8SgJwXLDdDVT50eA=;
        b=u/Ovl9yFxqp8pvkBf6gWzdYHyeYhsHO1tlDdvG4epBB8ExjvPQTWxEfAVFstMiJD8B
         Jb4Wc8rgzw7UZo9TgeKS1fbEa6laXjog9pJUwTFc4nX6ZbHdzmw1KElIhDUjUIthd1P/
         saRw9MWsfqvNGPDuVaLsrxGuZM93oBTBLpnMpLhdHv/OKbygQjz/pNTzadV8n6UnWpFM
         mOlM2J8srsmQ8j7NgBK5DLqCHAqgy8i5jGvA2yekk3SYA5h+UcXKIEZUnesOOZIxa6x4
         uUKBfEfNDKT2Rxzqm+cK7bt0NjvkSHqoKxMwvUmDN9yrUQHlFRo7fV01+Etf/m8abwXt
         H0Hg==
X-Gm-Message-State: AOAM530rBORSvv2rCgdIPXIbHwfiL6qtrn+grn8X3xI1p1I3mc6mTQ+9
        Qvp8sYqv2UGuaoKeG3Z3ckZl0jf8rw==
X-Google-Smtp-Source: ABdhPJxSqF6A2iPPt+15Fi7jqUAwkgGGJAYqtBG4RbU/Z4k9M1jC6z/duFCKHJbTU6EKbB10t/f7BQ==
X-Received: by 2002:a05:6808:181c:b0:2d5:8e6a:31cc with SMTP id bh28-20020a056808181c00b002d58e6a31ccmr3669102oib.15.1646766801853;
        Tue, 08 Mar 2022 11:13:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a056870048400b000da4412b3d8sm3335276oam.51.2022.03.08.11.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:13:21 -0800 (PST)
Received: (nullmailer pid 1164118 invoked by uid 1000);
        Tue, 08 Mar 2022 19:13:20 -0000
Date:   Tue, 8 Mar 2022 13:13:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: firmware: arm,scpi: Add missing maxItems
 to mboxes/shmem
Message-ID: <Yieq0JGAJtNM978J@robh.at.kernel.org>
References: <58b7c706f259f88a61bfe82d9106fe0a93a9838d.1646761693.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b7c706f259f88a61bfe82d9106fe0a93a9838d.1646761693.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:49:02PM +0100, Geert Uytterhoeven wrote:
> "make dt_binding_check":
> 
>     Documentation/devicetree/bindings/firmware/arm,scpi.example.dt.yaml: scpi: shmem: [[2], [1]] is too long
> 
> Fix this by adding a proper maxItems value to the shmem property,
> and to the related mboxes property.
> 
> Fix the grouping of the "mboxes" property in the example.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Exposed by commit 39bd2b6a3783b899 ("dt-bindings: Improve phandle-array
> schemas").
> 
> v2:
>   - Change limit from 2 to 4, as requested by Sudeep,
>   - Add Acked-by,
>   - Add maxItems to mboxes properties,
>   - Group mboxes in example.
> ---
>  Documentation/devicetree/bindings/firmware/arm,scpi.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks!

Rob
