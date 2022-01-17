Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14848FFEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiAQB1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiAQB1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:27:46 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43540C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:27:46 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c6so41359562ybk.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2digv+QpmJ4GxkGmzogQsMft19ZdoPKFKzQK1SlSeg=;
        b=MejeoNq0A5npx3dssEP0rb/nU7fxJrxLUw40OQDXbY5tmSWxVaXpKD7qnBTS3nA+n9
         B1MuGtyOzgeLk6Y5oYErBlf/G/UKRYPCPs3ZljeFwIJI2eXb4utCph1Ljh7Nd6HIWNXH
         YGg5OqTpeIr58NdzUPy5h3I0DC2gMcXAqsKHmg6AtfxiD+2/5CTGLArlEdTIZPygxVMj
         r7g4rA84Q4YTeQGtKNjKzC6LTECJUETOyJLmpXDqPCcUD8gNP8SMJZtmG906QIAyhLjX
         hOzRuk3kSomwPzG4y7QbCnFZ9DedGHtbrcJZ4SmRqY/kvrLJuIwE734V0keBrqYqxJkB
         Jdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2digv+QpmJ4GxkGmzogQsMft19ZdoPKFKzQK1SlSeg=;
        b=DX2wdW7FQ8Io8MXn9pDNvkwOmdFwollnNlfQ7wmjQiN9nYpE6elgFatl/4N6KDTrQk
         wmFRkTKp6Fu99j27GSmMYCPskxE1meZ+qcf+tzfBZi+p41bkV++y/DB+6Bo9OBNWl3R+
         Vx6uvBKBt6zAUEyyt6NHyDTCBnlgx84WRqRUoHsaMx0UuXuQRnDST5VnIxiAe3vtpgBh
         I7ZVwQ6RDVEyH5mfA01PlKb+DoukKfh7U56xhGYub3dXeQ3l9FCBkfYaQiwCqzC1bxcL
         CP4YRJmsquHfQd9fMeKNkbHj2QRaBv1oxhHXo4/G1EIfetLFspqaLX5GrQQ7tXLyi38d
         nC/Q==
X-Gm-Message-State: AOAM533GNxvGaKu/FGRigdx7Y3tO6XZZ9L4VSItNSRJjmwKrRsIaC5IM
        BYBi9p7V7O4U4JsEOvSf3VkN36wfCX5P6nMpNFLThQ==
X-Google-Smtp-Source: ABdhPJz8zqhGtaNQSz/m4dCzdhWzfxEwQd+tHTiXpYaIky+sLQ5J1hmqrROYJbKaWoccoZo13YxlfGMZnoOzx4k0HI0=
X-Received: by 2002:a25:a085:: with SMTP id y5mr7021533ybh.1.1642382865156;
 Sun, 16 Jan 2022 17:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20220117114514.5b6daa04@canb.auug.org.au>
In-Reply-To: <20220117114514.5b6daa04@canb.auug.org.au>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 16 Jan 2022 17:27:34 -0800
Message-ID: <CAJuCfpErqDrgEkw7OXyGTkfXiAEDHx=9DF9cW0qdc27Nm1_wrw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 4:45 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the origin tree, today's linux-next build (powerpc
> allnoconfig) produced this warning:
>
> kernel/sysctl.c:125:12: warning: 'one_thousand' defined but not used [-Wunused-variable]
>   125 | static int one_thousand = 1000;
>       |            ^~~~~~~~~~~~
>
> Introduced by commit
>
>   39c65a94cd96 ("mm/pagealloc: sysctl: change watermark_scale_factor max limit to 30%")
>
> It seems to only be used when CONFIG_PERF_EVENTS is set.
>
> I didn't see it in linux-next because there is a patch later in the
> akpm series (not yet in Linus' tree) that removes this variable.

Sorry, I saw the warning before when backporting this patch but I
didn't realize that the followup patches refactoring this code would
not be merged.
Posted a fix at:
https://lore.kernel.org/all/20220117012317.21168-1-surenb@google.com/
Thanks!

>
> --
> Cheers,
> Stephen Rothwell
