Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9057FA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiGYH2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGYH2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:28:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C991DFEA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:28:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31e45527da5so100146177b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7epkIx7Bo7OZyKYOv+XZev2GSnfQLkdGLGiZ0LxZ8c=;
        b=WLJPSC4TMjyg8I8soxTZ5c/HaieMRu0ilw/tYRRT3dW0234hNQCaBNsAMTmimcGDym
         gVcVywpiMWRY/hrWOgk+A1jqyaQK58ADdH6mp8Tdc8eGMhccWCQCpwhj7GoeV3boF7Ka
         8ZkuOxODo52fwq1YDMMA0VNVW2Wh//+YXV39E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7epkIx7Bo7OZyKYOv+XZev2GSnfQLkdGLGiZ0LxZ8c=;
        b=aegR+VhYJSlCYQlxxbjBH5DbrFvFgjyCK9xk6x9VOIVGrJjbemQWxlEfUfadfQ8NkH
         1RhUfSvqARTONQUxV96vmMoBOPahKUWM8N1ZcW/EbcfZojU3y74w4gpPTbCXA2TTsWSi
         hBztWIYrIRWMzz0N2nf2gyH5r+DY7clkeQdfItRIiuOiL3oOSomAlZB0chYBWkz9fTy9
         LIjKQ6tLNHdoTbdxPRsbokXlZEP/sNPLlX6bMWp/yKko/L5eUWDwT72M+BlGrcOzmX/g
         rlgAVK1Jfk1BuUHDf3O4CZTm30YnL8qNhg7A7KAwnuFSkJafQmy+HcRDcH5WjYy3Bd0b
         wDnQ==
X-Gm-Message-State: AJIora8WvbJ3aPXup9AIP7eIRmNhW3LG4WsW46RLYhllzDuiMcsry3HP
        X9vyPSzKJ/kIsjbHFpFiZh/1GgO83FCQc4J5TJ0XBA==
X-Google-Smtp-Source: AGRyM1sofK+ZbAm2wHz6/PMlObpSJxFDTP5gSmhP92Rp/Kt616QZhHpvv/6xAWxzGOgw9UhR8Behll/ww824d2IHfE0=
X-Received: by 2002:a81:816:0:b0:31e:acde:8726 with SMTP id
 22-20020a810816000000b0031eacde8726mr8600976ywi.195.1658734083888; Mon, 25
 Jul 2022 00:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com> <20220721145017.918102-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721145017.918102-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 15:27:53 +0800
Message-ID: <CAGXv+5E5+i3eG-04JAqN4wGmSd276FFE5KRDK5hUv+wK5vJT4Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] arm64: dts: mediatek: cherry: Enable Elantech
 eKTH3000 i2c trackpad
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:52 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The Cherry platform uses an Elantech touchpad/trackpad: enable
> probing it at address 0x15 on I2C1.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
