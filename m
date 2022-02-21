Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CCF4BECA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiBUV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:26:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiBUVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D2812AF3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so36519780ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I80ySfiXhu5cxVRWbKi4neSx3+uPEnbFkKrvK2nAmUk=;
        b=WwQ8r86FA3/GDA8Kgxf9cwrsnzEZ46xyJ/oY0OkCh0pFbs1ClcKC89/dpog+m/sDNt
         j7tdCQChDDBEXCglyTmMdL/BeBMTWo2EgmMc2BN4TgbxdIGZD+c4OfzlDkPTygaOfqCb
         MOMyBLp3D+W1ld2YzWlcGXntMWsmnqV81vG7VjSRMtDIW0am5o6GY0eny7g+uAKcW+Jm
         aCyZiJJe2yRb83i6OLbdVo/sf53d+Mm7j+phdvnO0C1gGZtcjlfasXtimww/omE2mgxL
         9l4hLdBVVRdin8jq5zGeHp2sM9Dk/aGX8rzQtRyD3ivFftMyN7UQv1oUuLUvd/3k1uCq
         i84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I80ySfiXhu5cxVRWbKi4neSx3+uPEnbFkKrvK2nAmUk=;
        b=BLxPv2NvYr1XEoG5DwLW3ttfUDvElkSOvElWJMvvjitRXy5FZrZGyNwmDt/uD2zaLr
         7PsKFV+WmdDmsyg5oRFLC4dlM5UqTZbbQ3e+MfT56DY77C2pJORSH9iD7vjdIDs80Kza
         n4fp89Dd6Yur/9vMW4YxF0yDXn2AgF8fAh868GEI4TQyV8G6yE7r46fZ2Uu8kivRY5+f
         bHTZcvVEoI/bgbTonPBCBeXxCGwl/Tk+NXcDQFVaLbh/c96eMdiCvm1Poq9BhsrqFdOD
         WXl0e/CoTIatm430+GuqUYsGZbtV4owwM5/R4NgvsNZoEMXteQ8UhIkOJ90XwyEmNAM0
         1RpQ==
X-Gm-Message-State: AOAM530rJDwRjkXpSB829CXjT28vpDwTsdKmgeMjcShRT+Yaoa+UhnU6
        K7QpW3P8XgnQOuSp75DhGkA=
X-Google-Smtp-Source: ABdhPJwHCYxW9Ia4ML0WjlgOFGuyUKpOSBtrvpuVVl3B7xYPpYxN8PM3EIOqKQde1vWpMQZVnFT18A==
X-Received: by 2002:a17:906:c211:b0:6ce:e221:4c21 with SMTP id d17-20020a170906c21100b006cee2214c21mr16927813ejz.691.1645478731537;
        Mon, 21 Feb 2022 13:25:31 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id d10sm5472313ejo.207.2022.02.21.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:25:31 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:25:29 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] staging: vt6656: Remove unnecessary line breaks
Message-ID: <e0d6d3d787051e3aef56fdba1aee8c2bbbe14e89.1645477326.git.philipp.g.hortmann@gmail.com>
References: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning like:
CHECK: Lines should not end with a '('

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Devided patch into two
---
 drivers/staging/vt6656/rxtx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 5839b34b2e93..4d29f8ebb393 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -353,10 +353,8 @@ static bool vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 		ether_addr_copy(mic_hdr->addr2, hdr->addr2);
 		ether_addr_copy(mic_hdr->addr3, hdr->addr3);
 
-		mic_hdr->frame_control = cpu_to_le16(
-			le16_to_cpu(hdr->frame_control) & 0xc78f);
-		mic_hdr->seq_ctrl = cpu_to_le16(
-				le16_to_cpu(hdr->seq_ctrl) & 0xf);
+		mic_hdr->frame_control = cpu_to_le16(le16_to_cpu(hdr->frame_control) & 0xc78f);
+		mic_hdr->seq_ctrl = cpu_to_le16(le16_to_cpu(hdr->seq_ctrl) & 0xf);
 
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
-- 
2.25.1

