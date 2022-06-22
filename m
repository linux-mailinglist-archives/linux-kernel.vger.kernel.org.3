Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998945541E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356944AbiFVExK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354927AbiFVExI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:53:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DDC5FFE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x4so8694324pfq.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w9EQSFAmGXcDrJ+8KvwBniXihEiKbTD4fg4mnulBGQI=;
        b=Xyw17Y3qjDWE4vSIypgVuX9bQ9sZi6CPLD/Eza5LjkapM9acZyPli1ynaA+DQqjY3W
         gCaa3x5cCo72VpFySOF11t2rmt3ZC0vdlEC0R19XbxF+K6WjE0ACpW02nrk2sh2PXXoj
         4IvRXROrmPT2QrRjP9nwE4UBcs9YPpeIBr1Jr81P4JtcyLF08eabIKBGV/rvGEymEJIw
         YvZZ1CWDLKePA9yF7s6q16jZXogr/d822xmifGs+BYmgGVvFvP+LEU4RzcG8U4QxkpFD
         eop6OC732YnW9bEvcGPf4KjThJGn8vGEUtpFPn3iFJILwhYl249Ir01uFanQ8bvyLCpJ
         YAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w9EQSFAmGXcDrJ+8KvwBniXihEiKbTD4fg4mnulBGQI=;
        b=xilbK13oGG1eple+Eanoi6hB5f+xUR/ktoym5JxSo3kAjL/8qInl779ikESFqZl1oP
         X/ba+2Iq2fH7Rv5br+LkYReKxXFw7aTV6C57QNafNmbauIWRDc0Z/UWWA7hbRFiAC9uv
         8EkgKGdD3loCtatDdkkK1yxETGRIXj+UAvmFlMjYrd14aQ/HQ9v745Kf4/9xl98tBchJ
         x3aIjgp8KXu/5KsE7Wgow79wThBCfRf9eMdFrz8zbdrtVuyGYDRhZjbviFDNsqtXeDq0
         QXhILpth41L3P35fK8z1oSZ/z+seIAr+oeO5UZz3ZQmMycVDunYP1FDVM9F1KiJepxSW
         YxhA==
X-Gm-Message-State: AJIora/82rKGGdUOhAL9v9mBl9bEQ+s6/97quSvRAEoFBPUl+OxeLk0+
        w6V3/k/tJmSBMQa09g3xEJQ=
X-Google-Smtp-Source: AGRyM1syBzoM+gI6UQ4DBoZL4CiYhlBCCwEeMwNtoGMrlP28Ob7tqNkCvtNhsP1WfsODlFIOVOdNig==
X-Received: by 2002:a63:e114:0:b0:3fd:97a1:7a5 with SMTP id z20-20020a63e114000000b003fd97a107a5mr1336117pgh.178.1655873586539;
        Tue, 21 Jun 2022 21:53:06 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id b193-20020a6334ca000000b0040c95aeae26sm6791013pga.12.2022.06.21.21.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:53:06 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: Fixed some coding style issues
Date:   Tue, 21 Jun 2022 21:52:29 -0700
Message-Id: <cover.1655872968.git.marcus.yu.56@gmail.com>
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

Fixed a few coding style issues as per checkpatch.pl and kernel coding
style guidelines.

Chang Yu (5):
  staging: r8188eu: Fixed a function declaration coding style issue
  staging: r8188eu: Fixed two brace coding style issues
  staging: r8188eu: Fixed two whitespace coding style issues
  staging: r8188eu: Fixed comment style
  staging: r8188eu: Fixed some blank line coding style issues

 drivers/staging/r8188eu/core/rtw_recv.c | 38 +++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

-- 
2.36.1

