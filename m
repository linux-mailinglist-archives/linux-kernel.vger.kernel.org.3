Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7E58B9A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiHGFOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGFOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:14:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BFEE0C;
        Sat,  6 Aug 2022 22:14:38 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k19so200595qkj.7;
        Sat, 06 Aug 2022 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=V8UVz/JJ92x87N8mDUF2jufqQ9issBtcACsOaWjPvSc=;
        b=ku9Y4zOjklrVKKJ0eLvuf615qLNYTXZrj3Oje2fyPBp4NVmplmO+zhYlG5+W9rrGjD
         5cUBpouVPMEQWNLJx4RNd43EVSZQiIS8M0ohJuyq46fJXgphAxfBLgZXnoMew0EOvkU1
         oQg31GgWTEJ1SbGb0tsAhUE2pE8TGGJyejaasjY5feIq2QhDWVwVE8aDu8Qo52p5ZmGj
         hl265fsLMWHdAfXPnlWpk1zOkpC08t4KbAr2DZ7RDEffPPUcNO1PNd/X9oB4FkiOPRT0
         JtyUft3GX1jVT7BXEXYReioZSCVvn8ZRBMNvV7cb+ANuVu5SiDaMIfYXlglRt/ylPG4l
         xfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=V8UVz/JJ92x87N8mDUF2jufqQ9issBtcACsOaWjPvSc=;
        b=OEyYPfbaXuaZ7HeudF4LL6yLtaF9Q0fz9uY4T/wkYTqfsSETQpijuJfq40TXUVTa/7
         eY5NBkRZsoEmDBceWxwfxlcIzs4GjC7pu8aLiQE9Vbf7hgtxDr+dKKGTDB+ahJZRJCJI
         68pD1hhQ/qBj4yg9qE8/DZV4RzAKGzFBgM+lOEIWUSxvQynnESN9vnZfmDbSuAVmIHh3
         1Y2GX5nzQS+ovvaWeEwY4n/wf7Ef9qkLE8FzgiW9La+vtDcHwyZvtMJ2Eqsbzd5GoXkg
         khPV+p5w6naIa8ptBG905BLwn8vbinCtj3SnDE8e+X6eW2SIn/vZNIbmVSNX8UVVPJgd
         rVVg==
X-Gm-Message-State: ACgBeo2j+L88QiXY7cHnJrxkbrx+0g9fy4jkM8qHw8tZMZP39NLPaA5C
        i2dZKCsYfbBOE5euMa/ODpU=
X-Google-Smtp-Source: AA6agR5E+alD9yxHjHQl1ufq23nIMjuxNubS2qqDr9pcYwmxxFwjncl8ZKY+QtEEjAGTS8+77CtUVw==
X-Received: by 2002:a05:620a:170d:b0:6b8:fd9c:da91 with SMTP id az13-20020a05620a170d00b006b8fd9cda91mr9873421qkb.683.1659849277505;
        Sat, 06 Aug 2022 22:14:37 -0700 (PDT)
Received: from localhost ([2601:c4:c432:d7:b6be:7200:aee8:de91])
        by smtp.gmail.com with ESMTPSA id k19-20020ae9f113000000b006b5e50057basm6441461qkg.95.2022.08.06.22.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:14:37 -0700 (PDT)
Date:   Sat, 6 Aug 2022 22:14:36 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yury.norov@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
Message-ID: <Yu9KPCxGYUUROdlC@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Sander Vanheule (5):
>       x86/cacheinfo: move shared cache map definitions
>       cpumask: add UP optimised for_each_*_cpu versions
>       cpumask: Fix invalid uniprocessor mask assumption
>       lib/test: introduce cpumask KUnit test suite
>       cpumask: update cpumask_next_wrap() signature

I think, Sander has a new version for this:

https://lore.kernel.org/all/YuV1J7Zt+NzkrWeV@yury-laptop/T/#ma2d7613315f331fac83d8bd5ae22ef740945569ao

Thanks,
Yury
