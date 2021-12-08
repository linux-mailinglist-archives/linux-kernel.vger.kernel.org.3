Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC61746CE97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbhLHIAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhLHIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:00:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E11C061574;
        Tue,  7 Dec 2021 23:57:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq11so1349587pjb.3;
        Tue, 07 Dec 2021 23:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhgVDMFI8xa91WQLyAK9fa0Trf9hS9CXcQk6dJBH0LY=;
        b=XpBiDODZyLWjFH34iGVpNBqGjYm6SfzkUC1zgSEdrUNm23g3vo722PvjicjWtPxS4b
         wriQMtCjcXmdoyaX4eg9jUQTTDaRMsf8sFtj7c8/41MpYA+1gkqau1ahgJtN/WEhHYIE
         h3L5yDf6ZMyBpzLyItsLXlDut0pZscQPucHH7GDeZ44blsyh2gOIzb02Rexd9hzpVh11
         SzypkRQUstLxlwCIEQNZg6FE3NrGLXZmjabNZUOyKJTtJgyDQ1GwX2jrKwpfsSqFeMZp
         zN6BPglMw1qSyuj6e7od1dZm7y62TDd7dEI6kVuBDPbYRSqU2BYP5aNB6MaAvXpt9fby
         EWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhgVDMFI8xa91WQLyAK9fa0Trf9hS9CXcQk6dJBH0LY=;
        b=KQy6KuoOiyd0ZyZ4r5l6HQs0xGVs4Z9Ta1lXapS6xYnw0kjJdpwKo/XC/RU8t4Py6L
         pdPN6LzNLrU8n3tAu8H5vSG2vOtyuwVF+4YL9OcJ68EbjSoTF3x7p86ixSA7yiWxkFOq
         7WgycguIBbULjwF+KMRdm5oViKaoL6nwqBW+aH/SQUs8hJrGxZIAIc6n4a+yAvQSq3Z1
         VEUvrQeYBBenOrJLkx6+QyhaPDA0u/Vmr10VnmlkGT23/nBN7qz72GXev770DspkX9ts
         HuuhW7f44r2osdcBazL/wVV8aV7/eKCUnGYigI26eyyh0i3YOsDUB8J+xlaqhX7A+FtW
         CA0Q==
X-Gm-Message-State: AOAM532XlGgUyQalWeFnoSuHNtAZ31LeJlQN/a7nzHwN4CLc58uk5oE9
        46mz08yv8vGj9ehS7TFvxt0=
X-Google-Smtp-Source: ABdhPJyV8kXDyBhPJSYUE6GkKkAUyBltUIuhfVJ1RF6D5G/nZmamk6Bo/+gee8AhkRfpMUpnTpbJ5Q==
X-Received: by 2002:a17:90b:4ace:: with SMTP id mh14mr5456606pjb.164.1638950230309;
        Tue, 07 Dec 2021 23:57:10 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b15sm2292514pfv.48.2021.12.07.23.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:57:09 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] netfilter: Remove useless assignment statements
Date:   Wed,  8 Dec 2021 07:57:06 +0000
Message-Id: <20211208075706.404966-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The old_size assignment here will not be used anymore

The clang_analyzer complains as follows:

Value stored to 'old_size' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 net/netfilter/nf_conntrack_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 770a631..1c786a4 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2590,7 +2590,6 @@ int nf_conntrack_hash_resize(unsigned int hashsize)
 			hlist_nulls_add_head_rcu(&h->hnnode, &hash[bucket]);
 		}
 	}
-	old_size = nf_conntrack_htable_size;
 	old_hash = nf_conntrack_hash;
 
 	nf_conntrack_hash = hash;
-- 
2.15.2


