Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2A4E8FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiC1IFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiC1IFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:05:50 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA5C52E6F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:04:10 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id z23-20020a6b0a17000000b00649f13ea3a7so8106764ioi.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nRtWCn1LjghzIqUfsdVVE+gyfveDudhr1FJxsjtTVEA=;
        b=m4JewRQDCrTR53NCc3z+1W0KpL1IAfQi+AcxHv9lxTHkBbXEQyaHSDjB8wg169IITt
         v02BOqYaMPjD3xIM87EX3RSq/AjKEJOdh78kg2jUHprwhTcSkUCOAwBTjUCBEBbC8ucq
         KFMMuOLG2JiOwkcNaraugnqEaAy5s/N8hdbgbPGQhB9vFIckXNLa9Qh0cxkRhUV5J3pW
         Sn9RcVuCFVietV4peSUZvKPihwvhbUARjL4PX6HeqEcYgRWzVEgX7cqm8qOMZZ7m82SD
         OrmlGAWd7q/MScNDBJhQy9DnT7ajyK69BW9xIOSLX2OFxOYHQqLMOUTpg0MITQMn7uBL
         lkfg==
X-Gm-Message-State: AOAM531Vl+gkou4kAt1UYviIei52kWMq2/SPqvRh2W7YKj0i2D6nl7iF
        47anxQdVzsZeo8Piw5EUsgycshuxqtuzjlDu/rEP/bgbqbcP
X-Google-Smtp-Source: ABdhPJwVCd2V66G46MtzEKodxqyrRt7tEIw3hFbNLQdaE6yWlpPHdwzfmRtSCU55e8P6O5rwVQ1YiZA+UOw1JP+Iuna7UIF1zGmf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164b:b0:323:5dd4:cf79 with SMTP id
 a11-20020a056638164b00b003235dd4cf79mr4604876jat.205.1648454649659; Mon, 28
 Mar 2022 01:04:09 -0700 (PDT)
Date:   Mon, 28 Mar 2022 01:04:09 -0700
In-Reply-To: <7364962.EvYhyI6sBW@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d244e905db42c1ac@google.com>
Subject: Re: [syzbot] memory leak in blk_mq_init_tags
From:   syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, fmdefrancesco@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com

Tested on:

commit:         ae085d7f mm: kfence: fix missing objcg housekeeping fo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6583b67d32c256f1
dashboard link: https://syzkaller.appspot.com/bug?extid=f08c77040fa163a75a46
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120b3e8b700000

Note: testing is done by a robot and is best-effort only.
