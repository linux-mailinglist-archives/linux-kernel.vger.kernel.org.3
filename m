Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15184749DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhLNRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhLNRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:40:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB9C061574;
        Tue, 14 Dec 2021 09:40:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y196so14813825wmc.3;
        Tue, 14 Dec 2021 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYOb56O0FbcuAWrk5jCm0zPU5m7gkpWd9tRe2Z27drQ=;
        b=VmSnB34E7yOOd9ZQ1y+KsocicIq2xJGnsyBwtpJoRadCzn1sQ6hGGhnQRot5MbDH68
         z+nxp/HLrD6noqT/ZBHVhH5QditXtINCAbkLC5HmkjQW1CUbaj7G9DPG/GKcQS20zF1i
         hAZkIA3Apnt6kPA3UUupEZ0tzlHUfBck/k6noMgHulm82p52fbaXzObOAx2/wvILfCpJ
         FsRAE6hEFnCB9qVhtIbUAVCXjZQe0hwXPImKvqpEP1pZsQi4/pf76ZmmXYyctJRacDiV
         tpKff84hYITiqyKv4Eyi0Y1RqNE0t+V1qzhlO/PH3VLiXHAQdnQNc0qvY7lIgkR6v9UZ
         sA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYOb56O0FbcuAWrk5jCm0zPU5m7gkpWd9tRe2Z27drQ=;
        b=HowGnmZMS/Z+kcEXC0IaLyvrMjVCkWzXmV6wiM9gxDR0nrHvVoGB/s5FO82Wmw/sgP
         NgfwcdgHPCg6FQcyjmtLiyPUjTgoRnhHU4iIbxUXjv/HHTde8QXoziRRIV3wd9dAE8s+
         vwxfvN+i9SYq/JVO411re9hFLnEshpS8sIGMmNIaVqZuxkVsRSfzwokoguo6mYBvwmof
         zu+zfKgbdGAJzPQYyLtQewsTxbtAiwrUvLoXxViLjzz0wyW5Uq2tUuB1YPugB+eURLOn
         i3b24b2oqgya6yiUPyfuP0bbtnifY9dD4qdSFKT6ebCJVQMG6ZPztVoFMpx8hrM5H+qW
         e+8g==
X-Gm-Message-State: AOAM530fetvxgISb6KFGL/IEBhYZVWcrdQhOd/GBk+7VYGGqweMk5tAt
        5m9+VxlWATpmILB9bYbsbbsW6EJCStDDbYZsJAs=
X-Google-Smtp-Source: ABdhPJxFJ6AUg234VZKFM1url5v9R3FOUw9tF5GF1bp3GgW+69uAKldnaJGy9qkVPAvrAkPDQPuxdH0AE0eQUMgSct8=
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr387662wmj.91.1639503624812;
 Tue, 14 Dec 2021 09:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20211214030215.3181149-1-broonie@kernel.org> <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
 <CAEnQRZB9E4uBDuUidiJ+QJnQhGZp43jig4q93Pkw3pSr=K48YQ@mail.gmail.com> <11ed7f0f-ad5a-cae1-035c-23e5d3736818@linux.intel.com>
In-Reply-To: <11ed7f0f-ad5a-cae1-035c-23e5d3736818@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 14 Dec 2021 19:40:12 +0200
Message-ID: <CAEnQRZBQdP53aHSCS35-SO6t_5fn3vX5OBqGtkwj9zP=sbwDMw@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 13 (SND_AMD_ACP_CONFIG)
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:26 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 12/14/21 11:21 AM, Daniel Baluta wrote:
> > Hi Randy,
> >
> > This should be fixed by https://github.com/thesofproject/linux/pull/3284
>
> no, this was precisely the change that exposed a new problem.
>
> https://github.com/thesofproject/linux/pull/3335 contains the suggested
> fix posted earlier. We should know tomorrow if the 0day bot finds any
> other issues.
>
> >
> > Let me quickly send this to alsa-devel.

Thanks Pierre. I have seen your PR now!
