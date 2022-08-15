Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A511A5938D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiHOSyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiHOSvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:51:37 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F546DA9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:29:26 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bb16so9392327oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kKQFgWHEbY+p2ZFCCe57naXRy0LRcwbgkfnnHiuAaKI=;
        b=dXTeuhXE2fMa8lJrfwZYFIdaVIzgrPygmU0f1QQ0c5f8eDvL0TaRVpZkemuok3gkSV
         cByWuo3hoGYzk92+fWoo8RZAX4Kkx7J5UOerAAZd2iROc3GuDEiDLWwNL/0QcDfJmEd6
         MCkjP9g7ZjL6DmyA3R7NGbIZt7bH/+Z6G67LsDWhqqhRhDYjUj7hDY5gFZBw29oB+Dwr
         IC+bUkyLsAai3ke2ZbDWnyljOK7N7c59WY/CJQWwuHoDNVXdG8Zv8ehjVpG6nqyUY5+g
         M8S/WJTHFFb5qxzxVa5GkHPgKR3IDAELKrBwlF03airGtJYG/xyZxuj5tMZ6NycqnZLk
         8dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kKQFgWHEbY+p2ZFCCe57naXRy0LRcwbgkfnnHiuAaKI=;
        b=1nn0YTQmtyBwjcykdku6Tu7qUTEJU+LhDlXGn0odXafNbjycqTO38gv5DIr0ERh82e
         ff2RIL/fnuPBpTOqdhXvx6hmPAhExele5iCl59i+ITfkbwAQw8VhbAbsDSWuLvBDG2Ty
         nUAweKFA6BzTmIKtZQPq9+3K1qy1hKBtMgMDZBBBJ7K2nN9X1euPdb1vVmd9pZi0f/pC
         Y06/OCKRHaefsYPRNVMIL57WFX7GeCtb0Jn0QS13mPvv9IWHOlIP/jTx7fxmP7ZZXQcu
         F+iDaFKT+zM4XP0/o2uqTC2sTf/7hYgxznaDqA2RJG0Oee49r1YkGsKy7noZdHPASpmA
         K5CQ==
X-Gm-Message-State: ACgBeo3DGLMS+RuIzr00pmXVUPhcU7Dsi8xz3u//Hx5Dbf2KMklFv4vd
        Qj655dmGR44YFl1lwkLCmD1+VBvXeQ8kXptjYR6UNQ==
X-Google-Smtp-Source: AA6agR6mHgLUwhhSGDDVkPAeBPIKfkAX3M0vhyj+SC2VMmz19Px/LCYhJDzW/ocV6X5KfhKTBwhnrixkhl4hvuHusSw=
X-Received: by 2002:aca:5e89:0:b0:344:80ab:1351 with SMTP id
 s131-20020aca5e89000000b0034480ab1351mr4591083oib.105.1660588165502; Mon, 15
 Aug 2022 11:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220811204024.182453-1-mail@conchuod.ie>
In-Reply-To: <20220811204024.182453-1-mail@conchuod.ie>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:28:28 +0200
Message-ID: <CAPDyKFrefLiR=QtuRuCdXgo1Y=vuwF6ok=kVK0hYgzVtaGHrSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: remove Piotr Sroka as a maintainer
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
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

On Thu, 11 Aug 2022 at 22:41, Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Mails to Piotr bounce with a :550 5.1.1 User Unknown and the last
> mention of him on lore is the orphaning of Cadence NFC drivers.
> Remove him from the binding too.
>
> Link: https://lore.kernel.org/all/20200510122430.19105-1-miquel.raynal@bootlin.com/

This link doesn't work, so I decided to simply drop it.

> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 99f89eb19356..7124e77617c9 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -8,7 +8,6 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> -  - Piotr Sroka <piotrs@cadence.com>
>
>  allOf:
>    - $ref: mmc-controller.yaml
> --
> 2.37.1
>
