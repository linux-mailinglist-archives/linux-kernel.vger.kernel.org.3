Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D054259B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442655AbiFHCAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838719AbiFHACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:02:04 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC926471
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:42:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3135519f95fso21191047b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+9mkaC5FXCdiilP0sDFa95pXGDowopI6qZcmfpOFwY=;
        b=THGdgTWpz2L5yBciJ+3Rp6qRkwa3YV8CzDaERGa1QNRKVT/VWtYXuaZ/4qrV3XRG2e
         BVFuV4GtFjklye2XPemT4GhsO9WNT3UtZOgV/U3GrscQINoitVv6tdr3qP0lDaedcFkF
         1XuXJIyca7cvFEiDuKDSpJGA0QblfBT/DaMngv4vQxtESApf00rw13BQBJQSNcukywRF
         uxy8nJ5UwX7wk/VwYQi80pvbOvkWFhXnl0OXANctXKeqYSGap9JRubfD4NxcIGzkuf1T
         +PgqYeVTs2wSCe7WMwG+684FgQc0Cc3hQYmDzPDQ3+sCrGim9mKX+TmzimLYU1mF+Caj
         mKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+9mkaC5FXCdiilP0sDFa95pXGDowopI6qZcmfpOFwY=;
        b=nc8LbhM+QPAVdyDiiwoiJ9UgmNE4S7miOwjlgIwHDHuV//BN8fPEb4Dto/f3SMtghO
         q+gRDKK8G1YaPDc3rfqvuodE2NcNkIQjEeiRGeZHZywlvVjt+9Mxxg1DBT0JPAJ7XnEk
         cdMuHnTiA9agplae+7e/lpaaXychGT4FuIRLaI3SuSPdZNM9VgCk8Qn7+QDCk3WxNWpb
         5F3MPIqrGTXo/rjDEbGytVHemfKdcY1LmXblSMqc1j5bL4tSZjMbvnoDWUUxEu1q7BCX
         3UYyjdrJgCIZJGIWpweSvT4IiFT4e9WrHdQWLiUIkBnoeGJvGT0GgEPf+bg3ByuRjoGL
         El9A==
X-Gm-Message-State: AOAM530JIsPFeb1nh2OOkUA/CQj/d0OTj41T/rFVRZ/aERzsTVLOI40y
        RcNWUAF5HLgF/19ctCFH4cj71c/oDISpw3dan/vMdg==
X-Google-Smtp-Source: ABdhPJzl1Nbb7E5Gb8nax2J8oOG9hgoViYBNrjUIWKyk/TT1bG7pSkuwyr5KQvYdLoD6HBAKGfxEyFAcUZqCfHuqjpg=
X-Received: by 2002:a0d:ca44:0:b0:30f:a4fd:2ae7 with SMTP id
 m65-20020a0dca44000000b0030fa4fd2ae7mr35214191ywd.151.1654641733433; Tue, 07
 Jun 2022 15:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654529011.git.mchehab@kernel.org> <d27b5d508fb757147b720bf573ce5a2e3fc5920e.1654529011.git.mchehab@kernel.org>
In-Reply-To: <d27b5d508fb757147b720bf573ce5a2e3fc5920e.1654529011.git.mchehab@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jun 2022 00:42:02 +0200
Message-ID: <CACRpkdYas3jHvigeHPGBVHuEtqvQvAKvnuKwBMXPOgdUV6d7DA@mail.gmail.com>
Subject: Re: [PATCH 17/23] MAINTAINERS: update cortina,gemini-ethernet.yaml reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
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

On Mon, Jun 6, 2022 at 5:25 PM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Changeset 208b65f7b5cc ("dt-bindings: net: convert net/cortina,gemini-ethernet to yaml")
> renamed: Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
> to: Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 208b65f7b5cc ("dt-bindings: net: convert net/cortina,gemini-ethernet to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
