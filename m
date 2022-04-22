Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8150B888
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447873AbiDVNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiDVNgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:36:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B272D546A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:08 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w27-20020a056830061b00b00604cde931a0so5489850oti.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XP4fJ6AI9bNtZNyc3f8poAVuF7t5smExe4sN8IlP+I=;
        b=Rkg4hoiOhuFqWTTCStiFTfQZS2ZqqSJIUkCGJlCDV1Io5sEqb/b6zLPkmAQZ3iuWid
         F8czCNbNfCoKOz0I+fJvMvZeiPWMFAY1jE78+GY2AjRQg9OWMu2f577mAxJf7i/mbN3S
         5SJb2SRhBbBN+HvNt4Jlr+fthzkx9ktF4pF4gix2v1CYw6SGs+b0LeeUERyk2FYlhkg9
         qB73exR4oOoAe1N2Cvma1fN49iAxMxXVhhGr/vzRrR1LfON0g8/m4lPrh8Zd6pzzr/Dd
         RaDtYwzeH+4fWeww0QsCCzJ3Khr3h40SwlxOGrGler8G/8vGiuns0Be9uamuija60ou0
         ShGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XP4fJ6AI9bNtZNyc3f8poAVuF7t5smExe4sN8IlP+I=;
        b=Jd2TtwA1PsPcUtuUOojRX2AjwrNg7SzZ7QDcaROBGAg5i1B/kIFxkiFvqJ3WigiN+a
         +lX40ckAIPWZ5w+zvGHqRY7clodZopHDJyogn/3ssVnoGlLHu8QtjLAQfSvSfS+AJk85
         1FWudJUAtIwIZ6FFt3cUH3cuIzxWN0GSJobB1IV8bwAOVbnWP+G5B89ghhPQ66aWl6Mk
         dBjjLKLIn40HvpydjXzmSXkD9AkH0Uw+ApGwo0/A8X5CKPkY/EGGxTvQ3s9ozC8JX7nz
         Zbi5pAmoMhUO155AlkMy1GQuwoGNHfZjy8xFhhbj7GqC8nTWWyrXDjvQhQaLZQ7QoN7Y
         u8ag==
X-Gm-Message-State: AOAM533C2uxIKvyEvbxP/zb8rTmWz/qjtQvb5SiLtkVIAUnQ6tp12QHk
        vBaakwI13uOkSFMniEkCjhM=
X-Google-Smtp-Source: ABdhPJztLlSzomtYdfFbLW3oDBC/unlSEQKTz3dw36/NxDDn5+baM+dCdhTam+rTk5K18i5tWDwfcw==
X-Received: by 2002:a9d:738d:0:b0:601:7f05:a729 with SMTP id j13-20020a9d738d000000b006017f05a729mr1666882otk.39.1650634388090;
        Fri, 22 Apr 2022 06:33:08 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a9445000000b00329dab1a07fsm771915ooi.17.2022.04.22.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:33:07 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 0/5] memblock tests: update style of comments
Date:   Fri, 22 Apr 2022 08:32:57 -0500
Message-Id: <cover.1650633253.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

These patches update the style of comments for memblock_add_*(),
memblock_reserve_*(), memblock_remove_*(), and memblock_free_*() 
functions to match the style of comments in tests/alloc_*.c and 
remove extra spaces in those comments to conform to Linux kernel
coding style. This completes an item from the TODO list.

Rebecca Mckeever (5):
  memblock tests: update style of comments for memblock_add_*()
    functions
  memblock tests: update style of comments for memblock_reserve_*()
    functions
  memblock tests: update style of comments for memblock_remove_*()
    functions
  memblock tests: update style of comments for memblock_free_*()
    functions
  memblock tests: remove completed TODO item

 tools/testing/memblock/TODO              |   3 -
 tools/testing/memblock/tests/basic_api.c | 350 +++++++++++++++++------
 2 files changed, 256 insertions(+), 97 deletions(-)

---
Changes

v1 -> v2
Add a comma in PATCH 1
Move separator outside block name in PATCH 1
Squash whitespace edit into PATCH 2
Add a colon before memory block visuals in PATCH 1 and PATCH 2
Add PATCH 3 and PATCH 4

v2 -> v3
Add TODO edit (PATCH 5)
Add changes summary


---
-- 
2.32.0

