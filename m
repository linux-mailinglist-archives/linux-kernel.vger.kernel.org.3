Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051834C8E45
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiCAOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiCAOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:52:53 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499596808;
        Tue,  1 Mar 2022 06:52:12 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d07c4a0d06so146778967b3.13;
        Tue, 01 Mar 2022 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6Qg573gQNt9jfmniDqk9TUY0R6tRZETMQPLMgu5ja0=;
        b=MVzYKmbx2t7YMZV9Xu+2eR04C5rESan7pI1k2NW1iYgltGe4Mb7IYmeBqg2gA+t6MG
         19DmTPhph79iYaEvmXnUGkuQOiv3Q80nP5y4TZZ1Ok2g1V+Zvyj/WwRldjuPZWv4INRi
         GmfapsiSFKSnJ9UKK0+QxdmRLrzOuilB+dRkm7orz8EKBJ3FLi8f2hgUfu63BTWEbxAM
         Gw1PfN9U3QqKRA5svNldODCwyLCWCAzyB9ORWAAw76IPRNZkrhe28RVRSDoVsJJYEA3l
         Ugp9K89fWodTQTziL8XmaWk0Yv4gfZeG9DDTZbnlzCoeZcOYbpkI7jQ6bi/9u5P6IwSP
         JOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6Qg573gQNt9jfmniDqk9TUY0R6tRZETMQPLMgu5ja0=;
        b=Qsnua7bwtLBYVjFGa4bOCj1QykROn1soaoYma+QVWIIOBVE82PHLVkpfXJ49dZ2xx7
         9NVGKavpbux3zPZrj1EAxN6Drw6gJ43ofQxNRtXmvZCkre5IgEK6ppC3SVA1aSbfx+dA
         VSBpGwR1SdWW4xZjfEhq52wTRZv3DA2Kq3e3/Zgmh5LUETu/3AygkNUP2seXcXAwDu9e
         7LbQo8/6LWIEinCKiZU/gZgzGhemEN57T8FJ+cu+x90sNAN3ytKMioW2dpL9GTKQlpQS
         MxbtWVdH7zmgF7rh2plnr0gXagBKHHBhBgDFHLEGGNgt9SzdshLJoHznYBgu5T5BPW+K
         lIOA==
X-Gm-Message-State: AOAM5335rMxRRbpwQd04qjBZL0oCgXirPTYxytQ98ONQN2KSFR0Wimcc
        OcuNL7RHnDdp43tImY3ltR89a59syBgdcjn3lEc=
X-Google-Smtp-Source: ABdhPJyysLGtnRH92oZtE9p17EhgqGO4pnLHjiquEF3VshCrVWSWx0aniFMT/paLW5OieVagmvOftjmUzRGi1FAxI8c=
X-Received: by 2002:a05:690c:89:b0:2d7:fb7d:db7 with SMTP id
 be9-20020a05690c008900b002d7fb7d0db7mr27255346ywb.219.1646146331471; Tue, 01
 Mar 2022 06:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20220228135700.1089526-1-pgwipeout@gmail.com> <20220228135700.1089526-2-pgwipeout@gmail.com>
In-Reply-To: <20220228135700.1089526-2-pgwipeout@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 1 Mar 2022 09:52:00 -0500
Message-ID: <CAMdYzYqs=iRY6uNzVSkHrrhPYFixXdbZjtwSpPOjf-6f8TXutw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: grf: fix rk3568 usb definitions
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vinod Koul <vkoul@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Good Morning,

Would it be possible to pull this patch individually, to fix the
current error reported by Rob?

Thanks,
Peter

On Mon, Feb 28, 2022 at 8:57 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> The rockchip,rk3568-pipe-grf and rockchip,rk3568-pipe-phy-grf
> compatibles were incorrectly assigned to the syscon, simple-mfd
> enumeration, vice only the syscon enumeration.
> This leads a dtbs_check failure.
>
> Move these to the syscon enumeration.
>
> Fixes: b3df807e1fb0 ("dt-bindings: soc: grf: add naneng combo phy register compatible")
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 072318fcd57b..5079e9d24af6 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -15,6 +15,8 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3288-sgrf
> +              - rockchip,rk3568-pipe-grf
> +              - rockchip,rk3568-pipe-phy-grf
>                - rockchip,rk3568-usb2phy-grf
>                - rockchip,rv1108-usbgrf
>            - const: syscon
> @@ -39,8 +41,6 @@ properties:
>                - rockchip,rk3399-grf
>                - rockchip,rk3399-pmugrf
>                - rockchip,rk3568-grf
> -              - rockchip,rk3568-pipe-grf
> -              - rockchip,rk3568-pipe-phy-grf
>                - rockchip,rk3568-pmugrf
>                - rockchip,rv1108-grf
>                - rockchip,rv1108-pmugrf
> --
> 2.25.1
>
