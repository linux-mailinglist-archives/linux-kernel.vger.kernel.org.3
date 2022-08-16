Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92959613F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiHPRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiHPRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:35:42 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC91A39C;
        Tue, 16 Aug 2022 10:35:42 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id p9so5696924ilq.13;
        Tue, 16 Aug 2022 10:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RnoAucd176W+o4ETJ7P9jHc6+1EKnkGk1HGPAZBXuwk=;
        b=ZHaQEqgO9DepXVKnCTsUcSZxOaRRTs8J7FTPUtsxK2Tb2xr0fZNzC7crv6EHpNHXtL
         dIRMqhFwnKIQ37Ml9z96C4yT8a0DLlxedsl490s26oUQDPLajx15QIY567J4TMQWP1xy
         MWAEEz5k9f3UEoBGS1hNT8z1XGBSy2eLopM49iR0MUJ2jh4upLw4/V4fA8wR4fiWW3Tj
         /7MPR2JIpt0aM3BgTbDM3dQoB+5B9ysdzWoTLV8SutTIwtZlOchBlBekZ1s3d1p8SnIV
         peWwu6GMJ2qJzGBT1eLP2xgQDaa7CYtthqYMz2BsNFFyQv1jeXkmB124sZUd6aC53SnP
         W96w==
X-Gm-Message-State: ACgBeo2dyFsJi5amRMotGQOehE0clMEr6I6zMvmaLczaE/881rJe9OTZ
        +XGxamaUttFBgnyR7heEhA==
X-Google-Smtp-Source: AA6agR6SitkaJDU9fxs/PoyypEjRtrIRm+X9J1OjRamGhN+UfpSsRZky+nrmJnLwNAwcNtebknW+QA==
X-Received: by 2002:a92:cda3:0:b0:2e3:e214:5fa5 with SMTP id g3-20020a92cda3000000b002e3e2145fa5mr9293291ild.306.1660671341354;
        Tue, 16 Aug 2022 10:35:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f28-20020a056602071c00b00688b5bd70dcsm1081734iox.8.2022.08.16.10.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:35:40 -0700 (PDT)
Received: (nullmailer pid 2427019 invoked by uid 1000);
        Tue, 16 Aug 2022 17:35:39 -0000
Date:   Tue, 16 Aug 2022 11:35:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 04/12] dt-bindings: riscv: Add Allwinner D1 board
 compatibles
Message-ID: <20220816173539.GA2426958-robh@kernel.org>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815050815.22340-5-samuel@sholland.org>
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

On Mon, 15 Aug 2022 00:08:07 -0500, Samuel Holland wrote:
> Several SoMs and boards are available that feature the Allwinner D1 SoC.
> Document their compatible strings.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/riscv/sunxi.yaml      | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
