Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8655526F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343744AbiFTWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiFTWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:25:09 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2FC13E3F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:25:08 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3177e60d980so92025707b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n93C0vcaJqb78FIO6WlUdPQXhs8rR4PY+fl82JmPDc8=;
        b=C41COq2xSle1WN6qys6phrTq+MeWSo6vh/QF8YYwrjVNtthF9sph75HfeYsMzf58JA
         BbcRURv/bfmvJpxT9slwyKhGCDjpFO4jRrE4EqhAvqzmE9KbBLXs/8PyUzo+8YYvdRwr
         xqmac0GESk2+14P6gEACxsxDmRWFMr6WbPeUE2pJ8XbhoADmomx61p7SGQ8n+XB/uY8f
         cP1uIFNX6nSLfGkcd8cTkCCIdXtOCrKWiywtsupj3Bcvo1ZOxGQPnwdJKYSo1gwpo0cA
         lHEz6z6a/s9KS96l3t62vf8TYVKyHRJSJut9CqZTsosVGu5uDx6tjSoneXyftw9WJK5A
         t+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n93C0vcaJqb78FIO6WlUdPQXhs8rR4PY+fl82JmPDc8=;
        b=Eup2sbI0RE8Yjk5CfqckeF/zeR+VULxUDYkH7h6hUGZaMMrfZ2H+S2fTntlCMDLNVW
         l0v7Qt2jJlyAFvW7ir+M29OIVddGxrDfs+j1B7VfzdXrhOhUgvBWWyzXUOv28oO7t0Zd
         /Kfmhg9cxHx88Q3P3JoXDdRrbei+UEJvhrwBNHJ0BT018o/TH5xcXullZ0cJGlppK2nI
         4gitIePVZvVFnkegCjO6aA1MV99pe9RDPZn6e9462Bxr2H+UslZXViZxAgWmFooYYWuG
         88PHXuOP7fRywQHpTWFhWjYpe6AEf12TQFGXT7vjzAUThGEfBNO1kEv+48hK7c1Ebps4
         bNbA==
X-Gm-Message-State: AJIora8A/VhV9+PHzYTNlyotJMCItRvv5tygXngbrReADCwIy2P93vZR
        A6Zb8jgdWocFPLVS/rM333G11M0Xzk2kEZVqoz0=
X-Google-Smtp-Source: AGRyM1tyRDWf1K91HpEWmpwV6SK4VX1oKf4umwNM6lWgTPMe9Ap4zjLbUs3lpNr9969Hy6e7qauG1rZUxVQZEEzeOhc=
X-Received: by 2002:a81:5a86:0:b0:314:1495:8491 with SMTP id
 o128-20020a815a86000000b0031414958491mr29754232ywb.419.1655763908195; Mon, 20
 Jun 2022 15:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220618015642.5958-1-jrdr.linux@gmail.com> <_2lEhqJcf7dWZ9gxUFTqACIgfM7O6Mnus7HdamgrIT3zwLBiP7Quzy9MLnuFk5EYQAobBEa9UwI-1SSgEhmsncVEsKai10xWlJk8LvRs-W0=@emersion.fr>
In-Reply-To: <_2lEhqJcf7dWZ9gxUFTqACIgfM7O6Mnus7HdamgrIT3zwLBiP7Quzy9MLnuFk5EYQAobBEa9UwI-1SSgEhmsncVEsKai10xWlJk8LvRs-W0=@emersion.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 Jun 2022 18:24:57 -0400
Message-ID: <CADnq5_PrraeJ+ffvegLMWEowz2fUizGqBkwnAPYiK3fmV4E7jw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused variable 'abo'
To:     Simon Ser <contact@emersion.fr>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Kernel test robot <lkp@intel.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Jude Shih <shenshih@amd.com>, xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Wayne Lin <Wayne.Lin@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent out the same patch last week.  I just pushed it to drm-misc-next.

Thanks!

Alex

On Sat, Jun 18, 2022 at 1:38 AM Simon Ser <contact@emersion.fr> wrote:
>
> Reviewed-by: Simon Ser <contact@emersion.fr>
