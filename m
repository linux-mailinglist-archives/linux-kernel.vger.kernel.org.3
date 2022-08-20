Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18359ABD0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbiHTGnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbiHTGni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:43:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02812617
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi31so5906509ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Bgq9rqpIso9rl0vPsOVlAZuRxdq9H6kaSUSyTutuwoI=;
        b=kUVmY6J+CfKBrjhC8OhBlsh1CKsjgQBGzaB2ylkt3QWkOrnMuy+8H5XbmzAybkX80y
         VuHm1cLGQnJbNfcfaAu+buN8HiO7N1QLao4WNyFY7Htfp9nHD6G15VxgOwWg1cVYJ3Kx
         USsrsK3/HBjFmU/HLqlFjG9KQ3wBA4wA3zKG1xS8djtTofppNERzHGcyp2Hge3rjWNHf
         pAnkDug+NMHRtYrMh+53iQ8vcVV9/PE1dYPTE25Jwv6GK6floSNjsy97yAnYL4mk/+Aw
         HWL148ceSvb3Njmo7uSCE0CJIJOQTGmTQ1B9EDLGvz+JrHsaYyXASwZVguOPfeL3xjyn
         X4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Bgq9rqpIso9rl0vPsOVlAZuRxdq9H6kaSUSyTutuwoI=;
        b=QhZ5B2mop+v8SOeDnAZ7ooD9NWs59Q9PgIendoA9czuuwl1bg5zGsIhoRHw58iyQKN
         DNFdpxTDJql3PJ9Q6Gmi41wIpv7UneRrd+d76cF7EzlznBj6mS+zOKIbNlzE06Io10Et
         N4KnDPyMzHQFm2uQXcaiJ/B6tcjG2bMU6lh4FKr8Wad9gfXseowuNYHHJ5nsZ7valn1l
         a8UFAd6NcPnHySIHTegoN4NHm4ESgQh6egQqw7umJjnFHGVuy6D57fHvffXTgQAOhzuS
         RUIDFMEBTtncfzMEmkYoMb1y0Ayor89yiEPubJnTKn4vAeHHpuOuAIt2wPI4P8C6yvCJ
         e0Kg==
X-Gm-Message-State: ACgBeo1/MHUB5CVvnrDAQZVsukjH6UsaTMk/OvqFhhQUJcEUEJIy9O1Q
        jtMss205gNy5J32TYgTz2xQp04Pik0PrMQ==
X-Google-Smtp-Source: AA6agR6of3iUp/w71+objZLy3fm6yFRF9fQbTA3mm9pBUgJhE+P88mBVswX+uzLscl75fxC9WRwAbA==
X-Received: by 2002:a17:907:a073:b0:730:a5a4:4b7d with SMTP id ia19-20020a170907a07300b00730a5a44b7dmr6756244ejc.533.1660977808187;
        Fri, 19 Aug 2022 23:43:28 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm2935816ejw.198.2022.08.19.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:43:27 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 3/4] staging: rtl8723bs: remove odm_NoiseMonitor.o from Makefile
Date:   Sat, 20 Aug 2022 08:42:45 +0200
Message-Id: <47513f97b4492e35e6bbe5aea331c60da6bca5a8.1660977536.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660977535.git.namcaov@gmail.com>
References: <cover.1660977535.git.namcaov@gmail.com>
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

This is preparation to delete odm_NoiseMonitor.c and
odm_NoiseMonitor.h because these files are useless.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-staging/202208200447.kdEhBy9a-lkp@intel.com/
Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index 159ca1b9016b..bc7ff1dd14f9 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -33,7 +33,6 @@ r8723bs-y = \
 		hal/odm_DynamicTxPower.o \
 		hal/odm_EdcaTurboCheck.o \
 		hal/odm_HWConfig.o \
-		hal/odm_NoiseMonitor.o \
 		hal/odm_RegConfig8723B.o \
 		hal/rtl8723b_cmd.o \
 		hal/rtl8723b_dm.o \
-- 
2.25.1

