Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8B5299F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbiEQGz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiEQGz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:55:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188438F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:55:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i10so29585650lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=zQp7s0X9+kl3lXqC1JJ3PoOlPjmjQXAF40+pr6Pmt+8=;
        b=Zh0z+q6PRSSWHmhj2Tgq3r0UtD0iCxcWd9FUZokZRN7TV5ExOkRlCRBsmN5kNwxGgx
         hhu8r0hJYMB8naXb/Er6HGXsejlL4zGHJcpnbfnnmTQfh9aB5ZqQWdIhUb7pguMPPSSZ
         7k1gAy3JmVfSM9yHEDwPmH4CpgxoLLWlgHmen2MfXnQnsf4DLeCTw5xxCk+ZB3MpMFpT
         01XCzYgd6UaWOP5h1nPXNFr1w/n6drQLr8bgdMtvnTCBf6DK2iARhLtSaExot4gQ5+94
         PiiI2tXGVdAgUUbYQbhvm/L3IJgBm+Gt23BDQFMBYffew/Unk6nGFVgDzO3NScJxgIK7
         2DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=zQp7s0X9+kl3lXqC1JJ3PoOlPjmjQXAF40+pr6Pmt+8=;
        b=kbLkybEVn99gecXJTJb067RGHAHs9TzH0/hJTLxXsYjIVsNrH4A9TgnlBBNPiK9TBG
         WGRREeYNpA6+3Fw9E87m7p31581VW5JfzCIJLolJ3tFIkstR8/0lCV8BjAVSI1m8wOHN
         2pUyH9MyFMzQzajQ7h+KxgTIuQ+UAJ7iUcL/qF9qFOiIIHFV1e4o4Op37XNCU8q3XFYM
         LxNZrpkvkK1N9y8XsEIGWX0XNVrsh1LUuGD3FB/a785TLd9Zl72cl5mwKS6cRiixFmZT
         obtfbDGwhv3EcYT5gn87KtaEkna+5Iwc4pGTJLWyls4A5zpJ+yAlELl6wPAbQrjQE2yZ
         BfrA==
X-Gm-Message-State: AOAM531ktzTL3Z+hzja8EPpU0KdecdIglTXpGmVhelOUUyz3bvFxAe+i
        cIS3pkGV+IhRb0W+mJzpl9dlFFG0iETorg==
X-Google-Smtp-Source: ABdhPJzWMUFPISwcgHCNIseYyz+BpKninQQLEvHDw6X8smXeJp4RV2m35x0T90HAoRy0yGDx6O4w1A==
X-Received: by 2002:a05:6512:1594:b0:474:193a:15f0 with SMTP id bp20-20020a056512159400b00474193a15f0mr15129645lfb.70.1652770553035;
        Mon, 16 May 2022 23:55:53 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id i4-20020a056512006400b0047255d21169sm1499316lfo.152.2022.05.16.23.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 23:55:52 -0700 (PDT)
Message-ID: <001979f3-e978-0998-cbed-61a4a2ac87b8@openvz.org>
Date:   Tue, 17 May 2022 09:55:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm-stable] cleanup for "percpu: improve percpu_alloc_percpu
 event trace"
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes sprase warning about incorrect gfp_t cast

Fixes: f67bed134a05 ("percpu: improve percpu_alloc_percpu event trace")
Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/trace/events/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/percpu.h b/include/trace/events/percpu.h
index e989cefc0def..5b8211ca8950 100644
--- a/include/trace/events/percpu.h
+++ b/include/trace/events/percpu.h
@@ -28,7 +28,7 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__field(	int,			off		)
 		__field(	void __percpu *,	ptr		)
 		__field(	size_t,			bytes_alloc	)
-		__field(	gfp_t,			gfp_flags	)
+		__field(	unsigned long,		gfp_flags	)
 	),
 	TP_fast_assign(
 		__entry->call_site	= call_site;
@@ -40,7 +40,7 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__entry->off		= off;
 		__entry->ptr		= ptr;
 		__entry->bytes_alloc	= bytes_alloc;
-		__entry->gfp_flags	= gfp_flags;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 	),
 
 	TP_printk("call_site=%pS reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p bytes_alloc=%zu gfp_flags=%s",
-- 
2.31.1

