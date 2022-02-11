Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033F4B2B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiBKRIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:08:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351944AbiBKRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:08:21 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF5C02;
        Fri, 11 Feb 2022 09:08:20 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so6505191otr.11;
        Fri, 11 Feb 2022 09:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UP82tZK0mR8kf+RIcXUHEFVtVvjNxQjI8M9cf8aM7EA=;
        b=Gf6FRuf8YyOudckEiEDv/7Tpj8Qh+VKWT7/GfT1/eWuu7dcgnbQLj6mzBR3Nnd3z7W
         Qs2vsS5sVivlwupO1R1g5tq13srF6zotCkvTK3Dvc6PLvFPR1UC5GRZ5TP/VA1tTUOyo
         n3qWLbuXPq6fxgts2OrthOhuOFfCeChzjnHZoaCAKy6P6g5oCR4aPcWaKcrNWR8OU0js
         PMXYRgNAsI6k+wz0nb7Iu5GRTYMgsy/8BpdSJTa2XAoR52l8zyQsp1SZtKnlnjd4+/f4
         BL9pUkq64JQ6yncczZAn9TJEcu2JNJkIE/ElzAMEBNHTJCWd4jMZR0dtb8LId1sD7LrK
         ShTg==
X-Gm-Message-State: AOAM5325UbpzQ8GC7TuzGmA7QIgoICyDAlTqnjRPMKTE+V4HyrkWEX0F
        Tn1qp0U1CfsKeG46OKzA1rywIoDDTw==
X-Google-Smtp-Source: ABdhPJxZQdbH8VWoY++MFQ5YEvKMcvExNGQkuMa365b4w3lrJpxTmRIndhtiT0EQKribgxgz7bG85A==
X-Received: by 2002:a9d:4806:: with SMTP id c6mr903303otf.317.1644599299563;
        Fri, 11 Feb 2022 09:08:19 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id 79sm9280615otc.56.2022.02.11.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:08:18 -0800 (PST)
Received: (nullmailer pid 531058 invoked by uid 1000);
        Fri, 11 Feb 2022 17:08:16 -0000
Date:   Fri, 11 Feb 2022 11:08:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        paul@crapouillou.net, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add PWM compatible for X1000 SoC
Message-ID: <YgaYAOmej5V4yRWo@robh.at.kernel.org>
References: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
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

On Wed, 09 Feb 2022 23:11:41 +0000, Aidan MacDonald wrote:
> The PWM hardware on the X1000 SoC is almost identical to other
> Ingenic SoCs, so it can be used with only minor driver changes.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
