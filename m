Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180B84EB3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiC2TMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiC2TMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46916D969;
        Tue, 29 Mar 2022 12:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D8861659;
        Tue, 29 Mar 2022 19:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFC1C34112;
        Tue, 29 Mar 2022 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648581064;
        bh=Z9f2r56vngMSRkwrHGORVdFRCd3Ja+qoUjCgMo0+fMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AOqfCUf7yLFwIfnj5brTUWDumtDXd+nH9QlX4rQ0iGE9+11qaGnEBp5dfHRHfjO32
         aBcnWaGdSBdUaIJbBTN+NVlcs29bfVJx9bZH/qD1VHGmFP37vRLWLy5sH9LyCgTrTC
         HVBcc1/XBxBl/En/IFGZxjAo/jvof8AQcq7muiF49yBOPh4ACv+UoTSYtAcvsrYLsv
         xw/IjhZznRIY/cA1ecbc9P7eyS4w+NLmU97gmiBuxSvJfmPOXLHi5r+zKoQPY9CQXl
         kAiQc+kfmQQyHFY3DHfYToyr/8CLrbSkEZwdHaRxioM8S+oVpOQIJ5NxD4qyimkzXm
         ocTtn0FJky02Q==
Received: by mail-ed1-f47.google.com with SMTP id b24so21786722edu.10;
        Tue, 29 Mar 2022 12:11:04 -0700 (PDT)
X-Gm-Message-State: AOAM533ypBUei2Sib0mS6x9NJNklSRuELPGCZs+4MmTrZfPhSCpwd+NB
        +s2iydj8UiJ3ppWamzfYj7FV3AgAIXW9cCQHqQ==
X-Google-Smtp-Source: ABdhPJz2EcwfbpLLNfbPV4lpc6oRX1DfGgrw/zODvGbU5XGzz47/sV8C7BZQxzV2+8hYQITbC12p1Ms7BrmdH7NXLW4=
X-Received: by 2002:a05:6402:2711:b0:419:5a50:75ef with SMTP id
 y17-20020a056402271100b004195a5075efmr6622477edd.280.1648581062773; Tue, 29
 Mar 2022 12:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-3-tinghan.shen@mediatek.com> <d720a5e9-d078-6c60-f55b-0506c4b4e1fa@collabora.com>
In-Reply-To: <d720a5e9-d078-6c60-f55b-0506c4b4e1fa@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 29 Mar 2022 14:10:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLrgW4GwSZ20x5Gsu-umjtw4x8k=uHeZk9T2+A3K6UT0Q@mail.gmail.com>
Message-ID: <CAL_JsqLrgW4GwSZ20x5Gsu-umjtw4x8k=uHeZk9T2+A3K6UT0Q@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] dt-bindings: mmc: mtk-sd: increase reg maxItems
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 7:43 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/03/22 13:45, Tinghan Shen ha scritto:
> > Add optional host top register base for the reg binding description.
> >
> > Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 7032f7adf3ca..6d41bcec900f 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -40,7 +40,8 @@ properties:
> >             - const: mediatek,mt8183-mmc
> >
> >     reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
>
> it's just maxItems... adding minItems: 1 is not required.

If 1 entry is still valid, then minItems is required. If not, then
it's an ABI break.

Rob
