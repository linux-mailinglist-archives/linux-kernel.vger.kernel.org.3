Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C44D917B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiCOA3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiCOA2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:28:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C7A41324
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:27:05 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id o5so5338014ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6zq46rHunNi7v3K49xKmXhCI5sJtyCz6o2pZoTkjlQ=;
        b=oBVypg+q31LLjPraa0FmLk8b8a/IQ+bLc4AdFUpwXa97vWDI/VwwPNA4ZMvUcIfQMk
         VGMIIWcbjJBUpBG4KCnuasIOpbM/EjA/z6G4OW5lxUodjSiL2OCz0tdO9gZIkRvqfJ8d
         ekLNpaWYEixyNMI/A+xW2xORsYFvSS4DqUPIc0ALOAVUgF3Aq7LcJhvDb7Q3by5kUKD+
         /Ixvipr0jScwivBHQSbgkbhu3rjyJX0OdOynvGGWdHAb1L+SGiqPgUt4ECfzInKhOwAo
         EJ3nPikmUrD7xaACVJwmTlhvRJ1kV+JYG2c5XEiLOeWnKY2OvjMd7DCjW4hfzZnHLHoD
         Jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6zq46rHunNi7v3K49xKmXhCI5sJtyCz6o2pZoTkjlQ=;
        b=wY9KVfbnWR2nMNpQemn2DHQSNznj/TXIKBd7OAV1/gA49VhjMLFL94LwM7WN+dnOL+
         kfd8ifSa4mdTxYnMZCgZG8dbuZR4uYOddEkXD1V2Of/L5TWS+SVO25APq65wfnZypofP
         yDRNuWmFQ5zx15vnWofBOIRsCb7L7ZmNcxgF1F88z0aR7D55dvStcowfN11cS9xTL5H9
         ZH7yyn08ao2WFS7gXfNn5lWr/rtEXqwvrdjwsOfD9CKNTJVQdttwW75NMn2db3Ois+qY
         6ThwnWkXD3G6zVTFuNsYIoA/HadsxHNlmETOmHYZ34RM250Nqq//3VmsscSNyt/i9VVE
         VKPA==
X-Gm-Message-State: AOAM531m9GZSFwRKLrchCSMQMG/L0AO1afkK987KhjRQkuXVcQ6vtJRM
        JnoomJT4OD8MmP4khRmZxe4LlUkVVhTSfgbPcWBTyw==
X-Google-Smtp-Source: ABdhPJzhNSBMeH8Wbm5RieTMFPizoex0ebgYgfTJfbTlzcSn/yt9wuadfyo1A6KVLbJC4/hoy217PiYiNj5qfdUXwpY=
X-Received: by 2002:a25:e710:0:b0:633:67d3:7264 with SMTP id
 e16-20020a25e710000000b0063367d37264mr3458356ybh.291.1647304024460; Mon, 14
 Mar 2022 17:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220216113131.13145-1-tinghan.shen@mediatek.com> <20220216113131.13145-3-tinghan.shen@mediatek.com>
In-Reply-To: <20220216113131.13145-3-tinghan.shen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:26:53 +0100
Message-ID: <CACRpkdYP0RTfPDW3JSjpKHuOkGyVMG1Y0XAOidcespz+qN_7Hg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:31 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:

> Extend driving support for I2C pins on SoC mt8195.
> This property is already documented in mediatek,mt8183-pinctrl.yaml.
>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This patch applied to the pinctrl tree for v5.18!

Yours,
Linus Walleij
