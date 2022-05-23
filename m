Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF34531F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiEWXsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiEWXse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:48:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614189809C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:48:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so634573pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OFso9OvgFktevYaqxOetwJ5xDm4GKv24Ll2bnbnpMvY=;
        b=QkIz3JvLpyR1TtHr1TjD3AbVaecKLZqmtTg3pfSwIVC1wz1cPERRI+/CgGRaLqEb6h
         dOPHD5ggLevzSJvcxqlX0WOFL+TlK7tpsGb6Mj9KhmmZaUmEEqwYdfe4Hych4Y0UkyCk
         PwbsTCni0kU6ey9zIvTc9BEnWSHMx2ShsJaA+VkQ2BuBpcidC0AC+WSfdX8KWsm7qQem
         8LEqALTbsMB53LwCnZGrZbOLpi73hS63vnhYocaWLgyXA62S/FTXUaPQoKrJm/eYZVsz
         Y3lN5d5GR6HbWQ6zSRJ0YeLG8N0ooQ3VlGBwpOL+66QlcziRJrxkoVfr3gMX9ZNbK6uf
         uiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=OFso9OvgFktevYaqxOetwJ5xDm4GKv24Ll2bnbnpMvY=;
        b=425cFQ1opeaxaQA1jsoSbmdJ2L8YSQbdV8fwTtjKRsQP4w1nLiSBr86/e5hxB9fwfn
         njQ+S9BZFZIJ5Ei8OoFMrbOFWY+dYOMSCUvhTJ9O4WFbjDSvrcRZNpGfw24luX4XjzvL
         CC/+XqTwuS3INPFrWcSv2o7g/uYrNRNyUfroO9aQ2o7E959WsRF+x20BVq5B8uoA4JXX
         uCvKFco47jSeEKBFOEg7CuGW8i4lEW6XkbAhX4Tn3oabRaRVbSkJdwsT81UShusYw4DL
         IQjGBjo7RYWAM37Ow5A6mDxLy8eTNKFXiuqc+wh8kxAPLFhJAEgcQ24z6q2hIsFiyt4a
         zkNg==
X-Gm-Message-State: AOAM530dcgacfmeTaYYiAK941z3AIOWuApQ9erhwChhMFnxFfzmghQc8
        SjRfHLvTZMMJ1l09dBi0Oh0=
X-Google-Smtp-Source: ABdhPJwDVZXwIocc6GS8s0aElY3RbfweAUNky2akZcg14mis+A2cSTRp71tb2YDtP4dFlmYijbz8EA==
X-Received: by 2002:a17:90b:3910:b0:1df:e147:6d85 with SMTP id ob16-20020a17090b391000b001dfe1476d85mr1528981pjb.18.1653349712805;
        Mon, 23 May 2022 16:48:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090a118100b001df6f16be29sm246149pja.32.2022.05.23.16.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:48:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 May 2022 13:48:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] wq changes for v5.19-rc1
Message-ID: <YowdToGDbq7S3PWa@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A lone commit fixing CPU offline handling for per-cpu wq workers so that
they don't bother isolated CPUs.

Thanks.

The following changes since commit 59f0c2447e2553b0918b4a9fd38763a5c0587d02:

  Merge tag 'net-5.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-04-21 12:29:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.19

for you to fetch changes up to 10a5a651e3afc9b0b381f47e8930972e4e918397:

  workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs (2022-04-21 12:31:04 -1000)

----------------------------------------------------------------
Zqiang (1):
      workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
tejun
