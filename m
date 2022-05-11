Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3EB5235AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiEKOg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbiEKOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:36:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2341616;
        Wed, 11 May 2022 07:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F33A7B82410;
        Wed, 11 May 2022 14:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BB0C34116;
        Wed, 11 May 2022 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652279807;
        bh=CFhh69pRRTRkzZMswQTkxgZWxD/YArFAjT9FIgk+yio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gEiSBSsGKR+8BwK8haoPAsMJZYD8XCaC46lJnoHPerCMp1g6l9P3xZteEOsKk2MUo
         ZELEJ1mhPuDhJmP3W+BmC6+m5Y+12EYvpGP8QstJEZBeHL/AVpMiFpf493GaDnSS/M
         OkGALA59NNBTMT1eUG/2thE3TNfy8FjzAreDuz/5UUhAKiLbdQr/l3+ZqdH+XWYymp
         ZaPf2ZqzoiiKqUBpg+UMK5SZ278kFIWfvi1QQqMzqxhTdHy3Vb7OtHLdD9l3RgV0d5
         dQsiJXbqdK5Y2Rs8nGNZwhzkcD3yr374Vzpk+l1sKqylC3lo1EteelNQbN23gaG6vA
         yN18XzCLNNY/A==
Received: by mail-pg1-f172.google.com with SMTP id 15so1975211pgf.4;
        Wed, 11 May 2022 07:36:47 -0700 (PDT)
X-Gm-Message-State: AOAM530Gah/Q4jE02qiGWsyjL7ASd8mQmRALHe+g+A6dzKYOpJ3sE4Vs
        IK+nXqt7JccN+2irDY+0YVeepwRPgu/higbeVA==
X-Google-Smtp-Source: ABdhPJzuQsnkqZbdNusjFeMctKvTdpkvefeyuXEUsA0fTySx0Vw8lpkWlOD30zEX2dqbf4Ozf1dDOiJd7nqvDOobbuc=
X-Received: by 2002:aa7:9519:0:b0:510:5175:7649 with SMTP id
 b25-20020aa79519000000b0051051757649mr25841856pfp.15.1652279807276; Wed, 11
 May 2022 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220504091923.2219-1-rex-bc.chen@mediatek.com>
 <20220504091923.2219-2-rex-bc.chen@mediatek.com> <e45e68c76775edbf935418ca4f75dc83591805cd.camel@mediatek.com>
In-Reply-To: <e45e68c76775edbf935418ca4f75dc83591805cd.camel@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 May 2022 09:36:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLcZ69-WPk6Oq54EgXPZo-wviu5-SrKEaAYRQ5LZU0rcw@mail.gmail.com>
Message-ID: <CAL_JsqLcZ69-WPk6Oq54EgXPZo-wviu5-SrKEaAYRQ5LZU0rcw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: display: mediatek: dsi: Convert
 dsi_dtbinding to .yaml
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>,
        "xinlei.lee" <xinlei.lee@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 2:24 AM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> On Wed, 2022-05-04 at 17:19 +0800, Rex-BC Chen wrote:
> > From: Xinlei Lee <xinlei.lee@mediatek.com>
> >
> > Convert mediatek,dsi.txt to mediatek,dsi.yaml format
> >
> > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../display/mediatek/mediatek,dsi.txt         |  62 ----------
> >  .../display/mediatek/mediatek,dsi.yaml        | 115
> > ++++++++++++++++++
> >  2 files changed, 115 insertions(+), 62 deletions(-)
> >  delete mode 100644
> > Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml

[...]

> Hello Rob and Krzysztof,
>
> Can you give us some suggestions for this conversion patch?
> Thanks!

You can check status for yourself by looking at PW[1] where you will
see the review queue is currently ~120 patches and goes back to 5/3.
If it is in the queue, I will get to it.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
