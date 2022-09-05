Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7075ADA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiIEUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEUVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:21:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D729A3120B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:21:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso8358165wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qK8g1so1NHgtdfDBp+1lgIp6oz/unpeLonHutdiTva0=;
        b=FGdNc3yo2x2cVa9jFFXEuDe2LubjXj7cm+oe7YZe1o7KViBm5F+RpPm0dwu8aQ+Kei
         jRtpEe58P1bZjRriEVfs1Kcr4Nx1Aw3LPDakdtywK6mWdQQed2QlO3Q6Lvme9tcEX+Bp
         PsqujT/fnB5eIPcZ0IXdtT0+ebF6TMaJ9mSWQqRwwLfDh4CdqQoECNRP4W0Ol0sKc3AL
         o4j6ZHHupFdDd1PgtUXLQ6ZjuMJvTYv7o5kBMyffRLHW+oHP762yqTHJgaq4Tnukw1uW
         LPCcShtxpwIRTrWXawr7cD6Q0MMZkxiz9JOMdiFYX7I62VCBaZxCQseJFvU400LxlFzx
         OCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qK8g1so1NHgtdfDBp+1lgIp6oz/unpeLonHutdiTva0=;
        b=jZ5Z/5mzOMd6EDlRuBuz2lwV/K4b7+/+r4vGyUFxZ1rZFAZWETeCUiMb/5SVYD/e8d
         oUOEoLLecjG7yWxS7uTiai//1zBZDwn6AL93ZMYCKny5XLcS0/eMGi6oFEs1nrS/nAj8
         tAbDyoF2zlv9HFLtNmK3+0L/Z/8PINmvNaXtkmdeS9h2b0tv9+gYIwaaRHbQL+037Rts
         KsydemKRNP7ZGZbsVBoIQ6Exs5NL7kbCLArS/AGCQ0j4EuEtlDUkTr7ZYUGDa1UWfcKr
         Oi0O8RjgWKA+9Q9wYpLoLR/A80BKCJ/k7UR7I4LMaIs71ATxE3qYWLQJ+4wS1sZKMghp
         KWJw==
X-Gm-Message-State: ACgBeo1Xo/HkGMm+Tfr6h9x75B74FdLkYHO102raTlhXS+2ZYj1aXjjP
        sHoZ3Gaz42Cnv1Hg8agVVohMzxmQjNbjGy2t
X-Google-Smtp-Source: AA6agR6diDgtK5K1JSKNLHo44677Ccqyyg3ou9EZwE5V1mI1+MF9uM/sIgm08uDI6rFmXv4Ag4ucVg==
X-Received: by 2002:a05:600c:4ca3:b0:3a6:1616:e591 with SMTP id g35-20020a05600c4ca300b003a61616e591mr11548208wmp.99.1662409278200;
        Mon, 05 Sep 2022 13:21:18 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm19841272wms.23.2022.09.05.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:21:17 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/3] selftests/.gitignore: Add vfork_exec
Date:   Mon,  5 Sep 2022 21:21:07 +0100
Message-Id: <20220905202108.89338-3-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905202108.89338-1-dima@arista.com>
References: <20220905202108.89338-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Andrei Vagin <avagin@gmail.com>
Fixes: 6342140db660 ("selftests/timens: add a test for vfork+exit")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index fe1eb8271b35..cae8dca0fbff 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -8,3 +8,4 @@ procfs
 timens
 timer
 timerfd
+vfork_exec
-- 
2.37.2

