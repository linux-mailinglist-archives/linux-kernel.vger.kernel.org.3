Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF459ABCB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiHTGn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245060AbiHTGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:43:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1511163
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o22so7916055edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RU3vYRLuQKxt8Hd9Yyqo+KAgZMxn2BTVCKejZHVAHN4=;
        b=m4g38oHu9ymHfkRcDWWXCQl6ixV1MIgEGjOhX2J3UVxDJJbt3clFcGElWf9db1K4BG
         YjuRSCYTTPdDJTCBKY9sR4KUBiLA18t/WWndtYvSFv3+plqk6DLhC4j3V8TxlAkD2eJm
         cW7LG0GsC5KOr+BQIHBTDuPMLb0aNcdQqat+tWDaLC8pGXQjBIEvIOUjEViNFK8yJEs0
         FBo3mZxVASDaISqAJSU18RNEATql6+WWyRoVXdqFHXwPa9lUIEYAr+nJc4ck9qysTjIl
         gAuWIY8VAMkLPAqkWjwle8RQFmR4iOqWdv/3E18E74gBU5FsTHn5cq5bbTZ/Iqc9Colv
         uwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RU3vYRLuQKxt8Hd9Yyqo+KAgZMxn2BTVCKejZHVAHN4=;
        b=Tgw5JRte94pw524gZPay0y9sR/0jXCrOthzz8lSq+EoKEnVaZpRerZCf5bn4UBVOlr
         dRDub5cPdwVBkQInVxIaN5qxGVf86PXByfT7jwfUsqe5J35yATbDVvwmv0dbXF69rxW5
         taSUNd8vfEIgYUsYlXeNBvqvR/9GrzSb802qOdPQb5r0o9rXdR/LZDM6evzqcvUsanfW
         oTJqgChdbzzgvyIksxwcgQ0Pjjbg2gsKR/O20+8QZYSUUdZZDCb8sF9i+YJ82QkMqY4S
         1KE/pq7p3K9TpSsdtowCNeHzETpK9Rjx3ozJLZc60y+1zflu4TzQWRNwE3LtSktX4U07
         XSNg==
X-Gm-Message-State: ACgBeo3Am/NPpeExnno2gkp582vpbAsNxLNTpp4qmZjB4jaMm2jy8+RU
        5kS0/JBF7ISlZg3iVZ/ytmc=
X-Google-Smtp-Source: AA6agR5RWErpONMzRQx8HXnACUqvwGadFt8Q5XrvObDaNqoCqCPunWpBvAJ942fOSHW0zg6Qmh21PQ==
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id h22-20020aa7c956000000b0043b206dc283mr4142574edt.381.1660977805089;
        Fri, 19 Aug 2022 23:43:25 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm2935816ejw.198.2022.08.19.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:43:24 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 0/4] remove useless files
Date:   Sat, 20 Aug 2022 08:42:42 +0200
Message-Id: <cover.1660977535.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202208200447.kdEhBy9a-lkp@intel.com>
References: <202208200447.kdEhBy9a-lkp@intel.com>
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

Delete odm_NoiseMonitor.c and odm_NoiseMonitor.h because they are
useless. The first 2 commits are preparation, and the final commit is
actual removal.

v2: Add new patch to remove the file from Makefile, otherwise there is
build error as reported by kernel test bot.

Nam Cao (4):
  staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
  staging: rtl8723bs: remove member noise_level from struct dm_odm_t
  staging: rtl8723bs: remove odm_NoiseMonitor.o from Makefile
  staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c

 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/hal/odm.h           |   2 -
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 130 ------------------
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |  39 ------
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
 5 files changed, 173 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

-- 
2.25.1

