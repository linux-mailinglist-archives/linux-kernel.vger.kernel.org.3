Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382BC47C067
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLUNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhLUND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:03:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8FC061746
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp20so13525417lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAKxA86yUoHK6VBBx2V4w+G9IgxdZUJ5j0qp6W74H9o=;
        b=mNpqWH/qF6Qq598ubZF+RaCmiRhRw4c+Iy9f801LyVK+D9TDYRL7gV4LMUdxUvSoas
         7vAVkB35q0W/wtT6apcgzCU6ZMAB9zwKDOIcad/+ToJOYVgpqvLJiNZV8Kf+35Ute/az
         vZUwBEL1d8kr+ADgTVnsvACnq/q2KuEchu6EWXDLjcOhdqm5ePhoPuMQmpDEje/tcWJT
         8ZQr5N0CK+7gmtDMfULlcQSPxEJNZ1JYZi/9d9r+g1BPXmfBHRRv++kNO7Cv4pzwYowu
         CS2lWs0PW+b5hEpJfcuix9hZZzjcizMicHOsA0nU/pvSjgoUzkK5e48tP+Sj760RbE5K
         GJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAKxA86yUoHK6VBBx2V4w+G9IgxdZUJ5j0qp6W74H9o=;
        b=Fob8Op6hPxd7tS/1iNzPkNrKmq8QwZuhJEl/fxht0SPuxuXVGqBVybDphThG4HW1gp
         wnMHZ5hfdWwKAzlKiO0uEdz+QFtC1A9V9HC9O3WbsSXLpBhdv+MUW5pJCu3JCxxvjyIG
         09/c0wfGr7d8EJKvUWI4SHiFziE10RdEVLWa9nI9EGrdVC7THHPONeSWxpcV9tT/yWXL
         d6AUAw0nSx06kmhD8ShqlnzOt4EZQ/GvxrfNcwSUhjdzueTz7pAcgj6/2nMOxjzHhaAD
         Dkzfuj5eDVA/xfzduRNwvadQ0D9NmiE5W5no5HxJLArjXSl8YWgbc8T9mz2Dox1zIjIk
         TiJA==
X-Gm-Message-State: AOAM533d07rVwy2kPpqW1XdYRvlcngu6Dc8EnMWGZWvMAJL8azUVI46o
        zqzSguuzfm3uvW2zMPgvY7aArcigViZUomo7Nei91A==
X-Google-Smtp-Source: ABdhPJx8IP2IAkRzIENJtaUA/EkQbrYytygRyaHBX3zyri4TEUhP93ZvkX5zMAMoMD6Gf5WjYsFU3b8O6W+BKXO4a2g=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr2973456lfv.184.1640091836638;
 Tue, 21 Dec 2021 05:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20211220190840.108061-1-paul@crapouillou.net>
In-Reply-To: <20211220190840.108061-1-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:17 +0100
Message-ID: <CAPDyKFrX+sajBhR88Q-DaNOgfAL6VZg6NvrT0Bds3wO5rVK_MQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: ingenic: Support bi-directional DMA channel
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, list@opendingux.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 20:08, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Ulf,
>
> This patchset adds support for using a single DMA channel for both RX
> and TX operations, instead of using separate DMA channels for each
> operation.
>
> As some older Ingenic SoCs offer only a handful of DMA channels,
> supporting bi-directional channels allow more hardware to use the
> channels that would otherwise be used for the MMC/SD operation.
>
> Note that the Device Tree binding for the DMA controller has been
> updated in a (already merged) patchset, so that it accepts a 3 cells
> (#dma-cells == 3) instead of just 2. It was merged in the DMA tree, so I
> am not sure the autobuilders will like this YAML - but it was checked
> without errors.
>
> I also removed the descriptions of the "dmas" property in the YAML, as
> they really weren't adding anything and were getting in my way.
>
> There are patches touching the driver file merged in the PM tree (the
> ones that use the new PM macros) but I expect no problem here, they
> touch different parts of the file.
>
> Cheers,
> -Paul
>
> Paul Cercueil (2):
>   dt-bindings: mmc: ingenic: Support using bi-directional DMA channel
>   mmc: jz4740: Support using a bi-directional DMA channel
>
>  .../devicetree/bindings/mmc/ingenic,mmc.yaml  | 37 ++++++++++++++++---
>  drivers/mmc/host/jz4740_mmc.c                 | 19 +++++++++-
>  2 files changed, 48 insertions(+), 8 deletions(-)
>

Applied for next, thanks!

Let's see how this goes when the changes hit linux-next. I will have
to drop them, if we encounter any problems.

Kind regards
Uffe
