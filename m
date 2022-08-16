Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1559613B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiHPRed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiHPReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:34:25 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8946526A;
        Tue, 16 Aug 2022 10:34:22 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r141so5236772iod.4;
        Tue, 16 Aug 2022 10:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vNdSUDIuCoXELlH9XMziCohsKXYqhqiaV6prSiBstnQ=;
        b=WZoxFtnjGTM51Hx+rVwuPw8J5zlalrb3ISDBoEp8aGycoPaQ/j4QqMOZBgkOnhXeGh
         OoJYzw06DSmYduHiRp1BEwd9oyzrkyHLbI20aZvIMPLEtjsW1aAA+ffmE8ZZXbSNLvgO
         bPaGPXCKIhOGUEFZGkXkicKFFoby+dw1dvJjdiksSrPJvMyvC9jRd9NWjZIV+7gz2r2U
         CN2JskeR+TNF0NYx5PgxIqEPlCczoU05VygiOGIxw4vW/Nc9+7ir1TU67pY6yNmeVUU/
         bw0ZiZIXHO4ZIpechpO6taRy7nbS9l/BLwJJjotYT9glh8cfof0Mv1ibYGbFTKfmq33c
         JdnQ==
X-Gm-Message-State: ACgBeo1YqWi3+fXqewy3IPipx9AMGc9bG6O6tWOWOlao53uYizHAXN97
        hv1S1Koqk3emfootehoXOw==
X-Google-Smtp-Source: AA6agR5x+GlJ3IuesfolxVkxENyVw8nMHypHsYHjBlt7Y2d8nb8vjeQSOsB8rWSXq8mciC32FhkGrg==
X-Received: by 2002:a05:6638:16d3:b0:346:a4c6:fcc6 with SMTP id g19-20020a05663816d300b00346a4c6fcc6mr2674535jat.147.1660671261318;
        Tue, 16 Aug 2022 10:34:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b22-20020a026f56000000b003436da41c78sm4600918jae.76.2022.08.16.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:34:20 -0700 (PDT)
Received: (nullmailer pid 2424921 invoked by uid 1000);
        Tue, 16 Aug 2022 17:34:19 -0000
Date:   Tue, 16 Aug 2022 11:34:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/12] dt-bindings: vendor-prefixes: Add Allwinner D1
 board vendors
Message-ID: <20220816173419.GA2424864-robh@kernel.org>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815050815.22340-4-samuel@sholland.org>
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

On Mon, 15 Aug 2022 00:08:06 -0500, Samuel Holland wrote:
> Some boards using the Allwinner D1 SoC are made by vendors not
> previously documented.
> 
> Clockwork Tech LLC (https://www.clockworkpi.com/) manufactures the
> ClockworkPi and DevTerm boards.
> 
> Beijing Widora Technology Co., Ltd. (https://mangopi.cc/) manufactures
> the MangoPi family of boards.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
