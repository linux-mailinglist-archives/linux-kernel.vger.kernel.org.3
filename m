Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAB543629
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiFHPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbiFHPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:10:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4A462254
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:00:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f65so8927803pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=snYtRqlzN6FmW7iKUQQGgEQM3lq9dvyDKA6mkLiAUXk=;
        b=mxp8iTlaqOtJI8Mq+UjN+xMVshUXOr9hpnLEyJzPEjFo/NISfUyYeLxPrW4xXktBDO
         gMyzwlrmkWny5w80WbT40lHpBAqckuHsp8daW9BFqMi3c9/0mMTCH/eV4yGSglm8C33h
         9KRKVFryAN5JGDWzmNt1wWEfG/GrU3rp00fEwk1FhuToqUMjqJMUOASu2K6HJWhWv18S
         uWAp0Ag/N8eETrOBWngh0PH9gpE64P+CaJ+M0+6zEvx4L2v1UeD9khBvoDi1cAQJj2Ln
         m1IHrQ+HSs4HqpbU/+c+zClVYxynz85GupmpT07etk/XExZPFKuXrnw6mWQW7of9uG5H
         LARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=snYtRqlzN6FmW7iKUQQGgEQM3lq9dvyDKA6mkLiAUXk=;
        b=RyTPvkB6O9dsypywwaoq+G9ft3/0v1VJncPRo5z7PdwF0LOOcUWHA9XnE+FfRUT8I6
         hZ6n5GdKN3P/J6VCjhmDZdKygAWRYDNMJk6iYkhk0MLWDmFzeBuRTGycWuAgDX9xlFgL
         hvKIYxaRTpztnhCr8PWtUhHArVxMJQHT+nRVo7WbnFBFLXmCVsJ7J9aKM9G88hq6hMdo
         3pZD07N/I0gA5fB9yfRiMH0hR2AEVKvKFHKLF0ZBg2Z7BDljcOCBORQrUau1tVuEx4if
         tSmNQ3Mt8k33S+rI6BbKqJmYrRRiqE1PIQ6q3G1d54V4OrkiVu3pp0seqMLA89vD+EXV
         AGxA==
X-Gm-Message-State: AOAM531iUlRlcQg72n0RwXDcb/6znjVPzTLe6Dbe/ffQV6+DdVMg9/g/
        B3IXasjvRVUx4xlA2+zQocHBHWiU5r3MLS7C
X-Google-Smtp-Source: ABdhPJywJi7CTj/LQGIzekB0IFgDCQVIvsvo88tHbTZvkIQVprrdYibBqcp8H8afBUiVy0/+xxg0Eg==
X-Received: by 2002:a65:6b94:0:b0:3fb:16f4:3620 with SMTP id d20-20020a656b94000000b003fb16f43620mr30386955pgw.464.1654700417416;
        Wed, 08 Jun 2022 08:00:17 -0700 (PDT)
Received: from longfanaikebuke.Dlink (36-236-169-23.dynamic-ip.hinet.net. [36.236.169.23])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b0015e8d4eb2c0sm14665453plt.266.2022.06.08.08.00.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 08:00:17 -0700 (PDT)
From:   Steven Lung <1030steven@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, 1030steven@gmail.com
Subject: [PATCH] sched/pelt: Fix bracket typo
Date:   Wed,  8 Jun 2022 23:00:08 +0800
Message-Id: <20220608150008.57629-1-1030steven@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second bracket describing the range is inverted, this patch
will fix it.

Signed-off-by: Steven Lung <1030steven@gmail.com>
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f3107682..ed82cfba9 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
  * When syncing *_avg with *_sum, we must take into account the current
  * position in the PELT segment otherwise the remaining part of the segment
  * will be considered as idle time whereas it's not yet elapsed and this will
- * generate unwanted oscillation in the range [1002..1024[.
+ * generate unwanted oscillation in the range [1002..1024].
  *
  * The max value of *_sum varies with the position in the time segment and is
  * equals to :
-- 
2.35.1

