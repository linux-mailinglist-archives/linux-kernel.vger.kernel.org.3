Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD752A1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbiEQMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbiEQMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:41:05 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94D15A3E;
        Tue, 17 May 2022 05:41:04 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-edf9ddb312so23978532fac.8;
        Tue, 17 May 2022 05:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dmRe+wb3qB33LoKWee22zj7uRY4UjJW/ZlvarK0xJ4I=;
        b=McgQOwCtPchEgymXSFKwAV+buRxA7hrizEVgq99sHU0MUzjZfvPrbVhsSkPOkFuGqn
         WDKVmIIR5a03YtJkbasWg43FGPjQVn8iN+E5oy1UYqBhwc8p4cV2d8Xz4b9kOsx/0vLh
         8+BCGzaCEuDA/Gdlu8uzgGosbGUfUeLzcIiqO02UhIbFhzWUl8ZFMvIPKU1cjDiyK0PI
         LE0+74KgApMILpa3X/wVja7idNtxfrssmp46fMTNi65vL5kYxmqQ8yiFDfCC6L5FFB6l
         /amjU48L0wwBZjrcpunRbOvGXa2L+uzMAh7QsjA5hjVBsCCBPW/bYbLtlg/zHcGOkixS
         v5Hw==
X-Gm-Message-State: AOAM531beHJUgsZloqMx2zyvprNiVGragzsq1lndQSfx6EqHqeU3Crc9
        BzdGh342PztJhA89LLYjaFE0McLWQQ==
X-Google-Smtp-Source: ABdhPJwnnXeDtNIrD9oMGMg+yVK7oZSnR6U4Y5GhHjmScQw8t3Gp/MJckdluI0FDFeWymxO+NodkOw==
X-Received: by 2002:a05:6870:b61d:b0:f1:9674:f095 with SMTP id cm29-20020a056870b61d00b000f19674f095mr5886409oab.187.1652791263511;
        Tue, 17 May 2022 05:41:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d6-20020a056870d28600b000f1ca01a7besm265451oae.24.2022.05.17.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:41:02 -0700 (PDT)
Received: (nullmailer pid 785396 invoked by uid 1000);
        Tue, 17 May 2022 12:40:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     daniel.lezcano@linaro.org, clin@suse.com,
        linux-kernel@vger.kernel.org,
        giulio.benetti@benettiengineering.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        cniedermaier@dh-electronics.com, dev@lynxeye.de,
        mturquette@baylibre.com, arnd@arndb.de, s.hauer@pengutronix.de,
        Mr.Bossman075@gmail.com, festevam@gmail.com, olof@lixom.net,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        marcel.ziswiler@toradex.com, aisheng.dong@nxp.com,
        tglx@linutronix.de, kernel@pengutronix.de, linux@armlinux.org.uk,
        stefan@agner.ch, abel.vesa@nxp.com,
        sebastian.reichel@collabora.com, soc@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, sboyd@kernel.org,
        linux-gpio@vger.kernel.org, tharvey@gateworks.com
In-Reply-To: <20220517032802.451743-6-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com> <20220517032802.451743-6-Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v3 07/15] dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
Date:   Tue, 17 May 2022 07:40:59 -0500
Message-Id: <1652791259.484121.785395.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 23:27:54 -0400, Jesse Taube wrote:
> Add DT binding documentation for i.MXRT1170 clock driver.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Change title to Clock Controller
>  - Rename to add fsl
> V2 -> V3:
>  - Remove unused include causing error
> ---
>  .../bindings/clock/fsl,imxrt1170-clock.yaml   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/fsl,imxrt1170-clock.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

