Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF64E331D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiCUWwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiCUWvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:51:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760A92303
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:31:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r22so21805295ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A3Kz4KZvaRiOgJe1t3ngqZtIUVbdUovCXw60tFV+lMU=;
        b=LX5a+s2Ci3x6sDDdQDgxWrS4aTCQiHwx3XKUMhGYaygGZTc6FFrXYHHycZQIJN+jFB
         IYOJWfv2K60k29Sq3Qf0fSPO+HdT6Gca0EZAjBxhcSkLjXIRfz4GXlJv+3VUJJ3iNE/9
         lHUTmSazMXruZaWs5xiYHIBaMuVmSMK8ojDeUS/B/cNW9MP2HS3fjSdqzVsKg+EFp1hv
         UxLExZEyMDV2We/71tmX9ADtvK0gBhJjDnlzOG9YLtdd0FOQju0TZc4XZxAWiX840UUm
         k+Y5XhScZWo/BY45nhf4rzGR9LQA4Hp5E4q0eLneDrFkC0v9XfLWSbv75cv8Mmyr7Q4G
         yX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A3Kz4KZvaRiOgJe1t3ngqZtIUVbdUovCXw60tFV+lMU=;
        b=RPTpOmtjSzptYeeimJa2pSJzXqBdBkOrsnl3q0r9ubdgg+ZwH77Y+NGCCCmgFf4eUE
         ECyEF5akftGXiMd8ZDG6X3g2AqXhqm0k3mLLDGEMzulwlnYEQ4twW9C+koiWEcr0uyYw
         2BFQBCD0sOHaQHc33IeqOE8cDCHO48fGBdBvq6IQ4S1vMteeUPCicjd2pPvLT2OW9gRU
         86nl/a2RNRM8aaZQA5+ifrida9bLE00K2lmt5gVKCE/T534LqL1G5ynK4EjpgYqJ4hln
         B2Dfav6/nkitkT5cLdre6FR8NAJs3BaxZPbIB2JCiPnzoC0HKViDRpEXvbLoeLOWk8o0
         VwBg==
X-Gm-Message-State: AOAM5302DaeIVxtNrnJrJy3Z5YZKdlGjfBDERo2a+c7IBvRr2OkxaSzW
        LJA3R6aOuCiTuBjgz4rG+LaFcxGdK+vY/blSR/5ZQ5cQFAyZ
X-Google-Smtp-Source: ABdhPJz3965Uy4d5QHoOKDMXyHIaR5GqBM6BApFEjEp9cDL7gyzHFIaTOQTamwyHJi5TOyg0hs97x6yCL9tuI57kw0M=
X-Received: by 2002:a05:6402:35c5:b0:419:2c72:66c3 with SMTP id
 z5-20020a05640235c500b004192c7266c3mr10970074edc.343.1647901279404; Mon, 21
 Mar 2022 15:21:19 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Mar 2022 18:21:08 -0400
Message-ID: <CAHC9VhTdj=86GwGpv5bgwVrQp0v1o-a=YKKDw-vC_Er8uKBizA@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Just one audit patch queued for v5.18:

- Change the AUDIT_TIME_* record generation so that they are generated
at syscall exit time and subject to all of the normal syscall exit
filtering.  This should help reduce noise and ensure those records
which are most relevant to the admin's audit configuration are
recorded in the audit log.

Please merge,
-Paul

--
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

 Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220321

for you to fetch changes up to 272ceeaea355214b301530e262a0df8600bfca95:

 audit: log AUDIT_TIME_* records only from rules
   (2022-02-22 13:51:40 -0500)

----------------------------------------------------------------
audit/stable-5.18 PR 20220321

----------------------------------------------------------------
Richard Guy Briggs (1):
     audit: log AUDIT_TIME_* records only from rules

kernel/audit.h   |  4 +++
kernel/auditsc.c | 87 +++++++++++++++++++++++++++++++++++++++-----------
2 files changed, 71 insertions(+), 20 deletions(-)

-- 
paul-moore.com
