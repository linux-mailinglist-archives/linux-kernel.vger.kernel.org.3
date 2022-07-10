Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1756CC2E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGJBbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGJBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:31:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7A1571F;
        Sat,  9 Jul 2022 18:31:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i21so1907579qtw.12;
        Sat, 09 Jul 2022 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ev0/JwIhf1IIvfZYtY2DhmTLI/RSQbxnQZu2/o+AGzM=;
        b=ZmYUJcdHvDbBCAGOIbyPkhIezwkEUexcyLIpVTznP3lFB5OXwbjNYTl2yaxri5ve/c
         rvWn88RJsTJDgidJWZckeUivc6iMO9g/RvvZH3W+sMDqtAu0RHdD0YnH8WrcOznKe4h9
         QvU9cPG5Bjblt0oMha2eytVvf1kbZDvmUlDnlg9FpLm2drWsXiTDDJA+ZrGSsh3+Y2cQ
         oQCDwpnGR954jQa9VgAy8akGAxz3PkQKrtlMkJRDBGwqO1tTIqWQ2RnALmtSkm04hnx3
         xFV7gNT2al1vaoKwBscOVh+ZKVKFwFvdcqSLElC69wbWU6YEWLJwi67b7qR2geOSD0Fp
         y2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ev0/JwIhf1IIvfZYtY2DhmTLI/RSQbxnQZu2/o+AGzM=;
        b=D0pf06jjvxrZK0HlTrUEhbuvN1AeeKu6nsEnj1oFdkvTaOvmEhPXe1AHZ856bBp+w4
         uNpssCw1R5FpO2zLOAXdtg2AS+IewNTrP0mzjF5xPuGU7bMovVMEC36ABo3OII2yPPmv
         5Ts2EcrKktjlnALz+jq+vlsXhSlqcGMnL/C8bsv7abaExTl0Nfk2eWLclrNcpLgOU9UI
         xF/DTqg1WQjt8cujqBP80xzXwKB0graZRot1xTXYVW7SBuupS4epMsYGBLBr7YBn6mbm
         1GNgoW2gA6XKbIkCckb6KbZtlvyRyZ0ubVwjS17D7uUFz71/WlLk28qjU7ohkNvhM1+K
         wCPw==
X-Gm-Message-State: AJIora9MyHCO9hi+o0NX7Jvf56c4wN5sMXQ3lILhVEk41Flv6TDr7eX+
        +xGFFX52VtNaCPLUP5GGcsg=
X-Google-Smtp-Source: AGRyM1t4JkflM/iuyD53lfdgfjSqMWy8diZh9ftsJLzP0I6Fm7p8PZGVOBMBhOJNWsjfd/lx9Lc8VA==
X-Received: by 2002:ac8:59c5:0:b0:31d:4bfe:fd5a with SMTP id f5-20020ac859c5000000b0031d4bfefd5amr8828300qtf.59.1657416694690;
        Sat, 09 Jul 2022 18:31:34 -0700 (PDT)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006b575a9775csm2137258qko.45.2022.07.09.18.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:31:33 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, geert@linux-m68k.org
Cc:     peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] iio: test: format: add MODULE_* information
Date:   Sat,  9 Jul 2022 21:31:06 -0400
Message-Id: <20220710013109.3349104-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220710013109.3349104-1-liambeguin@gmail.com>
References: <20220710013109.3349104-1-liambeguin@gmail.com>
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

In preparation for module support, add missing MODULE_* information.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/test/iio-test-format.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 237321436b83..fc67e6b73df7 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -265,3 +265,7 @@ static struct kunit_suite iio_format_test_suite = {
 	.test_cases = iio_format_test_cases,
 };
 kunit_test_suite(iio_format_test_suite);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("Test IIO formatting functions");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1.4.g5d01301f2b86

