Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F94F5DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiDFMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiDFMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:33:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E52CCB11
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:31:22 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t21so1665560oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fx+PuhUmntAQYILd3k06PDbFUSS94nXmjRNZJ6v+95g=;
        b=HKuwVS9lBQumFrTvaBXETrUzSjYqNbjMNl7pjRJxlNVTM0LSCYzaoeuEG8wBiaBFh2
         I95AWspuU1BhMxIJhwNJX5y+fgLxiysM0gGct2bDvLaOcaG/5esK2fH7GiynQDEv6ymA
         9cVpFqDzbROrLCp3g2i7+cZp6Z5uA+Lviekv+ntvXIKi6ub2jBVcaFPOizk3j3PAXzPe
         jfcdjfQ9f0eH4a6/7Fdlhk25lXsmBeimghJ97EVtMjPmeSrBmPYU8zCMtANGZ8h/2CeV
         8T2lxja9RJc9fbJHs11wVPP9sBEicq8ycbAJ7+Je1Hg49ZNob/GJn/mnBNsh14C2RlTY
         BRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fx+PuhUmntAQYILd3k06PDbFUSS94nXmjRNZJ6v+95g=;
        b=M802F6HZ8cDler95k84VgBPnjl6dlLfaQMI32bm0JVYTAw0aIykLvYlzCN9wNLUWIv
         UB8pDkFi4iJQwCg5Yuc+Ke8iWKnekZy1ykudaHK9AhbgUWehABAKXYKZRLJ6blh7Mnhe
         aDki7xWyvkR4Fo38TzgkR+c4ZUc2PsO9+xWYkSeDvZvTVjkoYDIRmKVyiFtl2L71h70Q
         tub05r1Ml48JfgWtX0YN4sI8fnwa/jsf7j8JXJLoZmRUf/3s4lly71b8HpEgBZC9PD0H
         vNu3tKvWFpEMjnASVKhtuay8yPJYfxD1M6cqo9Dv+5ihHiWtWU2H9Int+HMm7MtctniW
         cYKA==
X-Gm-Message-State: AOAM5305BtFtcU0JDJoEcmiB2+7bUrL7jeGuHx968rQSIT3pr7Hwi5r0
        MoH/q6NTq7udrznGV8e2ZEU=
X-Google-Smtp-Source: ABdhPJwqQwGchpMu2EMqAUxEdYcA9AXmytNB8OfGtkuDjeuI+izYShm5jyAzP89LrhVRvqqlRT7Y0A==
X-Received: by 2002:a54:4518:0:b0:2ef:8719:b041 with SMTP id l24-20020a544518000000b002ef8719b041mr3263934oil.188.1649233881904;
        Wed, 06 Apr 2022 01:31:21 -0700 (PDT)
Received: from bertie ([172.58.102.145])
        by smtp.gmail.com with ESMTPSA id i28-20020a9d4a9c000000b005ce06a77de2sm6938116otf.48.2022.04.06.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:31:21 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: remove extra 'the'
Date:   Wed,  6 Apr 2022 03:30:58 -0500
Message-Id: <e259a035b79c814f871b490aa277bf0dfe23fe11.1649233201.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649233201.git.remckee0@gmail.com>
References: <cover.1649233201.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated 'the' in comment to be grammatically correct and
conform to Linux kernel coding style.

Found with checkpatch:
WARNING: Possible repeated word: 'the'

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 9f5ece52bd39..cd20811ae152 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -519,7 +519,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecnetwork->IELength = 0;
 	/*  Added by Albert 2009/02/18 */
-	/*  If the the driver wants to use the bssid to create the connection. */
+	/*  If the driver wants to use the bssid to create the connection. */
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
-- 
2.32.0

