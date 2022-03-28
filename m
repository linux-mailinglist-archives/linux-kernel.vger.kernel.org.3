Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF04E8E67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiC1Gwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbiC1Gwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:52:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F64CD76;
        Sun, 27 Mar 2022 23:50:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so8911165pjb.3;
        Sun, 27 Mar 2022 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4s9IMNAqszUnjJUvZh0ZPNDb8lyZJ/qNC8E/MmbkHOk=;
        b=HldUjkSCtGjMDVedo2wN6gE8nA63cTOU2rvxWLh67xqWvXbDdEWMn+lQasAu4+t0J4
         a3fdJLXIB2dHmoHSQfbGLAQ1dYHB7I4XqwyIUA9ZNXTBJLL1ezi9jTtyHCf2MlpcfsWC
         4xg3GuRoP3EN7b4SxtouBuMSIOLONa39UQexeLY463cScKFq1I/trBg+m/VMgoUPZ6+/
         o9xc7Gs8Eauo20YHTR3zml6n0bAeMaoyXP8SSOXAmvh3Ofe4mVGg/WFWrzirAspzM9tS
         ORzFP5JvMMhqlHg0cloZo32SiCxXV+n2vg/rFZFCo4aVpyMGHGvmYYdaGrxzt0wxzHaL
         aP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4s9IMNAqszUnjJUvZh0ZPNDb8lyZJ/qNC8E/MmbkHOk=;
        b=E0CWsR1ecFZIKYVQnzPxQL08aqT+tv4IIYn4nX1ZT9I2XgiMWEgjlfq16eU4l1Wcm8
         FP9gzVAtWAYSm851+vFmCdWggydW41yNHQCeG34lr9N6Xk93bkGE/xX8seTtkmV+zK/i
         nE6reMCgH3mUEFnx3wPVwYTxhCIDOtyvZLajGc0PsQ9lpXO0feRET1NcXe438j8C1hrC
         C1xGcOwemxBT7mXmUQHYEbKb3rAuYeITR+1M8WDzZuGaTQb6J7ZRkpAfHrcJYksrnbuA
         /Y5Xocx52wwkCGrF1xHHk8yjArWtBtuWuWzvovRlvLvqmZ+rufghwmbB1RrT7g9COaTB
         zSIg==
X-Gm-Message-State: AOAM532lluWlHYaDFHsN8x74Sfs82r/ulTY66dK0QuJVCX0wAgRXfyEl
        Ex8tnRWdA5UpuoL9HhTuTplSpGlc+0F1DA==
X-Google-Smtp-Source: ABdhPJzd1ePNZIuputR1AT/PgT4XT38hK9NCgxu/JINs4btBQeVuC+7H83NhdY8LFYEEHVrUOClmqw==
X-Received: by 2002:a17:902:9307:b0:154:78ba:ed40 with SMTP id bc7-20020a170902930700b0015478baed40mr24678881plb.92.1648450250338;
        Sun, 27 Mar 2022 23:50:50 -0700 (PDT)
Received: from ubuntu.mate (subs09a-223-255-225-67.three.co.id. [223.255.225.67])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001c779d50699sm17653551pjb.55.2022.03.27.23.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 23:50:49 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Documentation: doc-guide: Add missing page titles
Date:   Mon, 28 Mar 2022 13:50:29 +0700
Message-Id: <20220328065030.24936-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/doc-guide/{kernel-doc,sphinx}.rst are lacking page titles,
thus top-level table of contents for doc-guide directly shows chapter
headings instead.

Add them.

Changes since v2 [1]:
  - Promote only two chapter headings in kernel-doc.rst (suggested by
    Akira Yokosawa)
  - Add Reviewed-by from Mauro Carvalho Chehab for 2/2

[1]: https://lore.kernel.org/linux-doc/20220326123337.642536-1-bagasdotme@gmail.com/

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org

Bagas Sanjaya (2):
  Documentation: kernel-doc: Promote two chapter headings to page title
  Documentation: sphinx: replace "Introduction" chapter heading with
    page title

 Documentation/doc-guide/kernel-doc.rst | 2 ++
 Documentation/doc-guide/sphinx.rst     | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
An old man doll... just what I always wanted! - Clara

