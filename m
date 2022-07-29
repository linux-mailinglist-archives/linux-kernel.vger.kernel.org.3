Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5F58522B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiG2PPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2PPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:15:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE193DBDD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:15:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y127so8674905yby.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVW1HuRhi3qWhCumOh2BN9qRaoJYOTe2cMXmsKboVPA=;
        b=q3+xVd38htCkerZKxQ6R7n4Dj/dhgTXP8cf1zgt0TETxOzRPDIPko+9f0eqCQOzoxF
         o/Y64pJri8xB0On7D4lX+BJ33/XKXOk/Es62jTldY/l7pg4XOKeesDuPqY9fiz35PN5G
         7Q2AerqnCZzrSfQgwj6hmLEds9r22fcQSYT/X3u/T4uNZHd1i2qdUo5V0H04IxJc+hdX
         q+wUd3CTnyTcE9E/+/Qtp8AHG0baKZiTcvw/mh/ongkjwlo96i1Lzlpt50A9cL96srAM
         YmE9GBS1/BXs2uYAh2q0wlxlqZDTKhh4lnaIsthfcd1q6Lj0fE/O46aD/eehLc9aD+kl
         L3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVW1HuRhi3qWhCumOh2BN9qRaoJYOTe2cMXmsKboVPA=;
        b=zlqkqSFzoinkLmdADNuEuq8yk1TeLwQ2OlV2Pub56yacQcaG3lX438m6xLEeLljU97
         LFDQK0alVB8Oj/yosfah93eNXtZfWbcUYpTa5KnljDE24XVJOfDhyBTLvaaloZaIvulI
         v3xY6HAQPENyM33BoOiGKqBYX7dFuO9B943Vxf1Wp0JsMCjeXynLKY9oM4vVznfN1V17
         kh/gYEwUB4gybKuja604Czp8T1Q2bf9K3hKOJgX8QSxzMYleIcq5zwX5xmsyRsz42R+Z
         39LYm7TLD9jDQ91X16cwcUjD8voIGekuhwZER7rQreaZZMndKVZZ4KVzNG52KC0KTMv9
         r22Q==
X-Gm-Message-State: ACgBeo2NtRRIo5Skds11xcFBSJtIMeOEeZmDYtPh/HbmiiRxqbAcQfJY
        n49ixspTI2asUOlJS0WncPjzXzrqXgybNdxnOiRmQA==
X-Google-Smtp-Source: AA6agR7MjsWrl5+wY6we1QLY1FGUyJgK/g+rqxviL46ZaTQ/lIO46FFNuI2HHXPoibeBW6Xc014AeHOzzqbfCG2Ff7Y=
X-Received: by 2002:a25:bb12:0:b0:66f:3c5f:dd9c with SMTP id
 z18-20020a25bb12000000b0066f3c5fdd9cmr2700663ybg.520.1659107737834; Fri, 29
 Jul 2022 08:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-3-bchihi@baylibre.com>
 <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
In-Reply-To: <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 29 Jul 2022 17:15:01 +0200
Message-ID: <CAGuA+opZSoWLZ62tZMdA1GoUe7N9K8DV19AUAophCQpr6rNH9Q@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

This error only appear when I apply my series directly on top of linux-5.19.rc8.
But, when I apply the other two series that mine depends on,

https://patchwork.kernel.org/project/linux-pm/cover/20220722200007.1839356-1-daniel.lezcano@linexp.org/
https://patchwork.kernel.org/project/linux-mediatek/cover/20220523093346.28493-1-rex-bc.chen@mediatek.com/

and run "dt_binding_check" again against my YAML file, it does not
print the error you found above.
Would you check it, please?
Thank you.

Best regards.
Balsam.
