Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E952F300
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352886AbiETSfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352754AbiETSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B7195791;
        Fri, 20 May 2022 11:34:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j25so12589155wrc.9;
        Fri, 20 May 2022 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8geAKDJH2TGCu2QyVwReNWvHJO14MErucPbInNWFGSQ=;
        b=RBomN6zQo8UFcA1PEebPuBWE0pu2975T2F7qSHownP1gxiRm1to4oW0uMYVyAzKJdA
         XQGMe5x1qpmtO2blYTRDoFOQMoTQotEJpXOB7TKdG686KARmbWyGyC0kR84KFrs0iF0Z
         YZooxY7jWunxLUxhLI5rj3zFHygbGRyObG5sAVKSo2c6Y8bcc8mnzb/NqJNnloOZ9itt
         nSXmKXdQxgoQ4SESg1QDFqhsxN2W6qC3uIrjj0smwvI3odg205A00qv19QMfB3u1qzOa
         CKyUqUc+hpDq7bgjkvrt+OBgwJJh7BPzCPRC9xHDqSp2eWfGATymYSozUX64yWN4wTVo
         2CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8geAKDJH2TGCu2QyVwReNWvHJO14MErucPbInNWFGSQ=;
        b=XVpx67hRPLFUsfPHpeuavdeSPnDzidSCQe4uXah1Rea3xtFFOI4NR1FGVe4R+vby2k
         GtqnrwfvhJFwD7G5fmnuCgQXqwkbSeMTxxs8h48EETR6a8QdZrFccLCLAf6dUkZqRi0Q
         cyGjs9R2dikZlNq2ebi0ESRfN3T4MiWmOD2fAB57CEUoNC8SukPjMwAnPK7kz2+Wtou4
         V4/mT69N/l0SD+Btd7nDGntKOoicpKCyWTzE80wZrelcknRMqnN0V4ldfbyb8cvnt64O
         wSLGvfU9E4UwOS35RDqqPbhalrV4OU/3HD86Lzs9qsDIPJh6j9VdhhXH9xz/yTwMYdTf
         HFCQ==
X-Gm-Message-State: AOAM530cbhu4va/eSMXw59b4mu4q1SIU2m4GzR4WPkvoyao7eH2CCGEQ
        ohnw2/WBG2eX6XVKJ3wTPFSssOSDS/M=
X-Google-Smtp-Source: ABdhPJzJ12oqJy+lYtUdO9dWjDKZKiytHJpEsLTlBrVSA82eIPSomj/u0fbKYlKzL2ppv7YQ7/fVkA==
X-Received: by 2002:a5d:574a:0:b0:20d:70c:3aa8 with SMTP id q10-20020a5d574a000000b0020d070c3aa8mr9315712wrw.255.1653071688150;
        Fri, 20 May 2022 11:34:48 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:47 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] platform/surface: aggregator: Add comment for KIP subsystem category
Date:   Fri, 20 May 2022 20:34:19 +0200
Message-Id: <20220520183422.7185-8-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
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

The KIP subsystem (full name unknown, abbreviation has been obtained
through reverse engineering) handles detachable peripherals such as the
keyboard cover on the Surface Pro X and Surface Pro 8.

It is currently not entirely clear what this subsystem entails, but at
the very least it provides event notifications for when the keyboard
cover on the Surface Pro X and Surface Pro 8 have been detached or
re-attached, as well as the state that the keyboard cover is currently
in (e.g. folded-back, folded laptop-like, closed, etc.).

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 include/linux/surface_aggregator/serial_hub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index c3de43edcffa..26b95ec12733 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -306,7 +306,7 @@ enum ssam_ssh_tc {
 	SSAM_SSH_TC_LPC = 0x0b,
 	SSAM_SSH_TC_TCL = 0x0c,
 	SSAM_SSH_TC_SFL = 0x0d,
-	SSAM_SSH_TC_KIP = 0x0e,
+	SSAM_SSH_TC_KIP = 0x0e,	/* Manages detachable peripherals (Pro X/8 keyboard cover) */
 	SSAM_SSH_TC_EXT = 0x0f,
 	SSAM_SSH_TC_BLD = 0x10,
 	SSAM_SSH_TC_BAS = 0x11,	/* Detachment system (Surface Book 2/3). */
-- 
2.36.1

