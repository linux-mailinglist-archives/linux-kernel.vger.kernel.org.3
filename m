Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60D5160DB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiD3WxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3WxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:53:12 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131E457A3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:49:49 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-e9027efe6aso11354000fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5n9Fz8Zsn8kPakCtiFy0jX4c/yVGfPmnfdVJ0koknD8=;
        b=YaVFwXh5LEvYeAB5+m7Tad7PmiN+RTdrCRvfLNFnWulLQEJRnnLal2XTv9SA6Mwri8
         FtGyo2+u7RpMtKxD6cqtAcC5FTWgDdRBs3eto49Baf4OofUX36qa+mVlPF71LydVA02d
         kfHPGy+Ln92iHjbMelittAProdxO98VJHHXGhbB1M9skiw+ScvgX/vymH+xgpN9ZUwI8
         y45rNYD7KC/4aqvqnLGAUFbdXFCn05d7+AGaV54gXTIJT7MDI+gwI9am9DnIYuFxUcRQ
         +UtaA/dkukq6WOrAR4X+AZRcYenwQWtTX0cOl7mq26kN3WgUEia9LNSXGlFvCGDYmJoY
         A/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5n9Fz8Zsn8kPakCtiFy0jX4c/yVGfPmnfdVJ0koknD8=;
        b=qdaQDkQdcPvVqoz7UKpQFYK7D2fFk/lPyXq1h1AKQE7f+x8ZzUVXt3EmopV8FkaSbD
         yt6HXzzRZWerf693URZLqbdhxpUmNCeG20cfusPtrYAhblbqCMb8bsky30kxG0NNHQTK
         UjQaYciP2/DGbePoGqNuZ+WFKKNbabirY1BZeVtEBRjuaGtBgELEjZj6e/DPaqxytc05
         1oFtkicYn1WIOAj45ygO1Tz2/SkYDRRbKTWCh+0wXCy7HZd9zNAzDXESGuavV8IsEO8B
         5MoaMZgI2db79IHNHvAiazy2jciR/AQ71IwQo8AnbZMgcVUnEKYD4K05whVkohVbeK4D
         KmIA==
X-Gm-Message-State: AOAM532bkuICt6mMvKegyR9ctSAGjHAEcKoVDl45kf5KLAqWokpZi8Fs
        jveFaLj6RqlZHdfsCPR0UIdI/0aCRKI=
X-Google-Smtp-Source: ABdhPJw0Y7gSX1YwjOGVuarx6SapQCkzTDTX19qalfZFeF7ZdoFwAHVcZTE6a4FoaLBiwg/maBt2kQ==
X-Received: by 2002:a05:6871:79b:b0:d3:4039:7e7c with SMTP id o27-20020a056871079b00b000d340397e7cmr3981788oap.121.1651358988394;
        Sat, 30 Apr 2022 15:49:48 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id k18-20020a9d7612000000b0060603221254sm1286001otl.36.2022.04.30.15.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:49:47 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 0/5] memblock tests: update style of comments
Date:   Sat, 30 Apr 2022 17:49:35 -0500
Message-Id: <cover.1651357434.git.remckee0@gmail.com>
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
 tools/testing/memblock/tests/basic_api.c | 392 ++++++++++++++++-------
 2 files changed, 278 insertions(+), 117 deletions(-)

---
Changes

v1 -> v2
PATCH 1: 
  Add a comma
  Move separator outside block name
Squash white space edit into PATCH 2
PATCH 1 and PATCH 2: add a colon before memory block visuals
Add PATCH 3: update style of comments for memblock_remove_*() functions
Add PATCH 4: update style of comments for memblock_free_*() functions

v2 -> v3
Add PATCH 5: remove completed TODO item
Add changes summary

v3 -> v4
PATCH 1 and PATCH 2: add Reviewed-by tags
PATCH 1 through PATCH 4:
  Correct grammar
  Replace references to first or second (block/region) with r1 or r2
  Add references to r1 or r2 as needed for clarity
---

-- 
2.32.0

