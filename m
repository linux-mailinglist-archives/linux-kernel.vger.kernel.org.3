Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EC5160DF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358131AbiD3Wxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiD3Wx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:53:28 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327EEB16
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:50:04 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-e93bbb54f9so11358815fac.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=de5cYv9udGhvYDO7mNwHuK98M+en+qgo8AFwYs9167Y=;
        b=SlZXS31/hv1yey3GZfbcR/cwUXkVaB/SG7lf/EOgofrXGn3aOXrj4eosMWiBiwwCUY
         mznrGQh0r5NPWXckqu7j7ukJaE5unMRyKuU8rXDZgqsrMP40qLL9LtniPNnb9on35Bw0
         6iJtkpvDJjmEsv5Wz6la6lTKm09UI9mHSKawMuh2zxdw5Z5jM0l7JGcPv8LhfR53/lT8
         0rzh4+1kCWGGQbwNGSRuRTRTaEI4tdjCVPiuLpuOM5/YD1Hx6TiJsI72cltrqZgX2H2P
         5+gInEQ0oCdAsPlq76ChSeBKjvOdZOyMn+lpb9bNWG/sXpyieutTOIIS5TdnvO/MXGAm
         yeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=de5cYv9udGhvYDO7mNwHuK98M+en+qgo8AFwYs9167Y=;
        b=5urRhjZjSByzQi1duBOmr38t+yhwfB83cZyNxNODTVYmXpHcmaxVPCuVpMDEbfSu+7
         nJ2MWdp3oL2EHqdQuLqmepaPOMKaXqRBU3djMZgCAbZvlUf5q8dLC4+NCA86hR7h5D9E
         BU6wTM/T5tqaXmuo9FXf8UqWZitKZyE+993NVOlIEiu63AmJOcEaWuh9GvmFA2m34g06
         jnFZ9ukVscszl5+HgbjIRoJ8ZmOAFq4KlKmcw7TiD//RXpiN7lqbdt+nn0FMSW5jLRGc
         8x20c1KBaDTDQyP0O9LornuZKVENVnTsiFcyikqXzzVpWg4FLy4ZIbocGW+sYxj20HwR
         vUJw==
X-Gm-Message-State: AOAM530jehyS01217uFP2Efv/4j0bkjA3NshGKBNLKyhv8h2GoCbrvdV
        WVJYY5uKlT2T/no9CYVrO/c=
X-Google-Smtp-Source: ABdhPJzVHCIx4JQceoZTOZI8SmdwY54K7u6kmktJ1v22KmjV+AYTOclHcyF8HKkTDM3w4T8yGVgwfA==
X-Received: by 2002:a05:6870:2186:b0:ed:97c0:e334 with SMTP id l6-20020a056870218600b000ed97c0e334mr940677oae.205.1651359003607;
        Sat, 30 Apr 2022 15:50:03 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id i1-20020a056870a68100b000e686d138a0sm4430318oam.58.2022.04.30.15.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:50:03 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 5/5] memblock tests: remove completed TODO item
Date:   Sat, 30 Apr 2022 17:49:40 -0500
Message-Id: <f20acebf95681cde611d578e255b467d1fd2c958.1651357434.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651357434.git.remckee0@gmail.com>
References: <cover.1651357434.git.remckee0@gmail.com>
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

Remove completed item from TODO list.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index c25b2fdec45e..cd1a30d5acc9 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -23,6 +23,3 @@ TODO
 
 5. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-
-6. Update comments in tests/basic_api.c to match the style used in
-   tests/alloc_*.c
-- 
2.32.0

