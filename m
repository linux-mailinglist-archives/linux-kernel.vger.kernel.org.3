Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98476547BD7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiFLTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiFLTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:35:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4330403CF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 12:35:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x4so4016443pfj.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mcglg5t3zt5+GfVjndH35JT4Wlw/ztKoJYP12BUcGv8=;
        b=OVVrekBtq9gEuZISHsTcfiZh/gVPTNpcBNIqYwU3YZ9ohW1yXrxpxQAUodDEXbH/5m
         pB5xElGIIbqgQVEqOApt+IwsZDnT0eJ+zmVgYonVMmHBDBCkJLukJLp2oVSxV5SnffUP
         y84qzbPld6AcmoWmwxpBggpfKapN/c4nEteBApO68jWsf14eeXahrAIAE9FymBOPmy03
         5RiZiHs9azx38BvBItWdqHRcmYh6D4g8xUNV0Romj5c9ZzA1SGDwF7klkrc/pGPS5Lts
         kU9YQz/gsfpSGcrmD4yt87opMIN6miZHBbVfGi27wKJ/b9N2VCNvuKhcC4X0Tq9ZrB7p
         Ci7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mcglg5t3zt5+GfVjndH35JT4Wlw/ztKoJYP12BUcGv8=;
        b=i1ZQ+Lxwng+tqOA5SXxwlgmF8Pmaj8ePYYZS+V266yfxwAcxMQMjLxjymu7t8vXSKL
         Px88xOn7NGHjOixGEL7XNs8wBRiZjZ878GFJF2HqnayL2U2ZZnWTPNRXPYyb5qqUIpYP
         IgqVu2LeCEYKCQ/pcDy1lm4q0uRv0kWAyilUMArK5xElPLxhNM/KlystfnDNUPIbS+mR
         nyzX8d+EcAZMyUDJIU1QYuaVEQBK7sFC9oJMoKVI+vYIwLBdxeLYNRKVlEsE8QhdIZxp
         YyOlM18521SDx5mwwB5zxIQd/4gH52LvGsg/9Q/GJS3KfUu0nAUUXZiaM2aByV3CS62L
         pQLg==
X-Gm-Message-State: AOAM531KvrB+bnnZwyCJFNlG52AebNQyc25tBLFlGPnWyMJ2BarX3d91
        7Dr7+4k5drVYGqGJBs8sfDE=
X-Google-Smtp-Source: ABdhPJy/K2h8+fFz76BqYi46SQR7uqvT4LzvgGgSu/LeRGBllCIWAy6HYO8Fg1AmzNAYaW5MCzedIA==
X-Received: by 2002:a63:574d:0:b0:405:12c1:5b06 with SMTP id h13-20020a63574d000000b0040512c15b06mr8134603pgm.387.1655062512171;
        Sun, 12 Jun 2022 12:35:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a728200b001d903861194sm5593810pjg.30.2022.06.12.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 12:35:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 09:35:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [GIT PULL] wq fixes for v5.19-rc1
Message-ID: <YqY/7Qcj21CiAvGw@slm.duckdns.org>
References: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
 <CAHk-=wiZyO1CY77vfpJ1oCoKEC=oRvWgqqTfdv4jXiiM7wbjeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZyO1CY77vfpJ1oCoKEC=oRvWgqqTfdv4jXiiM7wbjeQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Jun 12, 2022 at 11:19:05AM -0700, Linus Torvalds wrote:
> > Tetsuo's patch to trigger build warnings if system-wide wq's are flushed
> 
> Have all the regular causes been fixed now? Because if everybody gets
> a warning, it's not useful.

Yeah, Tetsuo cleaned up all in-tree users and the warning doesn't trigger on
allmodconfig builds. Even if there are stragglers, they're gonna be really
few.

Thanks.

-- 
tejun
