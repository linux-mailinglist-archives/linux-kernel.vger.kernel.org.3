Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F224C8558
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiCAHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCAHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:41:16 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA1710F7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:40:36 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so5307532ilu.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=U66UnEeJvPbNemSDNTL4SKaNbvdd1FDN4FpcXGghVtc=;
        b=p4OMWNBkBUSyAvymhhYnXqsrlhvkv/sV5xgWM+oD/MEvIW6x/5fKkBD9gtqOC0f+sU
         aXD11bCmnzmpypq+rXAiAS5Vbiwv/4ipTw8uZpUjDVuM0ylnyPFO3olfuSM6TmmrRZRI
         EborMODDpPxMdVgeFDYwqgR5uiLgDVMaborP9l5idSBK7lS44LdUvJoGgvv+WuFqJnim
         nTuOxIt2BDXrCCz6tMWfiM1pzjW/2QWblGwWPBdYerlBfseGv1Z3wDxZi7mjrbrcMAQn
         I4H7DyEicxtUux4NG70+BFd32dHjENHp+S8pDeVlExTbAG9RIqgxMlU93PvctXRn5eAW
         MOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=U66UnEeJvPbNemSDNTL4SKaNbvdd1FDN4FpcXGghVtc=;
        b=gmBf1mWRRu7aCy441L0VYTP+aHKQb3yAzfTNo3hetnMES7UNqQfkZuEyx+Lewgx+Dc
         4qCHINuBgqyTZZFZCzypK94bykHlRzrbjNRqhFQxfHcy/+e1RNYm2r4rvyeGcN+q3LzR
         mfZliZcxwpERxxwSpcFYkK7utIOyG2ZQaeUsB2C1+sjT+AjDvbKDIw6F9cT3HtSrvlfk
         VjjLRJ4sB2r+FH0heDw6A199iaqfS6Blu433z8seBy5U/iaRxmF/6j426ZmqMj1NElb6
         tx6JS7t9BNoKyiQFEJ3G1YbbDDZhnUTzty0q+Irvm1XRZtfpTP7tlYUDca2EZi15vnbw
         ITbg==
X-Gm-Message-State: AOAM530g5YDAH1igIlqX5DJI5dkEjbsT/cLQbHz2gqzgLC8a7+BW9ORH
        logUkcKJfGhlwf/0RLMfonCgVsLU4AafLVbdhr0=
X-Google-Smtp-Source: ABdhPJxX7tWPP+qvYOlcY1KhAllL98gABKEAlwK3+swsRECPkE/96wfrsXuQ45dDQ6OJzhrkzA7ZE3IPh1qanOt0ttI=
X-Received: by 2002:a05:6e02:1525:b0:2be:68ac:6c3b with SMTP id
 i5-20020a056e02152500b002be68ac6c3bmr22432329ilu.188.1646120435698; Mon, 28
 Feb 2022 23:40:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:152f:0:0:0:0 with HTTP; Mon, 28 Feb 2022 23:40:35
 -0800 (PST)
Reply-To: eshahat.desmond@gmail.com
From:   DESMOND <infor.commercialbank.uae@gmail.com>
Date:   Tue, 1 Mar 2022 15:40:35 +0800
Message-ID: <CAH=-Mb5YKpzVDdEbLygCXGB7u9CEGPthjoxVpb+VBqag5Q3YAw@mail.gmail.com>
Subject: Hello kindly reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Hello good day to you

i have been waiting for your response i sent you a mail last week
about a huge fund that was deposited on your name, kindly reply back
to me i will be waiting for your reply thanks

Desmonds
