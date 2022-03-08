Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D34D1FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiCHSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349464AbiCHSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:19:36 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01783344E5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:18:40 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2dc585dbb02so147862307b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=oo2XJmePFb5oDErsPdptJnurLpOrjhyGiTCBcM40kFs=;
        b=h6mLb7fLhGQbMGjslfy5q0yMPi+HWyTn2UpSDt+E/dpy0TSbIoYKpS7rhc1s+bbBxU
         OofcQ1U9S3ZeVq1WjVaZm4fB08X6f3SkGnptvgIqcNC3qN96c9E9ee1rAVpc95ZVqIBM
         /xAyXLukVgnraNVE4ARNiUsv1N3tpjfiZiPAaTvn1sG3l9pVBzZqWGN/RPaMMfFVyt91
         ltmSktHZTHb58uTYqCxlTV5ad25FQkFgV4PkYJUarXy1dyhi/qwsYTzJkWb1VJLk7XVt
         RtCYKnIK6X3xYF3B1ocLge3rh/mlUMIb9/0hS11bfBiempYmtpgynDO0XWW/SJ6wm6nM
         VFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=oo2XJmePFb5oDErsPdptJnurLpOrjhyGiTCBcM40kFs=;
        b=Wv4/lftvc9UMq847+EH+PY3BRI3J4nDWrtcOUyCs1xFnTZUKh4X7YYg0XYbc/BNq6T
         0T5hdY1oOPmYH2SRHLFzmTe5n8/zWOa3RVWlmoRABin2UehaEwWhp8/o+9O6nz51jMiF
         K+NeSC/w+hYEujTUuiPsr5C8k6Rw7cv5BHOprwvVfKvD1mopCv4olWOMUqvS4mnA4jUp
         pOZk3g7wOEv6vNqzGt8o4zUsb9eowSqXeySqbQjEvKuDzdVzzA0KiFQ3BLBX4BbJohmS
         SqMYMucTkxbKjEqqORnjLbBfwRHqWgii1RxBJQlJAGNdcMMgY5w5zCoHDw4UQi2W/QjY
         RGlA==
X-Gm-Message-State: AOAM530LJwXedFpJXI5pe2j5Z/RHdeErg+tIzTP8jFZ+hLHWMTLPHI91
        eVLSSU2jXqO4ANYPr6oFWDcS6LN4sKjeVfypNBA=
X-Google-Smtp-Source: ABdhPJzbyKm5J6tfZJLcRxt7RGEHLFFZFwdXU7+HBOyEK0CrgSTf/jwbcVAkhsKg58KYlG3c4ANypowG2x3LAoY1EH4=
X-Received: by 2002:a81:2341:0:b0:2db:dd3b:cac0 with SMTP id
 j62-20020a812341000000b002dbdd3bcac0mr13862854ywj.51.1646763519277; Tue, 08
 Mar 2022 10:18:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:b51a:0:0:0:0 with HTTP; Tue, 8 Mar 2022 10:18:39
 -0800 (PST)
Reply-To: blessingbrown.017@gmail.com
From:   Blessing Brown <steveraymond3415@gmail.com>
Date:   Tue, 8 Mar 2022 18:18:39 +0000
Message-ID: <CAEtFjNKCrUyRKnNxy=F4z3jr_dqz1Bjo8ZB-59+7xZjsXLcZ2A@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm Mrs Blessing Brown.I wish to communicate with you.
