Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7B5395F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346860AbiEaSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiEaSNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:13:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4956CF51;
        Tue, 31 May 2022 11:13:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e2so19789321wrc.1;
        Tue, 31 May 2022 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAfJ7T0Z/J/C9AfxbbafihyH+pzjBT+hZHcZn6iwQ4I=;
        b=o2t8zxMy+2HTUWIwsMd/dpupYxH0UrnK7ChsgSgp1sCKvAXKy9/I//kxlp/2lIyZBg
         T3nxvD0r+UCKByHmvsAZAP4Pq/qnw1kQbCHeUASrKO8co4+TWUbrG/qnXEOtf7qYpabX
         TshhMa7nuRvkIWZfUGhpJ8IzqMHJrI3OVOItufwTmTLN+1UPq5bxOiIppMaP9fz50zys
         yoBKLa26X5nzDOKKP19fPFGZiPp1aErioz6NMZTpl1NADk2tIH9+m/DP0Dj6ah6iM5J9
         20q+yG2cCYRPt/3ZomcUmbiT2l5oXCK0xb2txQ4nqydumqbW9xRL5ZuaVtsQ4/6pgUng
         x7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAfJ7T0Z/J/C9AfxbbafihyH+pzjBT+hZHcZn6iwQ4I=;
        b=F4uiGqJggfN93HSpJrjdWXc19j9ySNd3KsySQb8AfR333tF5nCPKbNY8GIaMvCTPH/
         67HFhbQSJh28UlDC0jhgw0GGEDrjPNczu5KnBXm5JCBfxzNz1FbOYNZic2MPzxAMQx5o
         zbuymKW+6HbeXLH3mozyJV+GT2ekQEOyHySGasf0dy7L2/LhFIzf1GXCY5VMvCgPjbwi
         WQxnWFuTqFKws9qB6Iu3Cmc56FLEs0u8Jg2WZZCkJTYl9iiupgCHN89fz0nJSmHzP6Zo
         9Q+inM3TbswRDgn0AEndOs+ElV6KaCeUgh7668t7CaBtClnhmbSAAT/c72iW1LUnDJEb
         lJVA==
X-Gm-Message-State: AOAM532B6IH53qvOKm9xV+QofldoH3bEvvGJe0bKMtGnt73A8KLh1Y2O
        v/UojM9cbnRArCfFOCpdGlY=
X-Google-Smtp-Source: ABdhPJz7fvKu11hh2N3KIGGisubJ0IyuQmHjMN7t7cHGrIjjOPPaf69Ijakl6FIDT1KykZ4/lFJBxQ==
X-Received: by 2002:a05:6000:1565:b0:20e:651d:7ff4 with SMTP id 5-20020a056000156500b0020e651d7ff4mr52011553wrz.641.1654020784768;
        Tue, 31 May 2022 11:13:04 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm3099597wmq.29.2022.05.31.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:13:04 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/4] Add support for XP-PEN Deco L
Date:   Tue, 31 May 2022 20:12:42 +0200
Message-Id: <20220531181246.190729-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello everyone,

This patchset adds support for the UGEE XP-PEN Deco L tablet.
This device belongs to a family of tablets that must receive a chunk of
magic data in order to be enabled (named UGEE v2 internally).

Once the device is enabled, its parameters can be discovered by parsing
a report descriptor. HUION v1 tablets have a similar report descriptor
but, in the case of UGEE v2 tablets, the number of buttons are also
discoverable [1].

The ability to discover the number of buttons is the reason for the
first 3 patches. They enable frame templates.
Because I lack the hardware to fully test this driver, I added some
KUnit tests to make sure no bugs are introduced.
I didn't see any other test in the subsystem (and I doubt I'm the first
person writing one) so please let me know if I need to move the test to
a different place.

The last patch enables the tablet.

Best wishes,
José Expósito

[1] I don't own a HUION v1 device, so I'm not sure if the information
    about the number of buttons is also present and it is not used in
    the driver for some reason.
[2] https://lore.kernel.org/linux-input/20220516112159.GA74406@elementary/T/#t

---

v1 - Initial version
https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/

v2 - Fix some errors reported by the kernel test robot:

 - Add MODULE_DESCRIPTION/LICENSE/AUTHOR to hid-uclogic-rdesc-test.c
 - Remove unused variable in uclogic_params_ugee_v2_init
 - Add sparse __force anotation in the result of cpu_to_le16
 - Add DISABLE_STRUCTLEAK_PLUGIN for KUnit tests

https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/T/

v3 - This version:

 - Improve Kconfig message
 - Add .kunitconfig. Thanks to Daniel Latypov for suggesting it in an
   unrelated patch:
   https://lore.kernel.org/dri-devel/CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com/

José Expósito (4):
  HID: uclogic: Make template placeholder IDs generic
  HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
  HID: uclogic: Allow to generate frame templates
  HID: uclogic: Add support for XP-PEN Deco L

 drivers/hid/.kunitconfig             |   2 +
 drivers/hid/Kconfig                  |  11 ++
 drivers/hid/Makefile                 |   3 +
 drivers/hid/hid-ids.h                |   1 +
 drivers/hid/hid-uclogic-core.c       |   2 +
 drivers/hid/hid-uclogic-params.c     | 201 +++++++++++++++++++++++-
 drivers/hid/hid-uclogic-rdesc-test.c | 219 +++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c      | 124 ++++++++++++++-
 drivers/hid/hid-uclogic-rdesc.h      |  24 ++-
 9 files changed, 573 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/.kunitconfig
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c

-- 
2.25.1

