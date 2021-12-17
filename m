Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6778F4784F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhLQGdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhLQGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:32:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CEC061574;
        Thu, 16 Dec 2021 22:32:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so3941797edd.9;
        Thu, 16 Dec 2021 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWaK4nuZq/Gptqq/StNfBOqK2pmw94eOOpm80CCHM+k=;
        b=iE2K+o+6yAVWBImSh9JPzbjoWp3pwFjLq1krhSQA4kN0RLevetGuJwsFzcLvVfYRqe
         DuIdzunsX9k5DnVjsBNaEFoFpNmEU4yVUETLYOeUct9bZe0gaeMeENk2KoDV1uk7yMQ5
         Hm9i5Tj78s1YfNkJBpAbKky67QV0hSqVdyyGZP4u2mu5L/rzzwpHi17XIrruAY39m2qf
         h7aR20/k5eop5sC1NMOJfq0cCFEtT37iqJNdkUHEhn4hOBP7tijp++8YUWv5r0LkiLk2
         pW3AWBPZLl14r90H7YPCd0336hZnxLzozoAuWid8F2vYCQCnOme2KhSrW9/hpr3PozBl
         ubWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWaK4nuZq/Gptqq/StNfBOqK2pmw94eOOpm80CCHM+k=;
        b=QbZT1SL4clNlajxSX80nqKiJcIysM9PQADJfHMdnIc6AQq28kEdQMBn1BVhV7YR2Ig
         p+19hqCu4l/ibdhYKMrRYx2ntfjCPS4RsrU75xEtwzW8WiXC/yTsUQluhvCAS1uY7j2E
         DlKF6qLw1jOQ+NbnycEcyTZADp3xMuleL4oawgj5DSo6weg2hJB8VRehGhgO/C5FaLMi
         ILxw7DZTlWv5kisvSoRafIQ+uHhxzIQqWCSvZUzTMAPuZWTxN+5krvrZ7vGuf+QIL8GU
         a0+yIHqAHQ3hhJtE0xGGAOPC2x8vtnH2I7Ea+iBKkGWSulBbZJJ6SGqnldgwVZ7wrRqI
         /6fQ==
X-Gm-Message-State: AOAM5310SKR2CnB7ZPjAfyuu6fVeBM8qdRv3WKlpEIVNKCYKw7pWOrHC
        5BZYHjM/3sFMgEpX2YULsEM=
X-Google-Smtp-Source: ABdhPJysFoJi3jwEJHIV/Ibe7ZZ+j3RrTJD0TV88nz5g/njfLBn2mXqpuMDROgi/LnY2ldSkNEbPaw==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr1491076edz.342.1639722771938;
        Thu, 16 Dec 2021 22:32:51 -0800 (PST)
Received: from zenorus.myxoz.lan (81-224-108-56-no2390.tbcn.telia.com. [81.224.108.56])
        by smtp.gmail.com with ESMTPSA id e20sm2490148ejl.189.2021.12.16.22.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 22:32:51 -0800 (PST)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>, hch@infradead.org
Subject: [PATCH v2 0/2] Fix some formatting problems
Date:   Fri, 17 Dec 2021 07:32:22 +0100
Message-Id: <20211217063224.3474-1-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of the patch set I sent in two days ago. The subject is
arguably misleading, since we're doing a bit more than fixing some
"superficial formatting problems", but I wanted to keep the original
subject since this is a followup to the previous patch set.

This patch set adds SPDX license identifiers to zram_drv, and replaces
all uses of 'strlcpy()' with 'kmemdup_nul()' and 'strcpy()'.

Miko Larsson (2):
  zram: zram_drv: add SPDX license identifiers
  zram: zram_drv: replace 'strlcpy()'

 drivers/block/zram/zram_drv.c | 18 ++++++------------
 drivers/block/zram/zram_drv.h |  9 ++-------
 2 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.34.1

