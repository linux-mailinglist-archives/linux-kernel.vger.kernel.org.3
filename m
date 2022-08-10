Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994058F245
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiHJSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiHJSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:25:16 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB149B75;
        Wed, 10 Aug 2022 11:25:15 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id d4so8730870ilc.8;
        Wed, 10 Aug 2022 11:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LcQlkqf3w+uIY1hqigVt5yrj9Rka522hQZXJqkKj/Yo=;
        b=EgZz4f7X8JVxzgsMLFOc2oD+wSfkT8DZIoyZEIEiwASXrMePTITHngcVmSS/OQfula
         C2k2UBAEC9XdV6Rz9DYHA8EW0p7f4g6x2/AevlArihAzmSpSVtQsgEjJfPqAIk5k7fb9
         L976X9bV/ant6979S0QO9WQwdIAcFYPJC9eE5jFw293DPo5RWMBUi0/0RcJSQ0b1FC8k
         BHQ6vr+GW2ncqRiuRxNEID76kFeKeAiw88Biayr6P5HbANkSRwJU9x8kYnUSaMItzKYj
         RgHoAKi8uEOBYeuG+bZdIL8y2bnx1KzsuSftBElkgTOIsfnid/IkA+SBVYfpJ3w1E2Ev
         dcgA==
X-Gm-Message-State: ACgBeo1ZCsgKKSIibY8TOj/8g3xx91oC9KdReqCBdxjWKm8MLx9ig6L2
        Z2mGc3OVuj1d2tw4QMKYPw==
X-Google-Smtp-Source: AA6agR6jsK6nG3HUQzekRN9Nqy2jzQ7PkAEWz/oZpXSHCY0PiPtK7n6zQ5qeD1OMCuoI795SMDoP8Q==
X-Received: by 2002:a92:cd89:0:b0:2de:553f:bd9d with SMTP id r9-20020a92cd89000000b002de553fbd9dmr12977061ilb.179.1660155914296;
        Wed, 10 Aug 2022 11:25:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x13-20020a056638160d00b0034347c6183esm555507jas.92.2022.08.10.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 11:25:13 -0700 (PDT)
Received: (nullmailer pid 286879 invoked by uid 1000);
        Wed, 10 Aug 2022 18:25:11 -0000
Date:   Wed, 10 Aug 2022 12:25:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rui.zhang@intel.com, rex-bc.chen@mediatek.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, abailon@baylibre.com,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, khilman@baylibre.com,
        fan.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, louis.yu@mediatek.com,
        james.lo@mediatek.com
Subject: Re: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Message-ID: <20220810182511.GE200295-robh@kernel.org>
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-3-bchihi@baylibre.com>
 <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
 <CAGuA+opZSoWLZ62tZMdA1GoUe7N9K8DV19AUAophCQpr6rNH9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGuA+opZSoWLZ62tZMdA1GoUe7N9K8DV19AUAophCQpr6rNH9Q@mail.gmail.com>
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

On Fri, Jul 29, 2022 at 05:15:01PM +0200, Balsam CHIHI wrote:
> On Tue, Jul 26, 2022 at 10:09 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, 26 Jul 2022 15:55:02 +0200, Balsam CHIHI wrote:
> > > This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> > >
> > > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > > ---
> > >  .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
> > >  .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
> > >  2 files changed, 148 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Error: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dts:32.36-37 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dtb] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1404: dt_binding_check] Error 2
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/patch/
> >
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit.
> >
> 
> Hello Rob,
> 
> This error only appear when I apply my series directly on top of linux-5.19.rc8.
> But, when I apply the other two series that mine depends on,
> 
> https://patchwork.kernel.org/project/linux-pm/cover/20220722200007.1839356-1-daniel.lezcano@linexp.org/
> https://patchwork.kernel.org/project/linux-mediatek/cover/20220523093346.28493-1-rex-bc.chen@mediatek.com/

How was I supposed to know that if you don't document that in the patch?
 
> and run "dt_binding_check" again against my YAML file, it does not
> print the error you found above.
> Would you check it, please?

No. Resend after rc1 and checks will be based on that.

Rob
