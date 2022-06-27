Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0395155DDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbiF0Vnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiF0Vno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:43:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF0C4A;
        Mon, 27 Jun 2022 14:43:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d129so10285263pgc.9;
        Mon, 27 Jun 2022 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsp6NWTiXSJ0zfkiGxcTyiVcKEGRfQJ96DU5zcvmvhA=;
        b=WuBauiPHNgwaS1JBOh71BPtqPlPvMN2PZLdgBpcs5mPw/64QyyNNsRDE2I1oPamnWs
         yH+ZmYC/KFHskKTFDDEdMiU0/NfuQnu2oHb0uefxd60xIBhQ71G9FBVEMy7AsGxal8kE
         J2JxpnlGhPrn+Hd4W42EK0DRx3GbS6q/yAE4dEGqMzhwG3ipp7LrSkr/lzQ/I9QkWd50
         gia8mVit37kNI1HQn27DfOjb/D9Erex/iPtiA6HK+TonCT19ckW9/Sb8FklUtBsvlX+S
         zPMwAoqLSN9BfViwkfTSzOZ+US/n0ZJqCIIZZdOsNp8VfwpbxDgOB+P7mo3alFSdaGl9
         DmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsp6NWTiXSJ0zfkiGxcTyiVcKEGRfQJ96DU5zcvmvhA=;
        b=qiNPXFhkz8K6ycRmwC7Pk7fYTLw+KJgH1EOzvbX8MZ1NuWJ14PDErKTMQy7vouOSFp
         VrBHeIxSUs3vrl8PJDiQcuslFsFfXXIx/EtX+K8A/0Mf3zFMGE/HD5+TD4esJFZNPhtB
         Z9eygSbbXIWVuo47mI+3MIIyZBr6u9BSAuo37bOeelx1+bDkeLXZvFFZ24EnfjGGBEDs
         /3EmAc2INYPgpgFQnbubokvLxtWqjZjj8G/ihCFczHyp1IjgRtELTykzrhimXIex55rZ
         8zhp/YEvDDtki8Dg0jHVbclU1LXMgFxG3f0mQIDsEVl8vfvzKfRgZGrV7vCAvwitEJmW
         AkDA==
X-Gm-Message-State: AJIora+PI6EEKlv0ta62BTJW4Umm6rpMaBUwMR+8MO+21zwMj7Jq2po4
        Px07d89Uw91MunAJDYx8YFY=
X-Google-Smtp-Source: AGRyM1sbLVHH/FJZe241zkPNZj4SGgeHPgS+lUiLtRFIreMiYU4bVWPssKK4vwZfhTUB/zhZEW+1Iw==
X-Received: by 2002:a63:d949:0:b0:408:870f:70d1 with SMTP id e9-20020a63d949000000b00408870f70d1mr14450923pgj.620.1656366222013;
        Mon, 27 Jun 2022 14:43:42 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:e95:685d:6958:8e77:9c10:bd78])
        by smtp.gmail.com with ESMTPSA id bj12-20020a056a02018c00b003fbfe88be17sm7587529pgb.24.2022.06.27.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:43:41 -0700 (PDT)
From:   Praghadeesh T K S <praghadeeshthevendria@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Praghadeesh T K S <praghadeeshthevendria@gmail.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, praghadeeshtks@zohomail.in
Subject: [PATCH] docs: fix 'make htmldocs' warning in leds
Date:   Tue, 28 Jun 2022 03:13:11 +0530
Message-Id: <20220627214311.7817-1-praghadeeshthevendria@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fix following 'make htmldocs' warnings:
./Documentation/leds/leds-qcom-lpg.rst: WARNING:
document isn't included in any toctree

Signed-off-by: Praghadeesh T K S <praghadeeshthevendria@gmail.com>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b9..b9ca081 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -26,3 +26,4 @@ LEDs
    leds-lp55xx
    leds-mlxcpld
    leds-sc27xx
+   leds-qcom-lpg
-- 
2.25.1

