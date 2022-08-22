Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6059C91E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiHVTks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiHVTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:40:46 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CE48CAD;
        Mon, 22 Aug 2022 12:40:45 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 53-20020a9d0838000000b006371d896343so8387716oty.10;
        Mon, 22 Aug 2022 12:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ZD+9Y+YHgSc74uZmGcIl7GpjcDtMGqKPBLpD0+ZP414=;
        b=Iu6N2u/4t3NtBQcNWiFNa9FQpvqhE0Am4wWqtLhAsA8NEbp8oSztuiQD+qZd2TPZES
         4MRJ3YlC7VbFS5n9fwNv4iCWyljXMZQEewuDOMZsYowIVlAxXIT6u/fPMDhqnlxhQVKr
         xhPxCFaJVfja4K+qbJobF+u9s8m5L5JiTVHZKdDl7M1lG9pUxlm5h/uksPdu3c7VY+LW
         jBLYlSWnGK3zbnwCjE+LK2/wpzybgl78l9kFyj0bPLoLCENoQ8rbSZ+lRvzWuVnoKh0R
         573AzjDJEJ+ZIWpGALIN2UkaRd9RSS9i9s8IvfOzqMy0QuUhpimPrvYnHvOmNlV3piWD
         PMEg==
X-Gm-Message-State: ACgBeo3UW5gEI/SSgrNgE4nkS/3SdweMyTrX3CylKKJ0GvUNwmqvyrJC
        cb6LnzXuxGDBdXgmy3Iqgw==
X-Google-Smtp-Source: AA6agR5d+cG/pMsqLg7MLuteBtnn/svk7s7yyhuSdlYHrm/7zVl0NJnmkHkqF1iNOCpu0ncOlHcOOQ==
X-Received: by 2002:a05:6830:6505:b0:638:94e4:f0c9 with SMTP id cm5-20020a056830650500b0063894e4f0c9mr8355925otb.270.1661197244562;
        Mon, 22 Aug 2022 12:40:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s63-20020aca4542000000b00342df642fd3sm2735031oia.48.2022.08.22.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:40:43 -0700 (PDT)
Received: (nullmailer pid 413610 invoked by uid 1000);
        Mon, 22 Aug 2022 19:40:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-clk@vger.kernel.org,
        Daire McNamara <daire.mcnamara@microchip.com>
In-Reply-To: <20220822112928.2727437-3-conor.dooley@microchip.com>
References: <20220822112928.2727437-1-conor.dooley@microchip.com> <20220822112928.2727437-3-conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: clk: document PolarFire SoC fabric clocks
Date:   Mon, 22 Aug 2022 14:40:42 -0500
Message-Id: <1661197242.557172.413609.nullmailer@robh.at.kernel.org>
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

On Mon, 22 Aug 2022 12:29:25 +0100, Conor Dooley wrote:
> On PolarFire SoC there are 4 PLL/DLL blocks, located in each of the
> ordinal corners of the chip, which our documentation refers to as
> "Clock Conditioning Circuitry". PolarFire SoC is an FPGA, these are
> highly configurable & many of the input clocks are optional.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/clock/microchip,mpfs-ccc.yaml    | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.example.dtb: clock-controller@38100000: 'clock-output-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

