Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24753EE93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiFFT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiFFT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:26:14 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC950E06;
        Mon,  6 Jun 2022 12:26:13 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id q76so8049429iod.8;
        Mon, 06 Jun 2022 12:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nUwoRK1Vj+8sy8SVxzKcJRhrQsEifyPzc9VgrjwL4ek=;
        b=P9i2uORFKd98uj0kmeYA6bmbDp7v+AWf2OiRgYhdlBr2l/I7o0Whwis21r4BcSLnpl
         xrJCK4Z/1GXUjKqfM+4v3YAF4LWtDb5RVOKMRXK9PARWrfCH4bAJTx4Q14Wi5U+SKYFI
         0N8GQb8zt7QI50QDOiZ6grsGaSM++APAjjIemOoS5NgKPOffALJ70Qq6l1VtJTY8tYSb
         5Yy6pmMgUJbUUIBbhl88ukxABPOn0K9f8mNHmPYYaDn1NKl13bGUFSilJGxVwNSka1HD
         8on2LJkIYV/wVEh9/qadj/bk0jqvpdqKGODJMmNURRCYeI/4bAddsrBFShzGpLPHra6H
         9vdg==
X-Gm-Message-State: AOAM530iVxuK1FHQTpkdRPCqMR7nIzkXwP7lWfiV7I0NzOf6B1JlYJFg
        Iv4ProQq6G8+1kOWH0pGxw==
X-Google-Smtp-Source: ABdhPJwhKTtphn6QN1OHiDFAVtAMaOl9ZTMicC/Fve+VnI1gdtbJ/yYlFWee0L6fHMGLVQMiwrx82A==
X-Received: by 2002:a02:ba82:0:b0:331:5aaf:e4b0 with SMTP id g2-20020a02ba82000000b003315aafe4b0mr13869104jao.196.1654543572788;
        Mon, 06 Jun 2022 12:26:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m12-20020a6b7c0c000000b006694b2de3bbsm1874997iok.11.2022.06.06.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:26:12 -0700 (PDT)
Received: (nullmailer pid 1117627 invoked by uid 1000);
        Mon, 06 Jun 2022 19:26:10 -0000
Date:   Mon, 6 Jun 2022 14:26:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        Ken Chen <chen.kenyy@inventec.com>,
        linux-kernel@vger.kernel.org,
        Steven Lee <steven_lee@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org,
        David Wang <David_Wang6097@jabil.com>,
        devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/7] dt-bindings: arm: aspeed: add Aspeed Evaluation
 boards
Message-ID: <20220606192610.GA1117514-robh@kernel.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529104928.79636-3-krzysztof.kozlowski@linaro.org>
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

On Sun, 29 May 2022 12:49:24 +0200, Krzysztof Kozlowski wrote:
> Document the new compatibles used on Aspeed Evaluation boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
