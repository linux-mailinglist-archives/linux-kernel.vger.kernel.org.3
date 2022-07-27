Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4F5822F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiG0JUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiG0JU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:20:27 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C465E5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:20:25 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id u9-20020a056e021a4900b002dc685a1c13so10678472ilv.19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=UCm/zsrNGDrUykxewC/HpCzegulevKXjDiQhblEElvJr855wu19JtSe4H13MILtKRH
         RtEGGytAqaGOloj3tCY/tV3M5MV7yk4NoBjKS1H9ZxUpdqPqp3OcReTamLNs8aRFuRGM
         PBYin9WdXsuea8Iv6e3/4cvsWGhkGm92PjKWYZRk/tcK/dUY8Hp+cp5XNf/KiEWTE9re
         1RDx1zx/IFyM30l7OGjSKu5XAmEAEtwFDq4pSnBjQA52nWvJkxPU68x2QkG50AsAzL4c
         xgQ9+g5Q4zLPS0D4krNN5R3J+jsp3yss7mxfdObk8uR895ebZjEJjR5mkz/fkxaqdwqv
         XjWw==
X-Gm-Message-State: AJIora8gUlojRG+hKww6hxb67xNGAqnjOCV4s0KUWb/MCouKJyFAkTGK
        m4O9NZF/6wx3K3EkmkWjktvHCRx5A3jTqcev31HXRqcE17m0
X-Google-Smtp-Source: AGRyM1v/ltVWJlJHyRfkORqGR+witY3Er6p0naC06l+kk7wNaHtLkhDvjcFWPeBQ0VmmCL3i65iAjbIQO7R8MobdoaCJl4FBANDm
MIME-Version: 1.0
X-Received: by 2002:a92:cd8f:0:b0:2dd:407e:74d7 with SMTP id
 r15-20020a92cd8f000000b002dd407e74d7mr6563029ilb.226.1658913625333; Wed, 27
 Jul 2022 02:20:25 -0700 (PDT)
Date:   Wed, 27 Jul 2022 02:20:25 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059e83805e4c5ed5d@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
