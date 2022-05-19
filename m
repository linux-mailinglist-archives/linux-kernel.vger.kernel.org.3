Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B552D3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiESNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiESNNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:13:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F3AEE24
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:13:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q135so8949812ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pU36f99eaZPxWc0unxPX9BsTsHo3kBMFnigWJpZIqUk=;
        b=NkuSkM4NnbBU4jIXuNzuDcd7T3EznqprgLSY+0J5GlXq39Kk/bVSP2ZVAEVvwGrui2
         DWUDMGpDhK45ebpEZjbwyxZCpJ6XPoMR2m8bdehall8m/mNmGrMaHTDV4r5lrvX4KhC3
         Szvu3aRZptzycSbdxytyx8zvTOfVLF5U40bgGBUvLv5YDO80Cbaw2EgPT7GG84ybLcFQ
         VK6n8/IGKs7sF47Ctc6cgtp7FbgE097cQFfmAvwe9Ao/egbTPxoPRzsyIcpPwZc0bJUX
         YyEi2MzopnelF92IZeXztApu885ZF4fBJty99yI94ZXpkdRsbxd/oc66q65lVBwMLd+h
         t+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pU36f99eaZPxWc0unxPX9BsTsHo3kBMFnigWJpZIqUk=;
        b=JMHtHQOvCnHlcqD4+VPTy+uYsx84I/Q1zJ2EHNqkzGDZqg1WkIIPudyaBXBRDkPNkv
         I0o4XMGvlTH7fivdJod9LZ7Wc06kI6keg1sMQ9MJKL/QuzHV3ndz1bCLCSS6hE6FWxUz
         SUiit4ykLSvao/wiuH4+mydQSYm/CrdP9eE7tg6FH4CjW6z8Wvoda7ZKnT26xYMTg7BO
         HL6Ojq3CGLKxumFM6agn1tkuzQoO74y7DT8w4xyVPN56W5RB2VqDRD1hB06rkuAIFVqO
         0mCYtWr/gpvpihJmHSQ6uKKShlCweQxMi77S8ObGDpqWW2YEXdXG/uJkYSpj89bvh5U7
         AzIA==
X-Gm-Message-State: AOAM530G3uHzJWVo16EGxXckkU8xxN0WaJpuT8YVT8O5WOqDJVjqewO7
        b36KWNNmYFMHTGidDiknV3wUeP5jwejymVhK3X941w==
X-Google-Smtp-Source: ABdhPJyJIP7Hag/4KdBY4u76XwIRxLNZPBE8+9JcpJlpRiGV0RoIBhT0aDk8kici5QeY4pJPkV2i1OGCVw41LmNy610=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr4392907ybt.626.1652966022951; Thu, 19
 May 2022 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220517083957.11816-1-angelogioacchino.delregno@collabora.com> <20220517083957.11816-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220517083957.11816-2-angelogioacchino.delregno@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 May 2022 15:13:31 +0200
Message-ID: <CACRpkdaj42rcQdX1+dVWyHmexrq4UDQHB0JLHgfREY9kn0zv2A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
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

On Tue, May 17, 2022 at 10:40 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied, along with patch 2.

BTW nice work on the X10!!
I can see from the feature matrix here:
https://wiki.postmarketos.org/wiki/Mediatek
that this enables a whole slew of cheapo phones and tablets to be used
with PostmarketOS.

Yours,
Linus Walleij
