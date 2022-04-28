Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB0513372
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbiD1MVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346096AbiD1MVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:21:18 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D4DADD4D;
        Thu, 28 Apr 2022 05:18:01 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q8so4695440oif.13;
        Thu, 28 Apr 2022 05:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AvrAp2pIkyvrhsFnFXmihXOHIOjqivUkysQhFCJ6/TY=;
        b=HFws/N7rTnVN4Ug24Nwuj4DFOQ40qsQi2UXyfV6hw+K93O3HgAtcFutZw0Z0SPSNA/
         ti7Qy4zJyTMKcW9sYGG1zOjDBhUPFLvV5DrRryC3otbYgar9YLWTcBRXTyD9IqYmMaLu
         c/CW93Nhegj/27PMPR/L7omRZ88lccteUUe2XvbzOcpboRJNfbU4dSJUMtIGmaqr0K4W
         n+uEYK9bJWGRgzVZXYusXNnOpRrenckDqPQ+TaC3XuXxl7cDMbY0hL8/7pMnrxU+qTKU
         tBTJNhrwJMy6OXy/gHZbZJhwrcS50Vgk9b5fku0yrhLc5d9o7qZNHjwPgn8vM0ihFSf5
         DRUQ==
X-Gm-Message-State: AOAM532glLF6J9kKaGSW49Do3KH5vLJKKi3KtYCEB48MjSBvmNazKCAC
        zn8YIoN0vV+7A3zk9zX6vw==
X-Google-Smtp-Source: ABdhPJz5RdYfwKUkJdq1T6ujFTPXJ1ox1QGJz4/fi/sFX1cbTyqNh8f7bmsrs3RFEOL8ECJg0cOobg==
X-Received: by 2002:a05:6808:10d4:b0:325:20c3:557f with SMTP id s20-20020a05680810d400b0032520c3557fmr10474972ois.39.1651148280653;
        Thu, 28 Apr 2022 05:18:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y18-20020a056870381200b000d6c86ea98dsm1778714oal.1.2022.04.28.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 05:18:00 -0700 (PDT)
Received: (nullmailer pid 1999484 invoked by uid 1000);
        Thu, 28 Apr 2022 12:17:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     tzungbi@google.com, linux-mediatek@lists.infradead.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, julianbraha@gmail.com,
        trevor.wu@mediatek.com, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        aaronyu@google.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com
In-Reply-To: <20220428093355.16172-19-jiaxin.yu@mediatek.com>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com> <20220428093355.16172-19-jiaxin.yu@mediatek.com>
Subject: Re: [v4 18/18] dt-bindings: mediatek: mt8186: add mt8186-mt6366-rt1019-rt5682s document
Date:   Thu, 28 Apr 2022 07:17:57 -0500
Message-Id: <1651148277.911772.1999483.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:33:55 +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, rt1019 and rt5682s.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml:30:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml:40:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

