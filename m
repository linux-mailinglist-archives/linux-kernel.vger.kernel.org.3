Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2838B46AA65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbhLFV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351544AbhLFV3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:29:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A3C061746;
        Mon,  6 Dec 2021 13:25:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so48958511edd.3;
        Mon, 06 Dec 2021 13:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJhO0TD9FxyBOSAsMHBoS4DzEUUiCc19SpaaArCSlRg=;
        b=TTK/sGlkC51XibKV283EHurB8uq4dFRC5lylJ+sSQgpvLZqv+YzfZOBRy2hjcRzRiu
         mDTZaPr0opOjufNa7GousDDy5K2UGMlrU/V2qN7hg1+kAnurKRYBkZ2jhnuQRSfd7uUU
         8N1ktZp695VJGlt2oR/Pj9eUB0rxT4oAm0ucZDv6Om2G2DKUqquYtotoXyuzSxDDlDxp
         EDtzFWuG6pXVODCq0IUMh9rwDJtPkooSJux3APW3GaAY4OmQGvo8wOU8CvtUzHmlWOD+
         GI/iA78s3VpnDMBwzegQFUSnvGTVMXNGJBqtLNzRrrVkYa8O9JeuGKVqti4i4owRkWU4
         poFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJhO0TD9FxyBOSAsMHBoS4DzEUUiCc19SpaaArCSlRg=;
        b=bSmdHMKIH5JIT3vMvNzztDJt2C6X6u6iDPUhyVOxXtCdgEjkJtHlzI/94DR3oA1WJf
         ZBjypcvb4c7V/riez6LMTYQXE1LCqSwUpOGKEf6IA8NGB3H6gnYXWWq3M7JknGWXI4ZK
         xELSxqIcZ3LpQA8ZjUwMhQKdeU/KAcIcTPQM8xaUcEJIceJ80BQ9aG8PmZM8/q0eHeE8
         0EU80HZGFJx4i2XKkap9Q5DaE68BsjawWD52ictyIwOrc2SB6COYdA1VgNq4BBTqp3p7
         Oow/Taa6SC4VCK4eqPmp2nwCAgNKBn+x4eVOSd5QvGdr0Y04cajtAReBACxk9xjE57Av
         rTTA==
X-Gm-Message-State: AOAM531sk19glRvk4jYJMw9DGpo32jOjWgL2eftx7RJ7zUY3vYcx1cF5
        qLFyk5jciF/gX7R09V4KNurzSAEHXX/kqSpqwRmczjmFr1U=
X-Google-Smtp-Source: ABdhPJzivefsaNiHaYwi9GZZhlshDUGfhrq9aeaUOKokrbFHJu1tlchzrUkrmL29IdqO1rYgGzvnKv9CgqpwJxrTkyU=
X-Received: by 2002:a05:6402:7d8:: with SMTP id u24mr2429113edy.215.1638825943964;
 Mon, 06 Dec 2021 13:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20211206100209.31971-1-xianwei.zhao@amlogic.com> <f20968ff-667f-3fd9-3f8e-af8eced694f0@baylibre.com>
In-Reply-To: <f20968ff-667f-3fd9-3f8e-af8eced694f0@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:25:33 +0100
Message-ID: <CAFBinCC42vo0WydYeodgjiMH676J75kaPyVtURmmdoL0=Of=6w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: add support for S4 based Amlogic AQ222
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 6, 2021 at 11:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> > +/ {
> > +     model = "Amlogic";
>
> Please change to something like "Amlogic Meson S4 AQ222 Development Board"
>
> > +     compatible = "amlogic, aq222";
>
> Drop the space after amlogic, and add "amlogic,aq222" to the Documentation/devicetree/bindings/arm/amlogic.yaml bindings.
You can follow the approach from the Amlogic A1 SoC bringup, see
patches [0] and [1]

> You will probably need to add a new "amlogic,s4" family compatibla aswell.
For this (and various other code-review comments) you can also follow
the Amlogic A1 SoC (and AD401 board) bringup, see [2]


Best regards,
Martin


[0] https://patchwork.kernel.org/project/linux-amlogic/patch/1568276370-54181-3-git-send-email-jianxin.pan@amlogic.com/
[1] https://patchwork.kernel.org/project/linux-amlogic/patch/1568276370-54181-4-git-send-email-jianxin.pan@amlogic.com/
[2] https://patchwork.kernel.org/project/linux-amlogic/patch/1568276370-54181-5-git-send-email-jianxin.pan@amlogic.com/
