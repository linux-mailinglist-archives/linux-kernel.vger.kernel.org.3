Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED0527C76
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiEPDll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiEPDlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:41:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63702654F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:41:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o130so9333101ybc.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qbprg47mGff8Lx1bZNFprPokgJzmTbqarB9U8g9864M=;
        b=qQVsp07KIB+qqikjoNoppCVqqixSC+TdjhSj0lw9Shz8BK8rlDc6mguvc4fKZ2i88u
         RWB73JoN9yOKoxVTofZYB3x7wh7h8sbSq5/YzBWQQLDuOV3m9v/SKdzl0Mt6e41R2lma
         smsSoxYLF9mncbtOA8o75RLdx5Nht21UovWtTIuvLf2ZRFSHsdCMZiw6VO/KoiAlKKYJ
         r7JIWg8vhOk6dQ47oBLNtZe7bQ8kxbmS+FCkUyqyGZ6RuRA/IOc1koDfmzcn+PQz1Arg
         opLGJRKWRLtjiG+5EwolqnaFqw6Rinbejee+KKcPu+PVutAocnwPZvKYtCSHYhSLtqbb
         5lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qbprg47mGff8Lx1bZNFprPokgJzmTbqarB9U8g9864M=;
        b=F3n8t8zB04fKvU6v38YO1h8rE/Vci7Jpz0SMSUaahby+Ji78I9v2OAooTQNdLJu6az
         7o79MWbjhtZMUwU5S17b31i7hhQByrreOf480maj0CarereDbh0JlQ5HqK0p7HVWUovf
         VkHgr8OOIN+DNUPkXCpfFdiqbfdsm/PYaWVF6lCdisA9XcJzy3mxdk2clKtPNdRkGo3u
         knD2/tbVZD+uK0xM0mNLToXht9X2YHbbtJwiEof238WjGAKl6hLRi9k7HzhggtZnw2ZV
         pvIcuKxWn20BCo7vzAYnQ4umXKKPZlmI+pTpJzbpvQ5GZhd5U5wsJFbfE1nqCPW+77Gc
         gW5A==
X-Gm-Message-State: AOAM533wWVfPDlty4MILUNwiEbRr7FFSqPCzlTX9RDr+y8QthoUYMP/a
        Q4Iep61IukEZ2weZayE2oUDRnzDc9FzkhAUf6kuQGo1Tv0YT3Q==
X-Google-Smtp-Source: ABdhPJwvY0sEFYZCEgYeIEUezMSQCUJGsMEhgjYkd1Z8WN/u/+26UNGKXQSSU0oaW7KAg84fs3Bmi0JBEKc1uHlDoQQ=
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr6664614yba.89.1652672496049; Sun, 15
 May 2022 20:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220516030039.1487005-1-bh1scw@gmail.com>
In-Reply-To: <20220516030039.1487005-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 16 May 2022 11:41:00 +0800
Message-ID: <CAMZfGtV=wympkmEkc9VbgBON1K730s5CdaQ8Qghn0MfTeNEj_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/page_owner.c: Add missing __initdata attribute
To:     bh1scw@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:09 AM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> This patch fix two issues:
> 1. Add __initdata attribute according to include/linux/init.h:
> > For initialized data:
> > You should insert __initdata between the variable name and equal
> > sign followed by value
>
> 2. Fix below error reported by checkpatch.pl:
> ERROR: do not initialise statics to false
>
> Special thanks to Muchun Song :)
>
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
