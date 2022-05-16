Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C259E527DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiEPGyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiEPGyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:54:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915F3668B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:54:17 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o80so5578891ybg.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKBPuBA7nDBUDGIjqJUvG0nPUeRoC5G1pQg45xIxF6U=;
        b=mNuqvS1iTG4dsC6WRNpNpy+Wy5D754aiKOBRNuv+qV/h6oHCDIrKd08VmYB/nZ5Tm7
         RGTkyICj7lQNxfNVRx0NM75savj3ViJswss4xqJSZm/W6s5TIIvmgpOcYqOgiQ9iAXNW
         QrLrS/YX3cTPkN4Zgzc/KdUWT/YA9RVdh7CpQvgBr6KVDgB1vRDsY77UlO/+LXOryrI1
         HBWtQ1RoybhyqV1bxmc12DW+sHMGgSZ08cNp0kw+HnMTAq0nx+spMNpvglGSb13XetP0
         nTBlgOyAVSOCPGTE0inW6mJegMa+7m3TnFwD4+1U2p2ySaDbAegbGQ3Wp23wNMdcUiA0
         JNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKBPuBA7nDBUDGIjqJUvG0nPUeRoC5G1pQg45xIxF6U=;
        b=yJudbaIuIOeGJuyeUuutw6dTrdofAsVL2ete0Rh5c1GBfFOb4nJ7R4XWVDTCBHIErG
         U8fGSntwgqTbiX6vQEWBzc/M4itEyEXjfEhG5fF18c9VIxRbAZr75yDclwZJBAV4bmNW
         UM7LtP/o8jOzMhWaHR0cWBW+wYpsirhzek4OKjItvockcYnY3Btn8xjidpSE0n1NxnSD
         ZD3jGGLio7zbr/2ZN9XjBDtmQuq+NoNbRPl2eAt4Jjovf0S1ndtXKnnjfGR3uNnBd+TX
         z80J3AX3ELlRDqEyYZ/SkTyRlOlhb5eJc0CQaKPI7xc9omeCtku1V1S4b1nvpnJaAs9n
         c+Eg==
X-Gm-Message-State: AOAM530Ihw8scvrRMTLv3a8sRg3jkJZXB0eSK66MEHbFS6uafTwr87sk
        pFBqVX+FnW5csq5kTy13dQ5JDfgI0/PMizlG22ZioQ==
X-Google-Smtp-Source: ABdhPJzf4PxCtwUi05wCCbSg7YSjtlGiEa8zxtzcSt2UvJoljiveFxAuz6UsQauFqdijB+4dTPm4bgq2zfchK4QlLao=
X-Received: by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP id
 f127-20020a251f85000000b0064ba5fce881mr13531143ybf.514.1652684056648; Sun, 15
 May 2022 23:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220406205505.2332821-1-linus.walleij@linaro.org>
In-Reply-To: <20220406205505.2332821-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 May 2022 08:54:05 +0200
Message-ID: <CACRpkdZ7oe+A_+9H7OWXNPvRXsVFUWjE++zWeXJtZcnWDUyDqA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/ixp4xx: Drop boardfile probe path
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
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

On Wed, Apr 6, 2022 at 10:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> The boardfiles for IXP4xx have been deleted. Delete all the
> quirks and code dealing with that boot path and rely solely on
> device tree boot.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Daniel/Thomas: can you pick up this patch for v5.19?

Yours,
Linus Walleij
