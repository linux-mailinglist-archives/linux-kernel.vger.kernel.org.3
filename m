Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43E84C57A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiBZSnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiBZSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:44 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01C1E64FC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:42:09 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id t25so4040063uaa.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xDMGqR1DOA5+Q69fUpjWiP+mzBXWahQcGJCJREKEHw4=;
        b=hpqSVN9igLk7uN0zom+qWN8wKk2Gzv3qrraY9GkOqmfjuZP6kLHiCM7oF7R3H1xwOY
         nPvHdXr5YZBkNDQGF1X6xC5cRB7jOyFAchoBJoFSOBxYvuBzQcHJPvmdDjGOIHNIUGmM
         3XVipDep++hfHuRHlt0HO0JCxq1LpCKYcY/TEcgEav4IRaxL8wyyOqLHmyixHUCt/ThQ
         MFz2iCn4J4mI4Zydldx6DICtgS1q/GjXZPjDkGvgY8adQN5sU4Ve7eM1j9f0Pp+KlviA
         lcHAmXMQ3J1AyHiBs7Xymv2S1AFSguV06+FRfNDqUsEQDf8ULAcL5tqshu6rg7qhsQsY
         gIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xDMGqR1DOA5+Q69fUpjWiP+mzBXWahQcGJCJREKEHw4=;
        b=jVqVtYEOHAFkEES7ENVri4BTdpNvM/LtRAQxbD9t5IwBBRKibd5X9iStbAs4go2U8K
         57MLbWz8hl3ys0gtGp7ZTauYwoNTWDMO0EJoerJ2LveJbPwWnvrqkZUJavAKgEvHBi2N
         /36PPohTOeu/9+WJ3NIh3UBZnN20AMq8f72us2iF3CPy/YtzM/iw93ecebxLI/9FrmLv
         8mDEidFg0VysKb8QBTa0m10Y3yo0RiHRSsXVwrojQ9QCQx8FjXVFE/DNJkj+vqyviVdh
         n5rWWvuQVR7Kf5R2KHQI+H46hia7cdVKiAel8GqvVP/7ytonfbw7/nKUNjJ+C+U7Wc9g
         AxEA==
X-Gm-Message-State: AOAM533FOFuXocUB5y/K4sbGMn/VhTqDd5ybpnpSAKzECApTN/1BjW3l
        vFsYhtft4T4LhVy1Xi3Th47Sd8SRw8pZ4HVAh/o=
X-Google-Smtp-Source: ABdhPJyZS/2vT0xqfSXreH29AytgJz6VLocXe7ogI6isfo+7Dg5QfF+2wgNCohKYyn+KYaWT50pkE+tdenYEhNFg8p8=
X-Received: by 2002:a9f:3089:0:b0:33c:5975:30db with SMTP id
 j9-20020a9f3089000000b0033c597530dbmr5039693uab.70.1645900928586; Sat, 26 Feb
 2022 10:42:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:bf13:0:b0:27a:2601:41fe with HTTP; Sat, 26 Feb 2022
 10:42:08 -0800 (PST)
Reply-To: ritageorge1@yahoo.com
From:   rita george <george7khalid@gmail.com>
Date:   Sat, 26 Feb 2022 19:42:08 +0100
Message-ID: <CAJSvgbgKsMOVkit7XfQDKH-e8sNYKOfqqdKeHAK5pij1c0o8Vw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello dear My names is miss Rita, i want us to be friends, i don't
know how you feel about it, please  reply me back,
I'm sorry if I embarrassed you but I have one purpose of contacting
you, and I will explain everything about me, my intention to write to
you, including more of my pictures when I got your reply

waiting to receive your message
Thanks
Rita
