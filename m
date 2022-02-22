Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE774C044A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiBVWD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiBVWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:03:26 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88D27160;
        Tue, 22 Feb 2022 14:02:59 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so19633883oov.3;
        Tue, 22 Feb 2022 14:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5TFgKXF78t7PnVJmCKd4IMylKZjD9zue4tteaNiNqo=;
        b=IxqgZDU/k2+8CRacncY+V9/9LmZE0wJP0d6vki3GPBVb4QDJhtVK2g8acUw3SVA5fV
         Zs4jajeg9hwQPSrVbmQjfbHnYPiz3Oz2Gq+nOqENArTLv7Me9yJuSLQXcxrkGEOTOA2m
         I/PDQN79jUG7SvhyWH0+x5x0AVfw8inwvPacd2kqZUAYw1uGoex2OUor74EpqLEtCksk
         op2dqo7bsvFgHIw98po8yRVxV/E6ryQeroLSOmDZnZumXjtVcRYDosEugh80HhspzQAP
         FeOLq+UfmaHafpKiXzTtgHEEWI3P/UocDuvgwIn/J4VNtVmFPJqTpBHvSmARQLecZ74r
         Fffw==
X-Gm-Message-State: AOAM531Lkag8Pe66I7W1wPn4sKvBfre/Cmr4zkaFcTYzb6dUdCowCXYk
        cLJcDGLGknqEx5jDv8U8eQ==
X-Google-Smtp-Source: ABdhPJxS/mlfaF7cWCXyVMr4GWsBSCgObWn9jZgPjfydueC6wgvCWkyQNc1HezkN5VT6H+Fqm/FWmA==
X-Received: by 2002:a05:6871:608:b0:d1:9e69:6590 with SMTP id w8-20020a056871060800b000d19e696590mr2669280oan.32.1645567379178;
        Tue, 22 Feb 2022 14:02:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a3sm6590914otp.49.2022.02.22.14.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:02:58 -0800 (PST)
Received: (nullmailer pid 3669897 invoked by uid 1000);
        Tue, 22 Feb 2022 22:02:57 -0000
Date:   Tue, 22 Feb 2022 16:02:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/3] dt-bindings: usb: do not use deprecated synopsys
 prefix
Message-ID: <YhVdkXFHMIOwLYsj@robh.at.kernel.org>
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
 <20220221082228.34407-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221082228.34407-3-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 09:22:28 +0100, Krzysztof Kozlowski wrote:
> The "synopsys" prefix and "synopsys,dwc3" compatible are deprecated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3-cavium.txt       | 2 +-
>  Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
