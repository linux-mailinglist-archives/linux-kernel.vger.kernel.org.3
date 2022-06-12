Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDA54782F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 03:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiFLBX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiFLBXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 21:23:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DCD642E;
        Sat, 11 Jun 2022 18:23:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s37so54278pfg.11;
        Sat, 11 Jun 2022 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiEciZY0Y+MsQ4Cu7oNktvyx7vPhk6nYZfGdQh1JxSs=;
        b=jIOEe15yrEOjUSrG535TJ+ZgC5XOVlDyZXMmwiv4OCYuiMhAG9OvMmvsCIxJRZiC4o
         5mdYXDVj0mtocFB6KWum8zOmDAqbx+ZjOp9FNbAMUg0l/9WMmgb4sfz+qwqk4xWECkLv
         8rE0a7qGvhc1++Qo58pKskwdl2bOg739k8pk9yE6sXsv0Gm8su7puKjoYbRia7vwVE8v
         ICGzFENn7vvW52qDdGlDdRxPbkUwRvZgQhjK0xj452j9REjHMJ667oAXzwqHH33xbPLm
         RSh2+s3ntAa/q2HcULb+FP1XCPORjjJ1sl+nsSXfY5ieOszsAtN0urFPUegBdghR7JH1
         B3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiEciZY0Y+MsQ4Cu7oNktvyx7vPhk6nYZfGdQh1JxSs=;
        b=GFtN1JsGafVEsDtCeTaxLqOEMvKQdtxRyQtoPTPA6rL+J/9tM0DvSgvmASDwBuwsoD
         IZ07a9jhOzRxKfNmKAHDeUTmQh9qZPOf3Jje54e86DnYfLjAPDslPBcXcQkyUP8Wz6B7
         rHFUiV+DH/I3MFzHlHh1asKfEeSzwl5lB+V8vKyR+FVSNGzAPCdi6GxQS9ui4QRoyrBM
         aXyOGnNG+bQbVYIBcfkShhQFQMnZXPXw6ZGm8obApyqOswE/hlBUkhltilIyOocYFYIA
         J1SD+E5ex6DerPdKQNtw/kiGbe4SpOtxVq7Bmw9plJ5OGmlYYkfsjJeLHSrBu4dHeitJ
         WtRA==
X-Gm-Message-State: AOAM533v46kGS6QkCyHwKwcIJKLlg4Rlq1DV0SDPQ0Ii2ru8i/q4M4co
        Zxp/+8OnBakWno/HdWEfRej3vSBmSD4=
X-Google-Smtp-Source: ABdhPJyeovKVqYWeYt4k6hSIw3xqU+X4t97IlTRs94rmPfk9/BEr4ePyNYDDmTSPnPXYDJok139gug==
X-Received: by 2002:a05:6a00:158e:b0:51c:2a89:3845 with SMTP id u14-20020a056a00158e00b0051c2a893845mr30382392pfk.64.1654996994964;
        Sat, 11 Jun 2022 18:23:14 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id b5-20020a62a105000000b0051bcf4877f1sm2177729pff.199.2022.06.11.18.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 18:23:14 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Ang Tien Sung <tien.sung.ang@intel.com>,
        Richard Gong <richard.gong@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: stratix10-svc: remove extraneous asterisk from #define comments
Date:   Sun, 12 Jun 2022 08:22:53 +0700
Message-Id: <20220612012253.16583-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <202206120445.FeU5wA93-lkp@intel.com>
References: <202206120445.FeU5wA93-lkp@intel.com>
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

kernel test robot reported kernel-doc warning:

>> include/linux/firmware/intel/stratix10-svc-client.h:19: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

The warning above is because comments above #define statements are prefixed
with double asterisk, which kernel-doc script mistook these as actual
kernel-doc comment.

Remove extraneouse asterisk from these comments.

Link: https://lore.kernel.org/lkml/202206120445.FeU5wA93-lkp@intel.com/
Fixes: 88f42ac48b8968 ("firmware: stratix10-svc: Add support for FCS")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Ang Tien Sung <tien.sung.ang@intel.com>
Cc: Richard Gong <richard.gong@intel.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/firmware/intel/stratix10-svc-client.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 5098dbba138d0f..63927aba0b5699 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -15,7 +15,7 @@
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 #define SVC_CLIENT_FCS			"fcs"
-/**
+/*
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
@@ -50,7 +50,7 @@
 #define SVC_STATUS_ERROR		5
 #define SVC_STATUS_NO_SUPPORT		6
 #define SVC_STATUS_INVALID_PARAM	7
-/**
+/*
  * Flag bit for COMMAND_RECONFIG
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:

base-commit: 107da326a0a3e7b6e81557c4225548db670a2647
-- 
An old man doll... just what I always wanted! - Clara

