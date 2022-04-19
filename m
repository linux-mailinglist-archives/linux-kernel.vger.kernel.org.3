Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4469F507BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbiDSVSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357934AbiDSVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:18:08 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D9AE7E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:15:24 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf4b91212so186784857b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bOCs7bEkMlCU55rgehqm/ct2scIWY/qXcB9Xu0/dpE8=;
        b=a1axMsNeO7mFl02JraXPiyLN/63tZlUj4XEXh/1CG6XkrIAezaf7iBU9QKG4hkCErY
         aEr4uvTAiD3Rt3vDMQfP3i/b8XDDanKX74ykjXZo+GnFDOS2CZH0drTPyqIGkWT35+Yr
         UREgvW73HeKNaB8aoW5EBdgfJVRxbP5LCYs/FEkl/lI49OZn6pQAoYYljOTf8N5rXOZV
         7WKheKCohzx5N2LpDrJwyP6xUOoatVjgrnh03VItZlUqrXOqi/pbnP8qgpF9skKMqxPJ
         EBZUbkrwqZwKXy2R0X7Xx1m+0RyoKS3ep9RFtJD5uirgN76KvRUn+FsGr9AUubGp/cu9
         AbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bOCs7bEkMlCU55rgehqm/ct2scIWY/qXcB9Xu0/dpE8=;
        b=n4I9RTmPPTNg3aiBHskr4I99dNUa9pKe22CIrpTC5fpFYC6C3Weq2wDmu0wQplhG2e
         Ref2dLBjAXO/hOLgc1CdeYEvn7tVNpuNqA6XpK+XWKecI6LpBUP3SnheihhSpsEPNpfp
         LuyxGsiH7h3PhU0qpE3kUPr0GHgBhji3YGd46UXFl6qziPuo26y5TFKbEhYlDRHKiPkU
         EpLXx6i3+XxptXeTmztFjLuPyU9dzJ5D9lcz4VwvVZBwv2UpX/2leQwdFmC6MYtknXSS
         AZUeaLlU+VP6fvFDF/IAdN+l3b44CRu5oOyyupTW7yrdXp1vJ575+ueO/692L7xn7Utd
         Ga8g==
X-Gm-Message-State: AOAM533xdkE7fQ52RJxuVho42DjIvgPE3Asvj/7Rds5uqpCu520RvPv8
        cPdp+xgFhoUfWDGiYb5ySMtSKBWfgB6n8aiE+jZKVA==
X-Google-Smtp-Source: ABdhPJyA/B/8ozJTOa4FYCgN2HReHc/Scq8Wo6z6yHWfCrTkAc6WTAwjAyoG3E8aJQiE7sq+YIEG84NwzJ5InDW+ukg=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr19141326ywh.140.1650402923618; Tue, 19
 Apr 2022 14:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220315211936.442708-1-nfraprado@collabora.com> <20220315211936.442708-5-nfraprado@collabora.com>
In-Reply-To: <20220315211936.442708-5-nfraprado@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:15:12 +0200
Message-ID: <CACRpkdYSJFYMnUVLUy-weaiOU=93HEygw-uLUjP8Ovc6Uq1HNw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] dt-bindings: pinctrl: mt8192: Add gpio-line-names property
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:20 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:

> Add the gpio-line-names optional property to the pinctrl-mt8192 binding
> to prevent dt_binding_check warnings when it is present in the pinctrl
> node in the Devicetree.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Patch applied!

Yours,
Linus Walleij
