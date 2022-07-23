Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5457EF32
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiGWNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiGWNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:21:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BD140FB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:21:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 130-20020a6b0188000000b0067bd829cf29so2666650iob.17
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hmffAVNxlHiOEaYApp52B8xMvW5HPizAGf30S8q82RU=;
        b=KvKQUkJ8r7teD9EL9Org1mPL7NAViAS8zOBcj3JhW3uQBBIrXRDG3BnNoAB9NEnQ2A
         iyQmSrIs+/6ZZUXrj4D3J5WXyNoJ1pFTzz8EvrpBxR2ATCU2P/qBO/P39k1wJsWvm2V6
         VEafApnlXkzYvKqHvuonH1ZmVjgUBoxai0VCpb/7MM7/hJZVNkbq4KbV4jA4SFKb8HjX
         /WEAUxx91r/IY/ztZvySQfu3ZB8OkIS0mRpnZPkcSdex4gRNEHmPZHGQoogvSVIYRHrV
         TBqJL006Wo7fn1Lxd3+Knx2HzyCluBviRc77/GNfUhsRUvyr8n+IQb0CIlGqmy3j9Dvq
         qBfg==
X-Gm-Message-State: AJIora9NZYC8SDvUheifkUI6q51DbE3HHgAPMOg8Wn2ss24D58n11+lE
        CtYcqq99bNZEigXRNQ1goGKv3A/EbiUwRFeWBoW1dlN9/cAl
X-Google-Smtp-Source: AGRyM1tJQ4gIpOa7fvV3PVWav4bilscZ5HguvTEDva3342vs8XKa3YhxyvAz6czHce3m1++6RnT1knWXxDJtmJAbRGYkITLCkBJ8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4c:b0:2dd:bfd:f2d8 with SMTP id
 d12-20020a056e021c4c00b002dd0bfdf2d8mr1728233ilg.106.1658582469220; Sat, 23
 Jul 2022 06:21:09 -0700 (PDT)
Date:   Sat, 23 Jul 2022 06:21:09 -0700
In-Reply-To: <20220723132000.195982-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8a18905e478d258@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
From:   syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, code@siddh.me, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:siddhpant/linux.git/post_one_notification: failed to run ["git" "fetch" "--force" "219a8dc7158a7de03b74c244ef07dcd062b9b3f7" "post_one_notification"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:siddhpant/linux.git post_one_notification
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       

Note: no patches were applied.
