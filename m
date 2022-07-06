Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81BC56944D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiGFVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiGFVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:24:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B419012
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:24:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a15so9606617pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lhp1fGKvwPNvsFfAFG1v3Vbo0uyHrO24/F8qohRrG4o=;
        b=TRsoU0qDks4bE5PcZFE0V98Tfj8OdOJ1+B8/RemOIavn7ZRlu4qEFl8Ey+KDlPIEDa
         q+RfpsegBpcL43ZGX1Twpx6xURoNXLhB8+hTEAKfaz1WV60ps5HS0F7F3kKRW++YS5B+
         JFchZcVx5CIVb2fY2Hk3Tf22puSNHCGEuFUqSzUjLyIWNtnqpq1GKoO0dCF+Y3jetJjz
         ydWxtnAFo9aEz2xW97yoU795D1iSalUQvs0m3vwyCabunIBAjHd4o3LtgQO/HbR7kJZl
         r5IwJC5rfa/6VRZpMsQVZryp13AHThbNiuILkjF8jgDlhaemC3MGv3jD8EaL7415som4
         uuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lhp1fGKvwPNvsFfAFG1v3Vbo0uyHrO24/F8qohRrG4o=;
        b=nmljHDDl7F0dgm8MtnWpU0qWM+kGdzNtP893kqzAgCu9FoA6r9isDZwA73wpuFVLsh
         PvkXGpmmiVv5mLGjdE02ZvDaqNpcjYX6Hzt+xCCg1BVgnUctaSTchViSoplxwIK9vChz
         vG4aTYUoH4/U8RzpiDMNoslY6adjwC4xtFhriGMkZct+J1dA9i5KnysJAkfJh08iSSOk
         mAK0p556KzDtiudkaddapLHcnJsgArRIHrCxYY0DUxZSM9YhJX5ilW3dSmqq7se5jg2R
         uTTAEa3DKV43LGxJNlo8XRAFVQm4cduPZUrc9KzmJbVEdQnV5e6Ma49gqQIeGQooQw83
         d4XA==
X-Gm-Message-State: AJIora/yrVyE5nnfdr9ZLa70nejqMin0n2wMR+/9TgcQb7RCUU7hQEpq
        OBwB5GHnnfjMDWC0lMilr1N3628gtfk=
X-Google-Smtp-Source: AGRyM1vMNxnbxtFl/qv8nXCo7/FyRkmRkL9VygDE57x/TUc1m1XNkCtk/aXL01zatnnkHJ/XNfCqvw==
X-Received: by 2002:a17:90b:1e44:b0:1ec:cc44:be77 with SMTP id pi4-20020a17090b1e4400b001eccc44be77mr861283pjb.34.1657142688375;
        Wed, 06 Jul 2022 14:24:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id cd24-20020a056a00421800b005259341029asm22166467pfb.49.2022.07.06.14.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:24:47 -0700 (PDT)
Date:   Thu, 7 Jul 2022 06:24:44 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] OpenRISC fixes for 5.19-rc5
Message-ID: <YsX9nNRJb4qVqYW1@antec>
References: <YsWMXAF3ePlWuxyF@antec>
 <YsWM+im7pmU8MdeZ@antec>
 <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:12:23AM -0700, Linus Torvalds wrote:
> On Wed, Jul 6, 2022 at 6:24 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > Sorry, again with proper subject.
> 
> Well, pr-tracker-bot still didn't like it, probably because you
> replying to yourself meant that the pull request details were quoted
> and indented.
> 
> So no automated reply for you.

Thanks, I need to automate creating these mails in my workflow.

-Stafford
