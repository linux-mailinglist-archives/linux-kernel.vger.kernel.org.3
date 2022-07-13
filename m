Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC951572E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiGMGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiGMGsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:48:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DF39BB5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:48:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i204-20020a1c3bd5000000b003a2fa488efdso303625wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6CjzYYkj2xapcxsDDDggL035MIFSdHC3l1JLuT4VW8E=;
        b=GkZbIJVp+OD28e4F8pwCTxhDe7DnTOdWYrLN7IepZgVQoKgR8jYtowTU9cyGpnzgWc
         hGF2EGVqg2KDz+D5j99px35SkMSxy31YeAtfnTIgcRwWt1DkOeFIFvrsPXdocUVRglKy
         TQF1Af7ccbVzx8/rWHmjlLyyU9EIpKppxIoB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6CjzYYkj2xapcxsDDDggL035MIFSdHC3l1JLuT4VW8E=;
        b=J6XHPQgIvXPC/48+WpyZ9m80zZBjmpuPx5WyLtIXLDLzCbtRZ8rgQgR1auVH68RGuV
         yEdda9cDG27/2my9O9e6i3ZZmIYHpAL7Z/VabavVXSVN6KQoHDBEMAgBlJwo15lLNDXx
         W7PC9kO2VOOgXYZfWNDgmfRZ5FdoPWgzJeUizWwGN+XrGfIQ0sI/biOxUXPNr6IYtH4p
         xJ8AKq1+xRfP6Gmq1dwI4E81KVU8+NAH8zgyEklS18tw3k2vASwXoPPBdG0+8xgrwiaX
         8a0olVSwmdWuuWheum4msEvfv9Dps6UKtMAfgvPMCECelSFapybuJjlzOfrFphrOG07n
         wE+g==
X-Gm-Message-State: AJIora/Uy2yIUmVu5GUh92aytMmYCRIj0WgET9vsIVJe74ofwTHxfpmW
        rLr7W1mp1tTREJnz5UR7xbEtEg==
X-Google-Smtp-Source: AGRyM1tCqkeFqv3bxkdwlpJaliNQsq7+cpPl4uF6hn89LfZJQPmZGQiEm8+wpwIFx3iKAa+DHgIwQQ==
X-Received: by 2002:a05:600c:3641:b0:3a2:df38:7ec8 with SMTP id y1-20020a05600c364100b003a2df387ec8mr1840095wmq.34.1657694928629;
        Tue, 12 Jul 2022 23:48:48 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-53-214.cust.vodafonedsl.it. [188.217.53.214])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d634a000000b0021b89f8662esm10359503wrw.13.2022.07.12.23.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:48:48 -0700 (PDT)
Date:   Wed, 13 Jul 2022 08:48:45 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-media@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220713064845.GA1386778@tom-ThinkPad-T14s-Gen-2i>
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
 <20220712163349.1308540-6-tommaso.merciai@amarulasolutions.com>
 <1657664975.862137.2476655.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657664975.862137.2476655.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jul 12, 2022 at 04:29:35PM -0600, Rob Herring wrote:
> On Tue, 12 Jul 2022 18:33:48 +0200, Tommaso Merciai wrote:
> > Add documentation of device tree in YAML schema for the OV5693
> > CMOS image sensor from Omnivision
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changes since v1:
> >  - Fix allOf position as suggested by Krzysztof
> >  - Remove port description as suggested by Krzysztof
> >  - Fix EOF as suggested by Krzysztof
> > 
> > Changes since v2:
> >  - Fix commit body as suggested by Krzysztof
> > 
> > Changes since v3:
> >  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
> > 
> > Changes since v4:
> >  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
> > 
> > Changes since v5:
> >  - Remove dovdd-supply, avdd-supply, dvdd-supply from required properties
> > as suggested by Jacopo
> > 
> >  .../bindings/media/i2c/ovti,ov5693.yaml       | 103 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb: camera@36: Unevaluated properties are not allowed ('port' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

I run:

pip3 install dtschema --upgrade

Then I check .yaml using:

make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
DTEX    Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dts
LINT    Documentation/devicetree/bindings
CHKDT   Documentation/devicetree/bindings/processed-schema.json
SCHEMA  Documentation/devicetree/bindings/processed-schema.json
DTC     Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
CHECK   Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb

No error on my side. I'm missing something?
Let me know.

Thanks,
Tommaso

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
