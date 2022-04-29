Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA051538F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379984AbiD2SYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379971AbiD2SYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:24:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D0C3E03
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:20:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q76so4057523pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hS0LaDQWfYwQHEyOl3VF+fDGCEpxszaqGhp5xQzuyk4=;
        b=HUWtr6EkStVFk+wq8ZEAJuivguyjLcB8QuphUUr2Y5yf9GwJsBGWcmd+W8dHrH4KDz
         qdchjP79VYAa7/0UrYqjYx24yHbA9V+UY7L7WVViiIF3MfVxL7otyMNqN1ezrS7+4B5g
         m+A0Pa8bBaVQx664k/B8x5eMrw4uMp6sAKRsIDZRtqCxtH7sI99QBN9X5HogzhEL1jfg
         qLpEvApe2fmIHsEJ81HxgHeHg9lyb0/fHmXf5fs8BrFCKuCwxBfmdxlLtO+K1FSPaU+Q
         mQ9xBQ60TFurpFp2ruGreXVyH2NsvTLtPEAonTmyJvAD8SVpEEv0UahEIbir2jZcMWq8
         cSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hS0LaDQWfYwQHEyOl3VF+fDGCEpxszaqGhp5xQzuyk4=;
        b=f6VA/0nAd8wVEJKE15XLaoLIfaxWDdiyxE89EOj6Ui4DGPyDFZoY6JZu2c3ktpLlos
         n3k96u/1rLsHETLVs2hc9Qg/G8RJm2QpCfRqyaGRJ9piB0k2tmsaAAvsWfv9FKzsb/r/
         CXe9bBYHzmpPOQXeAh6M+ol/JUY7SsEWehJkdxZJF8OkCjSuYdJOjz8E4UkEHaEaKcbv
         bZIHLLNDd97aDT1PZb5xwElwJtqiHI7MMvYVKfiVbgqjJWWEWzKDD3wadppc+1zD8T0w
         cxSC5YyF6cz8kjys5srYg7Oanu6fSJGlbV/xMRB65mXzxjh5uBVq1CJScnDz41B+aELw
         pepg==
X-Gm-Message-State: AOAM532twDTo8tfTahy2KAINe52rAdznjbopnn1OwvKznwqSCFcZG6s8
        +l1x+mqJdyVhh2vTj2GKe1fnBgoOLRU7eigVvT8=
X-Google-Smtp-Source: ABdhPJzar2Bb8LyTbdAakX3P3vb5EJiGpYx0O/NkkBJ8hNTdfO78XQ+Wxtahq7xj0D5x3mxFCQJfOw7i/oOK8dBJrKc=
X-Received: by 2002:a63:4464:0:b0:3a3:d8fb:6ddd with SMTP id
 t36-20020a634464000000b003a3d8fb6dddmr465753pgk.355.1651256445886; Fri, 29
 Apr 2022 11:20:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:1d87:0:0:0:0 with HTTP; Fri, 29 Apr 2022 11:20:45
 -0700 (PDT)
Reply-To: ugwumuruu@gmail.com
From:   Ugwu Umuru <ugwurugwu@gmail.com>
Date:   Fri, 29 Apr 2022 18:20:45 +0000
Message-ID: <CAAQmaaSMFmYY4kKGjZubceuZuEY80=LHx5DMCocV-miKH_B2sw@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5039]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ugwurugwu[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
How are you coping in this period of global uncertainties (WAR & COVID-19)?
Hope it's well with you. I have been contacting you for quite some
time now without any response. Could you please confirm if this still
remains your email address. I am an International Consultant. There is
this important investment prospect by a German national which I will
like to share with you. I an therefore awaiting your feedback.
Thanks.
Ugwu Umuru
