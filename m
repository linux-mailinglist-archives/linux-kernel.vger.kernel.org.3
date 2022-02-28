Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C124C70B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiB1PeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiB1PeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:34:12 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15D17E3B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:33:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c1so11801122pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQf8qrMwWa65Olbs/tkcGZr4CIuhr9pKKWXXLBTFbrU=;
        b=uB5qSRcnsaSDFmzTBjycEr8yk2SvyekKPBvdW1Av+6yDM+IWyFwc+XyVWwHHVmBbkY
         NRt+znfl1gYVZI355a4OsD5uRvnpSVfVIn5fHdvqCCmeSFftwowKXtI/QJTQrwmj6bjp
         ahZLYAAOn6G6vDcpLs6mKd9Kx+1sEd3QX7VJahdTkbA0rVsZfAjl5SRGIwbxLCsTom1T
         P+SG6u/CIO9tEcjvqeB0zDFeZIk/8+8saEXPsmd9BGKyVoTQrwd0icHmUXHwzbRrMC5Z
         StiFF+KZUeB534oMEoUzJoSCe5oSCGoqmJpOuNvzJ9ZGO7o0+z5NqoF39BaLXpy7EXSc
         5tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQf8qrMwWa65Olbs/tkcGZr4CIuhr9pKKWXXLBTFbrU=;
        b=5DDzulDQr01IV32g49zOj+/xfDd9YnVpjm2M506FR4bOaH7MG9YFi42LZhX6ovlZmo
         JJN3VZXnXR8OPllx7vhJrJ7Vy+sLVefbXeZ+GGe7mBlX6hVkxZWGsJLceLVsFa7iLIMH
         t8l7u4sasphPnARS3y/gp5fThIH7nj5+Qv8A6PeCPuPkduo2iFWMKL5CSVEWdYBG9NmU
         bJIdBAML1hCZ9ZhRkgttwLGKVuv07aNgmWl6pbf7gkYpx6enKuDwOkDX1qeCRf5jIPgv
         kVc7fZrNDH3c0Rbqlo8BaZSS3UuHKoq/tg7GhHqbUJolR9n7d26vSXewyaqPE/jqxVjP
         YxyA==
X-Gm-Message-State: AOAM531ikxMPCGaHE3zsQxoj0N+hbNScD+QhtSl7aozTVqgXLpAoFPRX
        Y/bwclJEYx6uBbueEsxgaZdq+kK4I7ZZzdHfZ9WKH23eSw78AuoJ
X-Google-Smtp-Source: ABdhPJxLdrmV5TzGPVnOcBzm0n3mNZcbT1uPCuab0u6Nz5lXiLjwAfBzwGbZxjMBWCPELThDLGRKITBi6q+J/6oZC1E=
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id
 q9-20020a056a00088900b004e0dcc35e06mr22150499pfj.29.1646062413537; Mon, 28
 Feb 2022 07:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20220225164231.904173-1-broonie@kernel.org> <CAJMQK-jGCX6Zp0gkfgqeA6=0zuWiSbWbytUixH3VFiwX9wtLNQ@mail.gmail.com>
 <CAPM=9tz0igKq1W3N_QseF97jqCY2Q9iSYwoFBVx2qJ8rWeVx-w@mail.gmail.com>
In-Reply-To: <CAPM=9tz0igKq1W3N_QseF97jqCY2Q9iSYwoFBVx2qJ8rWeVx-w@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 28 Feb 2022 16:33:22 +0100
Message-ID: <CAG3jFys+J1389TSADvR1jYOOQXig2thftfXKtgsGZLWkwA34bg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To:     Dave Airlie <airlied@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Allen Chen <allen.chen@ite.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

> > >
> > > Caused by commit
> > >
> > >   b5c84a9edcd418 ("drm/bridge: add it6505 driver")
> > >
> > > I have used the drm tree from yesterday instead.
> >
> > hi all,
> >
> > The following fix should be able to address the errors. Should it be
> > squashed into b5c84a9edcd418 ("drm/bridge: add it6505 driver")?
>
> Can you send a patch with this to dri-devel? It's far too far down the
> tree to sqaush anything at this point.
>

Patch submitted & reviewed.

https://lore.kernel.org/all/20220228081421.1504213-1-hsinyi@chromium.org/

Should I apply it drm-misc-next?
