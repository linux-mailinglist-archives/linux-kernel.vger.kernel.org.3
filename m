Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1114C4E1DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiCTVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiCTVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:13:47 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC461760D8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:12:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x4so14857456iop.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yzq93xtEK5Ypv1Cyb7lhCiwNr/P453Ucxb4rl4WdV38=;
        b=ElcsB4TYJb9n+5lEitobm3ZSjG3fkDFL4FH2b5LtN5EuGK2YoxHWRIyBVXcRbZqTrh
         OQ1EpTA2na4VWdB9XKHqjKsdyCgN6tePkJ6dc7+GxsO7mMmhIVxsCRwKMK+N9NOQ/HNV
         LlS7PghQOViEjUvwusdHtnhkqHXSt0cmZy1CSD+vcurd6bAoHGKk7wf7wRv0Q6+/N7rx
         ewyFg2p6sbedUSmXPqhA7f3W3q8FgrOJzoBzG5jctH9CBGYycpNNOXuUOG5Eu3luxfhf
         CqWoVvlwQe1WFMoawM2J6/gj/1Lv85tVrvFfC/+4TkuStWniZ9LXb5oV3bl3q8XjD1Ji
         ZVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yzq93xtEK5Ypv1Cyb7lhCiwNr/P453Ucxb4rl4WdV38=;
        b=Q45iZy1m8LoP3h3rl2A1iOuQfCqEET81HRqgJ+jsk2skMADo+LTXkWzdVQYzoZAD/W
         FgBlU51x4g84JviNZarC5rZfEBGWZJjWnR788YoMAUMM+QzXRmxxZW+juXHnzBCUv7Zr
         x8fSDHrsdaVlgR4wMjdTPlwYlbNQi/QlcNvRSvEuPSjfj5CBwUkL0NZGP4QCmYf7CXh/
         BQLmC6iVbmkY8X90ZpK+VwD21MGpEpVplLAA2VAgDrYZPivMoaNgKqWkmlJjk+0zVi0m
         FDAH0uB4y8g9Cp93YsihIRjl2y8av51DwLIFOe4ft9Lxem/S364OfVXXwsTmjwQ5MaJO
         2uxQ==
X-Gm-Message-State: AOAM532YMHcFmlSOseZGJ4zl4qeLAEyUcfyrNIaaet7KIomt9zKEMHGV
        WiNA+EQOxqhq27WefwahfKuqRDL39cFBMYWqwFY=
X-Google-Smtp-Source: ABdhPJxXUF1MDgaHESvndGgNAfueV5hDhUmlQZXL2rsHzov3A69R7SKlyP5c9fE1iCLMyjpZiFZXIz4EviVnVZvBtDo=
X-Received: by 2002:a05:6638:1351:b0:31a:299b:6d87 with SMTP id
 u17-20020a056638135100b0031a299b6d87mr9859261jad.22.1647810742908; Sun, 20
 Mar 2022 14:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
 <CA+fCnZe-zj8Xqi5ACz0FjRX92b5KnnP=qKCjEck0=mAjV0nohA@mail.gmail.com> <CANpmjNN-UPGOwkYWiOWX5DeSBWnYcobWb+M1ZyWMuSbzJQcFsg@mail.gmail.com>
In-Reply-To: <CANpmjNN-UPGOwkYWiOWX5DeSBWnYcobWb+M1ZyWMuSbzJQcFsg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Mar 2022 22:12:12 +0100
Message-ID: <CA+fCnZc5Kz5AdttmbzC_Jj8=Q_yNz_iOoa9Jiu7trK8tVm+w4g@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Florian Mayer <fmayer@google.com>
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

On Mon, Mar 14, 2022 at 9:57 AM Marco Elver <elver@google.com> wrote:
>
> > Another option here is to instruct stack depot to get the stack from
> > the Shadow Call Stack. This would avoid copying the frames twice.
>
> Yes, I think a stack_depot_save_shadow() would be appropriate if it
> saves a copy.

Sounds good, will do in v2.
