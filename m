Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7496505F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiDRVcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiDRVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:32:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C92C101
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:29:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v4so18882546edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7LTWo0OPBrGCZjHYoN1cmnPJEUpa4jNozIjdW1Tjhc=;
        b=En4TB4U44B8KkvJ/oE6YRz8ktzHBFO2hSHQvrSQgM/I7HmDnWkoLceq8ho8OUiCv3e
         E5mWA0s4dFFlcwHdf18d6P/398+fXbLU3vorFjZjmSoyICv0siRicj2wlfEcXsi8nUG4
         u4gsxmjXMnIZAbFF7qKRl5GlhpeDJFS3t/aU6rEG16IG8yrQAJyfN/O33LGJ0qPLd94C
         UpWhiPZuaHS5uRDRVMLeteofq3HLTT6BrnUzikZt50XLXM3bo5xrBZKWfXGjc/48H6Be
         do5u0dX1oc4P60EgwzwKUeCUA/BRmcYkAID84Hidmcdxag7E4TNazut9vePsJXPnefVw
         S6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7LTWo0OPBrGCZjHYoN1cmnPJEUpa4jNozIjdW1Tjhc=;
        b=BTtYrk+8VONg0xgb9KFZKX1Vn0Gs0aQiSC5GE5+ux4XucOATilpQDipSXe8WntzqgP
         vhxZK/YWq5l89N9NtkgrW1y8KvKVmPoWfL0r+tXx8Wn6NZp8lkDoyUiA7SVpREN4rfmA
         geVrHrKxR2FbkyllKsxv+2sAm+GqT+e9g498yeio0YVVjLfZAw8ThumjP6LNlSTcNgx0
         FRFL1gOxvmYT/6apg4f59RyZcb43B4sc/MS49IylG24QPWAdBlaRHJAfGau51Gk/hJEK
         9ePy7gSuSv1PCevTt334/ZAcHB1H8nZkpc0GbiXaIKBduonby6YTyQ7PG8X8JUrcunhA
         ySWg==
X-Gm-Message-State: AOAM5335p/o520OhB1d8k8DpRLNhe2gflbJRiiN/nSMVuJ4J01bOfh1j
        CoPf++Rn9MhBu7hZz+vg+6Q5udl0KzrxfUKPBJGQjQ==
X-Google-Smtp-Source: ABdhPJyV9fmS+hwdvvRUN2r//PwngZikr7xomDByGbznu+vO3elnnfiwHQRO9t3F2pz2zrmStYKSa7R9cdyG24KOkxQ=
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id
 f11-20020a0564021e8b00b0041c59f62c26mr14349493edf.156.1650317394544; Mon, 18
 Apr 2022 14:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220417102807.10b91497ed@19d04f311a0a9de>
In-Reply-To: <20220417102807.10b91497ed@19d04f311a0a9de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 18 Apr 2022 17:29:43 -0400
Message-ID: <CAFd5g46iNr_EnQ1zQGiXk34mND8-Xo3vTykpgKfbr-8_e5OOCw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: change complete_and_exit to kthread_complete_and_exit
To:     Andreas-Christian Hagau <ach@hagau.se>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 4:37 AM Andreas-Christian Hagau <ach@hagau.se> wrote:
>
> Commit cead18552660 ("exit: Rename complete_and_exit to
> kthread_complete_and_exit") renamed complete_and_exit to
> kthread_complete_and_exit.
>
> Signed-off-by: Andreas-Christian Hagau <ach@hagau.se>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
