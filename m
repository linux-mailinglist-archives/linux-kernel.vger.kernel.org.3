Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5B5B0E41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIGUjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIGUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:39:41 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E51ADA2;
        Wed,  7 Sep 2022 13:39:40 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278624b7c4so20745046fac.5;
        Wed, 07 Sep 2022 13:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=heUVe4bRCu44NED+njQs5QT2thfyuCxnA5VKZmd6Yd4=;
        b=hJ2nr4VAJrCJ19H23QYvOFAL6sLdyee9G+mP7/iF/JItBiv4WH1kSLiTi8Kpr1HZ0T
         rMhsofOXkbp9FhXRbtM/KxzQWrshJgLV8o/yAwn8pGib6cE60LqlvDy0yRxS9iAcHz8I
         oiUfGQf2Rf67oAmx8e/0zaTMQvYXmd1PMhn+v6Nt5EzYJzfB8ljazPq/R71hNCpFWeMA
         pmFNIejo2znTvaB7tR6thXxXal28S05TDBBiLEIJo4qhatqRMe05AbbAAt5tqcFVYzEu
         VWXK0CqOsCGnbaw/uHebvZHIZG3B/0n+UXoTu3wWR+X5r+HTJ5pdIgnZBL/EDtKIWhdX
         qwfA==
X-Gm-Message-State: ACgBeo3uiWRm1S2NeeFhu59WZPdROm/zHg62Oe31isb1JT9uqM251NdI
        11we3DAsZciYLPbCJqO4WA==
X-Google-Smtp-Source: AA6agR65JGHlKOOKvfsF5K1NUKfwTdscAu+V0quceiqJzTkZS+AyhWeUnObuubMlBFy9P0bLVCYI9g==
X-Received: by 2002:a05:6870:f69d:b0:10d:81ea:3540 with SMTP id el29-20020a056870f69d00b0010d81ea3540mr129518oab.257.1662583179316;
        Wed, 07 Sep 2022 13:39:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w9-20020a056830280900b00638a1c49383sm7416310otu.78.2022.09.07.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:39:39 -0700 (PDT)
Received: (nullmailer pid 301426 invoked by uid 1000);
        Wed, 07 Sep 2022 20:39:38 -0000
Date:   Wed, 7 Sep 2022 15:39:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Lewis Hanly <lewis.hanly@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        devicetree@vger.kernel.org, Cyril Jean <Cyril.Jean@microchip.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Message-ID: <20220907203938.GA301364-robh@kernel.org>
References: <20220901133403.3392291-1-conor.dooley@microchip.com>
 <20220901133403.3392291-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133403.3392291-3-conor.dooley@microchip.com>
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

On Thu, 01 Sep 2022 14:33:57 +0100, Conor Dooley wrote:
> Add a compatible for the Aries Embedded M100PFSEVP SOM + EVK platform.
> 
> Link: https://www.aries-embedded.com/polarfire-soc-fpga-microsemi-m100pfs-som-mpfs025t-pcie-serdes
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
