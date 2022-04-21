Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E04509C86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387748AbiDUJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382102AbiDUJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:44:27 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72FB62D9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:41:37 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2edbd522c21so45678497b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNExmSjlaYtm/wBO2/VQ+pMd8GmkEdKrkvYHc/Wjj4Y=;
        b=ZTayUALaY5kyKRozk55vRKsPIf4+z2700Gqa/7hhKzCqFAWs3UsbO9Aba/9NjKXURW
         dr3iE3+e9nAyrim9V8f/ldsLFTs67iMkt6NC8BE7tBKetLn4/tuAXUqOta8pd/cYtAxV
         /91cpH4ZeL1nxvLtiyqPnxx8okn/XAq289jp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNExmSjlaYtm/wBO2/VQ+pMd8GmkEdKrkvYHc/Wjj4Y=;
        b=Zm44AxlrQf/Wgf+eucF4gMwvYbmoZLTsoEpTcyNDFVlg7TolCpbaD46rP/h7yfTleb
         Y+Sc8+SAhTfVaATBxmF0Pc1lVnpjDOEz9rKb3qU9QJOGDU7n2QplaU0VL4hFJ+naftuu
         0YTtCalU5GRdTwBrj+H5by5xJjySqBqyycZFGQ1oUAbAKtU79Ez/7SZo8Tjkm/5y//xn
         aucHpmGwwUQgHhd1zUB1aQZt+0ieu9x1ey8ma1MLKfKRKKRU4Al9HZ+3n3DTNohdHL2+
         s0T3KHCCFgnME00PgCE/kSi6b+ZstUtWqASCq9kWyVY6n7jHd2Idfn2ixVvtoZFVMnxx
         5mSA==
X-Gm-Message-State: AOAM5330/hKDMUtODJtTu1NHE/js9anUbC7X7EQ9HMctjlft7/0KMhik
        /neunBcsaP6rYIAdeBeg5v0fs5/C45nSnv1M27GsiA==
X-Google-Smtp-Source: ABdhPJxEzCRntzAGeWIxrjGr/qnshzvCXz8EgyFfSbtLFpl+eCBT8hZWVlr/oyyY0OyXpG2DMrqCNnDkpGPQu5St42o=
X-Received: by 2002:a0d:eb46:0:b0:2ef:4946:544 with SMTP id
 u67-20020a0deb46000000b002ef49460544mr25077698ywe.286.1650534097187; Thu, 21
 Apr 2022 02:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-6-rex-bc.chen@mediatek.com> <90ad46a5-8b67-e9ca-25df-2a7cc6110bff@collabora.com>
 <CAGXv+5FL=YdjonwBWV9ZkRf3jstCsxCEonmH02g2+1PAopObYg@mail.gmail.com>
In-Reply-To: <CAGXv+5FL=YdjonwBWV9ZkRf3jstCsxCEonmH02g2+1PAopObYg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Apr 2022 17:41:26 +0800
Message-ID: <CAGXv+5E_1iAhBe3Avjrb4DWpanKYOMJHkopTqk9t2V34OYhx9Q@mail.gmail.com>
Subject: Re: [PATCH V2 05/12] clk: mediatek: reset: Add reset.h
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:14 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, Apr 21, 2022 at 5:07 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> > > Add a new file "reset.h" to place some definitions for clock reset.
> > >
> > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> >
> > Right now, you're adding the enum mtk_reset_version and *then* you're
> > moving it to the new reset.h header, but does that really make sense?
> >
> > I think that this series would be cleaner if you add this header from
> > the start, so that you place the aforementioned enumeration directly
> > in here...
> >
> > ...so we would have a commit that moves the mtk_clk_register_rst_ctrl()
> > function from clk-mtk.h to a newly created reset.h, mentioning in the
> > commit description that it's all about preparing for a coming cleanup,
> > then the addition of enum mtk_reset_version would be in
> > `clk: mediatek: reset: Merge and revise reset register function` directly
> > into reset.h.
>
> And probably name it mtk-reset.h ? 'reset.h' is a bit too generic, and
> I'm sure there are multiple files with the same name throughout the
> kernel source tree.

On second thought, please ignore my comment.

ChenYu
