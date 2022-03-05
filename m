Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF204CE733
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiCEVdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCEVdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:33:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6457B2F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:32:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so6235039wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TCx+9DHYBDfhmL0fL+WqxIFbJRjvIL+R18LxRNlSocY=;
        b=D/6Mxh03JisIRPfW54LnnhXMLj+II1rV2a1HSZsFlV3QaIN7ujYC5NFOf4xY/YwJi2
         rbW+B0cBnghR/lhw5MoiYwVwIo4656irbteAKpLrDj82Jdo+zD3oAKy6AFfXEnv4+gpI
         gHUNP0ESSQRFA5cmuejvRrIb6iT8GGfGuTVgS0PvikKpk0Z24r2riNod/QOgk9luP1rq
         HWbq+05bCGu+/bxnsXQOByfV7S/G/Xh5+R69BuLI0WiDuNCWAcXTDq2hqHiIYk4fFJ/8
         6eGpc7XuclJpDpu+tO0hGKyKUGuwcbFhis/7P+lL4L+CiuVELgT27qNxpBzdpfse563E
         bCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TCx+9DHYBDfhmL0fL+WqxIFbJRjvIL+R18LxRNlSocY=;
        b=vFxqkPAsvPye1Ln4Q0sDHWIj1Gh0SLY6NNUxMou4DusNUIg7xpJQiWnLDrLJSB5m2x
         uUHT43xKN6RYZd8L9PNwHc9ECIXO0Hbp+RpQCsxSH/c9tI+nQE765bM+YxjCiIRg0hww
         kQ97jwa1n9MWyI0Vtx2wAmGIaZ/uRZXWkfjTSzav4eTCCg0+ztjFIkIWlZ34PtCUHZ5Q
         6GqRlgwfi0XuC3nb9z9f8fVJMJlSYfaCNQtRBYPCHzgHDbsx0OHDs+imzaai1gaEYNP1
         m5ioOESvWtBh/GKQ8kcS4QOWt9tznbeHfKA2ZuhmfZWWvOyK6g6qNJUStQjU3MxA1u40
         A6bA==
X-Gm-Message-State: AOAM53214nzn+OMKMi53tgEKUVoOtz/STujXMEq16czA46jhP48pFOEf
        XHXS/SH1H89jYonWNFi+sy1DdaMih1E=
X-Google-Smtp-Source: ABdhPJw0e9sHrbr/DRqxVtpj/ROvHK3Uv7WPuxxIZQbWYFNbLxKH5CeV0/OPPVfaBScmmUFyYNwBiw==
X-Received: by 2002:a1c:f003:0:b0:381:17f5:21b8 with SMTP id a3-20020a1cf003000000b0038117f521b8mr3558814wmb.158.1646515930701;
        Sat, 05 Mar 2022 13:32:10 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b001f1d614b8besm3783740wrn.112.2022.03.05.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:32:10 -0800 (PST)
Date:   Sat, 5 Mar 2022 22:32:08 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: vt6655: Remove unused byRFType in baseband.c
Message-ID: <198341a249ea67acbf1be00b6465aa6a4eaef6e1.1646512837.git.philipp.g.hortmann@gmail.com>
References: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove byRFType that support 5GHz band.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 80 -------------------------------
 1 file changed, 80 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 84fa6ea3e2e6..dfdb0ebf43b5 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2065,54 +2065,6 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->dbm_threshold[1] = -50;
 		priv->dbm_threshold[2] = 0;
 		priv->dbm_threshold[3] = 0;
-	} else if (by_rf_type == RF_UW2452) {
-		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
-			result &= bb_write_embedded(priv,
-				byVT3253B0_UW2451[ii][0],
-				byVT3253B0_UW2451[ii][1]);
-
-		/* Init ANT B select,
-		 * TX Config CR09 = 0x61->0x45,
-		 * 0x45->0x41(VC1/VC2 define, make the ANT_A, ANT_B inverted)
-		 */
-
-		/*bResult &= bb_write_embedded(iobase,0x09,0x41);*/
-
-		/* Init ANT B select,
-		 * RX Config CR10 = 0x28->0x2A,
-		 * 0x2A->0x28(VC1/VC2 define,
-		 * make the ANT_A, ANT_B inverted)
-		 */
-
-		/*bResult &= bb_write_embedded(iobase,0x0a,0x28);*/
-		/* Select VC1/VC2, CR215 = 0x02->0x06 */
-		result &= bb_write_embedded(priv, 0xd7, 0x06);
-
-		/* {{RobertYu:20050125, request by Jack */
-		result &= bb_write_embedded(priv, 0x90, 0x20);
-		result &= bb_write_embedded(priv, 0x97, 0xeb);
-		/* }} */
-
-		/* {{RobertYu:20050221, request by Jack */
-		result &= bb_write_embedded(priv, 0xa6, 0x00);
-		result &= bb_write_embedded(priv, 0xa8, 0x30);
-		/* }} */
-		result &= bb_write_embedded(priv, 0xb0, 0x58);
-
-		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
-			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
-
-		priv->abyBBVGA[0] = 0x14;
-		priv->abyBBVGA[1] = 0x0A;
-		priv->abyBBVGA[2] = 0x0;
-		priv->abyBBVGA[3] = 0x0;
-		priv->dbm_threshold[0] = -60;
-		priv->dbm_threshold[1] = -50;
-		priv->dbm_threshold[2] = 0;
-		priv->dbm_threshold[3] = 0;
-		/* }} RobertYu */
-
 	} else if (by_rf_type == RF_VT3226) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
@@ -2134,38 +2086,6 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		/* Fix VT3226 DFC system timing issue */
 		MACvSetRFLE_LatchBase(iobase);
 		/* {{ RobertYu: 20050104 */
-	} else if (by_rf_type == RF_AIROHA7230) {
-		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
-			result &= bb_write_embedded(priv,
-				byVT3253B0_AIROHA2230[ii][0],
-				byVT3253B0_AIROHA2230[ii][1]);
-
-		/* {{ RobertYu:20050223, request by JerryChung */
-		/* Init ANT B select,TX Config CR09 = 0x61->0x45,
-		 * 0x45->0x41(VC1/VC2 define, make the ANT_A, ANT_B inverted)
-		 */
-		/* bResult &= bb_write_embedded(iobase,0x09,0x41);*/
-		/* Init ANT B select,RX Config CR10 = 0x28->0x2A,
-		 * 0x2A->0x28(VC1/VC2 define, make the ANT_A, ANT_B inverted)
-		 */
-		/* bResult &= BBbWriteEmbedded(iobase,0x0a,0x28);*/
-		/* Select VC1/VC2, CR215 = 0x02->0x06 */
-		result &= bb_write_embedded(priv, 0xd7, 0x06);
-		/* }} */
-
-		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
-			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
-
-		priv->abyBBVGA[0] = 0x1C;
-		priv->abyBBVGA[1] = 0x10;
-		priv->abyBBVGA[2] = 0x0;
-		priv->abyBBVGA[3] = 0x0;
-		priv->dbm_threshold[0] = -70;
-		priv->dbm_threshold[1] = -48;
-		priv->dbm_threshold[2] = 0;
-		priv->dbm_threshold[3] = 0;
-		/* }} RobertYu */
 	} else {
 		/* No VGA Table now */
 		priv->bUpdateBBVGA = false;
-- 
2.25.1

