Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C116517EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiECHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiECHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:37:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888B37A1E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:33:30 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-deb9295679so16459593fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8o0C2gjFqAcxMw11ZMv1RJhJlOaExSJ64lIhblQWfws=;
        b=lXTE9sxcWhhbdk92o5fmhgd7S6BZZn8IrV7fAgNfQRMAy8gYvIUopnsukDlQZwk3sh
         bSUz8biuThWxBQoQWVwP42cfgHyiXYRnNMs66n1/T596YR7Ke4Jr69iyln+VhGJ1ngm8
         NtUm8/AuWYQMDGGeXY5k+cSe3eDbrhQ0/QXHCVfg8FzEFBiZgD9XDiKq+WW+4Jz+wAwK
         A+Au0qiOj9qT4pjm3MC9BfCQ1+ZNZwgmEHVE3Qd9q0kEWcnbJ2W2z5Nr5ygQ+P3eT8n8
         RCXJFQAvp8Kt+39H/LA3+cUkPTkxsUoy9YP05e5ald7IKoRvnAtrcYIIkt5gKsgsFC/c
         SiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8o0C2gjFqAcxMw11ZMv1RJhJlOaExSJ64lIhblQWfws=;
        b=DugWPuxyCtIRAGqhPbXKwH2m6lgkfCkhGv1jR2CRPBcWLY3O43E/YIr0cPhXrchnji
         yG4Vd7+iRWSTY77XbRzX0CQfPJ1hayVWyULoDNAygzEArxno8LnYJ/9vrF6Scql4dcVO
         caRrlmKc1jT8lGPmjdDL3CRMycivAD2MuVgTvRa2+j1FCjYMprSm0h1DCyVWSFmtgEK8
         jvrw+SbBn6mvAkWEIPYxRdRM65xf4FxDD2RMwb3GCnT6C2ZZc/AsxF97zyxOB5l9qtl7
         /dzbKAILxOkGgmKbeUA3vidMxIDaC2ssUaPZGVFNdJdcFnQLZ4Spp52gAOdStzvG0oVq
         4yvw==
X-Gm-Message-State: AOAM533fdKyK/Owlx+bjnhbLot1BLwS7tCdYspXeIVFmSSsTNrUSyPL7
        7LJ7/2n5XMWFv6lUSamwoSS+G19WCkUwfl5Jgwgetis/mVy+bA==
X-Google-Smtp-Source: ABdhPJzUutyif87QHgKGdmTTISX4skx9CBm4o9F6ukqL/MIXC+iAt+1EAKBPHPoLN0tcvA2kL78Hu+EbVWHCacupEY0=
X-Received: by 2002:a05:6870:65a0:b0:ed:a635:eee9 with SMTP id
 fp32-20020a05687065a000b000eda635eee9mr1253334oab.48.1651563209616; Tue, 03
 May 2022 00:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
 <20220429220833.873672-2-bhupesh.sharma@linaro.org> <1651505609.486882.1161774.nullmailer@robh.at.kernel.org>
In-Reply-To: <1651505609.486882.1161774.nullmailer@robh.at.kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 3 May 2022 13:03:18 +0530
Message-ID: <CAH=2Ntxn8cb4YPYkwzro47zpcDVL5_dbaZ-_P1+vi8=ydX+Y+Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mmc/sdhci-msm: Convert bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2 May 2022 at 21:03, Rob Herring <robh@kernel.org> wrote:
>
> On Sat, 30 Apr 2022 03:38:30 +0530, Bhupesh Sharma wrote:
> > Convert Qualcomm sdhci-msm devicetree binding to YAML.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/sdhci-msm.txt     | 123 -----------
> >  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 192 ++++++++++++++++++
> >  2 files changed, 192 insertions(+), 123 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.

As noted in the cover-letter accompanying the patch:

This patchset is dependent on the qcom dts fixes sent via a separate
patchset (see [1]), to make sure that the 'make dtbs_check' and
'make dt_binding_check' work well and Rob's bot is happy as well.

[1]. https://lore.kernel.org/linux-arm-msm/20220429214420.854335-1-bhupesh.sharma@linaro.org/

Thanks,
Bhupesh


> Full log is available here: https://patchwork.ozlabs.org/patch/
>
>
> sdcc@7804000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
>         arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
>
> sdcc@7804000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
>         arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
>
> sdhci@7824000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
>         arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
>         arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
>         arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
>         arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
>         arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
>         arch/arm/boot/dts/qcom-apq8016-sbc.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb
>
> sdhci@7824000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
>         arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
>         arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
>         arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
>         arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
>         arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
>         arch/arm/boot/dts/qcom-apq8016-sbc.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb
>
> sdhci@7824900: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
>         arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
>         arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb
>         arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
>         arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
>         arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb
>
> sdhci@7824900: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
>         arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
>         arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb
>         arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
>         arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
>         arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
>         arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb
>
> sdhci@7824900: clock-names:2: 'xo' was expected
>         arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
>         arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
>         arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb
>
> sdhci@7864000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
>         arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
>         arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
>         arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
>         arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
>         arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
>         arch/arm/boot/dts/qcom-apq8016-sbc.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb
>
> sdhci@7864000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
>         arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
>         arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
>         arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
>         arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
>         arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
>         arch/arm/boot/dts/qcom-apq8016-sbc.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb
>
> sdhci@7c4000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>
> sdhci@7c4000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>
> sdhci@8804000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>
> sdhci@8804000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7280-crd.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
>         arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>
> sdhci@8804000: clocks: [[13, 70], [13, 71]] is too short
>         arch/arm/boot/dts/qcom-sdx55-mtp.dtb
>         arch/arm/boot/dts/qcom-sdx55-t55.dtb
>         arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb
>
> sdhci@c084000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>
> sdhci@c084000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>
> sdhci@c0c4000: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>
> sdhci@c0c4000: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>
> sdhci@c0c4000: interconnect-names:0: 'sdhc-ddr' was expected
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>
> sdhci@c0c4000: interconnect-names:1: 'cpu-sdhc' was expected
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>
> sdhci@f9824900: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
>         arch/arm/boot/dts/qcom-apq8084-mtp.dtb
>         arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
>         arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb
>
> sdhci@f9824900: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
>         arch/arm/boot/dts/qcom-apq8084-mtp.dtb
>         arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
>         arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb
>
> sdhci@f9824900: clock-names:3: 'ice' was expected
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>
> sdhci@f9824900: clock-names:4: 'bus' was expected
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>
> sdhci@f9864900: clock-names:0: 'iface' was expected
>         arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
>         arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb
>
> sdhci@f9864900: clock-names:1: 'core' was expected
>         arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
>         arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb
>
> sdhci@f98a4900: clock-names:0: 'iface' was expected
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
>         arch/arm/boot/dts/qcom-apq8084-mtp.dtb
>         arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
>         arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb
>
> sdhci@f98a4900: clock-names:1: 'core' was expected
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
>         arch/arm/boot/dts/qcom-apq8084-mtp.dtb
>         arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
>         arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb
>
