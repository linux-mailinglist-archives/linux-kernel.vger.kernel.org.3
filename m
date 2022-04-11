Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09194FC0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348013AbiDKP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348001AbiDKP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:28:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566D53D1CE;
        Mon, 11 Apr 2022 08:26:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v2so9879344wrv.6;
        Mon, 11 Apr 2022 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWQkTK3rSopa+8qydH4cKynBwojuwyz5cLnIhJAViHI=;
        b=GRiTgBcRca6sECMacftvFpl+a0/eMYsWuTLi5kdaEw2MYVFiv/5dqE79gmrDQKHwDj
         58ekxBYj4TauMYafu44BJOZgNuo5mVwdSkSMSFyCSsU9Wyu4SyXWHtCuKcLVFp16FKB7
         D5cMqscqt2nHnXo77ZDFytCC9+fnpBpa90B5BGXEMhClQ+syz3b3P80bRbCdW8D8Di5t
         YeotdxshhBo7GP4D1bzzUNA4IAYPTAO/RXFm8cL+eFsn/008Q/KWXMeqpm0f7y593NM+
         CNhQsNbee7+21aSpHWz/ycVM3JETUX09vnxZvEQqsI/4zpebhFsy1qu3ecPyfS3NI9C8
         DqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWQkTK3rSopa+8qydH4cKynBwojuwyz5cLnIhJAViHI=;
        b=HiGsVafaDCAladdQIpg6pGMhDwcZ04OLTr/oBbB7o+1/dFuhIryv7rat4n0EfyLwrC
         q42ylD28G2pOeIXARWvMHjskf54pTk8KCnDAxn3uh24HI0f/b4+8gcsj5hxSuUYgdKuw
         Vp/nlJ1oo8XtIHFROWCJRpAE67Za+fKycA7BsauZQ/fUgt8Mrazh1BggrukJ0CAfEXvH
         rHn9wXLv0XALuD0h1dHZ+X53jARZDfou/+9VJQuJ/tSIV7fUxfK7aYA7qqNhxwXc0loR
         0g48xuJ/he/CVDi2UJteGGJOfzYjEnLxcZih/cLcdnBdXwhxNxahA9gM9cB1s9sMnRDw
         PwwQ==
X-Gm-Message-State: AOAM531mt9iPwiWerhv17O2i0O1t7Fn707kOZZ9UjY0yMxJCySS81PIy
        ZTab/AYcWV2CV6hNEtx6xAg=
X-Google-Smtp-Source: ABdhPJwKM1YG/JgnOOVdHFFtRjVMNl3v2yETrecwEBgXJy9DyzKjATELxoXpvLb+SDzu5iGVkC3UJA==
X-Received: by 2002:a5d:588b:0:b0:204:1c1a:965d with SMTP id n11-20020a5d588b000000b002041c1a965dmr25246909wrf.669.1649690781695;
        Mon, 11 Apr 2022 08:26:21 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000184800b002040e925afasm31421816wri.59.2022.04.11.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:26:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: clock: Add compatible for D1 DE2 clocks
Date:   Mon, 11 Apr 2022 17:26:19 +0200
Message-ID: <1811990.tdWV9SEqCh@kista>
In-Reply-To: <20220411044002.37579-1-samuel@sholland.org>
References: <20220411044002.37579-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 11. april 2022 ob 06:40:01 CEST je Samuel Holland napisal(a):
> Allwinner D1 contains a display engine 2.0. Its clock controller
> matches the layout of the H5 DE2 clocks (2 mixers, no rotation engine,
> and separate resets), so use that compatible as a fallback.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  .../bindings/clock/allwinner,sun8i-a83t-de2-clk.yaml           | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun8i-a83t-
de2-clk.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun8i-a83t-
de2-clk.yaml
> index e79eeac5f086..17caf78f0ccf 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun8i-a83t-de2-
clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun8i-a83t-de2-
clk.yaml
> @@ -28,6 +28,9 @@ properties:
>        - items:
>            - const: allwinner,sun8i-r40-de2-clk
>            - const: allwinner,sun8i-h3-de2-clk
> +      - items:
> +          - const: allwinner,sun20i-d1-de2-clk
> +          - const: allwinner,sun50i-h5-de2-clk
>  
>    reg:
>      maxItems: 1
> -- 
> 2.35.1
> 
> 


