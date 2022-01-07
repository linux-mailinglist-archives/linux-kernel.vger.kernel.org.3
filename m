Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F5487EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiAGV5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiAGV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:57:18 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DEC061574;
        Fri,  7 Jan 2022 13:57:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j6so27004669edw.12;
        Fri, 07 Jan 2022 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBbZze+NTTaBtTNLSE49NYeYh1zKdJL76JcqKt2vsow=;
        b=H+A56YS7PpylJuLmsS39JH+eKUswGIj6b2xPbkNczasqwK1hrv5hlKX6YWq2LvIp1g
         WP9lnZlusrLbw4vkfooQ7rFH46XZh7r9LvC/sMAU0g9wtSUZ/oVQawWWKL1oVSDbkEIa
         mevCYT66ePU0FyiunrSDGCloRonG49Ovvg/jCdJd5MuuGo8cX1s5B5JtT4ESVGFuq9P9
         8jEStG0jFRa8AD2PU9gYBE3KIWI76gdLFoGUozm9iwotN5svCZo1924sQPPq/MuxJoJO
         BIkRM8LUr0jVdUEfat2GSiNcEis18IKZ0eWpfUyHV7Bal1WugqbKMheVQ9r5XNJWQBqN
         mxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBbZze+NTTaBtTNLSE49NYeYh1zKdJL76JcqKt2vsow=;
        b=tm8/6SiY4+7yVCwnnCl1PNgH31mGvMspj83RuYJWw0UJ+ZNynLJs5RuxXD58mSEziz
         VAnsrgMc+bv3awZ6jfdp/npV7AxgqJJ8nOD0p+nQnKTcqjWmSjhHP1HFKDszoLVFBJt8
         AkPojk/bE7qi52ljpV5oFyiwBL7BmmleqdrSFGsKPGNTpKZrODLKao22CewrnQQKHvzQ
         Ih/ACwQMofgKmLYN5CmPWsYF0S9ieZGNa8EcnSQspRBCFFtbQfu17UxAjciArgVlT1Uq
         1voePm+WeV1ixboCXOOqyAZlnhhXuh+Wml0qTKwQucoFdpsambb3wNjTOPQaTKKqDSDP
         ABSA==
X-Gm-Message-State: AOAM533OHc71ksYZnCzgcIb2RC0tEdrIFhEtvuSpTdR4bOk7M2YKnUNQ
        EMxWCcvl7vq92eNWpWyQzWKYh5nXSKFRuaG+RktTt80e6JM=
X-Google-Smtp-Source: ABdhPJzDby9D34unJG2ZB7reqzlxkBNe6PlR2WAX+belp4ijR7LhFKbQC64JKiJQkLGSMKKILBVf19WnTTSJny1l0Jk=
X-Received: by 2002:a17:906:f46:: with SMTP id h6mr22250197ejj.281.1641592636234;
 Fri, 07 Jan 2022 13:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20220107023931.13251-1-zelong.dong@amlogic.com> <20220107023931.13251-3-zelong.dong@amlogic.com>
In-Reply-To: <20220107023931.13251-3-zelong.dong@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 22:57:05 +0100
Message-ID: <CAFBinCCmTwPcmuMAFP-rgu_v5NR0Z3B5bp-WTEvnaf+UMY5MRA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: reset: add bindings for the Meson-S4 SoC
 Reset Controller
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 3:40 AM Zelong Dong <zelong.dong@amlogic.com> wrote:
>
> Add DT bindings for the Meson-S4 SoC Reset Controller include file.
>
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
