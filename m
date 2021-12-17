Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD95A478923
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhLQKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhLQKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:44:49 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 02:44:48 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g11so3751112lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 02:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TzW6TXnfq8OtLTLQdwOY4LZWcnWKKswJe+qqMF/4SPw=;
        b=TSV+wUdhZ+XhIOLwMu6BOh8wDDU8ZnkosbiL7jxDaLjMQEAecOzivQtTNizxRa8i9f
         BAcG8kB6nBbUKPvGe7pV3ocepyz66i19r03rlihSmzONLgECONFUjIwQjtq8CkyDtnB4
         X5N32yP4N3lbAaVbEnh8pUB+m2P6FyLPZfLwiD5zOTiaQWoZpBrQv69/dvY2XSYpj4zZ
         jpS5/1IAzLOV3/tgcYQvuAl51mTXa8z3s52UqSGw0cYX05mtDLfGevkY7CasHj5Gtj+7
         12+YtaQ8ADbD5065bGToZQ4orELZj6IfddORIpXNAZohmlp0Ycxfjg2A0reizmljEGrb
         UvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TzW6TXnfq8OtLTLQdwOY4LZWcnWKKswJe+qqMF/4SPw=;
        b=OkPN8ZfmJ1+6vGuEzsKndWxzqgvLLy1jZffw4Y+2UCC4j3HNqK27YV04IlYyhcOfdC
         7a5c9+ETBFMeE26eg4baRGqfI8r3CQ6MyUqdkTwwtuTGHFVis6pgnwFOAan20Uqou3xQ
         aMp3gZ4BypGWajH6tF9j6gBy8+ehyKaDZGIfdgifPjj9065JXQNaNQfMWpxRHRcVj5nK
         vBezf1G/WWVJzEboVy3azo8T6yeUbrxbRBdPyIzX203pL2hpa0DG8j4yOL01s96dah4+
         PvuPIoLHMFeGtU6AjpYZo/UXMmPFgTTrD0hjdcLZDWFAi8kq//BesJa79R88YhmMNwEG
         3clA==
X-Gm-Message-State: AOAM531RD0pY3t0Zc5CCSs1/KRm8SkBA+wMpRW5CgYxQKEYQLhOoFQeN
        7hcPQKX4ZV05Dx+zs7hejkqTqO8FC4iU/K32OC8=
X-Google-Smtp-Source: ABdhPJzZxbSE8jD5Wf4L0wFQM8VQoG7jMyH/Ekomf2TgcqlqEvJF5B4lyBRU1R/5CcE39+lp3swY++w/WlrRqHvksRM=
X-Received: by 2002:a05:6512:11cf:: with SMTP id h15mr2403645lfr.138.1639737887212;
 Fri, 17 Dec 2021 02:44:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:a68f:0:0:0:0:0 with HTTP; Fri, 17 Dec 2021 02:44:46
 -0800 (PST)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <tchanariyempaguidi@gmail.com>
Date:   Fri, 17 Dec 2021 11:44:46 +0100
Message-ID: <CALc1DuOvnj-e4atg15RoVaHTbhJHTai6Z5m72Ftu6eJWcntaeg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQpJIGNhbGxlZCB0byBrbm93IGlmIHlvdSByZWNlaXZlZCBteSBwcmV2aW91cyBlbWFp
bCwgcmVwbHkgdG8gbWUNCmFzYXAuDQpSb3dsYW5kDQoNCg0K7JWI64WV7ZWY7Iut64uI6rmMLA0K
7J207KCEIOydtOuplOydvOydhCDrsJvslZjripTsp4Ag7ZmV7J247ZWY6riwIOychO2VtCDsoITt
mZTtlojsirXri4jri6QuIOuLteyepeydhCDrs7TrgrTso7zshLjsmpQuDQrstZzrjIDtlZwg67mo
66asLg0K66Gk656c65OcDQo=
