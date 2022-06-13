Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC330547DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbiFMCuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiFMCus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:50:48 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684236E1B;
        Sun, 12 Jun 2022 19:50:47 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id s23so4771361iog.13;
        Sun, 12 Jun 2022 19:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rmYoTFjwwfLHaEAKyMwepQVd6Fyyjo475AJRyY0r/yQ=;
        b=YUSsW6W19zhbhRvuS0DwdHWUQOZiglEd1pOjHXaqb3nOWVzd88lu1muS2jSg0J8mDm
         ENa0esP3n+JpDJsqui+secRM3CZmi10jCXhTHdZwUzoCm2tTNwjs8/FscivzMk52tDxi
         LaD7TmzMUI+IbnvKg7PqfkE5bhXVo4AJ1ykGgbaanu7d1er8OneJVbvvT+oCZYkz0qqh
         n+kjk22MrrUfVohWHRG0OAlAkt6lhcB9L1ybCYyGLon3T7Xv9bI+YDvLN0XJAWiQjVcp
         O5fAk9WNSVUnp+AtSZ5sbrE5575dl277/fI+Z3hmCp6hzM/A9fUBccjHMO7T52WxZhxL
         zW7Q==
X-Gm-Message-State: AOAM533JWv68DRmbk1wmc3WCO6AsG5nc8qzNmknSxIdFpp36klRN++4j
        08Rc/jx0gMJ1F8bT+01WEQ==
X-Google-Smtp-Source: ABdhPJxyFckgQT337XDCiRAwgwtx3vUFkJL/tbw8qlrIqOoTtJpo2NVfXZ2udavPLZEGvQXL+u+/Tg==
X-Received: by 2002:a05:6638:dc5:b0:332:3180:fd5e with SMTP id m5-20020a0566380dc500b003323180fd5emr5261454jaj.285.1655088645082;
        Sun, 12 Jun 2022 19:50:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w4-20020a056e021c8400b002d10dc367a1sm3261489ill.49.2022.06.12.19.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 19:50:44 -0700 (PDT)
Received: (nullmailer pid 2612895 invoked by uid 1000);
        Mon, 13 Jun 2022 02:50:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20220612135414.3003-2-johnson.wang@mediatek.com>
References: <20220612135414.3003-1-johnson.wang@mediatek.com> <20220612135414.3003-2-johnson.wang@mediatek.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency hopping
Date:   Sun, 12 Jun 2022 20:50:42 -0600
Message-Id: <1655088642.973172.2612894.nullmailer@robh.at.kernel.org>
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

On Sun, 12 Jun 2022 21:54:13 +0800, Johnson Wang wrote:
> This patch adds the new binding documentation for frequency hopping
> and spread spectrum clocking control on MT8186.
> 
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,fhctl.yaml | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml:44:111: [warning] line too long (133 > 110 characters) (line-length)

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

