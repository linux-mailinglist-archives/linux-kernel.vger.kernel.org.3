Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64A4FAAE3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiDIVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiDIVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 17:01:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1C510BD11
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:59:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c64so1646857edf.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d12oPKQYmPRZxibcnnbYIKPV48P5kQ/K2Jm+dOK55is=;
        b=oGtt24kqoDhxdGwzLtSU0GmNtjcoi8NQoXUP+igb0fdMeK1XzigLaGtVNr0lPKkFMv
         pLo60ifxJgH6DCCYKZis8DIkvNC+7nq5jGHi/yXIZnhdlG8LK/AQ6TlM0PYojoEiwr60
         A//RI5ytvUIeNOI6DOdeY5PSM5sxe6KYeOHitWRhKNUG5cAzDusab7FgUvsJKjl00G5p
         jsgsJkjOEm0JnU6S5uc3ln0B3OuBedgN9zGF3rFBZYRivstYeKc98BOA2RWzKD3So+G7
         DXmvIunPMOcE67UYK/HT2IfDgF7EIwyCOFQE+9wouXcl9pBSKiEoSe0lCKbtxqWD8MbB
         ylMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d12oPKQYmPRZxibcnnbYIKPV48P5kQ/K2Jm+dOK55is=;
        b=IR6Xv3lg4lZCtY8b4851AMvkWm80Nn9fpoM6Z38KbKE054uPfMYa9njqVKgJuYR+jC
         0IQNJAz1gmlxZkwP9LPiI+szlVnMTymZIk7SrYhrPOegGrPrqfawATrpHoHXZcy1IHYh
         afS1kRCE6xwadrDFFE1B5FChKimdD39VWVTYlgeB+9gvJIO7bgKiwsVxzhsdLwKSiq2q
         wclKe4VNZpCh199pwF/SbZQE4NZTlCFI4M5HRM5//C8azzfPg3VPBmsHQUyMZwVa9FcC
         VorRyU4CKk5T+BBmdHFyPsEhEe+JCu366QaCgzYlWW1bIGGsxO0mjB4KJnHsE4AGHlfB
         wPZw==
X-Gm-Message-State: AOAM533Zwd1DkEfne3Cx4SpCJzljiVgX1lj5lwtSAeR/l41VjRSgNoDU
        NpC7CdrGx27XzgvifaN29gY=
X-Google-Smtp-Source: ABdhPJyxQLLRTF8KOCrmgAYDavqLophKNRQ1oPCeDiN/A4+OQ9+KbKWT1VjMYbVZkigPmoU/6S2U6w==
X-Received: by 2002:a50:cd19:0:b0:41d:709f:5c57 with SMTP id z25-20020a50cd19000000b0041d709f5c57mr2840304edi.227.1649537942862;
        Sat, 09 Apr 2022 13:59:02 -0700 (PDT)
Received: from localhost.localdomain (host-87-4-4-217.retail.telecomitalia.it. [87.4.4.217])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm8251298ejc.176.2022.04.09.13.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 13:59:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Junqi <liujunqi@pku.edu.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leonardo Araujo <leonardo.aa88@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, sparmaintainer@unisys.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove D. Kershner from Unisys S-PAR maintainers
Date:   Sat,  9 Apr 2022 22:58:57 +0200
Message-Id: <20220409205857.32083-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The email address of David Kershner is no more reachable. Remove his
entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba405f6ec31a..3b7497359c2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20188,7 +20188,6 @@ F:	include/linux/cdrom.h
 F:	include/uapi/linux/cdrom.h
 
 UNISYS S-PAR DRIVERS
-M:	David Kershner <david.kershner@unisys.com>
 L:	sparmaintainer@unisys.com (Unisys internal)
 S:	Supported
 F:	drivers/staging/unisys/
-- 
2.34.1

