Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907094EB811
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiC3CAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiC3CAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:00:04 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C6209
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:58:19 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s4-20020a92c5c4000000b002c7884b8608so10596363ilt.21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IseIOXkjbiVc9FdIOxRiy+s/BeCwVlVVfBMa+vQ5dYY=;
        b=NCGoo06H2QQHBvmlQdg6KNrInkg2yAfrT0l6w4mCNuno/Mh5+y+9lnyD41Rq6fB3RV
         dFQP3C8XgNsL9fFKvaN7wEcZMC2j3ThoqczPD2Xj5op4/rSezqYZl1FzYMHqSzCptNMV
         YP+FVJhh2o9/oZ36NkUQoIfmtJRcE/bnJe8pMfab6gEIJ1hH9qgxmBRefdV0FUoEw8GP
         Rh/h7t7WZqTs6Ja7o3rZl7YmHmzaK7kjT2JfWvlR1hqFcv6L9H+1OunHGFy1MP30xheC
         CD9MD/41jjb3LcoMyajG9jXMsZGF8AzAqe1NJ9Rl4sOf1uDwb6pjHVphl3HZkShCfivC
         W/dA==
X-Gm-Message-State: AOAM531NQ6XR3dgJIi7XZCTQ4i3w13QtCPnl3bX2r7J6S4tsI7O094s9
        QqVBnJ6X1fjqawlan1nuZK1ZrtJvovrGuS9cHA250sv6IK2a
X-Google-Smtp-Source: ABdhPJzZsTbs5V+jGlGVIPmp5OJTNAz4szJdfUPGD5BTq859VgJKGagheZr0km8YyX41O8llp18wpjR3unLlE2QdRCrpcxbY+eVR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2101:b0:319:d53e:5663 with SMTP id
 n1-20020a056638210100b00319d53e5663mr18244887jaj.115.1648605498964; Tue, 29
 Mar 2022 18:58:18 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:58:18 -0700
In-Reply-To: <PH0PR11MB5880D90EDFAA0A190D927914DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024006a05db65e1e4@google.com>
Subject: Re: [syzbot] memory leak in gs_usb_probe
From:   syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, pfink@christ-es.de,
        qiang1.zhang@intel.com, syzkaller-bugs@googlegroups.com,
        wg@grandegger.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/can/usb/gs_usb.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c2528a0c Add linux-next specific files for 20220329
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0ae90a195b269f102d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163e219b700000

