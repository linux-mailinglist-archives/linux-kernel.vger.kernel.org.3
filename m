Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7D53DE62
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347761AbiFEV0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbiFEV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:26:01 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5D4D24D;
        Sun,  5 Jun 2022 14:26:00 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id 68so1287669qkk.9;
        Sun, 05 Jun 2022 14:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UK9ijdy96x8DCtDL8y2FIG0/CEGyl91Wy+VkB6R2So=;
        b=xwybu9uHDMp3touf1aI1AS0AbpgJmUaZHl9gNxZe29g5OAPRKpbiyzq0QsSAJO3Yq9
         YDXVaITlusxEmcZmpoigvApIY1wRbmwnpUt/RvnMm5cPxHXLU42hnyBfn5RvhQggnMNi
         KjXulKFhO7Vs9w3zg27nny+g8zBkKun1G/X8tkL7QhZCivGMYMdEQPJUsCr9gY9tkDYF
         DyXnTrwOJd2sFFHsH3rBq6VCH+kEwWNOFwAtcAh7ZcOyv2BAjt08gqPsLmXAmtPjE0LM
         QYeTXozg4oMLg+JycF2qDAYUySXokWvOidHLTVlWhuNpJcJc7iEK9VhD8iI7HshlMDmd
         gmoA==
X-Gm-Message-State: AOAM531/PYiAGZ2UJMXA6PoSSrxJrJU+KQGYhakq94TtWFW2ju2BhYgM
        0Bn+314jAs4pfPcCd6h9lg==
X-Google-Smtp-Source: ABdhPJyEop9w4xBaCYIjf/DVQB28Y/OqN0tkJGt+4cQZQiepHy5gy4KhZBhLpI9CNR+b7AQev6vAyg==
X-Received: by 2002:a37:e202:0:b0:6a6:ab87:113d with SMTP id g2-20020a37e202000000b006a6ab87113dmr6241549qki.605.1654464359603;
        Sun, 05 Jun 2022 14:25:59 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006a6c230f5e0sm388127qkn.31.2022.06.05.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:25:59 -0700 (PDT)
Received: (nullmailer pid 3545686 invoked by uid 1000);
        Sun, 05 Jun 2022 21:25:56 -0000
Date:   Sun, 5 Jun 2022 16:25:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 3/3] dt-bindings: pinctrl: sunxi: Disallow the resets
 property
Message-ID: <20220605212556.GA3545625-robh@kernel.org>
References: <20220531053623.43851-1-samuel@sholland.org>
 <20220531053623.43851-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531053623.43851-4-samuel@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 00:36:23 -0500, Samuel Holland wrote:
> None of the sunxi pin controllers have a module reset line. This is
> confirmed by documentation (A80) as well as experimentation (A33).
> 
> Since the property is not applicable to any variant of the hardware,
> let's remove it from the binding.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml          | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
