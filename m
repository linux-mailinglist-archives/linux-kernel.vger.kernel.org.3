Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00114C0438
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiBVWAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiBVWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:00:39 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8AD1080;
        Tue, 22 Feb 2022 14:00:14 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso10635297oti.3;
        Tue, 22 Feb 2022 14:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xQgEbwRpIbRoiFzstIKSG/wc8HUtiCQcZKqTWizciw=;
        b=6nrH97Q8GV8KMxa5+xM0gRhOZ8sSV6LEtFF0aU+Q/oDWImvNkdno+WOG0QrbqSL3qK
         4xWoLRri+1rfaPyK2viFG7s1j9tbU46zr3H/k/GdVXffD9rq/SNUng2By5qMSiFSest/
         C+lbqbBUCH/KxDcgKZ0KqDzep2wHNM+nomL0sDAOi34ce02Rdt5x31l0vO4HjDPb7BlC
         SlMrNi+vQg9+/YVYNY7GOzl9hDPhvhOjDidUl0Ns8Z1+VdBVOv6AFCW/ZOyIchvkrAiu
         21SMDarTSXCeRAKEZD2xy3r3BBe5qUv2KT31UFiFNGuDpcUf+9Hp5K3XGlfi0H3uXdTV
         ZLdw==
X-Gm-Message-State: AOAM531+1nxoQyztDBq6qv/915PBZgm0uDD9zAxa8GrhEI3zR83DUDiQ
        zNlr5jAqyn38g2Ds4OXdRzGE3qLqXQ==
X-Google-Smtp-Source: ABdhPJzwef2sHCF2I+BS0cb2XFASLhaqr5vZykT9+sZ6EXKqJ2FpytLTMnC74l8RPAIO/nuAg/CyeQ==
X-Received: by 2002:a05:6830:243a:b0:594:cdbd:6ec7 with SMTP id k26-20020a056830243a00b00594cdbd6ec7mr8885035ots.39.1645567213296;
        Tue, 22 Feb 2022 14:00:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a32sm2324783oaf.10.2022.02.22.14.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:00:12 -0800 (PST)
Received: (nullmailer pid 3664795 invoked by uid 1000);
        Tue, 22 Feb 2022 22:00:11 -0000
Date:   Tue, 22 Feb 2022 16:00:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-usb@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: usb: dwc2: fix compatible of Intel
 Agilex
Message-ID: <YhVc67mlzBkZRHTE@robh.at.kernel.org>
References: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
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

On Fri, 18 Feb 2022 17:15:19 +0100, Krzysztof Kozlowski wrote:
> Intel Agilex USB DWC2 node is used as compatible with generic snps,dwc2
> (just like Altera's Stratix10).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
