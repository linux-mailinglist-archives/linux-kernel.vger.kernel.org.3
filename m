Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1C4C6FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiB1Oov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiB1Oos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:44:48 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F127F6C9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:44:09 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2d07ae0b1bfso110579597b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEEohAUQ9L+nWT6PUoP5Gt6jqOoXyZ9f0V/2D8nbNfY=;
        b=lk90BX4xnbyZWTu8zKlGX9ObtfkCXh2iyNpncHLflv+pEd7Ed/N6/XNrlOkqDnavas
         mOxXeHnBtBTZDRVXjK8BbElirtAUj+WBYd9db7v/4MPtaToBwF9QGUmQedz5XEozAUwc
         IsSpH+rzUnIp4bQg8Whi6HtQ8oznn7theZSbE+fa/9ojRJkQrwvtRIiHsWj86Q+9oRMg
         Iev+4f+RRmcqYEZuAgzwT0/+2XLjjX0qNPVGmMLVNqs4X7RbdLcaA33Cw7XDTtnRKRs7
         qb7YxNBD3L52cTP0CL+iQFs269WBcLkyK579QnekCL9mcgtS/qvYOpBi4mkMzyc0sRjx
         nKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEEohAUQ9L+nWT6PUoP5Gt6jqOoXyZ9f0V/2D8nbNfY=;
        b=jbW2249EMkdiFUNObO+ydC3TyK2opwlg1mR3Br6MIMioScy+RJkuzjGm7V+WQ9B9Qv
         ku/crEcQwKw3CaLl2NUogsX1LwW7dbLEgRXI7iQ82LTxGQzOU+uLcafSgPzH+TG/NEgH
         q3T2YBmO3qPTTzK2JmSoBytXW/jLKLLay6qO9ShDv2j7tg16EXN1VYXJn+xcIqZOxp1q
         yvI3LIsD9BUUrakcCGdeE8v+WoLKr+J92vI5KyqkM9vbTzpSFVVbjShjYgN3tyoBgyW6
         MIUTik7n0iDx713Mi6aOHZFZ5BS/u1G8nETlg6mBlGFiDiJqYuKA4s+ci4V7M81Wax7G
         /QBA==
X-Gm-Message-State: AOAM5302jMypmKeaSpYPOrYIgqEQ3vE2jbMVbEK0bzMUDQERf775vcnM
        aamcFXmTcA59yB6Hw5y2WKLnmE592Od3NeWZcx3DWA==
X-Google-Smtp-Source: ABdhPJy1x0juehoA04AlsoXuSMPFkbbSoXihjtFXip89aqsyhMnEZIVdSORIdkv5ZMhA+uqdl74pF921MjipQEF/Q2Y=
X-Received: by 2002:a81:f92:0:b0:2d0:5383:7ca with SMTP id 140-20020a810f92000000b002d0538307camr20110804ywp.268.1646059448999;
 Mon, 28 Feb 2022 06:44:08 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
 <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
In-Reply-To: <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Feb 2022 15:43:58 +0100
Message-ID: <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

On Sun, Feb 27, 2022 at 9:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Feb 26, 2022 at 5:11 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > some more pin control fixes that trickled in the last week or
> > two.
>
> Hmm. Am I confused because I thought I'd see a fix for the orangepi
> problem that Guenter has been reporting?
>
> That problem has been pending for quite a while now.

OK let's poke Hans, he usually fix things quickly so it must have been missed.

Hans did you see Guenthers remark here:
https://lore.kernel.org/linux-gpio/20220128172003.GA2666058@roeck-us.net/

Do you want to attempt patching it or shall I just revert the patch for now?

Yours,
Linus Walleij
