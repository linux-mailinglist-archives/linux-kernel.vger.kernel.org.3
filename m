Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E3509BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387445AbiDUJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387477AbiDUJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:17:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A4EB3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:14:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ec04a2ebadso45126067b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1uWVuZ6+A0BASrhtcS2ivTUwFpVOwbpQq4d16gjWgQ=;
        b=KfviBbNUxTMiBSnCXE3OrnaDK39G+p2hghIMD25j0KUp7ZLrh+Bw0OZCCeC1hIrSfM
         pTwQMys9R1SkEgZPN+U1YplF3DXwzr61jkkU3Mwwa78nUXpDeRMWrFKrBUAfDTLhyPsM
         ciErq4lfgYuxNGVDSG40Gj/QRvjJLmtgAGJLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1uWVuZ6+A0BASrhtcS2ivTUwFpVOwbpQq4d16gjWgQ=;
        b=Ta2So1GZ+R4XdCu1JOFZKTSnd991kAp3MCAfiD98AgO2V8XOF6qBKxOrEM/2aGp6zv
         k/Wa9BQ+CvnB91Dy9CM+VduU0oWzCrbAn6KCZBoAjGxuJeba8HJgBmH++NLiOfnpVDKX
         jo2+0tomTaeqZC7sDP15Zn1iPWJbAbLui19jy9OVtApA1AHXvWAQUpljM30+j0ObV+qr
         5Dzyp7CJ0g72rs5r2UlTvEbudT32OpTc8WpmcfQl6mOW0Ly0AMBY+vXNeptjNME0Uxno
         m7KSVQOjMCrrNpj+ZMmtUeX2OzukOEZ05WmwUtMYvSreubh1xUPtcJxxuIiXyB/g4+qN
         kOtw==
X-Gm-Message-State: AOAM5318PMYu5lkFCE5KtMssr42CB4pd9Gr35Zmaymtpb8HjRKpEg6+J
        mQAK82vTBiwWvYysgcf4wfm+2NqKPldbx69VOlUuMA==
X-Google-Smtp-Source: ABdhPJy9nYqH8i9c1NYzIrrrk2RUAbZ7bXTS0+WD7NPVL44tYER6HZDSPvwCms4t/XCM0TjMDZvIAjxJ9Py7xiUDcss=
X-Received: by 2002:a0d:eb46:0:b0:2ef:4946:544 with SMTP id
 u67-20020a0deb46000000b002ef49460544mr25008925ywe.286.1650532494832; Thu, 21
 Apr 2022 02:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-6-rex-bc.chen@mediatek.com> <90ad46a5-8b67-e9ca-25df-2a7cc6110bff@collabora.com>
In-Reply-To: <90ad46a5-8b67-e9ca-25df-2a7cc6110bff@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Apr 2022 17:14:43 +0800
Message-ID: <CAGXv+5FL=YdjonwBWV9ZkRf3jstCsxCEonmH02g2+1PAopObYg@mail.gmail.com>
Subject: Re: [PATCH V2 05/12] clk: mediatek: reset: Add reset.h
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:07 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> > Add a new file "reset.h" to place some definitions for clock reset.
> >
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>
> Right now, you're adding the enum mtk_reset_version and *then* you're
> moving it to the new reset.h header, but does that really make sense?
>
> I think that this series would be cleaner if you add this header from
> the start, so that you place the aforementioned enumeration directly
> in here...
>
> ...so we would have a commit that moves the mtk_clk_register_rst_ctrl()
> function from clk-mtk.h to a newly created reset.h, mentioning in the
> commit description that it's all about preparing for a coming cleanup,
> then the addition of enum mtk_reset_version would be in
> `clk: mediatek: reset: Merge and revise reset register function` directly
> into reset.h.

And probably name it mtk-reset.h ? 'reset.h' is a bit too generic, and
I'm sure there are multiple files with the same name throughout the
kernel source tree.

ChenYu
