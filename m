Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876125086CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377966AbiDTLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357141AbiDTLWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:22:00 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88D403F0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso886828otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KadArFvzGN0vjjHctUCz2D0KHHo4AWfMoHgl9oGcXV0=;
        b=efUbmaJ+hK5/eo0c801MFSNKfMdjkLH1PODhYzVgVy6xWSBL7HDSKa7Pz5klboL+0A
         7DfqtIBN7QOaf8c9sPUMPIAwcLzXVPMocbuF/GLIHjV+0vURPRY1idjI8hqKdjMQ4Pin
         o6JgNhajCMU6bZnf2cmE/3PjuUgC8UFU1mx3xh3Juo4MEeL7P6QAV3ArWtSjWykrY3OX
         tV9gm7UATVVbXhVSQQbFKnXsM3aMmPNFoKWyc7hMOcXrb3n3Svbfd3GUYjCfyVbQcNTR
         1F99wIZ9gK3ZbhsKqM1kQhd4ex57mPaznrV7WhSBHEDhArY4uIMtBSZT+VaAiAbld2SP
         e9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KadArFvzGN0vjjHctUCz2D0KHHo4AWfMoHgl9oGcXV0=;
        b=hL09x20Je7DUjb0SaGd+Yj4zwOJKLB1hqFxn7q5vzZjFsuiDAKV9O//0pKSQVHCOXw
         nzw3KO9JSbdfMdbcbIe/SD21j2s7vuwgm6L6/rsqDFn473uswvSY27HzEwPjsDJplRoN
         aZhfaWLte/x8D9wm8KBXU45kFL+Duiuy3wVyaV6Kz3cduEYPiGDn1buy4mc42g9FBVKX
         V836m4yR2Rk4tc3AAOL0mlEtt+gy8VJYX/eFebQWTRkzfuJaArNOcGE4Eh0Mg4wmmpE5
         lYwfPhG6b40ZBdTEwlRvGt/nQmg9BQEQsEcFs0BpqUbzzBWOdPWk6fhkFkCAEp/N6GGZ
         /POA==
X-Gm-Message-State: AOAM533/R9H1Ma3Ai2IgOyRWZhlsvhtbiaZnXclyJgEanDuKp9SCNJG0
        5QlecQ3gotc6hCy5XFZPpSA=
X-Google-Smtp-Source: ABdhPJzdklnuDqor0UNqYZX4Il6pCuIYRti2R1k7WVjPv3qiH4n0Hib51Mk1DRzK9/7+ro2C94Xatw==
X-Received: by 2002:a05:6830:4123:b0:605:6523:bfd6 with SMTP id w35-20020a056830412300b006056523bfd6mr681918ott.128.1650453553933;
        Wed, 20 Apr 2022 04:19:13 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b0032993003287sm6550188ooq.38.2022.04.20.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:19:13 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/3] memblock tests: update style of comments
Date:   Wed, 20 Apr 2022 06:18:59 -0500
Message-Id: <cover.1650452552.git.remckee0@gmail.com>
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

These patches update the style of comments for memblock_add_*() and
memblock_reserve_*() functions to match the style of comments in
tests/alloc_*.c and remove extra spaces in those comments to conform
to Linux kernel coding style.

Rebecca Mckeever (3):
  memblock tests: update style of comments for memblock_add_*()
    functions
  memblock tests: update style of comments for memblock_reserve_*()
    functions
  memblock tests: remove extra column of spaces in block comment

 tools/testing/memblock/tests/basic_api.c | 153 ++++++++++++++++-------
 1 file changed, 109 insertions(+), 44 deletions(-)

-- 
2.32.0

