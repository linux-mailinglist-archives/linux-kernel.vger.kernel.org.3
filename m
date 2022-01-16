Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984D248FA06
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiAPAkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiAPAkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:40:19 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:40:18 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s127so18087227oig.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GN1CeIhczaHOopL+n4Kv45Lh65dOQuxM0kOP9sPykkY=;
        b=WxtMehnPb07jjyDDcGRoCzba84TO+wT65fjwEYf2TIGNYfugCxDX7LxMP+MxEbiWar
         SADWBkmrpI1uFCWyG5NTjRS8hhPFr4xijLd5ElYhDV9MqcPVUvtPmpR0pw4K9u3IjYNn
         rJmnvfDPTrp9B9Ta1dIL/H9o4lMBb/3jcQs08K5QZwypkhMVVAq91DRyc6wDw0cGAiu0
         XgrnEBZuzEpH4Ca96XAIs4ZzQbafx8GCCCkKPLztxaYwEH3Wr57TUlhkl+zV7ECh8+UA
         MG/pwsYIzErGLlOt4IiCKwqVqjkQuybEhKKrqJTkLsp7pK0ZIj9Mwbq0aF4rSexVv/O2
         s4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GN1CeIhczaHOopL+n4Kv45Lh65dOQuxM0kOP9sPykkY=;
        b=L0B5HaGJaLC9xdpOfa+p5BazowK7jAp/ym/I0EAOWdlebdMW2+aFN2bnu/Xt3qd/F+
         zaYGbLDSI9xDIYd5592xaWlYzwitnQ7I7Fq+tCGrlSZv6NZgrrtZijrpeoNadtoaM9A8
         wcxz9P1Ws9wcgdUCY6wDE/GMlzxDJ2tfnN+Wj0+OQ7UmqyHLk3cvJw+qwNYd0ciylviz
         +PsPB9qnJZh2+0dwfk++3YKcuJHjq5/cu3qkalPBW6PYfqahYXB/LxiZ+GNt0Qys6+JN
         fnQnzZ61DKllllDqQ/pvAwxnrlgoYD0S76o6hJaEeJkaiRhQdsbFeSbXvUcsuz5tAVsP
         3krg==
X-Gm-Message-State: AOAM533pIZNIK4xDmEGyfo1pxkmnxqVLhAxNyM2qfty7vbIiqiRLm2k0
        pM7ozIqGZm88Uy2c3vNslC1AEzjcIzriMscxCCDLIw==
X-Google-Smtp-Source: ABdhPJzkb5Ftxq/SHZmYzAMYwVlIqd9C7WV/gsKqDYFD62qnOVGUtEo3sylawq2hfa9f+B5Y2UrIhb9Xrx95YYbsyuQ=
X-Received: by 2002:aca:5a87:: with SMTP id o129mr13216459oib.114.1642293618246;
 Sat, 15 Jan 2022 16:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20220110012730.643927-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220110012730.643927-1-chi.minghao@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:40:06 +0100
Message-ID: <CACRpkdbquo5mypt25FDKt_tbm3CFh1j1FwvzkvmD8bB1t=O58Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/pinctrl: remove redundant ret variable
To:     cgel.zte@gmail.com
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:27 AM <cgel.zte@gmail.com> wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value from pxa2xx_pinctrl_init() directly instead
> of taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Patch applied.

Yours,
Linus Walleij
