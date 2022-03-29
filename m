Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6A4EB5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiC2W10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiC2W1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:27:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833261C13D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:25:40 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ke15so15518629qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EDIv2NnbA2HoBvysLf3wHiMFJpgyzFX6SdC4PgZ8XbE=;
        b=E078j+CtyyfVfdi8VFaQaMdt+NElXSLQzSkBfloPiGe2UYTglMBZJz7mpbohxh8F39
         S+8oZhLeHVKS0ITF6aHCz8jNJLeK5L7/k5RXItXPMyWa6nbWmUAufWcoYpxEMdxyBPNM
         CmcQpNUwtyC0HhEqmZAPs6nZaRv6F+qnXuwlrM+XztOrZa4XD7ny2FJp+jdlzCXzBdjs
         Pd5WXBXG0LY1pnRanTcouM6xMyslAf64QA5OaDFcrR7+XR9uZyYcRjUxD+UQrT9oKBcN
         p4v/9P8minyCaTbqkJ3lEf0kxw2rHo1UX04iVsr+2lez3FyYWm0yKpNW2rXYFClkdG57
         ourw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EDIv2NnbA2HoBvysLf3wHiMFJpgyzFX6SdC4PgZ8XbE=;
        b=Lo39hcKKLb65WOZJ2jaxHfCUUh8+/8JcHDxoUSnqS3ZvhTASda/D8a37YIU1avYTio
         t5Bm/UnzSxDpf+jWf2HFz5RGbyPIsOQSi0hPjAsk4MnyQjHdfweKARk8zdAEKcOo9VRW
         pbrTcErZqkqGsnDt2z7c7Rika326LsMYsfdf72VQe6kI7ndZSzPtW4zWjb0mPRaBeS35
         CQlF5NEntcH7MmSqvGwQJHji7/maTLE+lwQXllx9NuYBr7LjmS7lBiiH0jDs7isqKrkb
         8TMYNMKA9y83SZ4zQ7z7hsPGkeoSZnCjOhvPUX2V+l9qZ3/8OxEwPhPtJhg4p+mQb2kg
         TKXw==
X-Gm-Message-State: AOAM530YiXxAuu4cbu+SBemiOu0BMqVGYhB1dwAW+d3IrXfK3WwTuqmK
        pS4tJ4SfK9QB7daPZfQ7Tn8=
X-Google-Smtp-Source: ABdhPJwQeCznI7jJGwMXETg1DyJ2CXIcdL8cnv8H29sEKJ+HqpOlskcyhNZrmoCsSiKDi98S2MQ+6Q==
X-Received: by 2002:a05:6214:19e9:b0:443:6799:829e with SMTP id q9-20020a05621419e900b004436799829emr7392065qvc.30.1648592739643;
        Tue, 29 Mar 2022 15:25:39 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id v5-20020a05622a144500b002e1c7d027b1sm15338135qtx.66.2022.03.29.15.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:25:38 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:25:34 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: wfx: remove space at the start of the line
Message-ID: <20220329222534.GA1002253@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces at the start of the line to follow the linux kernel
coding style. Issue found by checkpatch:
WARNING: please, no spaces at the start of a line.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index b93b16b900c8..e575a81ca2ca 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -170,7 +170,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
  *
  * The PDS file is an array of Time-Length-Value structs.
  */
- int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
+int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
 {
 	int ret, chunk_type, chunk_len, chunk_num = 0;
 
-- 
2.25.1

