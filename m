Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00655A009
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiFXR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFXR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:40 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26892BE6;
        Fri, 24 Jun 2022 10:26:39 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id s17so3378785iob.7;
        Fri, 24 Jun 2022 10:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=92QKbH/mPXhxHIYJf1fLlrKB6WxLUvpdcDo1o4OtEnM=;
        b=nkLqdtay6VGjJqffHvqtqksKSKVkBilY1c1m5KAlQMy8AJo7DT/wTGSiN7+Hvhm6OZ
         5NK5dApuZdhWE7sD7gmiuW8mnZNgcBVUWr08Y2QT5VUkWgLZWrdwwqNJFe3KLCMcVDiy
         OQkBVynzJVclFSBAvtlpFjkdTFkU7nBi+RExRN7qf2SF4KNAnAp6m35rcdlw3XWHjg0O
         jyaGn8aX9MWabkgmH4krflJGpABcTYGkLvT9Ff1Cn7vmFykm0oh3DpTKayQDOu7LFBY1
         KBdZbUaiR+/9Mg6TXWzJbqbh+o2F5a/G524sZ1RjL+AJcIYtJGIsyIPiLUmvaUnoWf/K
         cWTA==
X-Gm-Message-State: AJIora/T87xyD3LzBX1ATxDZL4VjYTWfmf/6ffZkthaxIq5ZiERfn/8E
        aw/Pd2wwO9Z6XxwV5t2hItwyaxa/og==
X-Google-Smtp-Source: AGRyM1s8SzrwSpGacP/r2ARwl+tUdS8WymnOz9QJv44qHprtsvHiQ9e/7OSdNfiAyfKqtnqiAMvqmw==
X-Received: by 2002:a02:90ce:0:b0:32e:e2ce:b17c with SMTP id c14-20020a0290ce000000b0032ee2ceb17cmr153954jag.268.1656091599142;
        Fri, 24 Jun 2022 10:26:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u10-20020a92da8a000000b002d925059ba6sm1354817iln.87.2022.06.24.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:38 -0700 (PDT)
Received: (nullmailer pid 146342 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        wenst@chromium.org, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, matthias.bgg@gmail.com,
        sboyd@kernel.org, konrad.dybcio@somainline.org,
        linux-clk@vger.kernel.org, fparent@baylibre.com,
        phone-devel@vger.kernel.org, robh+dt@kernel.org,
        y.oudjana@protonmail.com, rex-bc.chen@mediatek.com,
        martin.botka@somainline.org, marijn.suijten@somainline.org,
        sam.shih@mediatek.com, kernel@collabora.com,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        ikjn@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        weiyi.lu@mediatek.com, miles.chen@mediatek.com, ck.hu@mediatek.com,
        linux-mediatek@lists.infradead.org, jason-jh.lin@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht, bgolaszewski@baylibre.com,
        paul.bouchara@somainline.org, devicetree@vger.kernel.org
In-Reply-To: <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com> <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.386709.146341.nullmailer@robh.at.kernel.org>
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

On Fri, 24 Jun 2022 11:35:22 +0200, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 74 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.example.dtb: power-controller@10001000: '#power-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/power-domain.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.example.dtb: power-controller@10003000: '#power-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/power-domain.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

