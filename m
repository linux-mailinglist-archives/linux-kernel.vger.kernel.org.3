Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408C5739BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiGMPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiGMPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:07:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B34C62D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:06:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i204-20020a1c3bd5000000b003a2fa488efdso1049488wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S870gAIGJJG5wbnKkLGfuHM1oPY3XJ0b8gnuuYnNBhk=;
        b=HSaBi7kNblhwXwZ5+3BBnlTAa+0J+16JMVqfF+/WUAwzL/ajz/czXYl5lheiAmF8MV
         l7pJ4rIxyoCDWNy9/NevaJewgVkbfsDVtwPKgQkzTyx1Mye/lskFbTQggS0fblSMT6vq
         oW7lf25+g+v0KCk4y//xck/3pYqHkPUz8mmzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S870gAIGJJG5wbnKkLGfuHM1oPY3XJ0b8gnuuYnNBhk=;
        b=E+DF/RK0pPi21f5/iUeqXBppkXX/j1WSQbNS/Y5ibx4aHsVOtezA26nq8FvQ55NGq5
         7PQCkM+ah1JD5fKLnO+XwgOQhGsQCKbZx2N3RK3YcThLuPHZnKch7/kJf3vGcf4e8oPr
         JX33lHOkDyUU9o2a3CyODB3cMS0N2wmCdi0viRwOYQhSUxTvIx2tm5EC+D19HSTRdxgh
         vTMpCasMF5658VI2nfuCC3gKK6vuk9GRshjxVpMzNqTcq3IN7KpAkQRnWPYiaHXjRMZb
         FODc50qisOrweqNrCNNaT+MZiLFFZJdWjMQQ91wEYsQqSv56pcOcSvS2t5/zbDCyKIbt
         a7Uw==
X-Gm-Message-State: AJIora8WdTFpySraP/kqWOE3DgsuMaLhI9V+qa9PDXiIujaDzMxu70ku
        41Q04u8/hdBPHDhDFXKNc6+p7g==
X-Google-Smtp-Source: AGRyM1vZGJwn8mfldPvJhnlwK/C8tCWflZBhZAobYR+Xmu7mnOWQcypB3EgZo3C/S9q70UytXZ7HTA==
X-Received: by 2002:a05:600c:511c:b0:3a2:e2e9:6563 with SMTP id o28-20020a05600c511c00b003a2e2e96563mr10287808wms.204.1657724808544;
        Wed, 13 Jul 2022 08:06:48 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-51-7.cust.vodafonedsl.it. [188.217.51.7])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4c47000000b0021baf5e590dsm11214523wrt.71.2022.07.13.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:06:48 -0700 (PDT)
Date:   Wed, 13 Jul 2022 17:06:45 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220713150645.GB1725944@tom-ThinkPad-T14s-Gen-2i>
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
 <20220712163349.1308540-6-tommaso.merciai@amarulasolutions.com>
 <1657664975.862137.2476655.nullmailer@robh.at.kernel.org>
 <20220713064845.GA1386778@tom-ThinkPad-T14s-Gen-2i>
 <87086513-787c-3b0d-80df-b90ebdc3a28c@linaro.org>
 <20220713132451.GA1725944@tom-ThinkPad-T14s-Gen-2i>
 <Ys7YPIveQHRbG7BE@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7YPIveQHRbG7BE@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Wed, Jul 13, 2022 at 05:35:40PM +0300, Sakari Ailus wrote:
> Hi Tommaso, Krzysztof,
> 
> On Wed, Jul 13, 2022 at 03:24:51PM +0200, Tommaso Merciai wrote:
> > On Wed, Jul 13, 2022 at 08:52:34AM +0200, Krzysztof Kozlowski wrote:
> > > On 13/07/2022 08:48, Tommaso Merciai wrote:
> > > > Hi Rob,
> > > > 
> > > > On Tue, Jul 12, 2022 at 04:29:35PM -0600, Rob Herring wrote:
> > > >> On Tue, 12 Jul 2022 18:33:48 +0200, Tommaso Merciai wrote:
> > > >>> Add documentation of device tree in YAML schema for the OV5693
> > > >>> CMOS image sensor from Omnivision
> > > >>>
> > > >>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > > >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >>> ---
> > > >>> Changes since v1:
> > > >>>  - Fix allOf position as suggested by Krzysztof
> > > >>>  - Remove port description as suggested by Krzysztof
> > > >>>  - Fix EOF as suggested by Krzysztof
> > > >>>
> > > >>> Changes since v2:
> > > >>>  - Fix commit body as suggested by Krzysztof
> > > >>>
> > > >>> Changes since v3:
> > > >>>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
> > > >>>
> > > >>> Changes since v4:
> > > >>>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
> > > >>>
> > > >>> Changes since v5:
> > > >>>  - Remove dovdd-supply, avdd-supply, dvdd-supply from required properties
> > > >>> as suggested by Jacopo
> > > >>>
> > > >>>  .../bindings/media/i2c/ovti,ov5693.yaml       | 103 ++++++++++++++++++
> > > >>>  MAINTAINERS                                   |   1 +
> > > >>>  2 files changed, 104 insertions(+)
> > > >>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > > >>>
> > > >>
> > > >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > >>
> > > >> yamllint warnings/errors:
> > > >>
> > > >> dtschema/dtc warnings/errors:
> > > >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb: camera@36: Unevaluated properties are not allowed ('port' was unexpected)
> > > >> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > > >>
> > > >> doc reference errors (make refcheckdocs):
> > > >>
> > > >> See https://patchwork.ozlabs.org/patch/
> > > >>
> > > >> This check can fail if there are any dependencies. The base for a patch
> > > >> series is generally the most recent rc1.
> > > >>
> > > >> If you already ran 'make dt_binding_check' and didn't see the above
> > > >> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > >> date:
> > > >>
> > > >> pip3 install dtschema --upgrade
> > > >>
> > > >> Please check and re-submit.
> > > >>
> > > > 
> > > > I run:
> > > > 
> > > > pip3 install dtschema --upgrade
> > > > 
> > > > Then I check .yaml using:
> > > > 
> > > > make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > > > DTEX    Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dts
> > > > LINT    Documentation/devicetree/bindings
> > > > CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > > > SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > > DTC     Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
> > > > CHECK   Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
> > > > 
> > > > No error on my side. I'm missing something?
> > > 
> > > Rob's check are running newer dtschema, from master branch. The error he
> > > reports is about missing port, although I thought it is coming from
> > > video-interface-devices.
> > 
> > Hi Krzysztof, 
> > Thanks for the info! :)
> 
> These bindings are indeed missing the port node, please add one. See e.g.
> Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml for an
> example.
> 
> The reason why video-interfaces and video-interface-device are sparate is
> because they deal with different nodes (device vs. port).

Thanks, sent v7.

Tommaso

> 
> -- 
> Kind regards,
> 
> Sakari Ailus

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
