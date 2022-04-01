Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0424EE6C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbiDADiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiDADiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:38:02 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F79F4629
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:36:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id s4-20020a92c5c4000000b002c7884b8608so1009587ilt.21
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4CTVOpRlL+R3DgLW480cMVd45Tf3kymrAnPQ8cwHjuQ=;
        b=WfzEx9AeaqzgnYjWTCM3Eh67+PrhcbgbiVrhZlrGvdkffTYPaGasj13scJ6OVN059P
         Qo1KXGVdg7414D/YnL5N+wJdz+L3iJ9u7+avHxg7VexJN3CWmrq2/rnSe6hM5yrwoaVc
         Mh1bMKhleF753t4VhfaBm3YEAAhidEZSBQMlFfjRVRF7DNt/5MvGbWe8+Cx1A5/gJxab
         Mu6i1xMK0C0QxGS9JpfuHFeFXyaqTOrx5oSEmTD1tFRUlKc0tsyfqIAFPgFkxlMlFilg
         CT2OV1DtAH3eW8pImdI+0kt6J+V05vUs0mZ2BUlvGhl/N+tTZr8qc9PgvBmjkkYh6XS2
         M1oQ==
X-Gm-Message-State: AOAM530fVpU/mbsxq+NBtlUzGVcIfcT4oJc7FTXvBUtulV6nJrWtDdPr
        2cMiEajv7cxJpOYbcpg/DqbHT1jiC7y2bhOcZaa+nC8/PnbS
X-Google-Smtp-Source: ABdhPJyPTJAo7j7p54O5jevUsiLvUW96vIvsJSiUQkhbzfRTVaGd3ZKkQWtlF92JrXEgVsuN331iFK8xXal7zrTDeobFHcLMxZjA
MIME-Version: 1.0
X-Received: by 2002:a92:d9c7:0:b0:2c8:7bf5:b85e with SMTP id
 n7-20020a92d9c7000000b002c87bf5b85emr14615650ilq.275.1648784173368; Thu, 31
 Mar 2022 20:36:13 -0700 (PDT)
Date:   Thu, 31 Mar 2022 20:36:13 -0700
In-Reply-To: <20220401032249.4888-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f70c4805db8f7ae0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_xtp_rx_dat_one (3)
From:   syzbot <syzbot+a9dce1ff45c3bbeceb3a@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+a9dce1ff45c3bbeceb3a@syzkaller.appspotmail.com

Tested on:

commit:         ae085d7f mm: kfence: fix missing objcg housekeeping fo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bae4cd50262530e
dashboard link: https://syzkaller.appspot.com/bug?extid=a9dce1ff45c3bbeceb3a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cc67f5700000

Note: testing is done by a robot and is best-effort only.
