Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775525A028F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiHXUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiHXUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:14:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAAC7C51B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w19so35669668ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=5wderqoELsTLjghMp/IM+PXHINVRCuk3zx8LINvIKws=;
        b=XxLdjwXpYcSieF9CW8HBoOS3cQ+DgN/sIBQV0LTkPVYO+ZR3zJE6Y0iMOoBKY7W/5D
         Zin4S3yv/ej1awd6KT3sMaOZOAVK34IDl/lWip4rPIu/H2TXqNkcyQyRnxu/SIGr5rB7
         93joR9k2B5XZQ3XolrryZpIVl8MFylwqbPTKI6z+oLq9ASxybRwFOGhDAUvkqrYmrbjj
         nB8HDBUnE/sLJtZpZHnskApcE2U5Qngoe2lFbQ4zmjmiQIktA2CLOrbZ7uzD5hAQihfS
         oOUAeVJX2/1KeUbHnKo5kZXJu/T7aUts8zhuaYHSNsEpFrFx3R7aBKgxL0lrPz8fKXdq
         tMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=5wderqoELsTLjghMp/IM+PXHINVRCuk3zx8LINvIKws=;
        b=NyyDm03BfFbavwijcCCzAxRrGGKR1YUNHAOZR7LKwk8yawJE3nnvp/mjsCh1CiMzx/
         Fy/knSvbBMxFSaUZizJ/BHt6bd0Q4i7DxXoz5jROBRzJasRzhpsjb6JXjaNm4qSfdMGT
         3Z0ItgIBh70GRpFMfO0SUxWwiuLV4HW0YzrEtceGCDkNQgXs+i692AqSO4CYGw3r4t//
         Jl7LreGlcQL5cvpaTAZQBOwK89TWlhW/bjcsvNqrRnYYQZgrT6UFXsAU2EEXPmQpa+0k
         pvX4FicvhFbLEeS6Us9ZrNxMSRT+1qJZ4TvEONGp6oBIF8oPZ+Q6mUo8wSf6t7RjYgzH
         bOHQ==
X-Gm-Message-State: ACgBeo2sXCXtT4BhmPcxIeuEFZarsdPWqHzx47QFidB7YUsdTylmnzGZ
        Vll/Ak7ZivB0EdK3KruS01Xyl5aas6M=
X-Google-Smtp-Source: AA6agR6WLMPCX9zOhMSJKoDPqvnocG0tgnhURzf5jHERcYQZZI1RODLqHOu6dpSOa/sESEQLY2iGUw==
X-Received: by 2002:a17:907:3f9d:b0:73d:a90f:197d with SMTP id hr29-20020a1709073f9d00b0073da90f197dmr370845ejc.460.1661372071174;
        Wed, 24 Aug 2022 13:14:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id v6-20020a056402184600b0043d1eff72b3sm3587060edy.74.2022.08.24.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:14:30 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:14:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8192e: Coding Syle of rtl_core.c improved
Message-ID: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following Checkpatch errors are improved:
- blank lines
- CamelCase of TxCheckStuckHandler and RxCheckStuckHandler
- "Unnecessary ftrace-like logging"
- CamelCase of PHY_SetRFPowerState

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (4):
  staging: rtl8192e: Remove blank lines in rtl_core.c
  staging: rtl8192e: Rename Tx... and RxCheckStuckHandler
  staging: rtl8192e: Remove Unnecessary ftrace-like logging
  staging: rtl8192e: Remove PHY_SetRFPowerState and rename StateToSet

 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |   1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 166 ++----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   6 +-
 3 files changed, 18 insertions(+), 155 deletions(-)

-- 
2.37.2

