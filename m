Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565D956A3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiGGNdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiGGNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:33:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAEC32066
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:33:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id h18-20020a5d9712000000b00674f83a60f0so9799169iol.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0LECw51ls94LteVZlKugyiTPqr14mVoBcbTQiczvg14=;
        b=hoAKMvgGS/Vn0z0PmtJng7y0ga5en7gXNOSSM8pppuy2UQHk/J7gymmZgTvHH7ETEu
         A6TFzpJ6vcV1uMui71OkpiPoFWQysxEOu4DXPMDyzGX5SfkpBpEvg74/2LfM8gX+VNoj
         G70L2QIbyHBhlGzHNCQUHRIk1tdM9XqKeBqItrfM86wBhLUwbbmClYxnTa97GJuW3Lqt
         17fBpPCe4XYU7rhMTuRCGrv2xA//l47AirrI0X4vHNJStPwBoOISNdWddsBaKs2dTl0i
         EmO7wlA1YgGuu/TVsTAx9+6RtQPfJ3Ru2zU73CCfC2M8kes61JZ5XvxCXo587C+KQgZG
         BPxA==
X-Gm-Message-State: AJIora/+M7ILWpLr3/jOn5mSDyOlmWDw6RBMtD4HzNIybHCSK9jrWZDJ
        xGqoK6jmV2ip+6xoEl8hH1OBPYypLnkgoSoemaciObqDyLhp
X-Google-Smtp-Source: AGRyM1ti6n0V8uUHlPsmTuZ97R5qbB8BzFt4POgr/uCKeesL6DokbgtGbTdnB5ZczlhnTF3XCl/wEmF3rQIEMSRzUKo7Ec52yaa3
MIME-Version: 1.0
X-Received: by 2002:a6b:d7:0:b0:672:70c8:5b4b with SMTP id 206-20020a6b00d7000000b0067270c85b4bmr24983020ioa.1.1657200787697;
 Thu, 07 Jul 2022 06:33:07 -0700 (PDT)
Date:   Thu, 07 Jul 2022 06:33:07 -0700
In-Reply-To: <0ef5a253-f554-4abd-e376-e37a3fbf67fb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045b69505e33720b0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in pty_close
From:   syzbot <syzbot+49950ba66096b1f0209b@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:isilence/linux.git/poll-syz: failed to run ["git" "fetch" "--force" "eab646780d8603fd6348e6bccafebcb1c0ddc5bc" "poll-syz"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:isilence/linux.git poll-syz
dashboard link: https://syzkaller.appspot.com/bug?extid=49950ba66096b1f0209b
compiler:       

Note: no patches were applied.
