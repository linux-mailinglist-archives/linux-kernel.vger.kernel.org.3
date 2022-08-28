Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82A35A3C70
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiH1GxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiH1GxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:53:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7F24F1AB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m1so6675765edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=DNSBN9C7p+LGvSIvWgi8/5Zijc/8PAs8ggosrfqDjUI=;
        b=aWK0Irld/y/fDeTSTGI78+p/axompnlqxOs2ShRwsPp9Q8mhklsuzv6AtYU1DFBUKP
         Gw6RzyrzFnIKn7QHhyz0/YZVM4iSFVHWMDXw5G1R/yNgKDD1RpBjKiVoz83jFi1U60ze
         vOqTZCYIr4YtQFEprR+jKRFI2j8xWT3WjD8l1wqaxX3lTQ9QY7udXDgNstBJl2+809Nu
         KChrW7MPFa0MV3kEGAwa/HRr916eYDUZ7YFGIflYSqc+znNLzd71K/LsbPygYWnDFaXb
         /ACK3QeYDOc7irH4UpFZT+Bz2MSlTVVgQIKE2riJjMEV9GWUCaDqj0gGzT0ysFYyrRSx
         tDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=DNSBN9C7p+LGvSIvWgi8/5Zijc/8PAs8ggosrfqDjUI=;
        b=q1rlsBo6q710MnahCQyVmbc6P9xdB/KsIp7F3UHkOViBYgLwDHuhJ3goWyxkEtSmZQ
         vfwS3Bt5l6dDLgiBJPeqdmKGv5R9k4JCWhebaV+elOPjOsBfkV+pF5gmLWOUn094dcVH
         tY/ISCvcvd5ekaJI7xCn+9FoHuNYMhKXPTYWxGzZzi+RT1iu91Ig/Z0zQVkV/PlUOJuG
         USDFgAc2NS1opKjvBGfKeVfxiT+MZhaYFSm+5l00RIgh6kLTLbesoys03PJcQj78BORa
         SFmYSnJuXs7FIyL1FUmMpJVP/sLyRpcuQCDh04ugFuuN8teOYQjvDEaKuZfi78SbQidU
         a5fg==
X-Gm-Message-State: ACgBeo1k1xgYNWXBXckBYwQNiOVn6HXP6aadgcHSymZfjG9/st/5xaTR
        bWG8nvYniSL2+/kvB85xnis=
X-Google-Smtp-Source: AA6agR6FcSC44u+dcjInryTuDRj65F3MMcMmZS/u/gUOZMzvpOY8ipFjusS2uWVw9fFnphpl1Jenhg==
X-Received: by 2002:a05:6402:5242:b0:448:6849:7e1e with SMTP id t2-20020a056402524200b0044868497e1emr559284edd.137.1661669597447;
        Sat, 27 Aug 2022 23:53:17 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id h3-20020a056402094300b00445e037345csm3870077edz.14.2022.08.27.23.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:53:17 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:53:15 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] staging: vt6655: Remove declaration of
 s_vCalculateOFDMRParameter
Message-ID: <d2d6cd4a8888e4606255276b4f86e2c11487a3a2.1661666677.git.philipp.g.hortmann@gmail.com>
References: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove declaration of s_vCalculateOFDMRParameter as definition
follows just behind.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 846469cc06bb..bbe05d9538a1 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -55,10 +55,6 @@ static const unsigned short cwRXBCNTSFOff[MAX_RATE] = {
 
 /*---------------------  Static Functions  --------------------------*/
 
-static void s_vCalculateOFDMRParameter(unsigned char rate, u8 bb_type,
-				       unsigned char *pbyTxRate,
-				       unsigned char *pbyRsvTime);
-
 /*---------------------  Export Functions  --------------------------*/
 
 /*
-- 
2.37.2

