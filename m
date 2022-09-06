Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D578C5AF437
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIFTJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIFTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:09:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA19A6B3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:09:07 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 202so11446398pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=USGKt12KI6hqIl32nlA4hDouQZ/htGzTNTb50q1jr6M=;
        b=eu0Nbwk3cgdedK/+pik19CrYVr6eMYXGo3vPoqCXA49aHcfIcgJhNowT7n3hwr/KJF
         QGeCM/JeP3cIAg8s92XiDj/KFSDgqlmze5D6leEA0dRDFreh4MqjV+bxh0Oqkx8wzeFa
         Ym0/NeVFiB/CXxdhyfFUxmywfOvBhuwlOqwypcKyhpPJ5u4Tm9yHPVxkVQl/s8pEFVz9
         F3cI0bFnmIAl4oSbLlHIbw8P9l9RCYd2Jwmy27umsNcl2KajJxu0ne4T5e3FB6Z3ezRk
         XEUbVr/zNAWu7Ar5HtylPc4uwow6OxZipf+XwO5g3hlRcKKi/h1M+P607Sn67jRyVviG
         LDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=USGKt12KI6hqIl32nlA4hDouQZ/htGzTNTb50q1jr6M=;
        b=gF63v7x7mPxY7HvLopNnJl7Vx964o6lqdgIVPngYmO3ow4+xooASq10jlLEiJ/DjTW
         jhZ4dj5mrkivywTK2N7YqPsiDBqroLjtiBvtlD3DwJBJYzTlCdc1omcnjq0xU2F+bl+Q
         QpNcLgYEjSui8Y+JyKs3kfyxv3UQfti8TlvXyeu5eKVJg8pmf3+YKfPqsmIuWp7nXuDx
         iMBsmT/wO93RKoFCVqyyBUJNL0xp6FhwMGky1oi/cn2Z7n52MxCh85HBrMbXkJszg0ub
         N0rDDa0Nki5dQmHia6ZrPe4srtjZBGeMsi2fO//K+NNCEsTeeoIbxeQKZIvlmwF3d3DL
         Ol2w==
X-Gm-Message-State: ACgBeo16EoDUf6z1+zr7LXVQhU/U3NNJ6N1mBcURkKcmVqZCWcrhZALe
        HfQtEJIyALXQJ4D3EVZ/GqBy99idtoNgCmwzyn2pDw==
X-Google-Smtp-Source: AA6agR7RQfdgHlY4n4EkRR8HvndWT1gKDUsFCJrGt96RxjGT9OckJRtkjMg+3n7uk2ZMHpMO7kBgt2DeMpfxa9m5Txk=
X-Received: by 2002:a05:6a00:e8f:b0:536:c98e:8307 with SMTP id
 bo15-20020a056a000e8f00b00536c98e8307mr56516788pfb.73.1662491347060; Tue, 06
 Sep 2022 12:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220902230500.2624739-1-tharvey@gateworks.com> <cbb82e89-7035-1c01-8f22-319c1752156f@linaro.org>
In-Reply-To: <cbb82e89-7035-1c01-8f22-319c1752156f@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 6 Sep 2022 12:08:54 -0700
Message-ID: <CAJ+vNU0gqqY0Z=aeVBsPa_j_-ONVtJypJUUe-WxEgNzncsT0qA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904 board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 11:41 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/09/2022 02:04, Tim Harvey wrote:
> > Add DT compatible string for i.MX8M Mini based Gateworks GW7904 board.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 7431579ab0e8..ce89fac1898e 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -831,6 +831,7 @@ properties:
> >                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
> >                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
> >                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
> > +              - gateworks,imx8mm-gw7904   # i.MX8MM Gateworks Board
>
> Please put it ordered alphabetically, so before "gw".
>

Krzysztof,

Ok - will send a v2 after waiting for feedback on the dts patch.

Best Regards,

Tim
