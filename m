Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129A4EA6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiC2Eyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiC2Eyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:54:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686C35843;
        Mon, 28 Mar 2022 21:52:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w4so16558690ply.13;
        Mon, 28 Mar 2022 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdM4cL37RSuglpJuskBFKNTuLb+4KsQrXFdLYdudj7c=;
        b=bwchEIkHSSJkTdzpXSLuLwkxBUiJ+BY+klaXqB+WrsTXaFbewgZTIyuKZUgfncSO9s
         m5L/oYW7EkcFg6niSqKqf4bw4/jNY0Q1cia1hPlhQtwp0754Q5lNpqIx5xV6hDXtV2XD
         ZUrS0mvPVaMm6yXUlqdkDq282ZrOLu72M6QXZXdqHRvV1w0h+SRnXsZjZPpWfPDpvA5q
         DXWyhMhVpCjCZitiHmhEsFL6F6//vOz4y9DPQahaLtuVk5Iqgi9GTCIcSCk/epKEV1GK
         5ozl1LjPdJT8TMbC0xmKD1fRaySyO8WTk0XQ/hHjgf+XYxjpxxiu23F2EyUZb0cXC0SA
         TQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdM4cL37RSuglpJuskBFKNTuLb+4KsQrXFdLYdudj7c=;
        b=cz0zwJd27PeGnYZL7nfQdtFzr6g/U4A6+LjUzd+ilWeFnJZF/SIzdK8mC2mD2B/MTT
         6PiGa3SDJG1aYbQEnuzme57hq6UqjMzl5gDI48D3JhBK6IUU63l5tpEsBTpW/I0e8N+r
         TeyiRqttPc2slVDnL6qSXtJgHxayBpuX9LbnFAUVdKgkct+PK1fM7XpeMX5Mx+KB9qLi
         YL0ED24SNJhzm/9d9YRcYfEKvP4yIPZ8C6x2zvw5p0LvFR29gXBl4hos0D1WewcyzP0b
         2I7VPnF7UPhRM7EB0BCw0frLArzIKcyT3OoJktA3p+tTSJeeAbaa/Sg6iKy87rHhjlnF
         sTrw==
X-Gm-Message-State: AOAM531fRzbvt+cEXFb6vNi48OtYozmitxIWVRRcxlasl2rWP8Bl53gq
        sXSC+uvr0VTHZrf3oGaRnSgg+B7gKPSrh+ox
X-Google-Smtp-Source: ABdhPJxanNH+cQAvVog06m1P6fCLil8piWd6AhnvNWsa3bSXu8DUumCkVlLfKn8gGgaRi4J7RmmuHQ==
X-Received: by 2002:a17:90b:3850:b0:1c6:572e:f39a with SMTP id nl16-20020a17090b385000b001c6572ef39amr2620429pjb.233.1648529574510;
        Mon, 28 Mar 2022 21:52:54 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00229000b004fabe756ba6sm19327282pfe.54.2022.03.28.21.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:52:53 -0700 (PDT)
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
Subject: [PATCH v4 2/2] Documentation: sphinx: replace "Introduction" chapter heading with page title
Date:   Tue, 29 Mar 2022 11:52:35 +0700
Message-Id: <20220329045235.11879-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329045235.11879-1-bagasdotme@gmail.com>
References: <20220329045235.11879-1-bagasdotme@gmail.com>
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

Replace first chapter heading ("Introduction") with page title named
"Using Sphinx for kernel documentation". This way, the first-level TOC
for doc-guide contains title instead of chapter headings for this page.

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
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/sphinx.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index bb36f18ae9ac3e..2ff1ab4158d48e 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -1,7 +1,8 @@
 .. _sphinxdoc:
 
-Introduction
-============
+=====================================
+Using Sphinx for kernel documentation
+=====================================
 
 The Linux kernel uses `Sphinx`_ to generate pretty documentation from
 `reStructuredText`_ files under ``Documentation``. To build the documentation in
-- 
An old man doll... just what I always wanted! - Clara

