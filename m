Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297C54C043E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiBVWBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBVWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:01:12 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0012CC3E;
        Tue, 22 Feb 2022 14:00:46 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso16669591ooc.12;
        Tue, 22 Feb 2022 14:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CPmhbDGY+iCtNKx95loioT6htwXbSXUXUs2lvzKEMpk=;
        b=7VXY5b3JqvdiGTLfbcLFSwzrftXV0YrqGz+gqSpzUSDlDrL3UT6Ju4wSj4GDiqJPgs
         K5vM8Db/Y40TO7OXVd9TOSnmweIA4pJrn9TfB3IjEhZD5vlu6VSdYAqpWl61inWIeBVa
         50tgCLCOc0b5BlpoCxr+ETJEb9iHpOy+2btLiq+DrfrHk0KYhle0TrCs5rqU/JQuN5tZ
         S5289nGm/5uVK5KdMYuvY4hNhucRN00bfEEJzMDsUtqjZy4OYP7+gTeuZXqsFz8DTR/G
         tBIEjtXT/16bEXiYPYNP8mE5+wPmvEGWjxQRGIFuujlF9egqHdCQVUzkai+08/T/o583
         lPbg==
X-Gm-Message-State: AOAM5309KsowlEJ1gXBl+ecWtQJuFxxReu97r8b6FRIKxSqP7Za3bPqq
        ns33uueulba/tvX3D9zNfnkrzS1dpA==
X-Google-Smtp-Source: ABdhPJxVuXFocKfOWbDnOp2RKTFWU4E2DJS63Mbywf2SKhp5F7mx4ag5ApZE5y0TG9dpW2LKltclRA==
X-Received: by 2002:a05:6870:f2a4:b0:c6:690c:2d with SMTP id u36-20020a056870f2a400b000c6690c002dmr2705683oap.201.1645567245769;
        Tue, 22 Feb 2022 14:00:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h12sm28900732oan.14.2022.02.22.14.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:00:45 -0800 (PST)
Received: (nullmailer pid 3665780 invoked by uid 1000);
        Tue, 22 Feb 2022 22:00:44 -0000
Date:   Tue, 22 Feb 2022 16:00:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: usb: dwc2: add disable-over-current
Message-ID: <YhVdDD23wrr1fSkD@robh.at.kernel.org>
References: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
 <20220218161522.52044-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218161522.52044-3-krzysztof.kozlowski@canonical.com>
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

On Fri, 18 Feb 2022 17:15:21 +0100, Krzysztof Kozlowski wrote:
> The driver parses disable-over-current protection and some
> implementations use it (e.g. Altera Stratix10), so document it in the
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
