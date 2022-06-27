Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD255DCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiF0Nbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiF0Nba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:31:30 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0164E4;
        Mon, 27 Jun 2022 06:31:24 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id h85so9547976iof.4;
        Mon, 27 Jun 2022 06:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YBApyAZhryutkj1N0CgYhNXY1+WXUhBmjXDtALNVzOI=;
        b=hCMvud/6mKxaJaYNG9R4UASuCTNtbY1pl/kUT8ZykgYNwOOgqh4ItVXsGpNB1hsKa6
         sE3i8w4bmWA4hNWpsNofNyJuNoucj/z4MTCvevOyRytpI33SQfLrYBpGrN74Yg9nBsh4
         Ot8qWBumWj8rdkfGCuA9NR9u5YqQZQmhhGAHdPoDvDpfaqzZRtYwFincFUbtBP9thpFA
         REuGgRmQbvSkkwziQ1ayCKBzmpRb4OUhhfzblhhUxgl7mtaArhSFRgZiv5Nn19EuXtGG
         ntILoFrPLAPfd5T2AW08M43fQz9g1m26Qz/biNonPF5oSeugMECaRoA2A0OB+GBXI04L
         y5sA==
X-Gm-Message-State: AJIora8hbRmjW31LblXkop6IR8KEInYQfQM0Fz31Hq/tBzF6QFT62xKU
        ylherlwi5vim/SynW2ex3Efrzestpg==
X-Google-Smtp-Source: AGRyM1smbEVZ88IdJlCAbanipzttn6crpX6AL3iQCbRbOLHyD61OgJYhYskFjkrchfE0bQdfdtAKcg==
X-Received: by 2002:a5d:9ac4:0:b0:674:fca5:62db with SMTP id x4-20020a5d9ac4000000b00674fca562dbmr6517964ion.177.1656336683456;
        Mon, 27 Jun 2022 06:31:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d18-20020a056602185200b00669e1a9588esm5299273ioi.43.2022.06.27.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:31:23 -0700 (PDT)
Received: (nullmailer pid 2285166 invoked by uid 1000);
        Mon, 27 Jun 2022 13:31:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        quentin.schulz@theobroma-systems.com, linuxfancy@googlegroups.com
In-Reply-To: <20220624230307.3066530-8-tommaso.merciai@amarulasolutions.com>
References: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com> <20220624230307.3066530-8-tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH 7/7] media: dt-bindings: ov5693: document YAML binding
Date:   Mon, 27 Jun 2022 07:31:09 -0600
Message-Id: <1656336669.640985.2285165.nullmailer@robh.at.kernel.org>
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

On Sat, 25 Jun 2022 01:03:07 +0200, Tommaso Merciai wrote:
> This patch adds documentation of device tree in YAML schema for the
> OV5693 CMOS image sensor from Omnivision
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  .../bindings/media/i2c/ovti,ov5693.yaml       | 123 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml:123:7: [error] no new line character at the end of file (new-line-at-end-of-file)

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

