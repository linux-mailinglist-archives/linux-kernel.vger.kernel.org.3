Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939604BCBA7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiBTCKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:10:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiBTCK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:10:29 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE433135A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:10:09 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id e23-20020a6b6917000000b006406b9433d6so5891483ioc.14
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GsxtTaRJylm25mi2kyEsvMoswXN+IqBXVjyQu0VFrJo=;
        b=e8ett1gUmPqgd8pZvSSPRFme3UxdRy8cYXTCbmAxTOw0DrAIEUZzThjSt3ywPAuOc2
         jM7iJMMppdINmcq6g9o3Nm/vOxeXMt5Ke9HsYYoz/3hUK1vY/kN0DwltBldd9QQ++KVl
         ZJmvNWeC4p7w2C3f8tDSs33m3nRGQfu0+vu0DAK6s2DQI4GmhX7yZLc6WhTmJ5XSY3Av
         ZuIfwxHOCAW/8uoF3afPhYblv4+x8w+P5DHYcWFxF2qe6qgCigvi7UTOalxR+YIQVjpD
         Rj++0ST9DYr/jB9kLCyXsrlhgqmieW3fc2x1dIn2qnAyQDtHiCB1RXcXamuHNVCu8Kfa
         Ttfg==
X-Gm-Message-State: AOAM5315HVbr1EKf7lWQL7Dn4Ao5dkl0ihoTcdxe9WlaWrjnj/xQAKAh
        fbgsImOK19k8fVYH9TufWbzjV+9Z293XP0KTLq4A+gQ8eNWD
X-Google-Smtp-Source: ABdhPJxIXaOrysE6lBGo3xzHv11vFxG7BEKQ9JQIUyLaQym6RQ3aaeDfICl2NR+/xmIwah8EOUt/kjWJpRRpZ6araSts/rE1hHEQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:2c1:facc:d0ee with SMTP id
 s9-20020a056e0218c900b002c1faccd0eemr2959152ilu.7.1645323008503; Sat, 19 Feb
 2022 18:10:08 -0800 (PST)
Date:   Sat, 19 Feb 2022 18:10:08 -0800
In-Reply-To: <20220220014715.921-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007675d105d8699d01@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com

Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143dc0d4700000

Note: testing is done by a robot and is best-effort only.
