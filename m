Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106E54F99CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiDHPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbiDHPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:47:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BE6A7767
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:45:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s137so5380640pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8LQvS2IDMfT7AfI5L149G2Y2gHx1++a+D0M/c9N+Is=;
        b=jznrHDdMq++SsQ5Wb+PA2dZALsOj7yD63+KADfRkGG5Z9X+lpkEm6E3Ls5iDVBPHBJ
         LcyIyvhh4O33WKepwf6h9Ut/2U5fJF54KNWkgaVEc3SN2ZYdwTlI6ak1hW2eo2t0atSC
         fec4tseUvM4dwaaI5Zx5hhKd4Nf8yZ4oV3ePJKuOjWt6NqTDslMmRj7/7DAJsOGclEuU
         kTC+J2olbcaQaHlyQsHTZmD3nnV/KnlV8kCBM1riYh3NSeVxjK9higmyL166sslzKwOq
         UtEraPYXaIpCkoclm4Z2HZiGCKeoGcZseHE1UdCyzUphRp3nIC4IAOUUoKzYt78SoVm3
         502A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8LQvS2IDMfT7AfI5L149G2Y2gHx1++a+D0M/c9N+Is=;
        b=2eWPzMTNbeZQIOZqCnYp8T094uNoM0ihYpBP7HzsGBJL3LoVDPKe6JJRJE0AlaR+Ff
         T+XpVlhYUwJbXBqUNtEM5cW94M5KZyamOK8MQo0jzQ2PZOsF56xUF2ve6VmmgFhoSzde
         8gR/52G9cjNx4E8dj7Sbu2x4bPoyweIqcWHPkpqLIisfVHPw1kjkO1wMEwLE5fry/JsD
         6VIfLN3Ne0nHep60wVCsaaXv23CGOI0UQXCXPVr21HBf3Wz7ynmoiXXba2RACKuEFNDY
         Pu4TrwcjQhSmyqE1ZsJ6oo4ka8f86WYT36oUR+uGq28T2DSj3WB3s0+Yhu7ZAu8ChxU4
         A0nQ==
X-Gm-Message-State: AOAM531pXQtUvVYWMlvNzsDlg8e0/vCdSRZtaZh3/whk9Otkgh+ZLhfg
        FFavgA6+TwpBkpTvw3b8WqUT59RqCOy3+xjNVT3+lQ==
X-Google-Smtp-Source: ABdhPJzR3j6x8l8Za7nDxMHGog4JAum2Pcwl1K2K+XdW/8m5ix4E6SP4xJ2g8UpSJJ3li88c+xaDKR0I/gdUgQugdkM=
X-Received: by 2002:a05:6a00:14ca:b0:4fb:5d3e:5f77 with SMTP id
 w10-20020a056a0014ca00b004fb5d3e5f77mr20239165pfu.34.1649432751151; Fri, 08
 Apr 2022 08:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210411.8167-1-tharvey@gateworks.com> <41bee12f-fa23-16d6-7244-1c4c543cbea0@linaro.org>
In-Reply-To: <41bee12f-fa23-16d6-7244-1c4c543cbea0@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 8 Apr 2022 08:45:39 -0700
Message-ID: <CAJ+vNU2BybB6dqo4GWTGT7Bv+Qi1Ph3t3+vxJPxDrttHrs9O=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Plus Gateworks GW74xx board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:07 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 23:04, Tim Harvey wrote:
> > Add DT compatible string for i.MX8M Plus based Gateworks GW74xx board.
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
> > index 08bdd30e511c..c04203d537d0 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -860,6 +860,7 @@ properties:
> >          items:
> >            - enum:
> >                - fsl,imx8mp-evk            # i.MX8MP EVK Board
> > +              - gw,imx8mp-gw74xx          # i.MX8MP Gateworks Board
>
> gateworks
> You are using a deprecated vendor prefix.
>

Krzysztof,

Ok - did not realize this got deprecated. Will change to gateworks,imx8mp-gw74xx

Best Regards,

Tim
