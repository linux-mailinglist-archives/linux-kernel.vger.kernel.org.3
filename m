Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894C348CF74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiALXzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiALXzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:55:10 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB6C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:55:07 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r138so5537644oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sg4haoVhGfqcJy96RZDuqpK7b4znU/XZS/3LD4XsYVA=;
        b=I4rXHfEehYuHdlJpaeZurJZYw5gDLaE799m0bfrKRzkZmzrhNkpxhPechTauENI8sx
         V8goHj+N+YuzZU7iBnEsyJnfVNlUF7uvT8uoO67R0Uoolqaad6WDk5w27mq7JCiOFhcV
         SF44GUvT9mS7pIvXQm3IZ5PU6p6jGEFKT0V+lbbuwWssAdZ3iI38cUdXOUvIVhr8YvjO
         zHhngs5MSQdbe8FejqsIKtkPiQRnDEhw3sBtHaCqixorS0+9tI2sEL4KJDKtDUXEaDx5
         Tyids01cGJQuyeOk7aqWpoj9anotIOolDlxp591zft+bwrYP+6Ia1qUG1nf0UCcXqjYR
         NLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sg4haoVhGfqcJy96RZDuqpK7b4znU/XZS/3LD4XsYVA=;
        b=uZj73gHGXREeON0cdik6RlhEN4wJD8qbwSLlONJXNgNZTHltsgiYs993PUvhcr5bVh
         b7eL8rCgAJpCvfFAf5O7UIA0CtNB85eQOw0bAZtlTSYiSKeIyf54mYL40s0+qpiNU5I3
         zfovPww+CrUn5xjgPcxQR9Qoa+blXS6r93njqJrxxlNdHCG8qPeho9hWLlXq9lPnODek
         rH1m01ZDbzOQytSJpKQTC/Z5ubL2okAGL+JGHdRL3SDf5auKtsbqSKJ9CV8f9pOCwGL5
         tauqoN6MVXm8Vr21pKQHnBj7/TAjmwtBJtxGFNlfDbNW6Q+bivIyyaJ4M4sMno3LtQJU
         fIqg==
X-Gm-Message-State: AOAM532iQ0tO5+FCcMcv49hC/oTqR16nHvcINttXZ91nflzj1aLq/5Y1
        4BVBy2ORd9Erh20uLeJRgEwZB4sc1TFMGFq89AEzrViylVI=
X-Google-Smtp-Source: ABdhPJy+r8906AoK0fKTATnHiiCVWoA19BvOjlPlJLpsbdB7zRsAFkb/Ek5aDFN2Tx7ZSZSiZpsQlTw7NGn9EQ2mKJk=
X-Received: by 2002:a54:4613:: with SMTP id p19mr1316839oip.162.1642031707215;
 Wed, 12 Jan 2022 15:55:07 -0800 (PST)
MIME-Version: 1.0
References: <202201130136.7675O5xx-lkp@intel.com>
In-Reply-To: <202201130136.7675O5xx-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Jan 2022 00:54:55 +0100
Message-ID: <CACRpkdb=604wtkcfY_DeSWDj1ojsPm2pZpGVrvVwMjp7=fi2sg@mail.gmail.com>
Subject: Re: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for function 'ixp4xx_pci_write'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 6:23 PM kernel test robot <lkp@intel.com> wrote:

> FYI, the error/warning still remains.

This code is about to get deleted in the next kernel cycle.

Yours,
Linus Walleij
