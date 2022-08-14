Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF12591E83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiHNFue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHNFuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:50:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E09B91
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:50:30 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f18so680162ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=I26C4MdSUaU9Ach+cqjQZ87JE8VFZvwPr+G+H7I7T2c=;
        b=dKKCc4gny/4ndFeGqTdn+xmvI6NfVwHoHixzpGrkT8aeIQdh0y8HLp5VCXkDZ/EV96
         xQzwiOUgg7PYZ3G9znIkPQaNiFptdV/1fKSXOpiL1nBNN+yhbb9qsntG5p5gy3MVC4E6
         m+iiIWDcbQAuQVuchNHZrbLF+yu3mkRGfmay+oeh6v1JafCp0HkzJispM3akSPRfmFZW
         qAE7M+wfEFWPPvAENURp0lElIe6vbIcIEua9XMwZheoGhdwOHscdjYJLpdHyKYwWGDxH
         mzIp/2jsTyo9o4X8ZVRRc3OZtbV34qYcLReimcHk17oTnqRrqqSEnqOfaOb6SN8sJNvX
         ssIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=I26C4MdSUaU9Ach+cqjQZ87JE8VFZvwPr+G+H7I7T2c=;
        b=ImSCah6Pte+5pmp16fw16Mu3cwoV7WSh0Eeejn7MHpvIFx/9L8HD1yxS1Y8l+vmwZJ
         p1ukTtM3v2cDwjRumvvvN1IFtX6JCWzaUgaUgOMXKhB37jDVGVFWBUuaGRvCuHaDI3+I
         dCIUcYPC4KgpiyilxosKGa4iOaLheY0zdchJTmPHD7seb7kH6RsMaMznhzj0TTlQ2gq0
         f6LnUd9oIlkPL1ktI/jgzYXvRXwJRBnUbw1H0qoNxm8cRCzKvOdh9qzTALpAO+Wb5vJo
         4d1Dzxdw5kt3GpuD77E4AE+33oyRlZOLYmns3dUE8Guzn2ZT6iWiN4JRkusl9v6BMO63
         qPZQ==
X-Gm-Message-State: ACgBeo2mnAlE2DppIfGKhJB4f2oDYyCbn/rqEYjDfEKPw9dzHPl7ZWjv
        bEpHIy5Lecm/gd5Lq8PdsFVhGC1zpepHYg==
X-Google-Smtp-Source: AA6agR5db/q2s5bI+J4j2Lc7PWTQD/JavAjUyD/Qwk9UeqhVHzpsHLSL7kKxmXurJXtgaBgW1YfJUw==
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr4751815ilm.310.1660456230201;
        Sat, 13 Aug 2022 22:50:30 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id j18-20020a056e02219200b002e58adc323fsm948212ila.32.2022.08.13.22.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:50:29 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/2] memblock tests: add command line help option and update obsolete comments
Date:   Sun, 14 Aug 2022 00:50:18 -0500
Message-Id: <cover.1660451025.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
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

These patches add a help command line option to the help message and
update references to an obsolete build option in comments.

Rebecca Mckeever (2):
  memblock tests: add command line help option
  memblock tests: update reference to obsolete build option in comments

 tools/testing/memblock/tests/common.c | 4 +++-
 tools/testing/memblock/tests/common.h | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.25.1

