Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4985822A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiG0JC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiG0JCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:02:51 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E813E87
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:02:49 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f379a0754so65591507b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMfKgfMggMNo3eihisQlQcnwku84/adCCeUBHxwgFgY=;
        b=AVctTuCDLV66HgOOebgeRV0S1c8FJndDasQlXmmcLGkjwPJsXQhTimeMepc3Vj4wqO
         pdTiIh44L7gXx816XA0kVVCujErNu5wfVFJbs79Lin6dgfieUxrgLZjAxSpBt6TkOIU8
         eKjmpPmUdgob41bpl+2pj8RQEfmF2NdaPc95fauCu/bAWIKMgjWLsEcfPx5ZcLB7NpNt
         Fnk0ygntA2pshSJrbCspJh36vwLl61Q2ga4JTo5x9MBOQ8IWqkuZ98nV61I0Pfh6rFBl
         SDwDF/br+DhrVHUmzLqHoD9XbGuwyWKd1mc54eDSrIZZRBj8WXbRAya0F1q0kWusr2mD
         MoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMfKgfMggMNo3eihisQlQcnwku84/adCCeUBHxwgFgY=;
        b=q8SQbpDgl8yaV6adb9m2AJQkIuiFLUbwl1qC+r0EdfCtyUfKM/uNCqW8qIiPk6I7eC
         qZge0gngHIUIyWwawH3sGNk+sVeY+MmIy5X88fN4v6derJdN+yaWUp705+yzwLvqflJ8
         NM/AORPDzDf1x4M4VkiQYxE+4Ie7hnWUCVzLcof//aZ2sQ40af9Jg/9VLgVM6KyTROqz
         2APjVzzSopptrfIjutexwYDftUHrQy2uoHH/w6ExVbPXyDiirsEjDnSiUp3Cskqa0BcS
         Svlf6TteKYP6oe+yOh5P6dw+kVQSAfgaSiH6RcIIXTeUtV3iAoPfiGt5HnhvlLEWeygE
         BhVA==
X-Gm-Message-State: AJIora+zaBbsfL3//2NMu49TijEgHlVYl7kFQB+w8no0WVekXlRSQpW+
        5va7az5E/IAOyyPmfR+q/lBEQYbdFndFUHWdkgxuRg==
X-Google-Smtp-Source: AGRyM1vHX+qKTMq6tfqznzj4BNItgMsLSP5R9D+chOdqP/40r06PtcoFkng2x2B+2afSmTdaPGf6uhJXJv31xOyY2sk=
X-Received: by 2002:a81:ad60:0:b0:31e:68a9:be1 with SMTP id
 l32-20020a81ad60000000b0031e68a90be1mr17834847ywk.244.1658912567588; Wed, 27
 Jul 2022 02:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-3-bchihi@baylibre.com>
 <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
In-Reply-To: <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 27 Jul 2022 11:02:11 +0200
Message-ID: <CAGuA+ooAHSvFAQC4mg7inOXO_bLvZv5Req=vm3PE6Pkjtf_vsA@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
To:     Rob Herring <robh@kernel.org>
Cc:     rui.zhang@intel.com, rex-bc.chen@mediatek.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, abailon@baylibre.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, khilman@baylibre.com,
        fan.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, louis.yu@mediatek.com,
        james.lo@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 26 Jul 2022 15:55:02 +0200, Balsam CHIHI wrote:
> > This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> >
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
> >  .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
> >  2 files changed, 148 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dts:32.36-37 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1404: dt_binding_check] Error 2
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
Hello Rob,

Thank you for the feedback.
I'm updating my dt-bindings check tools, fixing, and I will resend ASPA.

Best regards,
Balsam.
