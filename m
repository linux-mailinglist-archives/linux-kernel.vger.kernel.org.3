Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC7519158
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiECWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbiECWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:25:29 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3640A26;
        Tue,  3 May 2022 15:21:55 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id m25so5735699oih.2;
        Tue, 03 May 2022 15:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AYzqDCKsTIUNQSFUA88IsjM5tVXZRYkNm2IzoI0SdEc=;
        b=IucN/UOZSpOm2ygS0mq5PjnbWocrETUqkgf7AAsw0VrRt6Odo0mH5NOTe7EX44mo5G
         uImRt1r6/t2L/bvc+XV/2vxKhvgXsrDju30r+RQKUMzKCUAVfx7K+3r3tko619HJunQw
         7jhebPK1WsZkdno3UJOZhcOYeoVouukv8D1D49YzNUeDvUlHapnYCusFlTDUEPQv/aZg
         WE2+UQB8qXICVyWakr3DVff6N2rC2pZ0vc/5VyvPUdRoEL5fEhRZYsMJpxAgbClhwmpJ
         itT44f/ZkqT7KgQWWpEghxS1it9OdRJTfR5xZowpYjcK9sOq3FyLeWIuCMRkpTUDZgto
         6Zgw==
X-Gm-Message-State: AOAM532A+h6NVcP/yYoJrIJoDzZUhHH9H25TWFPvw+jr7+6APwBbt/S9
        QVcyh1lHPnefYjaTEdkFBA==
X-Google-Smtp-Source: ABdhPJzn/rfeIWO5DHbfNPeuF8m9ikdAA2XqhXdqzdxa0Z5LXZ/l9fkqrmw7YUHe4HECh0PvVs466Q==
X-Received: by 2002:a05:6808:d4c:b0:322:e7de:fffe with SMTP id w12-20020a0568080d4c00b00322e7defffemr2726225oik.107.1651616515316;
        Tue, 03 May 2022 15:21:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a9d64c7000000b006060322125csm4564785otl.44.2022.05.03.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:21:54 -0700 (PDT)
Received: (nullmailer pid 139788 invoked by uid 1000);
        Tue, 03 May 2022 22:21:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sean.wang@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        nfraprado@collabora.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20220503142537.152499-2-angelogioacchino.delregno@collabora.com>
References: <20220503142537.152499-1-angelogioacchino.delregno@collabora.com> <20220503142537.152499-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings
Date:   Tue, 03 May 2022 17:21:51 -0500
Message-Id: <1651616511.157901.139787.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2022 16:25:36 +0200, AngeloGioacchino Del Regno wrote:
> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 224 +++++
>  include/dt-bindings/pinctrl/mt6795-pinfunc.h  | 908 ++++++++++++++++++
>  2 files changed, 1132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/pinctrl/mediatek,pinctrl-mt6795.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

