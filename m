Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8252F1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352175AbiETRyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352351AbiETRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:54:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D738185410
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:54:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p139so15376067ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iApAdyBX8ilcGDG8gvIwdHm4qN+IMFua5cISFSS7Cfc=;
        b=B+rcO9Cf3hWEhVg8pGKEqlPG/bloz6ugIfqlnsZUR4YGABayH9/9wpTXUXNuT7hbWR
         2WhsO+0vg5oPL52Cv6BkQLugaiF2fg54BlMy7gwJqJBLLiqDCt9SjBFm+CLxZU/R1ydV
         c4VTCsH2JXA+QDMzte+jLWNKo8xtir4fRhguk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iApAdyBX8ilcGDG8gvIwdHm4qN+IMFua5cISFSS7Cfc=;
        b=q2yxJE+MDqzp4YI50zJu/AMReVgkAio81of0mkw+kKc8MylFa6d2VLcGERzvrMmNqx
         d2nWQAkMvAOR8NCfQ6dZqWBqQx5Xef0XMONJyCHBAr4vmIL9VUyPYhztsE8vv6l4Shxc
         7A2U+BMJfsyzfAMYJUVpoNmOKEn2HkB57SpbfGQ6CgP6/KOdCzeFkfXdUjS70tSyaJYr
         yLm7t2WmISdzn6qbQUoRyhHgEiA11hOpAIAygwz3ZvBoYvszr0f/Jf+iHlbQJxpUqeRd
         rNejL7KFupzV74iuiBSIEKU0U/+t3fDlCgjo221FUUxsPmdYnZs1CH5jarkB8Eqj4U7U
         g1CA==
X-Gm-Message-State: AOAM530q7xNMl2YdRZuuey5LyZfF5rVQZcnS2U8Pm9xuZzr5BtUhcDXJ
        rVQPBbUycDP6XLxJ7tTcGoy4yGPlD5XLFk1Ro8uv2g==
X-Google-Smtp-Source: ABdhPJwIhh8yTz4dzzAk7wj2hCgyY+1vKToTj62xyVZw/o722sTV3hniOTX3c5D6FummiSKEVhTO8GlyC0kJptSJLks=
X-Received: by 2002:a25:7695:0:b0:64e:b01b:c94c with SMTP id
 r143-20020a257695000000b0064eb01bc94cmr11168738ybc.35.1653069242275; Fri, 20
 May 2022 10:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518132345.40615-1-Jason@zx2c4.com> <87v8u0i0vq.ffs@tglx>
In-Reply-To: <87v8u0i0vq.ffs@tglx>
From:   Kate Stewart <kstewart@linuxfoundation.org>
Date:   Fri, 20 May 2022 12:53:50 -0500
Message-ID: <CAG_66ZSHrHpXu7mJ_-67QgdL2Ubrxg2BAtn3n3YECdHYDHtSDg@mail.gmail.com>
Subject: Re: [PATCH] siphash: add SPDX tags as sole licensing authority
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this bit of cleanup Jason!   Much appreciated.

On Fri, May 20, 2022 at 12:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, May 18 2022 at 15:23, Jason A. Donenfeld wrote:
> > The text "dual BSD/GPLv2 license" is somewhat ambiguous, and moving this
> > over to SPDX is overdue. This commit adds SPDX tags to the relevant
> > files and clarifies that it's GPLv2 only and 3-clause BSD. It also
> > removes the old text, so that the SPDX tags are the only source of the
> > information.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
