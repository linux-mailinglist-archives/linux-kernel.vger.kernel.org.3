Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7697500BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbiDNLM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbiDNLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:12:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5627FD9;
        Thu, 14 Apr 2022 04:09:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k22so6425497wrd.2;
        Thu, 14 Apr 2022 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2Vs4ciu46ou2hNULWCHI54Lmxg3kp1yv38/f1qW9TE=;
        b=oRbld8DbCKjE48EmaQZDoxwbiXFMx3PCduuGm9hCXb1jL1ysEV7Uvyzqc6E8boU+kK
         0whFkb+WeBhwT2dhYVRLcLtJlNP3GHbTncmtn/lpZZe5fd8dgwEtjY0V7rAcx8x4wUkr
         WNQO6zXHaypzGmequZfSw+BSO2FhdK1Ta2AeNYx2AmrDmO32LqMTLT3cN5l9FRj7qDYL
         bhN6btUlPxiX/H0/wrR/lTLgl7tAg7P7g2zi5r6P2BLkwxvVyuV1XHOw3Et33nv3sAWq
         B+ufnLesAp8p4rkcaJjmJRtoT1ptnWAGl0p/trEWugqfEtCfKSGZ+s9UXQmr9mzxrRHp
         s6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2Vs4ciu46ou2hNULWCHI54Lmxg3kp1yv38/f1qW9TE=;
        b=cPKDLlfP0YsGtoq5JUVY/KGXjGq2p7djvWJbriTZ71QrL3RwYHniqKaqa7hqtVbpwQ
         P76vyQ/dZeQNWqP+86IFYNHfsXEmV92uq+p68vQ3UY3wXgTSpDd5B8VVSMy/xd2e6XH9
         iWPYAeN3IeoYvTQe1nBJhEZXD9JWlwKeb8JDyn/qb8eED4vKmiGQ0K3JqRnUkBJ/v8eL
         iNf0gYr78h8Pr9nWxEsuFdKjZFAouzZFnBFnmjQ1NvTsZuSr5w6/0vd9d2h8g1aLImPV
         MFpTqab6UkHtSTfY7HUUecavbW5JeN4+o9uAaJXOjZujVZOtslWp6NO7XGU/wls1QAvv
         lo1Q==
X-Gm-Message-State: AOAM533H0TCoKPQrOEJxh9DFhazEaGfacZDG7RZH9U5jl+TNVuY1GX/n
        5rshhiV4VOsxgpvmMvfYrxk=
X-Google-Smtp-Source: ABdhPJxPL0P4OOOsTGIIoNLZH8gYlpV+8nQ6jU3JSG7Pcv77RmrE9z3xY598Yly8sTnnxm4yQvmGyA==
X-Received: by 2002:adf:d1e5:0:b0:205:85f5:656c with SMTP id g5-20020adfd1e5000000b0020585f5656cmr1684250wrd.65.1649934592493;
        Thu, 14 Apr 2022 04:09:52 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b0020787751295sm1694504wri.35.2022.04.14.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:09:52 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 2/4] HID: uclogic: Reduce indent for params format str/args
Date:   Thu, 14 Apr 2022 13:09:34 +0200
Message-Id: <20220414110936.146378-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414110936.146378-1-jose.exposito89@gmail.com>
References: <20220414110936.146378-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nikolai Kondrashov <spbnick@gmail.com>

Improve legibility of UCLOGIC_PARAMS_FMT_STR/ARGS.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.h | 186 +++++++++++++++----------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index ebf84b56746b..78965e683d20 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -203,102 +203,102 @@ extern int uclogic_params_init(struct uclogic_params *params,
 
 /* Tablet interface parameters *printf format string */
 #define UCLOGIC_PARAMS_FMT_STR \
-		".invalid = %s\n"                   \
-		".desc_ptr = %p\n"                  \
-		".desc_size = %u\n"                 \
-		".pen = {\n"                        \
-		"\t.desc_ptr = %p\n"                \
-		"\t.desc_size = %u\n"               \
-		"\t.id = %u\n"                      \
-		"\t.subreport_list = {\n"           \
-		"\t\t{0x%02hhx, %hhu},\n"           \
-		"\t\t{0x%02hhx, %hhu},\n"           \
-		"\t\t{0x%02hhx, %hhu},\n"           \
-		"\t}\n"                             \
-		"\t.inrange = %s\n"                 \
-		"\t.fragmented_hires = %s\n"        \
-		"\t.tilt_y_flipped = %s\n"          \
-		"}\n"                               \
-		".frame_list = {\n"                 \
-		"\t{\n"                             \
-		"\t\t.desc_ptr = %p\n"              \
-		"\t\t.desc_size = %u\n"             \
-		"\t\t.id = %u\n"                    \
-		"\t\t.suffix = %s\n"                \
-		"\t\t.re_lsb = %u\n"                \
-		"\t\t.dev_id_byte = %u\n"           \
-		"\t\t.touch_ring_byte = %u\n"       \
-		"\t\t.touch_ring_max = %hhd\n"      \
-		"\t\t.touch_ring_flip_at = %hhd\n"  \
-		"\t},\n"                            \
-		"\t{\n"                             \
-		"\t\t.desc_ptr = %p\n"              \
-		"\t\t.desc_size = %u\n"             \
-		"\t\t.id = %u\n"                    \
-		"\t\t.suffix = %s\n"                \
-		"\t\t.re_lsb = %u\n"                \
-		"\t\t.dev_id_byte = %u\n"           \
-		"\t\t.touch_ring_byte = %u\n"       \
-		"\t\t.touch_ring_max = %hhd\n"      \
-		"\t\t.touch_ring_flip_at = %hhd\n"  \
-		"\t},\n"                            \
-		"\t{\n"                             \
-		"\t\t.desc_ptr = %p\n"              \
-		"\t\t.desc_size = %u\n"             \
-		"\t\t.id = %u\n"                    \
-		"\t\t.suffix = %s\n"                \
-		"\t\t.re_lsb = %u\n"                \
-		"\t\t.dev_id_byte = %u\n"           \
-		"\t\t.touch_ring_byte = %u\n"       \
-		"\t\t.touch_ring_max = %hhd\n"      \
-		"\t\t.touch_ring_flip_at = %hhd\n"  \
-		"\t},\n"                            \
-		"}\n"
+	".invalid = %s\n"                   \
+	".desc_ptr = %p\n"                  \
+	".desc_size = %u\n"                 \
+	".pen = {\n"                        \
+	"\t.desc_ptr = %p\n"                \
+	"\t.desc_size = %u\n"               \
+	"\t.id = %u\n"                      \
+	"\t.subreport_list = {\n"           \
+	"\t\t{0x%02hhx, %hhu},\n"           \
+	"\t\t{0x%02hhx, %hhu},\n"           \
+	"\t\t{0x%02hhx, %hhu},\n"           \
+	"\t}\n"                             \
+	"\t.inrange = %s\n"                 \
+	"\t.fragmented_hires = %s\n"        \
+	"\t.tilt_y_flipped = %s\n"          \
+	"}\n"                               \
+	".frame_list = {\n"                 \
+	"\t{\n"                             \
+	"\t\t.desc_ptr = %p\n"              \
+	"\t\t.desc_size = %u\n"             \
+	"\t\t.id = %u\n"                    \
+	"\t\t.suffix = %s\n"                \
+	"\t\t.re_lsb = %u\n"                \
+	"\t\t.dev_id_byte = %u\n"           \
+	"\t\t.touch_ring_byte = %u\n"       \
+	"\t\t.touch_ring_max = %hhd\n"      \
+	"\t\t.touch_ring_flip_at = %hhd\n"  \
+	"\t},\n"                            \
+	"\t{\n"                             \
+	"\t\t.desc_ptr = %p\n"              \
+	"\t\t.desc_size = %u\n"             \
+	"\t\t.id = %u\n"                    \
+	"\t\t.suffix = %s\n"                \
+	"\t\t.re_lsb = %u\n"                \
+	"\t\t.dev_id_byte = %u\n"           \
+	"\t\t.touch_ring_byte = %u\n"       \
+	"\t\t.touch_ring_max = %hhd\n"      \
+	"\t\t.touch_ring_flip_at = %hhd\n"  \
+	"\t},\n"                            \
+	"\t{\n"                             \
+	"\t\t.desc_ptr = %p\n"              \
+	"\t\t.desc_size = %u\n"             \
+	"\t\t.id = %u\n"                    \
+	"\t\t.suffix = %s\n"                \
+	"\t\t.re_lsb = %u\n"                \
+	"\t\t.dev_id_byte = %u\n"           \
+	"\t\t.touch_ring_byte = %u\n"       \
+	"\t\t.touch_ring_max = %hhd\n"      \
+	"\t\t.touch_ring_flip_at = %hhd\n"  \
+	"\t},\n"                            \
+	"}\n"
 
 /* Tablet interface parameters *printf format arguments */
 #define UCLOGIC_PARAMS_FMT_ARGS(_params) \
-		((_params)->invalid ? "true" : "false"),                    \
-		(_params)->desc_ptr,                                        \
-		(_params)->desc_size,                                       \
-		(_params)->pen.desc_ptr,                                    \
-		(_params)->pen.desc_size,                                   \
-		(_params)->pen.id,                                          \
-		(_params)->pen.subreport_list[0].value,                     \
-		(_params)->pen.subreport_list[0].id,                        \
-		(_params)->pen.subreport_list[1].value,                     \
-		(_params)->pen.subreport_list[1].id,                        \
-		(_params)->pen.subreport_list[2].value,                     \
-		(_params)->pen.subreport_list[2].id,                        \
-		uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
-		((_params)->pen.fragmented_hires ? "true" : "false"),       \
-		((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
-		(_params)->frame_list[0].desc_ptr,                          \
-		(_params)->frame_list[0].desc_size,                         \
-		(_params)->frame_list[0].id,                                \
-		(_params)->frame_list[0].suffix,                            \
-		(_params)->frame_list[0].re_lsb,                            \
-		(_params)->frame_list[0].dev_id_byte,                       \
-		(_params)->frame_list[0].touch_ring_byte,                   \
-		(_params)->frame_list[0].touch_ring_max,                    \
-		(_params)->frame_list[0].touch_ring_flip_at,                \
-		(_params)->frame_list[1].desc_ptr,                          \
-		(_params)->frame_list[1].desc_size,                         \
-		(_params)->frame_list[1].id,                                \
-		(_params)->frame_list[1].suffix,                            \
-		(_params)->frame_list[1].re_lsb,                            \
-		(_params)->frame_list[1].dev_id_byte,                       \
-		(_params)->frame_list[1].touch_ring_byte,                   \
-		(_params)->frame_list[1].touch_ring_max,                    \
-		(_params)->frame_list[1].touch_ring_flip_at,                \
-		(_params)->frame_list[2].desc_ptr,                          \
-		(_params)->frame_list[2].desc_size,                         \
-		(_params)->frame_list[2].id,                                \
-		(_params)->frame_list[2].suffix,                            \
-		(_params)->frame_list[2].re_lsb,                            \
-		(_params)->frame_list[2].dev_id_byte,                       \
-		(_params)->frame_list[2].touch_ring_byte,                   \
-		(_params)->frame_list[2].touch_ring_max,                    \
-		(_params)->frame_list[2].touch_ring_flip_at
+	((_params)->invalid ? "true" : "false"),                    \
+	(_params)->desc_ptr,                                        \
+	(_params)->desc_size,                                       \
+	(_params)->pen.desc_ptr,                                    \
+	(_params)->pen.desc_size,                                   \
+	(_params)->pen.id,                                          \
+	(_params)->pen.subreport_list[0].value,                     \
+	(_params)->pen.subreport_list[0].id,                        \
+	(_params)->pen.subreport_list[1].value,                     \
+	(_params)->pen.subreport_list[1].id,                        \
+	(_params)->pen.subreport_list[2].value,                     \
+	(_params)->pen.subreport_list[2].id,                        \
+	uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
+	((_params)->pen.fragmented_hires ? "true" : "false"),       \
+	((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
+	(_params)->frame_list[0].desc_ptr,                          \
+	(_params)->frame_list[0].desc_size,                         \
+	(_params)->frame_list[0].id,                                \
+	(_params)->frame_list[0].suffix,                            \
+	(_params)->frame_list[0].re_lsb,                            \
+	(_params)->frame_list[0].dev_id_byte,                       \
+	(_params)->frame_list[0].touch_ring_byte,                   \
+	(_params)->frame_list[0].touch_ring_max,                    \
+	(_params)->frame_list[0].touch_ring_flip_at,                \
+	(_params)->frame_list[1].desc_ptr,                          \
+	(_params)->frame_list[1].desc_size,                         \
+	(_params)->frame_list[1].id,                                \
+	(_params)->frame_list[1].suffix,                            \
+	(_params)->frame_list[1].re_lsb,                            \
+	(_params)->frame_list[1].dev_id_byte,                       \
+	(_params)->frame_list[1].touch_ring_byte,                   \
+	(_params)->frame_list[1].touch_ring_max,                    \
+	(_params)->frame_list[1].touch_ring_flip_at,                \
+	(_params)->frame_list[2].desc_ptr,                          \
+	(_params)->frame_list[2].desc_size,                         \
+	(_params)->frame_list[2].id,                                \
+	(_params)->frame_list[2].suffix,                            \
+	(_params)->frame_list[2].re_lsb,                            \
+	(_params)->frame_list[2].dev_id_byte,                       \
+	(_params)->frame_list[2].touch_ring_byte,                   \
+	(_params)->frame_list[2].touch_ring_max,                    \
+	(_params)->frame_list[2].touch_ring_flip_at
 
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
-- 
2.25.1

