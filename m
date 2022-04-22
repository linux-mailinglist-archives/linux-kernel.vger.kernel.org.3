Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB41650B7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiDVM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiDVM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:58:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A011EB3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:55:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k29-20020a056830243d00b006040caa0988so5408166ots.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zm9GfdANLktexLnSc2t2HLTF4hneluEodUT1P1kDEsM=;
        b=hqpExlYNzkwIX37Hy7SHOLnExYYUGG8vNf/6n9iAKjl5YQzWvYMgOOIuE2PmHkVlId
         8p2hIYnz2HLmhSYdOwsAzjY/APN2BXnUw/+SINDligXdzFGG3E1vx0GomViz5E701Hu5
         +YXaVWJpR0D9lTq8jjEGNXIAYwlJNJ0x0VaJxyrxdsa7mWwQTsd1yMHq/havwPdPp8lH
         gE6GLCQsPBCZFgC0GGJHYFfoFUfQ8JMLuORrLRTgNl2GvXnwkUPpoTK9WNCU9xaO6yCF
         AN4YMsRpo4Ng/fPi9zygy3b0diFDQQtg3fmBU5p3mJJNKSkssyLATjOAy6FeI8xFj4wc
         ctLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zm9GfdANLktexLnSc2t2HLTF4hneluEodUT1P1kDEsM=;
        b=suJNGb3ceiPBsyUviCwriUd36J9i7u50YypbXhJsZYqIT3hfovF6W0n+sFCw+0urbB
         vhQv1p+Ax46ZtFJqJwYshGefJa5zw7yCKNPru9p+hecaQSn+DU66SsP62f5a0t/kTFjn
         Z7LccLraU/7aUCmGnMBXKqYXy6fDrYSu1bUpAkg0MFurBPxmwXkMAc5kiEtv0q6CvyMM
         mZQO1uNW3c7UnMjQ0fA5wwSdv1Qyx+EiktNTWQJOatsVSAbD9ilwOD1L7XlTCHrxcw+Q
         kDjzc8uI9v/s9xbnwz6fnQ2oXmTD6zUhr1LwEwHORKqR4uWYf+RayORAth9n+7rKeRmx
         w9JQ==
X-Gm-Message-State: AOAM532rB6eRcbPWc1MiYe1+R/7t8oZFDtsnxPewprRhPWVR62b5754u
        IyZ18Q7VN7Vc5pqckRkgHv+QHPsQcs3EwQ==
X-Google-Smtp-Source: ABdhPJyNyko5expXH8i0LaM0d82/FWE6LtI1dFtVxCQad4UDosaAE16fqf3aYknTT7loeHX6IM4g8Q==
X-Received: by 2002:a9d:7608:0:b0:5e9:5b29:bef8 with SMTP id k8-20020a9d7608000000b005e95b29bef8mr1628062otl.368.1650632143462;
        Fri, 22 Apr 2022 05:55:43 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id b5-20020a9d7545000000b006054e5f6703sm691686otl.31.2022.04.22.05.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:55:42 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/4] memblock tests: update style of comments
Date:   Fri, 22 Apr 2022 07:55:34 -0500
Message-Id: <cover.1650631746.git.remckee0@gmail.com>
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
coding style.

Rebecca Mckeever (4):
  memblock tests: update style of comments for memblock_add_*()
    functions
  memblock tests: update style of comments for memblock_reserve_*()
    functions
  memblock tests: update style of comments for memblock_remove_*()
    functions
  memblock tests: update style of comments for memblock_free_*()
    functions

 tools/testing/memblock/tests/basic_api.c | 350 +++++++++++++++++------
 1 file changed, 256 insertions(+), 94 deletions(-)

-- 
2.32.0

