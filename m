Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0FF5ABB0C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIBXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:10:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF145F72DE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:10:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p18so3244257plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YdCqUFWhsJ7rqN+FajMNNwdjukjkfYe/PA1MS40hUx4=;
        b=JzR4Xjn409JlT+JRW3hNdc49L7FPD+h6IH4EuebW+xEZzdPT0/eQacO0YI5JI5/DQb
         tXHa0hF1KIIqDa1yJZRxGZHv+madhxwpakV3O3dTTe8Dc5VnVLyRCL/ZRU/jCW3zyXCS
         JivIDw58Q1ItuPjyWuax7FezjRbsUSFIPPT5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YdCqUFWhsJ7rqN+FajMNNwdjukjkfYe/PA1MS40hUx4=;
        b=JPj3mRDy+f2XoEl13a8IZiKE3OQdhOlkc76k56D7Mjpz8GpNVNN81I+qNs7Obhe8Vb
         MZh8sIEHYLpkoa/IxCRG0zDIJy5dIClG808y9YmBvkw+OyJ/dyNfs/lLfL9D4ZzEG6UZ
         qPF2nn6aBUXlqrzPeQ9AMRVTZeg5niSK8ZUuLW6L0Il4t3xW/mucp/AlXwELvU2D3M6e
         YDCdN7hHYgwgmqhyGFXvUONz6jfv3YwTTRa6C/iGvjh6TA0h1+Htym1bxf/HskPdHhjZ
         jJDFNydugOn5fZxH5F6WDsoJDa3nmxiO74t8xItCba6AuWhDOIfqlMDP3DfGvT/7GAG7
         n1Xg==
X-Gm-Message-State: ACgBeo0obLY3QG4zXTIFEtq4n8hW7fMh31lVYhVdkOf9gJdl3TdgMLV0
        LNqx41K28J73qO8liBUKyJHJdw==
X-Google-Smtp-Source: AA6agR4RcLmbgoajEqMQuDbsBprE4hAPXzi4uym+QkXwfTgGZCCDJC3LZv+pyFcWwtceq2RVUvKhng==
X-Received: by 2002:a17:90b:1189:b0:1f5:1311:cd89 with SMTP id gk9-20020a17090b118900b001f51311cd89mr7131290pjb.181.1662160255516;
        Fri, 02 Sep 2022 16:10:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b0016bedcced2fsm2213538plg.35.2022.09.02.16.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:10:54 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:10:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] entry: Remove has_signal comment of
 arch_do_signal_or_restart() prototype
Message-ID: <202209021610.80DCFC7A@keescook>
References: <1662090106-5545-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662090106-5545-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:41:46AM +0800, Tiezhu Yang wrote:
> The argument has_signal of arch_do_signal_or_restart() has been removed
> in commit 8ba62d37949e ("task_work: Call tracehook_notify_signal from
> get_signal on all architectures"), let us remove the related comment.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Fixes: 8ba62d37949e ("task_work: Call tracehook_notify_signal from get_signal on all architectures")
Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
