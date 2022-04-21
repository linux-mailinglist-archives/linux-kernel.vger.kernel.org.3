Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1359F50A774
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390939AbiDURx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390925AbiDURxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:53:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66249240;
        Thu, 21 Apr 2022 10:51:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so1459393wrh.7;
        Thu, 21 Apr 2022 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8UaNUL5oKbXOZlbqC77oKUrKBJ0bpPyiwRTd3rDL3U=;
        b=ST8Zj6bL4HKEmzyE2IiiPecSgzSKwlq7kb7nrj/RdUL8RV1aWahGD8+9QlDqdUlV8E
         GUupb5LVZl1GELr5CTYH2CqqeNtNDXGeXkjPE02aC/VDWn5Vz3FmIBekI9ImZdKWznoj
         hPOjr/5K3Avx7E8aI1Jc24cb7S8FS3QPeEw2hp9ACFK5y0gjPXT2bEHeXA7VusY49gU0
         Lu+v42RYB+XTIw2TMWj2l6/d7CwWwrtFbI9BYANkKQQ9w/NrsAM4SdK/JCDQSctviT6x
         AvhL7scCPL8johCRU+ZqIvFQbzfU89rCtTCI0GP0pihpt3JWvLUjshVGyvyFG4LQRQnV
         JfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8UaNUL5oKbXOZlbqC77oKUrKBJ0bpPyiwRTd3rDL3U=;
        b=1h1v+5bYYMm0We+NR2wKVc1HCeJL8oxfPUePVMCJs4tmm7bNEYaTFgEHgvhnIk0C8F
         DnGdGpeikx/3sFAUefU2d9eI3C35eA3T31UEHr45DAIo7nPgmadUft4chpHfQifkJRze
         ZJPtyqE5Elz/aQ+Xk9y85KiE+Q4+nu+4JXBMcG59XEaJ2h8LPYkr5R7BIVil1DZzYwOI
         8gTwdAa7NPQcMKQXnL0Jr2uSoAT5Z4XX9rOXbTVBkZAJN7BwckRMOsXyF0jWILaSPx7x
         MWFiknWnLbQJcs0p7vQKW5zJ9RXkMUTGge0lc/CPKanYQe5ram0vmsJL/qY7gV4w39S/
         ObMQ==
X-Gm-Message-State: AOAM531MtKnvXkylvLlzwHteZJI/Gnublz+Ko1/1g1pGlT/6qMIiTFkd
        Gyhj/n5TYAH6HdDAIrp5wk8=
X-Google-Smtp-Source: ABdhPJydfQ5pFiUcN+2puVV/o6uCQ998PigwElqlg9csMTxYVk2T8+somUsREpKvrPheUDLDStLJ0A==
X-Received: by 2002:a05:6000:156c:b0:20a:8397:6d28 with SMTP id 12-20020a056000156c00b0020a83976d28mr615523wrz.363.1650563460486;
        Thu, 21 Apr 2022 10:51:00 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm2685634wms.8.2022.04.21.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:00 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 0/5] DIGImend patches, part V
Date:   Thu, 21 Apr 2022 19:50:47 +0200
Message-Id: <20220421175052.911446-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series is a follow up to [1], [2], [3] and [4] upstreaming 5 more
patches authored by Nikolai from the DIGImend project.

Patches 1 and 2 are documentation improvements.

Patch 3 allows to create a keyboard interface to the tablets that have
a "Usage (Keyboard)" in their descriptor, like for example the Huion
HS611, which has media keys [5].

However, some of the tablets that have a keyboard usage, also have an
invalid pen usage, creating an invalid pen interface. Patches 4 and 5
allow to disable it.

As always, many thanks to Jiří and Nikolai for their work :D

José Expósito

[1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
[2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/
[3] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204111653000.30217@cbobk.fhfr.pm/T/
[4] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204211005520.30217@cbobk.fhfr.pm/T/
[5] https://www.huion.com/es/pen_tablet/HS/huion-hs611.html

Nikolai Kondrashov (5):
  HID: uclogic: Clarify params desc_size description
  HID: uclogic: Clarify pen/frame desc_ptr description
  HID: uclogic: Pass keyboard reports as is
  HID: uclogic: Support disabling pen usage
  HID: uclogic: Disable pen usage for Huion keyboard interfaces

 drivers/hid/hid-uclogic-core.c   | 19 +++++++++++++++++++
 drivers/hid/hid-uclogic-params.c |  9 +++++++--
 drivers/hid/hid-uclogic-params.h | 17 ++++++++++++-----
 3 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.25.1

