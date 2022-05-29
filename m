Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD805372BA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiE2Vtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2Vtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 17:49:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FAA78EF9;
        Sun, 29 May 2022 14:49:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so5412664wmg.2;
        Sun, 29 May 2022 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=3IqEUaHXVUti1x+VtbbIBYixMF/dH9xlsIzM142Izsk=;
        b=XnI93CKrvklEf5VGEZl1YQAXwpLwRtBcNZjt1+tVeQ29g/wwmdKVsgOCtTkh99uvLm
         RgUbQJDX9zo8sSLnX7Fb02xAA6gavGSyTNoo6Ba2LnE02BQBkhd05v8wmvKg0Uufsiia
         xNYexS5tKEF7R2akh5g52zG2p9dLYBDN4L4khw1+PYnVPgtJASd3hjrmB3/nlDY1K++d
         iGvgpTpGjTizaJzf0M5eYr4kcV5uvIWTGA2LWTlrA7+ICR6X3K2DD3tzMxNtrvBOpYBl
         iQsv7wYArwZQjvpVtXOhbSO+QyutyVHqgNaqvgC9dadjjvbxdKMOkS3oRAKPnwWZdiNj
         RSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3IqEUaHXVUti1x+VtbbIBYixMF/dH9xlsIzM142Izsk=;
        b=SvgChpiFtT7YNJjloe7qOEmHEs1ub0d0EE24yUwMUAKyHhqN/FQddNpJ6owgHjCgbi
         IUzZFjyIvM5NNZa2/jIaaXQJ7NOGyOpWGWNz2dX/MIxegR+5eAih2UGiSaHb1gFfcsUE
         /Ow/4rh1sjSMne9a0wE6iG141rtBvwLc+Zl8RTiJXmQRw77+AFs584SZ4Llv5iOkgyBl
         fuYHHSejbs4cj4+4Myay+CQCjxp6N7LCo66w0RRnFYFcdKUSDn7+QgTezDcyaVnJVutw
         qwDaaV+ijz2DTNepgfOeub39gevJkpuazV6EGKrbPWIGtOlUOt5WiNmKI1Gs3B5HZ8pT
         sjSA==
X-Gm-Message-State: AOAM5324IDV6smE4YEaasWb3fD8STVS4uhO7fzy2au9Ol5HAeJ0AwNUZ
        o7K+MROBuiGzmgU6gSX0W9o=
X-Google-Smtp-Source: ABdhPJzhIg9f8Dj/7ytuzhsI+g2tpg2o0OZCNwPojM8ZlIPNswe05K/2V6th8+9aYHhxAaioSLfbjw==
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id n7-20020a1c7207000000b0039766ee9d71mr16384904wmc.8.1653860989542;
        Sun, 29 May 2022 14:49:49 -0700 (PDT)
Received: from [192.168.178.29] (ipb2196a76.dynamic.kabel-deutschland.de. [178.25.106.118])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d47c1000000b0020fff0ea0a3sm7288566wrc.116.2022.05.29.14.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 14:49:49 -0700 (PDT)
Message-ID: <17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com>
Date:   Sun, 29 May 2022 23:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220518224702.1409327-1-jose.exposito89@gmail.com>
 <20220518224702.1409327-4-jose.exposito89@gmail.com>
From:   Stefan Berzl <stefanberzl@gmail.com>
Subject: [PATCH for-5.19/uclogic] HID: uclogic: Remove useless loop
In-Reply-To: <20220518224702.1409327-4-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The while in question does nothing except provide the possibility
to have an infinite loop in case the subreport id is actually the same
as the pen id.

Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>

---
 drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index c0fe66e50c58..1a6b941f3964 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -423,40 +423,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	if (report->type != HID_INPUT_REPORT)
 		return 0;
 
-	while (true) {
-		/* Tweak pen reports, if necessary */
-		if ((report_id == params->pen.id) && (size >= 2)) {
-			subreport_list_end =
-				params->pen.subreport_list +
-				ARRAY_SIZE(params->pen.subreport_list);
-			/* Try to match a subreport */
-			for (subreport = params->pen.subreport_list;
-			     subreport < subreport_list_end; subreport++) {
-				if (subreport->value != 0 &&
-				    subreport->value == data[1]) {
-					break;
-				}
-			}
-			/* If a subreport matched */
-			if (subreport < subreport_list_end) {
-				/* Change to subreport ID, and restart */
-				report_id = data[0] = subreport->id;
-				continue;
-			} else {
-				return uclogic_raw_event_pen(drvdata, data, size);
+	/* Tweak pen reports, if necessary */
+	if ((report_id == params->pen.id) && (size >= 2)) {
+		subreport_list_end =
+			params->pen.subreport_list +
+			ARRAY_SIZE(params->pen.subreport_list);
+		/* Try to match a subreport */
+		for (subreport = params->pen.subreport_list;
+		     subreport < subreport_list_end; subreport++) {
+			if (subreport->value != 0 &&
+			    subreport->value == data[1]) {
+				break;
 			}
 		}
-
-		/* Tweak frame control reports, if necessary */
-		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
-			if (report_id == params->frame_list[i].id) {
-				return uclogic_raw_event_frame(
-					drvdata, &params->frame_list[i],
-					data, size);
-			}
+		/* If a subreport matched */
+		if (subreport < subreport_list_end) {
+			/* Change to subreport ID, and restart */
+			report_id = data[0] = subreport->id;
+		} else {
+			return uclogic_raw_event_pen(drvdata, data, size);
 		}
+	}
 
-		break;
+	/* Tweak frame control reports, if necessary */
+	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+		if (report_id == params->frame_list[i].id) {
+			return uclogic_raw_event_frame(
+				drvdata, &params->frame_list[i],
+				data, size);
+		}
 	}
 
 	return 0;
-- 
2.36.1


