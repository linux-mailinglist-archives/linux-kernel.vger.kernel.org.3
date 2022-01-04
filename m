Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C24844D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiADPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:38:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39662 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiADPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:38:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE6FCCE1804;
        Tue,  4 Jan 2022 15:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FF4C36AF8;
        Tue,  4 Jan 2022 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310705;
        bh=q3J++ppIXFGs4Zc7BRSjku9Sf288+Vh9wEACN8vGaUY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ei62MY/0Yo6URqU+Id+DonIwUoAul+ZpuGo4TqGXPQLvV3jEltzw+69e0pe1jaZtM
         zTAqbws1DuBRyt7gX6QKyrl+VRsxyN2DpVUF4pEOGDyGqQOaz4aiaWNQs9NFNHi/7L
         x3xj7mAKTH2FACLUsdXagHaGwY7ci5TCdNikghqK3k9phjuSvZTUINpeekbBdfEWJU
         gNe8Zbgmm2Llkr+mnkKwzaADczia/nr/6gpugDY7FWEzk4MjvjboT0fb9tKJIkaGkR
         ygSvwlikm8dRHiIhgZOEqjQGpCCHLtWnLoqsx3Uu2wBH2fFk5B9kOSq8uHKjkWMI/L
         N8idsmyL8T9Fw==
Received: by mail-ed1-f49.google.com with SMTP id z9so80118123edm.10;
        Tue, 04 Jan 2022 07:38:24 -0800 (PST)
X-Gm-Message-State: AOAM53188MdY8NgwMVnXkHtzg7MpcGYl64ji3NgKxwzEF0+co1DL+8u2
        UhDcEjWIROZKQa2TR7ExA2F2x0thzLutiUhoxQ==
X-Google-Smtp-Source: ABdhPJzeuvUC4UoexfET3DhOEOU9wx5fuYXHhi72Y0OrlhYosLvDPgd32gKjmTbWPfbTvIxJanUf34tGd9xPHq6+aRc=
X-Received: by 2002:a17:906:eb04:: with SMTP id mb4mr38698526ejb.27.1641310703360;
 Tue, 04 Jan 2022 07:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20220104134843.27382-1-liyao@cdjrlc.com>
In-Reply-To: <20220104134843.27382-1-liyao@cdjrlc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Jan 2022 09:38:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQnqYyPiPFSdnBnbc=P5Bcpfs0zrzrQQZ=woZTWXTkKg@mail.gmail.com>
Message-ID: <CAL_JsqLQnqYyPiPFSdnBnbc=P5Bcpfs0zrzrQQZ=woZTWXTkKg@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: return true/false (not 1/0) from bool functions
To:     Yao Li <liyao@cdjrlc.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 7:50 AM Yao Li <liyao@cdjrlc.com> wrote:
>
> Signed-off-by: Yao Li <liyao@cdjrlc.com>
> ---
>  scripts/dtc/util.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

All dtc changes go to upstream dtc project (and list) first and the
kernel copy gets sync'ed back.

Rob
