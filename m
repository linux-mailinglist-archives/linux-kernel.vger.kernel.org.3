Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3264E81DE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiCZQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiCZQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 12:00:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939BA36336
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:58:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h63so12188226iof.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=XCZQh+CO+cBV3cmairoGtLj9E24I+oc24tgfoDGjQzI=;
        b=KpryxcE9QrrTM9bwL1Nnywp8QpSjp6x8TOOtBfhu0p0wvr2j4UUnzdmEQOAivQ1bWC
         zxdNnwzJUB/yMWU856rHXMmMYbRgShWzdeg0g+HQVzLsCRW6RAx1mJ7Hz8gdPHsPb+qG
         RJBO82JwNkirlKwvgDKPoH1UzQlrOm+droBMqgobCWTotanDRKuA7I1TkfSZoRsesGdV
         e0jufmfBIyRJxQxXNFxULoPAUSY41Sjlf77qPZzn4Wo1+hPmhu2R6Yo7yFDnfriRiz18
         ySZqN0ffYQksV/IKlEbewuVRBL6Z0/KPojJO47ksx/jXSEghShZj6YvELQkV5DXcUuvm
         /YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=XCZQh+CO+cBV3cmairoGtLj9E24I+oc24tgfoDGjQzI=;
        b=ZuIpQAI8d01yhlbqxzXV4p1/Wr0BKMhhYrBvv4X1kywPDgIJy8xWOS5rcrlaHAiztF
         0EvNnedR9GXOBUblKg9SPitNKqIqNhXg7WLrVbEbibyaF0IfySyRNWhTCFq2UhxhVY45
         67bwDEpxyu5JSd8SpymU35CR1J+ZI7CkN7KDjWWGQPVK6V+wEWfzqYZtI0J+1UDdHQhL
         ZWIFFI4+n80ZZ27b8Na12LvwP9Klr4O98F6dMAi8J+0s7vxY6xfJJHddZxA4y9p2YtZT
         Cf+3Yta8SHMhQhKKA2eSisBv9fzff1b87JGQlDEYVRtSAmuDgUQ9t5SzV84ZIgBK7W2B
         BTJQ==
X-Gm-Message-State: AOAM532DUZS9Wqa1xZ5cLcRR756wFxd+B1GrbjNJMUSiLWJN1sDwXKrx
        mY1UtKWpgBcXrdp0pfnN/IS4YNdopwXAloET2G0=
X-Google-Smtp-Source: ABdhPJyZIVRcCQBHBMOzw1n7FZuKZkY/phDfF9ZjZGl1y1BFQgLUi76c2cbUeWXkDm6AYtMaDhYHm3gbr6qHXnKpyGw=
X-Received: by 2002:a05:6638:628:b0:321:2ffc:7cd4 with SMTP id
 h8-20020a056638062800b003212ffc7cd4mr8260104jar.97.1648310311881; Sat, 26 Mar
 2022 08:58:31 -0700 (PDT)
MIME-Version: 1.0
Sender: tshekpecharles@gmail.com
Received: by 2002:a05:6602:2f02:0:0:0:0 with HTTP; Sat, 26 Mar 2022 08:58:31
 -0700 (PDT)
From:   Precious <precious101david@gmail.com>
Date:   Sat, 26 Mar 2022 16:58:31 +0100
X-Google-Sender-Auth: LG3_F-A5ov9nlokBsgMhje_y3Ms
Message-ID: <CA+d8bw=742RgXYQbjTUDudMF5rQUFFCQZJy2tRW-Tj9ByemQnA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting, I'm Precious from Southern Cameroon, I want to communicate
with you, please reply.
