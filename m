Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE14D3EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiCJBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiCJBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:24:08 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D952B96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:23:09 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2db2add4516so42748167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ws9DDxQhvCEEb7BpXYKAziEzXNx+Th/TR7SYTtd0TTQ=;
        b=rPsL/UBSo75uMp4Kf4nWtT3UmSyBb+aUjlKo7XO76dew6M+tRnOTBKom4Rkf30yX1P
         j/V9sqWLqsUYMqCurq0M4aq8rHEaSLVt4DUdM3rFOmKzAwTBenKB5ytJJ5biMLVwWPg4
         W8tVLU0pNc0c9r4CqnxJP5Wq4xYRDBuSH8jLyXSZnNzc2jBml6ze4twSn6IngDsEOBJF
         mu3B1/CvZo1d34EDoxRvRj2mHhS5lb7o7/KFvZmfgu9yZNZu07ig//34FX3rjgErW4Rd
         FarGDXiXTiFkYCrnK8S0LLn5ooNOx/bkP2jv2KuC17CBMcEuayYvxNPWJGms8PvAZlua
         GAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ws9DDxQhvCEEb7BpXYKAziEzXNx+Th/TR7SYTtd0TTQ=;
        b=HaUNlXPWm8LlldkvJemOFu9CfOkXDEU/jkuLBsJfgkZRQYDGCrD+kKzObgX295GOB0
         YB1fhv0fgy6M8q2CmhswZ6Ws+7T4iYDqaqkIJO0O+9FK4/j3fjAhqWmOIMEd2azGJ9KO
         QD5BI1RcvzDT1oP8gy8cuNTXlOEJEOLP+XkblblHCJhy32ZLDr8LAnfnbmWlDzRNTGeH
         LYxDt+fZT2tSebc+cMNDl0mAAXcZiBD1NU2dKUS4rTzlZCLfXjkDStX3HZ0+lqQznXue
         Uw4Po5c1hmDBin3wpJ1kU8uZzsHO8jur3aYA7T7eABtdf0TBV39S3G2yK+KlXmgXqbOz
         jkiQ==
X-Gm-Message-State: AOAM533ZLoDasJYB1UXvBph43pye3dENF2keHenx8uVAmVt9JTO3dYCn
        ejLy6TQMhtdgGTIxT+735YyUoetPDd8GvDp6w7vlwiQKJy5NhQ==
X-Google-Smtp-Source: ABdhPJz66JQy/7OqGLGZmSbVvxn4N7z0wbJVqc4K4gqb0fIa80CrjLzJgWezBlCYZftD5uvE0w/ZkwVpokmDSpngMmU=
X-Received: by 2002:a81:854:0:b0:2db:255b:dd6 with SMTP id 81-20020a810854000000b002db255b0dd6mr2200475ywi.140.1646875388271;
 Wed, 09 Mar 2022 17:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com> <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
In-Reply-To: <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Mar 2022 02:22:56 +0100
Message-ID: <CACRpkdbxico4SDottfB9Z8PHsXKG4fNA6G0XNyuaY+LObOovuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
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

On Wed, Mar 9, 2022 at 5:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> Robin
> > In that case, it would probably make sense to garbage-collect all the
> > configs, setup code and other stuff relating to older MMU-less CPU cores
> > like ARM1156, ARM940, etc. at the same time.
>
> Right, good idea. These are only selected by CONFIG_ARCH_INTEGRATOR,
> but that in turn doesn't build for CONFIG_MMU=n because it depends on
> ARCH_MULTIPLATFORM. I'll send a patch for these.

Just delete these, I do have these CPU tiles around but they are so obscure
and I never got around to even testing to boot them.

Yours,
Linus Walleij
