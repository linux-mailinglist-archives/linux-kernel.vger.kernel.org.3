Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401B14EB369
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiC2Sfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbiC2Sff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:35:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70BD201BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ke15so15052135qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xs0YVSxqXM6+RJUqS+VnwD5hs9dBgnS+FtAIycO3jfs=;
        b=CJzjq0z6H8P6t3YSkp9PIG3aCvbROZXMvlDEPKMs2JZ+FiyjuRPZ8qcZcjZP/kHSYt
         0L7OqAnI9iUUXpuWviHCKsQDUgZom+UIZl3s5/iqenIxaohEql8Eh8rrDtQK7P1A9arw
         wsiiP5w7ku6kEWaYj32BQ2UIVEsd1w5FZdg5raCVebI83W6H7RLMHofJ7AfQPT7X4yiZ
         KUViLAfyDs5mvMGCYb8M7jX37idURsHcRyzWzkq/HR2ZFiECoLZqo1IBlcDBQjQZi8CN
         g41PuI1+EEMT7h0GneLhMj6XDH2TB3YHhQ3vQL8IsbBhxb5mRyyK+RVQIM9A5KwfbSwJ
         TSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Xs0YVSxqXM6+RJUqS+VnwD5hs9dBgnS+FtAIycO3jfs=;
        b=LQh61X8Pxeu24GEcTVz74DVOOOZGPhzKllX/to6MXXKihC7krz/BUfnJLzbgTM0L7a
         mM3RKPJw7C4R2wGc5mlMt0GuSt2MVdTvomq7ddblMRk4TBrDucXLnIww0mWUa9I+gDWE
         mnozJWGQmUy/pabuZDLLvvS0mq8mseqEUjf/Id9AvDPqnvQ4Mog4eTBc/RpaCMznm1a9
         KRUzHue8T0zb/JveXg8AKoa/iSZeJ5BQboLjpbr7rQiJ65HvvUT0Bwk3HUB/3wIi6w/3
         HvLbEDuBwlkJ0OAAi4feR5cV6uzqgyVYe+g07zS2/Y6iNnJmoT64DoQpZm45S8G/Mhdt
         090w==
X-Gm-Message-State: AOAM533IabRJk1pU5MpC2TCvbfQof2/EF2j/4IMTJfovvYvO0neNNjJj
        /77OKvP7T/nTxM2HVy/8/iq3R1M3fg==
X-Google-Smtp-Source: ABdhPJyz3IG/1GVxQbPMlMH0HAUijtzkB6hizGeGB4NUCeE1fgqDmHfgJsYQNzb3R7ciy/9soefmYw==
X-Received: by 2002:a05:6214:29c7:b0:441:3f11:9315 with SMTP id gh7-20020a05621429c700b004413f119315mr27834968qvb.87.1648578830934;
        Tue, 29 Mar 2022 11:33:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id u22-20020a05622a199600b002eb841fcb6dsm5764649qtc.73.2022.03.29.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:33:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by serve.minyard.net (Postfix) with ESMTPA id BAB141800BB;
        Tue, 29 Mar 2022 18:33:47 +0000 (UTC)
From:   minyard@acm.org
To:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ipmi: add limits on users and messages
Date:   Tue, 29 Mar 2022 13:33:36 -0500
Message-Id: <20220329183340.471474-1-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I had actually already started working on a set of patches for this, but
I've incorporated some of your work.

There were problems with your patches:

* The limits on messages were global, not per-user.  This could cause
  unfairness in the interface.

* The counts were on the BMC, not on the interface.  The interface is
  the right place to put them, as that's where the messages flow
  through, and it's easier to do.

* Going through all the messages to get the count is kind of inefficient
  to do on a per-send basis.  Keep a count instead.

* The ability to flush messages is a no-go.  The IPMI driver guarantees
  responses and internal kernel users (and external users) rely on that
  property.  A flush could break the watchdog or ACPI.  The messages
  will just have to time out.

This is my proposal for your review.

Thanks,

-corey


