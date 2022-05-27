Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F016D535B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349380AbiE0IUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiE0IUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:20:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F66610274F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:20:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g20so4508018edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=q5z3Aufdrp/Gxi62uQV7hECtfAkDuGBcrftkqEmnImQ4nZWtXCDLQSUGZVAuB88pWo
         lNBAmHVQ4yGI5QQ4VX7WIWnnnSxxBk0mNSYbZIXj+OuEgZ29GJyTWu2djYrt4+zeOdKw
         cQ4FKj6b38cPZBQdSDR5F9CYFJRyFKqW8L0y3Mqzcr0vfS6zGoGNjhA8RR8BKj6ms/dk
         3VU/+Lx6y2bXY+1wc14rQa9Z0M6+2q+ckWbFMg5EKRaKiGCH6xXD3Lyvv11Ukga/QoB1
         xBuK08wSFO6Sf2XcQHUNMO4hmwkF7x2sWV2NvChYO3zW1UEBrbahQWtSeVDXqaGwKcW7
         T1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=GL3FYTyjl/6qw+1NLhJRUE/V1QNB60DjwV71OHGt2uOCUfHCWnv+7A/5rQNkqt3fxG
         sVVYb4qfSbYOj0spyqefqTLfoaTs4MzRQDxHDS/drKdqkLUrlohkDysYnzYJqivxG/fm
         QKgIq24Y5fAIQnEwu6wzDl3PG/1bDbyNzwlHQkBHFJlkxBPIkLZL7AKyJu+aHPjXV00e
         LoRAmTcYY29q9sl3J7SqjXe7MAw6D8E7eSSJW0odhtijbFCpQDh7+5PqF3M7lX7phuC3
         LIVK+EeAAzsfkeXoQgjYTSZrJ6kEpeMHsWoTXCvs5IR7HzvNXz++o+txD6U7jFqkjihX
         b8ag==
X-Gm-Message-State: AOAM5316GwJ6f0glb6bFJMo8VXBIsAQKPkS1nf9oWKRNPYqpNUKPrZyd
        boAplrK/Ecz4Df75R70RzfLHqme43B00eu/u1aM=
X-Google-Smtp-Source: ABdhPJyGH2WttTLj12vQVAglvL1i6kowj67BaAF+mTlYsVmet3/ALeTMaRvssWDytofpoNk0nkXRrCqb4sBdB3FnBjU=
X-Received: by 2002:aa7:d6c3:0:b0:42a:cc78:1764 with SMTP id
 x3-20020aa7d6c3000000b0042acc781764mr43470611edr.134.1653639604232; Fri, 27
 May 2022 01:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:2550:0:0:0:0:0 with HTTP; Fri, 27 May 2022 01:20:03
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <ezhejianghuayan@gmail.com>
Date:   Fri, 27 May 2022 04:20:03 -0400
Message-ID: <CAF6pdHzr08vHQ--Huzovdy0=b+gR_90VKvjxFdRm1Pp4YkRnJw@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I engage your services?
