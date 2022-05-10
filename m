Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA352222A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiEJRWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbiEJRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:22:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD32222C3C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:18:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o190so19232644iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjMlOQV9Js69yelDDoYzxf+n6vZz1PVMWrLc6+SPdvU=;
        b=dE+nuGgAKRdICu++/zfDmEycVTxCSXQaXHpXvI4ruxTsM2D/Iq/+JHtPnIMlUFo6Ug
         dMbXxZaeBb1YpGjy5vr3bl9AuPTMPKujj696L9TbAXqIYwcJetZQkVZen+KCnJavyAkY
         ZdHzRw5eyy02+LzRIPn6giJbziIKw06UB4tJEeOb9VvHKN1oDwVpz3GCtWlQhUeZJxw4
         jUna+CsMKko6GUxPpry1NhwRdj/nQ07XgdSVbz3YSXjeEfV6heks5EurOWQOmT2GZsaI
         BOk8DZcJFqIV3e7snOT1IUhgi/wIN8tWVG5p3gfEaBiPqgReafUOkA4eqwivaWr2oqv1
         IQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjMlOQV9Js69yelDDoYzxf+n6vZz1PVMWrLc6+SPdvU=;
        b=WxDFrh2tLaMGQFvB9WhT5UAqgDJ/zZzj/Q7TMcUlAcz+lZJScsfyjGWWmOtrqjLTp+
         KSn8sIuS2WqoRzSOw/4lBmDFaikACoPG/MqlEUlWjqOaq4JoNkhAgt5uMjBZ0IS+pfxk
         vnFNedIc8PRot5mOP++AFKmImaNt9RKBaBLb1+a5yN4r7BPepYDP2R/lk69mZFdFYrlg
         O848tRcgequyDS/cYixuXzE3IJ/Y4JfQm4Pm1UQrWWoGKs3Nw/4GKoonbmOJTb8aRq3f
         L9SUfCeGoUOt1WiGrIOIrLjEcxUlW27uypnsvluVdma+Q5npMLkn0r1ouZlOow1L/1OD
         fyVw==
X-Gm-Message-State: AOAM532ddnSW5J1rndY9+rmOKhfI3c/ByKs+3tQX3IqSgwrqbumJDI2e
        uJcmPeN/PBr9VjLez6+4+9eB9OQ3EFqC7N0SFLg=
X-Google-Smtp-Source: ABdhPJy+DhXtFqPHmvZ4i6w9CEyOXrtAPmMbDE1JGbZvxF6SGyXKNOJ156tLD05YW5ttTGLCJXt7k/szt7UdCL9SNPw=
X-Received: by 2002:a05:6638:168f:b0:32d:8105:7646 with SMTP id
 f15-20020a056638168f00b0032d81057646mr5172978jat.9.1652203112126; Tue, 10 May
 2022 10:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
 <YnpVJJz9IKyvBfFI@elver.google.com>
In-Reply-To: <YnpVJJz9IKyvBfFI@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 10 May 2022 19:18:21 +0200
Message-ID: <CA+fCnZcnVf41WrFRAV5RzeL6J9tkhTpYSYZrhZtC=jfWjTvXeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kasan: update documentation
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, May 10, 2022 at 2:06 PM Marco Elver <elver@google.com> wrote:
>
> > -For tag-based KASAN modes (include the hardware one), to disable access
> > +For tag-based KASAN modes (include the Hardware one), to disable access
>
> The changes related to capitalization appear weird here. At least in
> this case, it starts with "tag-based" (lower case) and then in braces
> ".. the Hardware one". This does not look like correct English.
>
> The "hardware" here is not part of a name, so no need for
> capitalization. And "tag-based" can also stay lower case, since it is
> not part of a name either, but an adjective to "KASAN".
>
> Or you rewrite the sentence.

Yeah, I agree that this looks weird. I'll just drop the part in
parentheses in v2. Thanks!
