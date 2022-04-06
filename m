Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60E4F6A14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiDFTil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiDFThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:37:39 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638DEF793;
        Wed,  6 Apr 2022 11:18:02 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id e189so3243939oia.8;
        Wed, 06 Apr 2022 11:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yVQ2J4c2VWHwJ0B/X8jXLgF6GbJE3tf471KObA5vHk=;
        b=NzvOZtbR4boKOvMVeF3JPwcJHPU+XnXVU5sB3kfU2Si7BTFWwd6UngeYHxtd/jAhl6
         Xt++q75rJJEJdlIWCRp2iwZmXoX0Tkx47e+yhW0JOco0e6nDFo4zz4skQxaH9VZwZnKx
         ifvuMq+KSNivwqHAqUv1FG4VN8FSZ4yt/LDcgwba1jvx2we5wKqROWhtxYYFZJJcUyQD
         PfpI3EtwC13Ukb5B7885GxjhbHRB9MN0Rkf8mKdmbIxe69I8nupb+ITOPXOD4YUximiX
         xb8YocVNeaH/2tz9cnWzBqDMdDc3QQeHegdnBd5d0Ir5XyeZ8yZDNYLJbaSv/ggcg0Kv
         heQA==
X-Gm-Message-State: AOAM530oanjGdL7sqDEKSRRpDmlFNybb//8wdHqrrX2C2eq05Cyi2vSo
        URE5yENM+T8obP8bmPyFiw==
X-Google-Smtp-Source: ABdhPJyCcrX550X5kHn4yyhHay12s23rJTOjmXniu90yHWq2OuGi3MAmBp+k3YVN0ThvPyumKI1Tvg==
X-Received: by 2002:a05:6808:2008:b0:2da:5b12:83ff with SMTP id q8-20020a056808200800b002da5b1283ffmr4036695oiw.216.1649269081713;
        Wed, 06 Apr 2022 11:18:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a05680800c300b002f935a7daa9sm6676425oic.19.2022.04.06.11.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:18:01 -0700 (PDT)
Received: (nullmailer pid 2529145 invoked by uid 1000);
        Wed, 06 Apr 2022 18:18:00 -0000
Date:   Wed, 6 Apr 2022 13:18:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] dt-bindings: reset: uniphier-glue: Clean up clocks,
 resets, and their names using compatible string
Message-ID: <Yk3ZWK3kazy2MD1E@robh.at.kernel.org>
References: <1649145378-30358-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649145378-30358-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On Tue, 05 Apr 2022 16:56:18 +0900, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
> resets, and their names that can be taken by the compatible string.
> 
> The order of clock-names and reset-names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../reset/socionext,uniphier-glue-reset.yaml  | 52 ++++++++++++++-----
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
