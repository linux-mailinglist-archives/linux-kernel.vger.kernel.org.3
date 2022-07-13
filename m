Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04151572E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiGMGc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMGc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:32:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC572EE9;
        Tue, 12 Jul 2022 23:32:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso2010397pjh.1;
        Tue, 12 Jul 2022 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTOHhNS82Zs7gv2Ll8m0Skpw0b8GkGo8ATBrvkVrkA0=;
        b=jGbN0Bbs3ByYTbUOD4XTusC6RAUPWyRYOgCkOBy1FRdDYFnur1Rxm6jMVFiIoFF5LC
         0G4rw3LHxT3HnTkKr4E9se2FnRySdZaiu69zaajuPUCZVKfBxBmL1M/gqf41UWe3L36S
         I+snLJbQcyeasDP/DBer1DfZf99BMhfL27vv7sK8M905YM08llOXBHIc3HqZFtYGzNpr
         uaaFDlvy3YBsYAhnmWu1emt6yvtf2x0XJwMLfBCTPMUO/8Dw57vR2w7xM+Xdrt0OBt0z
         J9wgLX+VMA0y4T4leZRy8eMTyWfS8LxakuDqo1RTwu1zzlMn7RSDfWG6nNb77x3K5U6X
         px2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTOHhNS82Zs7gv2Ll8m0Skpw0b8GkGo8ATBrvkVrkA0=;
        b=it+2YOKE31yAhb39GwR9L/CGyYADv+5eJeZ3IEC2aO0R248ic0+dbmyZ5ynR8koh5l
         0HYn9G7Kq0uWbEAtvqxHlnVXxZWSpwI5ixZ9K5Tn1amNaHEVeZ1CLTRmeyNVqDLHSQ9t
         E3+DppV+MNl74+xpTWVHHbniLRRn8jblSo4hcqSuhYtJ0UgoySKlV82vut2IKWuE0ZbD
         H3jifENZxvkgh3K/F+etai/miqLDz0bZwQZPNFTwzps4AkgvBHn17K1A4ai6GTO8xfws
         +yXpN+Lykef/rQBfkMyrsuBKoK4ld8Y+2DgOyZZxgEa7UJPxLKgr4wFeyOsUnyq5JcdS
         p6Gw==
X-Gm-Message-State: AJIora9ijG+It77Lbf4gtSEBP+7X4HIpqF5i9Sv+MqVgpDJN19iyoBwZ
        ygKVpURlucYveJNNDzEOAP8=
X-Google-Smtp-Source: AGRyM1tW0ynDfRA/BnWLYyXoQigU5zvqJXuBAWNWgH09We8DV2eKXA6HVuVltb/qV4aozKZSIa5BMQ==
X-Received: by 2002:a17:903:22cf:b0:16c:4145:75c5 with SMTP id y15-20020a17090322cf00b0016c414575c5mr1734686plg.127.1657693945494;
        Tue, 12 Jul 2022 23:32:25 -0700 (PDT)
Received: from fedora.. ([103.159.189.141])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79590000000b005289cade5b0sm7901023pfj.124.2022.07.12.23.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:32:24 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        khalid.masum.92@gmail.com, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
Subject: [RFC PATCH 0/1] Fix KASAN: slab-out-of-bounds Read in sk_psock_get
Date:   Wed, 13 Jul 2022 12:32:03 +0600
Message-Id: <20220713063204.6294-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using size of sk_psock as the size for kcm_psock_cache size no longer
reproduces the issue. There might be a better way to solve this issue
though so I would like to ask for feedback.

Reported-and-tested-by: syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1fa91bcd05206ff8cbb5

Khalid Masum (1):
  net: kcm: Use sk_psock size for kcm_psock_cache

 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.36.1

