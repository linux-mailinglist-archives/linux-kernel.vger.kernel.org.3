Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4258AC36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiHEOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiHEOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:14:59 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9545BCB5;
        Fri,  5 Aug 2022 07:14:57 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id s16so1437878ilp.3;
        Fri, 05 Aug 2022 07:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=PZrXXwpv3RypAblX5dbeiPo4VhGMvArVNf64YsF8K9M=;
        b=bbrMT70L20sP4cabSpScYpWirr5rdjoiUS7lM5MHW1yTMQknYXM2j7vpOzUvlP3MLX
         51PADw5mFliJZ1wRebBUgHcyJcD6GLQ2aE9zbB+7hjMd+vjgnxKaYUIZ84GZDwkAnzDv
         1aB7cDavNbj43SS51CbijgTeoBQEW9t4GNBJKLVnAPTyLgv/3va4TDWkixJR//egvvUw
         jBD/u7hM0UUjkYMoTt0evMONtXr3o6C76CJX4gN8HbOX/tgfHiV9tW1BMENwPbjqiQy6
         7zDR51tJXz1WTzx5Lg2SJCx36Dlh8+JzmjLacNvquO4N6SB2z6J5ma6efda3muxCXKzJ
         Oe4g==
X-Gm-Message-State: ACgBeo20l090Q1ayNTX0TlL7z44+sQ7Yth9snjubOxsJQd6pVoILPI2E
        eOChqa0u+Fg/UC9fWsOSH5gcRDQmGQ==
X-Google-Smtp-Source: AA6agR5TBL1zLeYtjOa/JeC5Bb1Q+UYEKyfEVWmzvt4wbEL63iXTjg3GdiFeHr8ndHckFS+HzOee2Q==
X-Received: by 2002:a05:6e02:1a87:b0:2de:8da2:9ecf with SMTP id k7-20020a056e021a8700b002de8da29ecfmr3115674ilv.263.1659708897053;
        Fri, 05 Aug 2022 07:14:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b6-20020a029586000000b00342872f5699sm1727811jai.64.2022.08.05.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:14:56 -0700 (PDT)
Received: (nullmailer pid 1809600 invoked by uid 1000);
        Fri, 05 Aug 2022 14:14:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org,
        Valentina.FernandezAlanis@microchip.com, conor.dooley@microchip.com
In-Reply-To: <20220805053019.996484-3-nagasuresh.relli@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com> <20220805053019.996484-3-nagasuresh.relli@microchip.com>
Subject: Re: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
Date:   Fri, 05 Aug 2022 08:14:55 -0600
Message-Id: <1659708895.330978.1809599.nullmailer@robh.at.kernel.org>
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

On Fri, 05 Aug 2022 11:00:17 +0530, Naga Sureshkumar Relli wrote:
> Microchip's PolarFire SoC QSPI IP core is based on coreQSPI,
> so add coreqspi as a fallback to mpfs-qspi.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> ---
>  .../devicetree/bindings/spi/microchip,mpfs-spi.yaml    | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml:21:4: [warning] wrong indentation: expected 4 but found 3 (indentation)
./Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml:22:5: [warning] wrong indentation: expected 5 but found 4 (indentation)

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

