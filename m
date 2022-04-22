Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE21B50C46D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiDVWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiDVWLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:11:06 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869C1EE1E0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:57:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f16645872fso97807077b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paM4ZFe32zXjEAEL1QAXaw+y9M+Olh2UYHZJ2Zmqcfs=;
        b=HTWV2tbqF/Fw+AZQyOXGIaxL+oUNtWeKA2WgHADrKMCgGmoAO2bS4yhD4WlruS+xtt
         WZcnxDLyzmyacrH8ibFjqvKG8s0aZH331a5erdvmxBb/KaG/+muiddh3LhB9wNZDARL+
         EQTW8xj/Qcm5B5nu8ls3aR18PW+nNijbIVVWj4xzCZsivf0pwLJCDPNz26r1+JD63VIj
         SIqKjPqDfN8k+dkfyPRdYgu+ngVJKFbw8crgP4KLF3e//j8Mg6j+gJDG7O/MUhccBokM
         C7123BKlcDpKXT8EsybGogYe94lMxg+29/Qqzrtut+4sNTo9zy3KPf11g3l78Okk9EK9
         XKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paM4ZFe32zXjEAEL1QAXaw+y9M+Olh2UYHZJ2Zmqcfs=;
        b=hhdq4Z8aTi9O6VzAvaWkZBRBjIjuPwJ9mNDoEraRsOAp3k0MucJnlFfdLgIrQx54Py
         QlHf7wIjtYLI71SPn//qgKycpAwzkxTRo9a9WL5cDk6TtY2o4UtEAOjcVSvQgnNpWq5N
         eVxkZ5CtzrsarbfIugblR8aixBaHunaWKrEsMBpevo99TglEAXb1dsisniF9H8/1OLnh
         ucWlTdtH6l3bRw+Fifz/q69REXWdyiUGVKdtxohPbbYLgEx684g2v7+UZ25vDCsz+/o8
         W5IqYZEQr6yM4zGutE8kxTRRB0+EehSVdKogwFEDTw2ISEKFspdsI24/jlY1MttZJYoV
         1/+A==
X-Gm-Message-State: AOAM5315EtZI6NQ2W/mWAutbyAuxV0CIt+VmPnEjrR7VSaLN+9Nj5v1V
        +Wo2awiD3hq68DWDUBp1+sek4EqefLysnK7fwWp45g==
X-Google-Smtp-Source: ABdhPJzRA09Os35MxrURwq66GBXME7v/WCyxoVco5IwR5ofnF5p/aH09aiSipEl0/QBCGFZOsTOomcY7oAiNUhVH4IU=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr7403919ywh.140.1650661055368; Fri, 22
 Apr 2022 13:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220421091055.12d6465c@canb.auug.org.au>
In-Reply-To: <20220421091055.12d6465c@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 22:57:24 +0200
Message-ID: <CACRpkdaD1G9J+jTJH4oGrcF_dinMjBjHCGMJqRZh8FC0dy+Xfw@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Caleb Connolly <kc@postmarketos.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 1:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In commit
>
>   6548c9dc711d ("pinctrl/rockchip: support deferring other gpio params")
>
> Fixes tags
>
>   Fixes: e7165b1d ("pinctrl/rockchip: add a queue for deferred pin output settings on probe")
>   Fixes: 59dd178e ("gpio/rockchip: fetch deferred output settings on probe")
>
> have these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Fixed it up by rebasing, thanks!

Yours,
Linus Walleij
