Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0E4FE68F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357976AbiDLRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350498AbiDLRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:10:38 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F9614037;
        Tue, 12 Apr 2022 10:08:20 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r8so19668472oib.5;
        Tue, 12 Apr 2022 10:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ncYZG5WZb4xBrOPr/eInboRfbbDNW68lt8cRNT2hsk=;
        b=uJAKHYcA02jQiMHU0l6fx8dGUzedJS8wsNMoQnoRCMb85uZGCsdK5bsxtb05xwcc6n
         Z4RBB9CkyQyQ+Fo5Ti7AQBZJQIw3R+3eTkLTptReWVF0XqVD4W6gi0Bo2OcNLfmAPKKh
         jMrysdyxhFNEnTC3o+zt+oLYxW7RzQvLZL9gYnwCJyTKeIyWt0mK0Ou4koqasrmMrgpv
         Z1HW0mPxq/Lib02LBj1D7uVUI//nYcGXJ/fHbTcv1QzHPXtp3CgQ9ueJC6rlAQyzU6Jt
         6vo1abG2JztXMlSw6d18Zb9vFp03fFM2F7yBXjbwzAiAX712V9wTBijTgUpWjB6tY4E6
         8QFw==
X-Gm-Message-State: AOAM530S1rxLLsbG2pKtrGDMBYcaWoIqvZVq/PcyQtBhOSFbvNqYbEHw
        uT99SXUroZ3e2a6Tss15HA==
X-Google-Smtp-Source: ABdhPJxrB37u8Aq8wyh7LZk3laglHfhYexiAKjReaVXTY1ffpS6Zhknewp/6/5OyHiDfXMZIUfYenw==
X-Received: by 2002:a54:4010:0:b0:2ec:f4e0:8acb with SMTP id x16-20020a544010000000b002ecf4e08acbmr2209538oie.97.1649783299883;
        Tue, 12 Apr 2022 10:08:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c19-20020a9d7853000000b005cdbc0f02ccsm13743143otm.68.2022.04.12.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:08:19 -0700 (PDT)
Received: (nullmailer pid 472113 invoked by uid 1000);
        Tue, 12 Apr 2022 17:08:18 -0000
Date:   Tue, 12 Apr 2022 12:08:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] dt-bindings: power: renesas,rcar-sysc: correct typo in
 path
Message-ID: <YlWyAgVZ6FylBvDq@robh.at.kernel.org>
References: <20220411095317.221317-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411095317.221317-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 11 Apr 2022 11:53:17 +0200, Krzysztof Kozlowski wrote:
> Fix typo '.' -> '/' in the path to headers.
> 
> Fixes: 981a34054038 ("dt-bindings: power: renesas,rcar-sysc: drop useless consumer example")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
