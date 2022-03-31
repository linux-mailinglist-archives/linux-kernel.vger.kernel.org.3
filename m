Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614EF4ED4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiCaHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCaHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:36:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7837A3D;
        Thu, 31 Mar 2022 00:35:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so39903022lfg.7;
        Thu, 31 Mar 2022 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=fygLA6FCziDtx1VVgJ2qLCPIBE2mOveDYVKTX7/lkjk=;
        b=ABe8/cH+f1dBFRiwJ4AEsV7aww+qn4+vKIMuvvv9tuCNrfepOW/5gy728C9WlHwSGv
         xpTlfYK6g5vAi28UNiMJOLB1fjXE8sMPi0c/5qZIDlyJgwUvg/klQwe8ZV+ScUudEU4/
         rRFpNnD//uLJ56Gh4R0F7UBJZVUlsBv8Szbjn5ZojwunVTI+lWkN1gCUYTos7E6Weg3Q
         +x/OOUhKvsHzQ4dELQVUbORt/wHgyAf+enniNwuPh3ADeEwzUifAIyAs4UOdf9nGJ/jp
         6K9dDZANzfnqn61QCv9YvEzM51D1mKBmU/pBjLChmdF1r/7EzlLr36TFrtM68CE2nPTv
         vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=fygLA6FCziDtx1VVgJ2qLCPIBE2mOveDYVKTX7/lkjk=;
        b=aUqU5hO9kEP6o3kdyp18laLltoJP8En7wNY5cWxbWMtDIr7yIe+jBR1TsxPPN4LgNZ
         Hu0OgVWNswOBGyebuIUTsH4KNrX82e5sgrnkOEtl2Hh3rd5ZoobLupeKE2nWVziXzAVG
         3Y9v6Zrxlb5YwNIsfNrcvWgkhRkkD8jvQCj7ExGONxWLrpCdwsDeKx0MeqJMtQDJjDgN
         BWzSjh/2KETlAJldEGxmG1v8IPg2ObaMZxpGkvs+0ZOzk3tovnM1fD5xq/E7IhJPOrEt
         C5MTF+8ZlZUkTGwFmJOv+3b2KFBfvosgddHsyL7QFhIGtp5fBe6uV+Y2/sBuNaWaVcvS
         mHFg==
X-Gm-Message-State: AOAM531t7Q+QtgOYnMej3h/LxTlONmi8UWfzCKz9/jGfEg/FnQyxszhr
        yKmnTP+KqG4Ocvb881StucU=
X-Google-Smtp-Source: ABdhPJzu3nKlbF6eQZCocWc8zoJnOAKYzLHgkxLeJ6GrZCGdjgOd8T7ZRJ1hHhlVxMensAN3lIWpTg==
X-Received: by 2002:ac2:5bcb:0:b0:44a:1fd6:6b14 with SMTP id u11-20020ac25bcb000000b0044a1fd66b14mr10099860lfn.186.1648712101124;
        Thu, 31 Mar 2022 00:35:01 -0700 (PDT)
Received: from [192.168.1.105] (235.132.246.94.ip4.artcom.pl. [94.246.132.235])
        by smtp.gmail.com with ESMTPSA id y21-20020a2e9d55000000b0024aa6b3feb3sm1978389ljj.29.2022.03.31.00.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 00:35:00 -0700 (PDT)
Message-ID: <9ccce84f-3573-46bd-0444-e812ea2524a9@gmail.com>
Date:   Thu, 31 Mar 2022 09:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Piotr Chmura <chmooreck@gmail.com>
Subject: [PATCH v2] si2157: unknown chip version Si2147-A30 ROM 0x50
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     robert Schlabbach <robert_s@gmx.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>
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
Signed-of-by: Piotr Chmura <chmooreck@poczta.onet.pl>
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

