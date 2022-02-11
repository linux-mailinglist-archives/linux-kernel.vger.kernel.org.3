Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C924B2566
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349913AbiBKMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:13:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349885AbiBKMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:13:04 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C6CDA8;
        Fri, 11 Feb 2022 04:13:03 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id 4so9266087oil.11;
        Fri, 11 Feb 2022 04:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cuBlIjJY4vaAWQT/4C6Ak9m1WRcqNbkYIsxGyvkT4rk=;
        b=nQLpFNMd20cVCONufynpoBNgFjHFbPa3JPV77p1MS1bGGvppbYH43z4mjIIQ18m0VE
         WzM+TkWySY7zj5X3aT3TBIt9DrM40CefCI+rlW/VNwrYFXXtSOCJ0tyCdX4ENLWlfWCs
         uT/vp6SfhI67SSJgfkKZWKz9Twgp3WyAoJCcfmQ3yCzW1wx7cjyFJQk2vU+VnGhNGALy
         kF0KYK5NBN9J92QkslaWX0Kj+QT5cXcwZNwnBhU4MuTX42eLsAkpjBxroPXoaADT3SNb
         zxHoXVjzUg+T9r0/CANGsBsH+Jx+vrAxWIaIrhuAMSP4nA78X/1Qp7CHQus3/fdNXnWU
         KBMw==
X-Gm-Message-State: AOAM531/pt1H0zmcbIst6pe2sg4J5Slw6gkYGFJV6D/i0ktssalJWL90
        KPwaRMJS5BjLgIZ5Yroegw==
X-Google-Smtp-Source: ABdhPJwC68NbqlKCoT6iGNdOcPryVMllb8uhD4nbb/rVM94vLoxVJPFWGXcXeY9hjrenDtePrHtmxQ==
X-Received: by 2002:a05:6808:2026:: with SMTP id q38mr16779oiw.243.1644581582414;
        Fri, 11 Feb 2022 04:13:02 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d4:10b7:69a2:33cd:1782:fb47])
        by smtp.gmail.com with ESMTPSA id bx41sm6384628oib.7.2022.02.11.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:13:01 -0800 (PST)
Received: (nullmailer pid 141879 invoked by uid 1000);
        Fri, 11 Feb 2022 12:12:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, trevor.wu@mediatek.com, tzungbi@google.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-mediatek@lists.infradead.org, geert+renesas@glider.be,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        zhangqilong3@huawei.com, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20220211103818.8266-12-jiaxin.yu@mediatek.com>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com> <20220211103818.8266-12-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH 11/15] dt-bindings: mediatek: mt8186: add audio afe document
Date:   Fri, 11 Feb 2022 06:12:43 -0600
Message-Id: <1644581563.497957.141878.nullmailer@robh.at.kernel.org>
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

On Fri, 11 Feb 2022 18:38:14 +0800, Jiaxin Yu wrote:
> This patch adds mt8186 audio afe document.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml:14:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1591561

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

