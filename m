Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1861591F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiHNI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHNI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:57:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394620194
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:57:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k26so8879160ejx.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=oFIo8KrWFAw4ql69EyYD1EHvN31zfLhd0U7GRD48ME8=;
        b=B4a2+mJf2HDA/4PCrI8aCNsfxS2SO2lsNABzb6OhkpuDOPe6GX6JZa0HlBiWhzIfNn
         kDQpFQIBAaAXJEhjrta9f5VdzA+pHR3hPs+QI1Qi7SwTsMyKxm6oZUplOdm+mm8gktnB
         m1gpujfJvujJ1FrRrJTMkITh+2OM1Lj3aOye6vB7PrBwMloXsr6obx3fjGp7tZz8d+l+
         Qy7llr39UorY+SgQi/4H1vTV0CqZiOWnbZ9RqoUx+OMYEvnRTk7OqUMcd+LNErIMNAXN
         6ERv82tWIBbjEG0PiVMAcfF24lr0eX/OCxBLF8nlfnjyvZUuB0pXO22mo2jsL0HLO6VO
         dNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=oFIo8KrWFAw4ql69EyYD1EHvN31zfLhd0U7GRD48ME8=;
        b=f5rb3KkULVu5PVWntY7Dx/6Io8XSMZGWtkP/46iRM0hBkhdFid1C9a1RvJgI3OBT0p
         s2t6mc14WlwogcYFt3R1jL+cJykmhyTj7DTE+ESKZ265CYSs1eY+qlsg0on8waE8/N5l
         hoxc6zHjaKonarTbxOCJbUm9115rLYQYQiQrGlMQKnnEHhKV65UL5UuBb80tcFJ8R1gU
         B5pvM7A2CqB2+QztmACEOSdiP/cNbWZ9VqMZUbxRrC2EIsoSQfwgYA/11mSNZOZuFRwp
         VZzyJImTr0q/wQSDd9Y7sleWNacBuVYee4R4tFqnf7qJsVHCYdtfUjEEoZDoUTPi85We
         uKBQ==
X-Gm-Message-State: ACgBeo3tMvymmlhZ+cg5oyOEFPoM8egDXgSL/2xLCKnHF+PXBC7tSShX
        eHCZjct3+nV/7n5k+UnTMyY=
X-Google-Smtp-Source: AA6agR47AXq/QFomXS2zUyLkRHiok+Z1qRXDvWkbySUsVtTOvwYFTEf7Xs2nzzi3fksGHzLRB/vEnw==
X-Received: by 2002:a17:907:94c3:b0:730:9641:8dd8 with SMTP id dn3-20020a17090794c300b0073096418dd8mr7481277ejc.586.1660467471454;
        Sun, 14 Aug 2022 01:57:51 -0700 (PDT)
Received: from gmail.com (195-38-113-253.pool.digikabel.hu. [195.38.113.253])
        by smtp.gmail.com with ESMTPSA id t19-20020a05640203d300b0043bbf79b3ebsm4460410edw.54.2022.08.14.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 01:57:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 14 Aug 2022 10:57:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <Yvi5DMkZJlaj2rBx@gmail.com>
References: <Yvd8L0qIbLarxrOQ@gmail.com>
 <YvfQUGLGY7cfZ9gf@zn.tnic>
 <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I think the issue is that "current->sighand" is always safe (and that 
> "me->sighand" is the same thing), and that sighand has RCU-delayed 
> freeing so that __lock_task_sighand() can safely try to take the lock of 
> another process' sighand.

Yeah - 'me' (== current) here can never go away from under the locking 
context which is 'me' as well.

Thanks,

	Ingo
