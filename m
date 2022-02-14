Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B924B3E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiBMXjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:39:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBMXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:39:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEB517F3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:39:12 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id q7-20020a6bf207000000b006129589cb60so9485077ioh.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Grb5c5kSdJdwVoDr8mgEnXm52MkCmPHn2piUCxXW1xE=;
        b=7zfKFzakcwDvlb9/mn4AY5p/TCrMARUgW0GV1h01gbbfD3lpyTycBoAY6cEuzqxhrZ
         y9Ny8WNF0zYMCmUsSnP3iUcTyiFPb4r/HKqejYBxBfoMnQi35wIZDiixoyMhPJTKYqnY
         m615gHFND/NxAbQSd+09zmeZJlXZ8AxHx0XsQ9Lu8mkBXlDIDNmR+eOu9prIGYMhpAur
         sXtEkLX/GhNK6pxhjS/c9DbfzHXNYDK/H4Bee+DCfVO4rhEmTe5lknWleRZbrn452Go8
         HJ+Y3TWIE39oG+qI4YISK0NPQ2Z1tfOdD6lp/the1ataE9qY14NFnwiTeDzJvawwgXRq
         FIqg==
X-Gm-Message-State: AOAM533TZ/1EJgFaYyLJhpNbYGFSQz/cWyXxRVLfYlqqrwMpXE2o519C
        a5Lz575gRzWvQY3C6m+/TxOCNTVt2hvZ/BdkqizJxdcE7KMc
X-Google-Smtp-Source: ABdhPJxlfXSDkijqJnP2A3+Dcs5aQ+nqWxmousD1TTPcol0yUj2uEYtOQtIEco3RqOEsNxl9QnkvSyIyVzF1aKMXQ/Bql5y8SGuv
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d3:: with SMTP id g19mr6080255ioo.68.1644795552093;
 Sun, 13 Feb 2022 15:39:12 -0800 (PST)
Date:   Sun, 13 Feb 2022 15:39:12 -0800
In-Reply-To: <e58c5085-c351-a7a6-fe97-3da6eb1a804f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c5e8b05d7eeced9@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_es_cache_extent
From:   syzbot <syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Reported-and-tested-by: syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com

Tested on:

commit:         754e0b0e Linux 5.17-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=c7358a3cd05ee786eb31
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1434b306700000

Note: testing is done by a robot and is best-effort only.
