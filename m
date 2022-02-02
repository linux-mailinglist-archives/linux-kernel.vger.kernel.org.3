Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA34A757A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbiBBQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345783AbiBBQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:06:21 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD3C061751
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:06:20 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id i10so62484220ybt.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhE+HHyFpW2DRFHuTlt75S2kEEeDfA0eG+B/I+nmgv4=;
        b=fFh7H+BbaOQ4B+p05GH56raXfaOn8ajgIVdTEPxN9lHFK7SPrCVHpsHplZvXWummPB
         G0p4aJBVAWs9KblSVpZriM1XMf1BE8u8b7bkSCnh269FB61HmvjuckgfiudKUXXEnfTs
         yj5tN50Jpu35k1QkQUQYCtj9jwnSkI5vMTL7yr/FiXn+mY7B3IHxz8E+JdOLWVryNCor
         ERUkmIpd/PZDbx66Urb/7WFvPziTDhA898AtS0CMNI/ZNuQOnt8+fuaZ3+aLFA1E0jrA
         PWVAi6pCHZpB9hVOYgT1/1wMgL1l2jw2xoEL3JlZMTxC5sDTtnVVMuZBwv5J5yPAbRo4
         B0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhE+HHyFpW2DRFHuTlt75S2kEEeDfA0eG+B/I+nmgv4=;
        b=NSwrTV4PdY2doGSzqAD0ksTCyoO3dF/94X49ObYw/8naWJznkU0kds8v4Z3W1IsZ6T
         D4bQKW/bY9Bd5viYOVCe/ldWchxSjAAh7uYl2sVZqTzQ0SWvoowVsyKLN9NDEdgTIEaT
         cV0dlWVJdXRACFMlZ7Ec2gyEcNkOC/qSxP18wyA9a1hqatVagcmXaogSSZN5vi206v+C
         ZbDgB9r/FZZIqdj4HEdQefSE7e20ZvJ3wUTR9oTyjh5Szj2Y0w2v1iE3zNDNd73S2mk9
         gPp6ERA32Bwl1ytGmPQwU1Rri/O+7YUm7oFlHhM5NgA6qRAzH5dX0MqaWYg4PBOPD0F8
         VunQ==
X-Gm-Message-State: AOAM530qj4bqhQ344Uf8K0UX6mo31X2MvJbpYitgJDfqZuxHfg9eX5xo
        8IdfMDr0GiLZ+Xt2orji2xQhazRsO1EyVFtvaS+uag==
X-Google-Smtp-Source: ABdhPJzafC5pwY46k2rXmjcY5vPjKYi8a7v4ircglXyoNbcuYsGfJNrRsCHGMMK6c6myzjuypdKKvDpQA0n24144LB0=
X-Received: by 2002:a25:8011:: with SMTP id m17mr42060866ybk.284.1643817979539;
 Wed, 02 Feb 2022 08:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20220201144940.2488782-1-clabbe@baylibre.com>
In-Reply-To: <20220201144940.2488782-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Feb 2022 17:06:08 +0100
Message-ID: <CACRpkdbAvexv2bokpqD+YhFpsdfaEGJZbvNBoWE4OQxtRwCpXg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: net: convert net/cortina,gemini-ethernet
 to yaml
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 3:49 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Converts net/cortina,gemini-ethernet.txt to yaml
> This permits to detect some missing properties like interrupts
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - fixed report done by Rob's bot

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
