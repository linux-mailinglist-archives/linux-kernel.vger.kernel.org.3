Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE95468E8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhLFBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:25:41 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:42880 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLFBZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:25:40 -0500
Received: by mail-il1-f200.google.com with SMTP id l3-20020a056e021c0300b0029fcec8f2ccso5923599ilh.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 17:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=G9/xKSRxtk5QZSJ/XYNtOO5L0g94YZRp0/LVH9WHm5j/M+aPxu3cKkRkJSeIwSqpvN
         4ltO9Vbcm58w04LdgiFfYS4JZ1fTUY4CzbIbxd8soHCLQu5YtttTwpMdH2V7grvE+hGN
         N+o3BHzWmP3KpHlvypJSNREKwWATn8GS8ugNlcoa7so8sKHKNA8ln+Psqno8wvR07L5O
         s6IQbXyX3dZr5PLzWWIijHA5Q0CW7adcyxskweVeIFf2tNYW+7qULDhMWqNa0tHep2qd
         omey7sGIsAbqjIH1Rrqe/CbE3qQTDdjXz3dpg2Gia3POw+VKYJ6X4DMQwjC63qElfCaa
         QMEQ==
X-Gm-Message-State: AOAM532m2xNknqjNHJWvF7HPhyOTqJhAdefp2+1T7IqdMoXJLSw/bhH5
        0zbmNbc2odnmmpMxgwIcFSLBVccG0FxuQqilMrpIv/wx/f9C
X-Google-Smtp-Source: ABdhPJy/LFie2vec2wVfvdbXF6LNvp20a0txNPQ2lsWp0Aoj+RwONdCz82+R9QNxfomVLUkwUx0wglERxX6iV6T3k8z+9P4CSiY/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d08:: with SMTP id q8mr38383669jaj.38.1638753732571;
 Sun, 05 Dec 2021 17:22:12 -0800 (PST)
Date:   Sun, 05 Dec 2021 17:22:12 -0800
In-Reply-To: <0000000000004c10220598f8a1d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ab61405d2701689@google.com>
Subject: Re: KCSAN: data-race in blk_mq_dispatch_rq_list / blk_mq_dispatch_rq_list
 (2)
From:   syzbot <syzbot+2c308b859c8c103aae53@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, elver@google.com, kasan-dev@googlegroups.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
