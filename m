Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846B447352C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbhLMTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242466AbhLMTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:44:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B8C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:44:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so56389573edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/bn2QA4sRokY+lW2mdsTbBERIo47tUeAt+yGqnl3lo=;
        b=Sh0+xasBUXbS3UacsNmltTp0MkTV/oG+CZVOKrPRjJVjfnIicuuAMfk55RUBcNdHOJ
         a0LPNIeZDwnZdOGVq4OgGQC4LYdsKQaraEp0aNMWame4VS7gnVm0YgzmNmP7p2NWPgb6
         A2RmLpAuWMJW1dAopi867SmawQF/hfeeQk1/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/bn2QA4sRokY+lW2mdsTbBERIo47tUeAt+yGqnl3lo=;
        b=1LJ7xg7d6ZoTgnj8Apit2qNX8qdykCc0IM3afPt81ziUUCRi5iLKAIomYwiahyY79H
         Pn6bSCSGzUqselFlX8rN63PklGkZ7lNg1lWbuGWEGjpE0R26Rg0hGAegl5yXClNavJqb
         Wa1rchfnx858YYpZWFHdqCDnUiPprGsytPeMItgLnKKpVy1VfhgodNHcb9KmYwAt3tvQ
         sHePVPloreN2SCast0Fqrb1CNHP+TxfFXc6sq9YuANZ1k2ZaSp71z/d2pswsx/yHgUVk
         5R9HZcH4qaiUq3Qe+dCBtJ0yhtnX0SGFGWsGJtA2dLwObLOC9IiEfI+YKspeX0caU9dP
         gz5w==
X-Gm-Message-State: AOAM531o7DJsca3UAKs4HuhSSJDKjQrxYHVdr9k4nlZSK1K8yDI+V4TG
        9KwQf4VJThloQRrOibjh56DdPNr79qrOi4XH
X-Google-Smtp-Source: ABdhPJzlhecMj2wzzBsphhiUmchwo2XsFfSqBiqa52DqZkvnE/l+9sOUhsC0Q+A5rjUQiPODMLGkIw==
X-Received: by 2002:a05:6402:1d56:: with SMTP id dz22mr1047620edb.291.1639424688886;
        Mon, 13 Dec 2021 11:44:48 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id sg17sm6085259ejc.72.2021.12.13.11.44.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 11:44:48 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id k9so11108125wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:44:47 -0800 (PST)
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr611346wrj.274.1639424687470;
 Mon, 13 Dec 2021 11:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
 <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
 <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
 <20211213083154.GA20853@linux.intel.com> <CAHk-=wjsTk2jym66RYkK9kuq8zOXTd2bWPiOq43-iCF6Qy-xQQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsTk2jym66RYkK9kuq8zOXTd2bWPiOq43-iCF6Qy-xQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 11:44:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whoMGTAAyah0jH+rHyAXCLnxAHu8KffrR8PrAXGhTxRdA@mail.gmail.com>
Message-ID: <CAHk-=whoMGTAAyah0jH+rHyAXCLnxAHu8KffrR8PrAXGhTxRdA@mail.gmail.com>
Subject: Re: [LKP] Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Carel Si <beibei.si@intel.com>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, fengwei.yin@intel.com,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:37 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'll just apply the patch. Thanks for the report and the testing

Done, it's commit e386dfc56f83 ("fget: clarify and improve
__fget_files() implementation") in my tree now.

I didn't mark it as "Fixes:" or for stable, because I can't imagine
that it matters in real life.

But then it  struck me that Greg has mentioned that he ends up getting
a lot of performance regression reports for people testing stable and
they can be distracting.

So I'm adding a stable cc here just so people are aware of this as a
"yeah, will-it-scale.poll2 performance regression has been reported,
has a fix available if somebody cares".

              Linus
