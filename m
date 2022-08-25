Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFA5A1132
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbiHYMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbiHYMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:54:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29214B28
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:54:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z8so5358344edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eTyJ5ysyBJphDxI681uzkkLxuflLaDMmY8laThwgM3s=;
        b=ZZjLAnzUFfkR+G4v+IgfNQyxujKrroHVtRt6sLDmiBVTQl1pPP39LVWYfE+C14b7jy
         drFFGtc6MLy9HT+qhNoOGpDmgp9Nboo9hsk8n/VBZknHf0aWOQQyO3nzK40UoyCG0HzW
         fXNWZFVaOMNNvtkDmAdm9sA4YcRvMnM9SQnlAFfOo7DkBCBOSHh9X5DDisnwDiJP5v1w
         3G2pmpLNsi239BmZHC5GmDihLNEHiBKMXvDnQlNHcRwVVh7BQdClm3jrRWHJhv5h6f0e
         2nDWc2tbxe/8Dv5Tl/zjy2f33JnCJOxHzk2QC53ZDPcp/U36ngjXCxslQJEmi8JYCPPI
         ow9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eTyJ5ysyBJphDxI681uzkkLxuflLaDMmY8laThwgM3s=;
        b=QOIo200TRuF8BkrJfVo8s/8XrMozyqsoxwGlD52A6mhIBSxjZrBkOyEvuXtAvFNoNv
         X0v8Mm6iLBdQ5tpaL76chMt4YCfELoL1Yb8bhyD3biJjtkmwg4m+TjfKXp8hjDgtv+Cw
         yF3S/xEjO3+EEDzglV39XkV9e76TO+qCx26gxw5YRPTVRzegE+2ZqzLhTg4VIRMs/2Y3
         g8i09WsrkXROeurEuYXktiJ714VIwI/tHY10lqfAi/4s8Rgd/W0+NsyPcLbVqIODj7oi
         Qm989Y3KhlXta1I7vU3LCfvRV5cwOu27xA4aO6YBYPnmd+M1qfFz7HovNt+IyoS6S9eU
         xzzQ==
X-Gm-Message-State: ACgBeo1YLLnBKIJHXFdvAxVutU1R2RnlCQZu6unaHfwttcx69cbr6yOq
        ea4kmoIcEE/ct6sKRa/7G3M3pS7UFBQ7KtMG3Ju+fQ==
X-Google-Smtp-Source: AA6agR5gBoA+DyRoVe1dyTC0LYezrrsqDvXPMxIYYWdtzgEXrzgLMkOxOeINwsG5S/OWaW8sXg9+wvi2winSXMVBq2c=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr3117148edc.126.1661432083303; Thu, 25
 Aug 2022 05:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220818075012.20880-1-hui.liu@mediatek.com>
In-Reply-To: <20220818075012.20880-1-hui.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 14:54:32 +0200
Message-ID: <CACRpkdbGjbd9Q9Chcnnc=3nD3XALsCdk7dz9mT3BfJdZs62xjA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] MediaTek pinctrl patch on mt8188
To:     Hui Liu <hui.liu@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        wenst@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jianguo.zhang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 9:50 AM Hui Liu <hui.liu@mediatek.com> wrote:

> Changes in patch v6:
> 1.Update driver file's coding style.

No further comments on this version so patch applied. If Sean
has further comments they can be addressed in-tree.

Nicolas: thanks for helping out with review!

Yours,
Linus Walleij
