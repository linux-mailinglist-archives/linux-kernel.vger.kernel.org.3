Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBD5898D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbiHDHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiHDHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:55:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C9CCA;
        Thu,  4 Aug 2022 00:55:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o3so18638280ple.5;
        Thu, 04 Aug 2022 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=54EqQuczfqvI67ynZTrQgux+A6Axf8M7+eUWnl+GYQY=;
        b=cVvxsSqtBgVzs6aiz10oHaHm4BLtplcM53UWYI+G5pjnuwJUc3oRhj3weJSnrlGKqh
         nKIbIYP3MR44OtTfhC3fY3VXb7XYqbeCWM0DnHU8dfhBpgJcRjOvYYApUnYM3ZWyM0DH
         +gEsu4fW2AFnBXhi94q3/SkW5waCCujMqWMHVXEVzVnUxPNRAnmJK8jekFEq8nJE1LyA
         6Gx3Z8G5LETxOETlFaC0FW39Nk9B2Ta01iN4IQ/IegkzcodvnGRTvLMNpT3nsKjPTfcW
         23M0PvZB6OtfN19bWoQSPH0E6lxTZC4yhlAg+VnnB8dy+lgClPSJEmupU7UyFKZskf59
         aB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=54EqQuczfqvI67ynZTrQgux+A6Axf8M7+eUWnl+GYQY=;
        b=BcEO2pTC2VG0AKTjSeQWAWg/BibY1SoVJ8Gi50No+CchG30ZJGug1MH372g7bAxXYa
         FeUcp1Xq2NGcPDNOVjwKN4oEeK0W6C0D2UJDwQRayyZaRVmurZmts74HzHgotNSI055s
         uH6hZg2B9ViUyjsO56LcqhtiLJDn/HijcDuVismgpo6kR5KIMxJn6PiMalP919cOedzq
         OQX4Iz41O6tBogAltVWyeKSrt+BHuKTqAH0269tKPcvkeXuRsGRa13E8FXuvWDvdJjrG
         6OrMsT65cLNr0H5BG6cI/dPUcNQfWqeJjv6vynNDMFFdV0/DghWiUQSeqvCQcB/uY0em
         Vuxg==
X-Gm-Message-State: ACgBeo10cM9hytWb7aVOgDgyJ/vsQ0j40TZSnSlS3thVQr/kxgNz+L9R
        XrVSeoWrdRI3MjfwXW3pHgc=
X-Google-Smtp-Source: AA6agR77gkuDrlhTcNbgqjfi0218/cHVu0gMIrsXDqtw+AsPkqT5H7nssypNgyJ7Vj9t1bCBLumAhQ==
X-Received: by 2002:a17:90b:2684:b0:1f4:f2a7:f2b3 with SMTP id pl4-20020a17090b268400b001f4f2a7f2b3mr9481691pjb.70.1659599711055;
        Thu, 04 Aug 2022 00:55:11 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id a3-20020aa795a3000000b005289ef6db79sm267652pfk.32.2022.08.04.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:55:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6B8D8103C7A; Thu,  4 Aug 2022 14:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/3] cxl/regions: add padding for cxl_rr_ep_add nested lists
Date:   Thu,  4 Aug 2022 14:54:46 +0700
Message-Id: <20220804075448.98241-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804075448.98241-1-bagasdotme@gmail.com>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=bagasdotme@gmail.com; h=from:subject; bh=+rB33dYg6FImuKcvI16eK0u18nQbK2ix0CrW/vabL24=; b=owGbwMvMwCn83935mHOB8QHG02pJDEmvq93fBd9OWX81yKdphabZ0cKjEU8OWq/MP1DH5af+IPL5 x1mmHVNZGIQ5GWTFFFneVO4W4/iw8mh/8PdMmDmsTCBDGLg4BWAiDJ8Y69QjNniY7Tya0rRu7e0dzQ cCjp//zHoz7tDTq3s8FLa9PNoVNWWW/yW53rR4vcNP1n95PZWxVihp1dcjprerL7tyGAoytTez8F9r 2Hy06cK8KQ7cLwOu+5y3qLCxV91V/D9wy9VVm4xaAQ==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=EC79BB1608F0A9C58F53F769FF4743C6437033C0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reported indentation warnings:

Documentation/driver-api/cxl/memory-devices:457: ./drivers/cxl/core/region.c:732: WARNING: Unexpected indentation.
Documentation/driver-api/cxl/memory-devices:457: ./drivers/cxl/core/region.c:733: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/driver-api/cxl/memory-devices:457: ./drivers/cxl/core/region.c:735: WARNING: Unexpected indentation.

These warnings above are due to missing blank line padding in the nested list
in kernel-doc comment for cxl_rr_ep_add().

Add the paddings to fix the warnings.

Fixes: 384e624bb211b4 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dc71ec457608d2..616db51c4e78cf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -728,11 +728,14 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
  * in particular decoder target lists.
  *
  * The steps are:
+ *
  * - validate that there are no other regions with a higher HPA already
  *   associated with @port
  * - establish a region reference if one is not already present
+ *
  *   - additionally allocate a decoder instance that will host @cxlr on
  *     @port
+ *
  * - pin the region reference by the endpoint
  * - account for how many entries in @port's target list are needed to
  *   cover all of the added endpoints.
-- 
An old man doll... just what I always wanted! - Clara

