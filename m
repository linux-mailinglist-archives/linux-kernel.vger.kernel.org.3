Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30468500BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiDNLMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiDNLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:12:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BB1EC6F;
        Thu, 14 Apr 2022 04:09:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m14so6417411wrb.6;
        Thu, 14 Apr 2022 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SG2NerS/Z9btdgGJcgFtGde6RnsM+bhTINNQTfxg9vQ=;
        b=g2FMOMrRUif0IYzEXY1rQdo/jcqKbEOWK9TtnxucUSAOXEo5raI0rQafKJoPlUzLH/
         1ftaBYIfku03nOStLGCMPsCh4W5jabaqr9ev2E5olnM6Z5D165lrcKBnYQjsp4tq7V64
         QQgqzzcPXpa5yZdWhvHcjq7Mui1Tqgl7dg7uFNMtmraBcT6Sgtc47KnimixNl0cSUs9N
         VZwaI2UUxfWbH/k68fRsbp5KnXt8DDoSmZPHoMtlMf7bNO0UeAzt9PpTTFd2vv51HZH0
         cHc6kgYKariAUgNXQWBlIGPWP5vPFY13ibaqNrPjjbcYgnUWGbUe59AUYBRb5wTJDN6w
         s6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SG2NerS/Z9btdgGJcgFtGde6RnsM+bhTINNQTfxg9vQ=;
        b=CHcDU+XoXbQHDaE6sMr5oqI8xpVy272EePRzZtfTabMmAV3ZEaCc+vyLtbZj4RPBiZ
         V6OO8mzFmuGFMT1swKzY6l/38GrrarZrsKrspv6uwppV6oZ9my2gUNwKcgd6VCAjYuPM
         D7BchgXiCNJV3HeLUjIce2ntSPqnOm2OQd/ap8YcJc7HCMHtga1/yLKUtHgO2sJ6rTVO
         Nx1QwqzO5GPnFWuEavNx4ocL/CoI1NJdbdUZkMRh4zvG2QgdbTyUpnZZz848NJLNDN7w
         kEPZ96htYojqPnmj5g3oi3a55z7koBdXB0PV2UTacxXLbZ8s1ztc1maTw2G242WUeIjj
         LvSA==
X-Gm-Message-State: AOAM5310Q5dSCkU9yaMpNoBCQaI6yLkpPUk31LAqO8Z3FgCQLmmkPQKs
        Gq/ml3nsXE8Ud59PCVTx0Qw=
X-Google-Smtp-Source: ABdhPJyxHlyUeD1qHL8dY85/xJO/EJIXid0Fo28BENvsfJjf8lmmmx4aGNVXdCWKB4n9DiVLR4ZbKw==
X-Received: by 2002:a5d:47a5:0:b0:207:a5b3:e68 with SMTP id 5-20020a5d47a5000000b00207a5b30e68mr1686781wrb.546.1649934585016;
        Thu, 14 Apr 2022 04:09:45 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b0020787751295sm1694504wri.35.2022.04.14.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:09:44 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 0/4] DIGImend patches, part IV
Date:   Thu, 14 Apr 2022 13:09:32 +0200
Message-Id: <20220414110936.146378-1-jose.exposito89@gmail.com>
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

Hi everyone,

This series is a follow up to [1], [2] and [3] and upstreams 4 more
patches authored by Nikolai from the DIGImend project.

Patches 1 and 2 are simple code clean up.

Patch 3 adds support for "bitmap dials". This kind of dials send 01
and 10 binary values rather than the usual 1 and -1.

The last patch adds support for the Huion Q620M drawing tablet, which
has a bitmap dial.

Thank you very much in advance to Jiří for his work reviewing all the
patches I have sent so far,
José Expósito

[1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
[2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/
[3] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204111653000.30217@cbobk.fhfr.pm/T/

Nikolai Kondrashov (4):
  HID: uclogic: Compress params format string
  HID: uclogic: Reduce indent for params format str/args
  HID: uclogic: Add support for bitmap dials
  HID: uclogic: Add support for Huion Q620M

 drivers/hid/hid-uclogic-core.c   |   6 +
 drivers/hid/hid-uclogic-params.c |  20 ++++
 drivers/hid/hid-uclogic-params.h | 187 ++++++++++++++++++-------------
 drivers/hid/hid-uclogic-rdesc.c  |  50 +++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  10 ++
 5 files changed, 192 insertions(+), 81 deletions(-)

-- 
2.25.1

