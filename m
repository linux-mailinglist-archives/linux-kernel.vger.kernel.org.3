Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E29F4BD1CA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiBTVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:07:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiBTVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:07:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86647547
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:07:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so27978727ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOmlFrZp7vrKUK5Y6WvCp/ko6OikJNfPxlEXm5n9vhs=;
        b=lrFAbfCiFLIXi0LAKP1ZAq+lBoLcQ6stIxid43XCseni3F7GbnDlpbBpaePMPeT9hm
         E+ONQcfSghrEP1qf+qDGGdzIM41VHTCc7vN9dYcJ8AF52N2kfEsbGATNidU2ZG5Zgklu
         YXrPye0Nx3hQ32dqyaOjW2XzuHKWW+MQIIflqHYXPs5DAmBSLDpHaC5kGrdOMDxxePhX
         vww4Xz+fE5Qg6rNZb5DKj3CQOfZPh+YPMw0VFg+QdmIVIbxsDJdcOy1Badjsxydgj01Y
         4faDeRSEgD5qqNReV3tUNgdaaAJf+jVzcSKY8ZeJjXVKZt4yY78nQaTl4eHo+ALFxGQu
         jcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOmlFrZp7vrKUK5Y6WvCp/ko6OikJNfPxlEXm5n9vhs=;
        b=SQqwhLPoUSoW7oMLU6BB5gTw7IBOnJM6W/O+tN2ig9BTlJ1IBM+h6xXMl7TPIseUHR
         /m/RKyOyA27vgeD58DNDwMEOb6PqmeHbmVVPUPXZyCNfmQ1zlnv1raT4DQy38GPPMdAQ
         d+n8NLnXpnaBMhB6aFtfRbR8m644rEUpcKm9lXH38xetjZGbmfGSEs2xcjpG4MafWbYV
         cVfOiDXAnB30265/XWmYa5EfGVCJiBKfVBQU+B3dU9oxDf4fLJFVlrEV+q8lGTFzXsJt
         iXn+u29TyuP6N8qq/DddcQjlxt9RX+RhaLruV2AC9pYt6Ox56EbXpOtL6cLPIYS9gAVk
         7lwg==
X-Gm-Message-State: AOAM533IbCOdDCLjGT7rFyBxcS8snqXiWHOsL1hadws0K2YPfrEld2fS
        4PUE4c5gnS+QR7vdyyJmRzI=
X-Google-Smtp-Source: ABdhPJyVabZx90O0oSxOrNaoDJGq9IKMVzfV8b/yQIMLwfip+pmFLLRmQZduqDULvxRnK9muJbuKaQ==
X-Received: by 2002:a17:906:14db:b0:6cd:e55:6605 with SMTP id y27-20020a17090614db00b006cd0e556605mr13571909ejc.31.1645391245320;
        Sun, 20 Feb 2022 13:07:25 -0800 (PST)
Received: from localhost.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id y29sm4508705ejk.199.2022.02.20.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 13:07:24 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] MAINTAINERS: Update Allwinner SoCs maintainers
Date:   Sun, 20 Feb 2022 22:07:14 +0100
Message-Id: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Maxime is stepping down as a maintainer, I'll take more active role and
Samuel joined the team.

Maxime, thank you for your effort! Samuel, welcome!

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa0f6cbb634e..c41979623f82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1724,9 +1724,9 @@ S:	Maintained
 F:	drivers/clk/sunxi/
 
 ARM/Allwinner sunXi SoC support
-M:	Maxime Ripard <mripard@kernel.org>
 M:	Chen-Yu Tsai <wens@csie.org>
-R:	Jernej Skrabec <jernej.skrabec@gmail.com>
+M:	Jernej Skrabec <jernej.skrabec@gmail.com>
+M:	Samuel Holland <samuel@sholland.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
-- 
2.35.1

