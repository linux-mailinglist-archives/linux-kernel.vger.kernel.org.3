Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883851AFA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiEDUtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378392AbiEDUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:49:12 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F94749686;
        Wed,  4 May 2022 13:45:35 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p3so190131qvi.7;
        Wed, 04 May 2022 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ek3zlaw/6IaI125lea4IBa7APabeF2bKg/BU8vuMPPc=;
        b=VZBY3N6v9fJ/HjnjRRCE9q9dOqXvwKTx8kesBgYAMknB93gRcC0zL91xoWNZgXXNxV
         VMMy1dU7uJPS7D4COtMHVA/I38WH5APC4yQC+9LrtEUoi+WeszHQbhnAF+JiIb7nLkBX
         czVVN+7BgYEfefvom1gsuw44SxZTVmF2qrWwWbL5ZeJpHu4kOCI1cRTJKgO2VtGvoxpp
         zbds7Ipg3ODS97KMFqIhnjg5Yd3s9QH/yoWf7uue/QcKYYf58m0Uj1gZoD/pGeLfUU/l
         HG+AdQSiKGChfvCjtowv6jd0hdPXHMsWY5ZLDZ6MyGU183KL+xflthX3Kjnl1XGMFrKi
         YLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ek3zlaw/6IaI125lea4IBa7APabeF2bKg/BU8vuMPPc=;
        b=R4xyigeKWlk2rXKWMJOSDkeAT7YpN5HRWit7eECXIho9JMMZ5UhKa72aZ93CU4Eo7H
         BjG6/hb2FJeg63CxL+WsxVe/CLHRuYFa6579LXhoGiJMF+dFkfpbPID735s6T6t3R+ZU
         1B5K+FmRK3Pk+XCZBswic0ZawXq/wQcSoVSz8GzYaL64NHt01f8wkGCg2jKJ+USroK/1
         Qh4xaEUHZvMS7UrTYww0AKvHRlLxAqQ3a3WfWM2UhBB+4FTv0fgPHjdgMEtPz1yiJAZf
         d3lvQeuakQ5HzfGUJAf4JGnBApWoM+E8YVaas2QC9NYexuhNJepjjxCgMHsr0B1tsLAv
         4Yjg==
X-Gm-Message-State: AOAM530GqrDXTK9NJofCwxj9nMFQjqP6TTHNCINunyklEaQbk+6BbCvN
        q+GueqLcIjwQhKFXRWyG/MXW+i5VcGBxzz+6cLY=
X-Google-Smtp-Source: ABdhPJys+oy8Pd0fOi6s08rhaeH/hcRRwbVUSpYYF7kmMN8MF/TTz4oMZrU5eerbqAayeouw5ul2UeJLD7GTpw1YA4E=
X-Received: by 2002:ad4:4f48:0:b0:458:12bb:1321 with SMTP id
 eu8-20020ad44f48000000b0045812bb1321mr19435280qvb.50.1651697134000; Wed, 04
 May 2022 13:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220503195605.4015616-1-robimarko@gmail.com> <20220503195605.4015616-2-robimarko@gmail.com>
 <YnLdTIKx80wszbj7@robh.at.kernel.org>
In-Reply-To: <YnLdTIKx80wszbj7@robh.at.kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 4 May 2022 22:45:22 +0200
Message-ID: <CAOX2RU5RMra4zj-jWZFH_fev-EavsnLnjob0z4FsaYnn8cs5gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add support for IPQ8074 APSS
 clock controller
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 at 22:08, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 03, 2022 at 09:56:01PM +0200, Robert Marko wrote:
> > Add dt-binding for the IPQ8074 APSS clock controller which provides
> > clocks to the CPU cores.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Correct subject
> > ---
> >  include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h
> >
> > diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > new file mode 100644
> > index 000000000000..df07766b0146
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> Dual license please.

Hi Rob,
Krzysztof asked about this in v1, I have derived this off IPQ6018
binding which is marked GPL-2.0.
So, I was not sure if it was appropriate to mark it as GPL/BSD dual license.
If you say that its not an issue to dual-license, I will gladly do it.

Regards,
Robert
>
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
> > +#define _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
> > +
> > +#define APSS_PLL_EARLY                               0
> > +#define APSS_PLL                             1
> > +#define APCS_ALIAS0_CLK_SRC                  2
> > +#define APCS_ALIAS0_CORE_CLK                 3
> > +
> > +#endif
> > --
> > 2.35.1
> >
> >
