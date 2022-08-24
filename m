Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B881259F61C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiHXJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHXJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:22:22 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB44832FF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:22:21 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z9-20020a056e02088900b002e35dba878cso12243037ils.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=rLUDX1c8FaovIu6S6cWyzRaX/BT1dxXTZt6s4VCw0o66wBB857ox1Hakd6jL90j092
         23SkMsF1oND+OfEn1ntbvQunC7SPxzhpoZZcOojZivkjkk6wvDz+uAIzBxaM8Jpg8YtB
         9YpY9LxXAXS+e3SCo4H2dvfruqOz1/bhsnxeNiwbBb++XjSyu7W+wftksfPEPwqBWDXn
         xOT8MavimAiO8iXt6s2mBr3spgPvlxFM4FKwrYM6whf0eGpPnZHQERupHRWdowvJnvnD
         Prz2KqRYKYy9pVxip2wjzHgJ4Nxi8u1GxKuaM4A3UHJX/GLIUXjV38FqckCDK++rQiB7
         6zqA==
X-Gm-Message-State: ACgBeo1oG6S6DcXYdTBM8PEHTk+6HwKYYhsvke3A6NwlwaSnc0fas/ae
        PG9Oc+ulja0bBxM/E+/Y2Mr2orkK/jG9BuSyGDKTxTMhQQje
X-Google-Smtp-Source: AA6agR6mP2aXHamSsBpvwnCpSKmNwCSi2tgtr0N3coyIek8Yc/zb44/ELnSpufpvajxhye3fmSAykNr+kNPBcTUHWfmsvDw8LjEd
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140c:b0:349:b5bb:5129 with SMTP id
 k12-20020a056638140c00b00349b5bb5129mr10501248jad.276.1661332941207; Wed, 24
 Aug 2022 02:22:21 -0700 (PDT)
Date:   Wed, 24 Aug 2022 02:22:21 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d082f105e6f93705@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        syzkaller-bugs@googlegroups.com
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

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
