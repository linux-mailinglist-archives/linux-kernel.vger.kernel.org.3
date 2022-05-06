Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128EC51CF6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388553AbiEFDbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388542AbiEFDa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:30:58 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C35EBD8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:27:13 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i24-20020a056e021d1800b002cf0541f514so3527681ila.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=SDvk3W1u3Y5B3AQr8NZuKkn9xySkn0Ipmm0MIefyhkC+2uJOe56NOHIJPoCcS/7jJL
         MI3gzQ4/J2VracVKo05bxV+bnRPmOwF3gbBaq82FEOog9y+Ty+2RbKU72SUTBPyU0cwx
         kezhTxa5ErPD9LXqmrPjtoL0ps+3bjCyW/vP0NKm46CytrFErkjxlhzlqrUs8kc+fdCi
         TbXPOdTLu0VOAComEKvsB0i89t4MfedNgI5KTf5Fstl4KkRzyU5MzrPD05elOPnEr+sT
         mAbjPsl2KGDtKMxx7FQ9SnZIz6Tqc2EwdDh66ppb5azuOVB/mwprzS2SZ103KKLzpriS
         3LNw==
X-Gm-Message-State: AOAM530F+Qq3wQKUjJ+jIzouBAKsi5vBo0MCQu+o026yRx1ff0hwAIBT
        9KxGlA9m3n4IpenINVahebdIF8vbLdz3kcwo0By8U1EMD1s5
X-Google-Smtp-Source: ABdhPJyasqX5oxM5Yv8PbXwSyn0fWRPp2AgQrPVu+ljQ1EikqoQmL5VHB/sAxMXahjzDLdO69sBE/BYzVYlJGUCz/AlQ6T3dWt+e
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194e:b0:2cc:4e4c:fc9a with SMTP id
 x14-20020a056e02194e00b002cc4e4cfc9amr526421ilu.178.1651807633045; Thu, 05
 May 2022 20:27:13 -0700 (PDT)
Date:   Thu, 05 May 2022 20:27:13 -0700
In-Reply-To: <000000000000b07a8c05b35e5f65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000347cd305de4f6fa1@google.com>
Subject: Re: KCSAN: data-race in do_epoll_ctl / do_epoll_wait
From:   syzbot <syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alexander.h.duyck@intel.com,
        dave@stgolabs.net, kuni1840@gmail.com, kuniyu@amazon.co.jp,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        soheil@google.com, sridhar.samudrala@intel.com,
        syzkaller-upstream-moderation@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
