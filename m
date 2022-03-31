Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A864EDE12
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiCaP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCaP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:58:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A51F0837;
        Thu, 31 Mar 2022 08:56:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so350469ljw.8;
        Thu, 31 Mar 2022 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=KxvZgz6hL7VJSgBkUh68HmLUc6RrDFibKDprz5pS9ck=;
        b=XmgzZVBW/FQUUWM2JyAFM5UgAwSSkAaAFRZ23B29xwV3qEosExNQ9XFdUueqgRmceV
         mYagYUESyK8stPscP97WnWXl9FhkpHIIgO2rpRDd4eEaDhpAY99XRHJqP8JqQl7Bu2P/
         /CEPqo7gVlJehBHWq1WO9MVVhU3wYr3dGJ5CLkSfUc9mWG3pvJEnEDAKDnF90KNNYwQ7
         0HejRLZGYDuNiEdOdWq427V2DmOvqXmc3Pp+PjA2pD229xmQITOZlHhucn1K6+Gy7vMS
         Unw2/keqtK/QwnFHjeU68i8KRyLyQ06GJ2sTNdYWcC3zcbOy6gFA86g1DWLKzFWWdwCe
         3KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=KxvZgz6hL7VJSgBkUh68HmLUc6RrDFibKDprz5pS9ck=;
        b=D7leKF2xF6HTcu1FyQ5wO/F4h7C8iSSOsM+hqVHITM6ACN+L45S545SMpwNyZl72u2
         ERor84qEiqM4xSfPaXCkymSruinVPP0Y8RxGFrw3jp1qlbCmF/+K69KLrmQH2ufDNMuk
         tg3x8Z8xaa9kSEv/97JwwvjGlLHzFLycSsmDXwIGwDoH88A+rTqX48ztmfuaBP8ggSMC
         57HQRTTGmXdXsDK3GBMha6xzD4T7Rt8iSveILWKMeu+u8jTg9s8BRDLoWMPPXeQysbRO
         BgWwguAdPJ0ZJgAkPa8UWTeD0HAhu6ZGCVeor1HNXjAaLZCuY2IE6UpLmwRZlAb4bPw3
         4b1g==
X-Gm-Message-State: AOAM532dp9hk1DlMV4yEAgRlsPql9XlWFKimd4AsNrq+26qr3efuDoUv
        5GO4BuzoYnHBi7CWBAG3fUQ=
X-Google-Smtp-Source: ABdhPJxiQKBkYN+HEsqJ45zmL5AhTq/ELypDRrWwMspKq8v1XmnxdyMNAp7obKvq+eIDx+R1K+y16g==
X-Received: by 2002:a2e:a602:0:b0:249:93f8:b0f0 with SMTP id v2-20020a2ea602000000b0024993f8b0f0mr10865404ljp.10.1648742209343;
        Thu, 31 Mar 2022 08:56:49 -0700 (PDT)
Received: from [192.168.1.2] (235.132.246.94.ip4.artcom.pl. [94.246.132.235])
        by smtp.googlemail.com with ESMTPSA id u12-20020a056512128c00b00446499f855dsm2705605lfs.78.2022.03.31.08.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 08:56:48 -0700 (PDT)
Message-ID: <c4bcaff8-fbad-969e-ad47-e2c487ac02a1@gmail.com>
Date:   Thu, 31 Mar 2022 17:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Robert Schlabbach <robert_s@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LMML <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>
From:   Piotr Chmura <chmooreck@gmail.com>
Subject: [PATCH v3] si2157: unknown chip version Si2147-A30 ROM 0x50
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Fix firmware file names assignment in si2157 tuner, allow for running 
devices without firmware files needed.


It's regression in kernel 5.17.0, worked fine in 5.16 series.

device: 07ca:1871 AVerMedia Technologies, Inc. TD310 DVB-T/T2/C dongle
modprobe gives error: unknown chip version Si2147-A30 ROM 0x50
Device initialization is interrupted.

caused by:
1. table si2157_tuners has swapped fields rom_id and required vs struct 
si2157_tuner_info.
2. both firmware file names can be null for devices with required == 
false - device uses build-in firmware in this case

Fix:
1. Rearrange fields in table si2157_tuners
2. Allow both firmware file names be NULL for devices defined with 
required == false


Fixes: 1c35ba3bf972 ("media: si2157: use a different namespace for 
firmware")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215726
Link: 
https://lore.kernel.org/lkml/5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info/ 

Cc: stable@vger.kernel.org # 5.17.x
Signed-off-by: Piotr Chmura <chmooreck@gmail.com>
Tested-by: Robert Schlabbach <robert_s@gmx.net>

---

--- a/drivers/media/tuners/si2157.c    2022-03-20 21:14:17.000000000 +0100
+++ b/drivers/media/tuners/si2157.c    2022-03-22 23:48:05.604408331 +0100
@@ -77,16 +77,16 @@ err_mutex_unlock:
  }

  static const struct si2157_tuner_info si2157_tuners[] = {
-    { SI2141, false, 0x60, SI2141_60_FIRMWARE, SI2141_A10_FIRMWARE },
-    { SI2141, false, 0x61, SI2141_61_FIRMWARE, SI2141_A10_FIRMWARE },
-    { SI2146, false, 0x11, SI2146_11_FIRMWARE, NULL },
-    { SI2147, false, 0x50, SI2147_50_FIRMWARE, NULL },
-    { SI2148, true,  0x32, SI2148_32_FIRMWARE, SI2158_A20_FIRMWARE },
-    { SI2148, true,  0x33, SI2148_33_FIRMWARE, SI2158_A20_FIRMWARE },
-    { SI2157, false, 0x50, SI2157_50_FIRMWARE, SI2157_A30_FIRMWARE },
-    { SI2158, false, 0x50, SI2158_50_FIRMWARE, SI2158_A20_FIRMWARE },
-    { SI2158, false, 0x51, SI2158_51_FIRMWARE, SI2158_A20_FIRMWARE },
-    { SI2177, false, 0x50, SI2177_50_FIRMWARE, SI2157_A30_FIRMWARE },
+    { SI2141, 0x60, false, SI2141_60_FIRMWARE, SI2141_A10_FIRMWARE },
+    { SI2141, 0x61, false, SI2141_61_FIRMWARE, SI2141_A10_FIRMWARE },
+    { SI2146, 0x11, false, SI2146_11_FIRMWARE, NULL },
+    { SI2147, 0x50, false, SI2147_50_FIRMWARE, NULL },
+    { SI2148, 0x32, true,  SI2148_32_FIRMWARE, SI2158_A20_FIRMWARE },
+    { SI2148, 0x33, true,  SI2148_33_FIRMWARE, SI2158_A20_FIRMWARE },
+    { SI2157, 0x50, false, SI2157_50_FIRMWARE, SI2157_A30_FIRMWARE },
+    { SI2158, 0x50, false, SI2158_50_FIRMWARE, SI2158_A20_FIRMWARE },
+    { SI2158, 0x51, false, SI2158_51_FIRMWARE, SI2158_A20_FIRMWARE },
+    { SI2177, 0x50, false, SI2177_50_FIRMWARE, SI2157_A30_FIRMWARE },
  };

  static int si2157_load_firmware(struct dvb_frontend *fe,
@@ -178,7 +178,7 @@ static int si2157_find_and_load_firmware
          }
      }

-    if (!fw_name && !fw_alt_name) {
+    if (required && !fw_name && !fw_alt_name) {
          dev_err(&client->dev,
              "unknown chip version Si21%d-%c%c%c ROM 0x%02x\n",
              part_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);

