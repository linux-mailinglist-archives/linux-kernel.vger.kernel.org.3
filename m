Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3829855001B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbiFQWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiFQWng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:43:36 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08943BBC8;
        Fri, 17 Jun 2022 15:43:34 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id q11so5890961iod.8;
        Fri, 17 Jun 2022 15:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zh/0Zx5VR9OkdNl9GEaMHnSoW3UuL0RxbuRlgNOyx3U=;
        b=Hgil84+ELMVRzRXMKAfqAuU6mR3YljnBX0unOibFt6Act3TAaf96ovJZ4VvLIODbE9
         Bh7/iPioI2soLxUkXk2ZAnggIYwROfH/3dMFghApTa6WIgwgHuYcJmpYKHBzjng4ma9H
         TyrlMz51vOj6g4mJq5hg5OWaAGxtmwCrQu4wzx7BnlMEngd2KjP9VQIlCsfEJqguKwRg
         opmiDyVWeKpcZGtkq1OIk7pSuYaQKqM86ugnGmwFzYvXS/7TucCu9ciQMWtqI8Pjgk8q
         o8fcmTfShYHQQxL3O+ewacUihemAiO63qGoq5OgKeRUOxp8pH6rvYYBeX8A+ZG+jX0xe
         nvjg==
X-Gm-Message-State: AJIora/9GAMo/VuBIxH/7sS2TIqk2FheBgDP1NG9tMLMYVXT87ULcP+n
        SJRHBXgrkfRjAcHolat9Pq8hi4s15w==
X-Google-Smtp-Source: AGRyM1tvyT1XZEsULmIOGU/hr9lRpu/t3yqYEU1/GhEsnQese2mFTYGyCi7NOLnTQaaRUC8jarJyVw==
X-Received: by 2002:a05:6638:d8c:b0:332:15ef:657f with SMTP id l12-20020a0566380d8c00b0033215ef657fmr6523987jaj.146.1655505814198;
        Fri, 17 Jun 2022 15:43:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i26-20020a023b5a000000b0032b3a781781sm2734205jaf.69.2022.06.17.15.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:43:33 -0700 (PDT)
Received: (nullmailer pid 2574515 invoked by uid 1000);
        Fri, 17 Jun 2022 22:43:32 -0000
Date:   Fri, 17 Jun 2022 16:43:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org, szunichen@gmail.com,
        lars@metafoo.de, matthias.bgg@gmail.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        lee.jones@linaro.org, ChiYuan Huang <cy_huang@richtek.com>,
        linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org,
        jingoohan1@gmail.com, devicetree@vger.kernel.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 06/15] dt-bindings: mfd: Add Mediatek MT6370
Message-ID: <20220617224332.GA2570673-robh@kernel.org>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-7-peterwu.pub@gmail.com>
 <1655127197.567546.3564136.nullmailer@robh.at.kernel.org>
 <CABtFH5JPu5tOg4wGJf5ay1-NJHLcPTK4XxADGTksHW1-6wjMRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtFH5JPu5tOg4wGJf5ay1-NJHLcPTK4XxADGTksHW1-6wjMRQ@mail.gmail.com>
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

On Fri, Jun 17, 2022 at 07:15:49PM +0800, ChiaEn Wu wrote:
> Hi Rob,
> 
> Rob Herring <robh@kernel.org> 於 2022年6月13日 週一 晚上9:33寫道：
> >
> > On Mon, 13 Jun 2022 19:11:37 +0800, ChiaEn Wu wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Mediatek MT6370 binding documentation.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  .../bindings/mfd/mediatek,mt6370.yaml         | 279 ++++++++++++++++++
> > >  .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |  18 ++
> > >  2 files changed, 297 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > >  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > ./Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: backlight: False schema does not allow {'compatible': ['mediatek,mt6370-backlight'], 'mediatek,bled-channel-use': b'\x0f'}
> >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: charger: False schema does not allow {'compatible': ['mediatek,mt6370-charger'], 'interrupts': [[48], [68], [6]], 'interrupt-names': ['attach_i', 'uvp_d_evt', 'mivr'], 'io-channels': [[1, 5]], 'usb-otg-vbus-regulator': {'regulator-name': ['mt6370-usb-otg-vbus'], 'regulator-min-microvolt': [[4350000]], 'regulator-max-microvolt': [[5800000]], 'regulator-min-microamp': [[500000]], 'regulator-max-microamp': [[3000000]], 'phandle': [[2]]}}
> >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: tcpc: False schema does not allow {'compatible': ['mediatek,mt6370-tcpc'], 'interrupts-extended': [[4294967295, 4, 8]], 'connector': {'compatible': ['usb-c-connector'], 'label': ['USB-C'], 'vbus-supply': [[2]], 'data-role': ['dual'], 'power-role': ['dual'], 'try-power-role': ['sink'], 'source-pdos': [[570527844]], 'sink-pdos': [[570527944]], 'op-sink-microwatt': [[10000000]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@2': {'reg': [[2]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}}}
> >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: indicator: False schema does not allow {'compatible': ['mediatek,mt6370-indicator'], '#address-cells': [[1]], '#size-cells': [[0]], 'multi-led@0': {'reg': [[0]], 'function': ['indicator'], 'color': [[9]], 'led-max-microamp': [[24000]], '#address-cells': [[1]], '#size-cells': [[0]], 'led@0': {'reg': [[0]], 'color': [[1]]}, 'led@1': {'reg': [[1]], 'color': [[2]]}, 'led@2': {'reg': [[2]], 'color': [[3]]}}, 'led@3': {'reg': [[3]], 'function': ['indicator'], 'color': [[0]], 'led-max-microamp': [[6000]]}}
> >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: flashlight: False schema does not allow {'compatible': ['mediatek,mt6370-flashlight'], '#address-cells': [[1]], '#size-cells': [[0]], 'led@0': {'reg': [[0]], 'led-sources': [[0]], 'function': ['flash'], 'color': [[0]], 'function-enumerator': [[1]], 'led-max-microamp': [[200000]], 'flash-max-microamp': [[500000]], 'flash-max-timeout-us': [[1248000]]}, 'led@1': {'reg': [[1]], 'led-sources': [[1]], 'function': ['flash'], 'color': [[0]], 'function-enumerator': [[2]], 'led-max-microamp': [[200000]], 'flash-max-microamp': [[500000]], 'flash-max-timeout-us': [[1248000]]}}
> >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: backlight: mediatek,bled-channel-use: b'\x0f' is not of type 'object', 'array', 'boolean', 'null'
> >         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
> > Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/backlight: failed to match any schema with compatible: ['mediatek,mt6370-backlight']
> > Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/charger: failed to match any schema with compatible: ['mediatek,mt6370-charger']
> > Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/indicator: failed to match any schema with compatible: ['mediatek,mt6370-indicator']
> > Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/flashlight: failed to match any schema with compatible: ['mediatek,mt6370-flashlight']
> > Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/tcpc: failed to match any schema with compatible: ['mediatek,mt6370-tcpc']
> >
> 
> Before we submitted these patches, we had already checked by running
> this command below,
> "make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml".
> But we could not find any errors like your error msg after the checking process.
> 
> Our mfd dt-binding patch is dependent on "backlight dt-binding",
> "charger dt-binding", "tcpc dt-binding", "indicator dt-binding" and
> "flashlight dt-binding" patches.
> Would you please apply them before you check mfd dt-binding patch?

That is what is done. Not sure what happened here though.

Rob
