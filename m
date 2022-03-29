Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D24EB0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiC2PqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiC2Pp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:45:59 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FA12769
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:44:15 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id c4so9987259vkq.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFXlp32xQw7/OjMn3uGU844211qFMDFeLujMZW6rFtE=;
        b=JqKDQ8MKvspOvGXGqMIk6wdMVNm2l+b4NyGw6XjLHvS4btBEqsAfnlyweRKHI4yMJG
         ghyNvZ3eYnf2Zor1uhlE1bG1HzDFRUTP7PMo7n3K63z+CtY6PMp+ACAjJZfIbgzqFp90
         dgEixgbPzK/xbL2DhnDrF0A+GFWKW9kK5u5AiazLqE+YSJHzqmcTH/kU2+j0gmpSo/K+
         tzBUrvWpmsdBIMHKH+y1Y7W42wYDLHBvBmnbvUvRxmd7Lr7PrD3kr+k+USKm9anB8Kbh
         icgrwgZdiP1VOnpV3IhtWS9kmwb6OgSbkglXY/R7vfdcXfv2gdQA86buPDgejlP+0TIA
         jNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFXlp32xQw7/OjMn3uGU844211qFMDFeLujMZW6rFtE=;
        b=YIg8AkzZofQ7OBrblvw1d8ATT2nR+V20UHqd4iRnxCtndLMOzSlCZ3MIdU78ECI75T
         Ukxs0tnDwaTGfdBBktcQAn+M1T5tSM5MZrQbXZfi8BP/GSbm8CTNnzDh6XmYEXDk5BTB
         Hko0UcFM6S/hkoConD1LFGqBTr3CozIvnaAP2HhP3uAgxdPrIzg/xQMplnFwFoAOZQRr
         DMG+Gf6Ba+tlLcmzAkMOre+L/bYZhB2DJkH6FIG0OxFhog1BbOmhje/jB4tef6HOPciq
         hc81jer1xnqBv7rQifyXpzWGve2mjR/WjbOnQGjFPxkFEf6baps3Ws6Rstr8jXo3nHcY
         XlSw==
X-Gm-Message-State: AOAM5306rJug2XG8zA3ordzkWb8mF7VlFIvxDKHe9mq8IPE0vH4n3M+b
        VQV3vyT0UM+NQiNZEicTCCI41K8jL9K5mSEOGyXP4GfLGFajXQ==
X-Google-Smtp-Source: ABdhPJyW12LjVa8kn/B0znyep6GosCNAp/KjjP9BVBaJg4O8d/25oaPhxtDrGS8yhBe02srwIag4mfxCnCj/FF/ECuM=
X-Received: by 2002:a1f:6a82:0:b0:33f:7eeb:5989 with SMTP id
 f124-20020a1f6a82000000b0033f7eeb5989mr17894292vkc.29.1648568654813; Tue, 29
 Mar 2022 08:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de> <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de> <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
 <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
In-Reply-To: <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Tue, 29 Mar 2022 17:44:03 +0200
Message-ID: <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
Subject: Re: state of drbd in mainline
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, my intention is to keep it in-tree, and at some point update it.
Regarding your questions:

[...]

> - Why aren't the drbd maintainers responding to posted patches? They seem
>   to simply be ignored, and I'm left to pickup the trivial ones that look
>   fine to me. In-kernel drbd appears largely unmaintained, and has been for
>   years.

The team here has grown, we are busy. Since you started to pick up the
trivial patches yourself, I thought it is not necessary that I collect them and
send a pull request in merge-window time.

> - Even if out-of-band communication is used for in-kernel users of drbd,
>   that doesn't result in any patches or fixes that should go upstream?

This one:
https://patchwork.kernel.org/project/linux-block/patch/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/
(relevant to users that have DRBD on top of md raid)

> - If there's zero activity for in-kernel drbd, all users are using the
>   out-of-tree version?

There are users of the in-tree version, some with huge fleets.
Some do not need the newer out-of-tree DRBD, and the in-tree version is a
lot easier to compile. You need coccinelle for the out-of-tree version,
and that can already be a hindering barrier for some.

> As far as I can tell, drbd upstream is stone cold dead, and has been for
> years. Why shouldn't it just get removed?

Because there are users.

> Is it just bait to get people to use an out-of-tree version?

No.

> --
> Jens Axboe
