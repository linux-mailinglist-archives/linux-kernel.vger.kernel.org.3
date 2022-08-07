Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576058BC43
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiHGSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiHGSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:13:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3965FD
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j8so12839965ejx.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=+FsM9BSLLhQlcBk3zJRjR04gJAe6i1I5jpWIJQymm4Q=;
        b=G9lNccKYXi936800LuvsrO6U9gwlyjprNZJqVFunrUPoeNUJeaCWgRdxklKtIPcIBa
         7YNaCqWFOLf2XTAU5tQU/MwvLGgIFnFHLEcdaBSBiS0W3feuCeiWT2xq7+0FEAi7phZy
         uIrdY0N3iVFeok6QtvYVp/5Vc2YY85gS4F/RSsoE35EQtpsQslCZt3SgeourenCRjUw6
         xvYW4xHflB30QVefC6n/xz6whJbBzINPn/mlQKcSedv0Yi7ygxACQ7UPBcutLzt02TvR
         5c74TYdL5focUaDU8hqNBkXEEr/epiLkeuzwQUT41SCNilwuwW4LMkI3RsSxboCA17+C
         idTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=+FsM9BSLLhQlcBk3zJRjR04gJAe6i1I5jpWIJQymm4Q=;
        b=KoZuDvjSdHhViDfQZcdvG6yybkj7TJDrZEAJgaeyjXetu9WjXmONbXIU6aHOrPodD6
         uRxdXJG2Ow4c7DxOLWv0TooszhHuYYzaOQlkp8mjjjopk047wPalvLOaCDw8iECnhzkI
         IMxExJXcpCrIcEevN1/2OJvij23CEbEu24vgdlNNhLQg9XSFEQ8bd3gfO8O9xSMrMGRz
         Ros8sp2290S5TUNviU+mAk2/pIHNlkyveeiL+ZKDXhlxUWbAC5HwzcCpYEXEU46ZRvZZ
         /WIGUTL74hIifOB4fy9fzV0rwWlcshkY15A03oLPvdm5ezehxfUG8JzAds8DYNE/+wH4
         pfKw==
X-Gm-Message-State: ACgBeo0lHPtYGTiVAmQ+ltlD/RuJf7z1VSkdkN+KCXOM+i9W7/wRFaxp
        Biz49jRlJIPCp4/9BuzOENobaEfenT4=
X-Google-Smtp-Source: AA6agR5nJtgs4H6oxgLQPmN30x/Pt6UcZezLdIKnEceF7jwGWJcrpU/O6N181CjwcMsHekov3oaHbQ==
X-Received: by 2002:a17:906:9b16:b0:730:d5f4:d46e with SMTP id eo22-20020a1709069b1600b00730d5f4d46emr11412955ejc.701.1659896024608;
        Sun, 07 Aug 2022 11:13:44 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b0073100dfa7b5sm3083158ejo.33.2022.08.07.11.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:44 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:42 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] staging: vt6655: Rename function MACvEnableProtectMD
Message-ID: <927d7c6e7c9d5214e4faeca886efd2696b2abc31.1659892670.git.philipp.g.hortmann@gmail.com>
References: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename MACvEnableProtectMD function to vt6655_mac_en_protect_md to
avoid CamelCase which is not accepted by checkpatch.pl and to clean up
namespace.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: No changes
---
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/mac.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index dc50bff4403f..ccfd4bfa0502 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -225,7 +225,7 @@ static void vt6655_mac_set_bits(void __iomem *iobase, u32 mask)
 	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
 }
 
-static void MACvEnableProtectMD(void __iomem *iobase)
+static void vt6655_mac_en_protect_md(void __iomem *iobase)
 {
 	vt6655_mac_set_bits(iobase, ENCFG_PROTECTMD);
 }
@@ -1475,7 +1475,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
 		if (conf->use_cts_prot)
-			MACvEnableProtectMD(priv->port_offset);
+			vt6655_mac_en_protect_md(priv->port_offset);
 		else
 			MACvDisableProtectMD(priv->port_offset);
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 84d203c56b1f..4de9974e6c69 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -12,7 +12,7 @@
  * Revision History:
  *      07-01-2003 Bryan YC Fan:  Re-write codes to support VT3253 spec.
  *      08-25-2003 Kyle Hsu:      Porting MAC functions from sim53.
- *      09-03-2003 Bryan YC Fan:  Add MACvDisableProtectMD & MACvEnableProtectMD
+ *      09-03-2003 Bryan YC Fan:  Add MACvDisableProtectMD & vt6655_mac_en_protect_md
  */
 
 #ifndef __MAC_H__
-- 
2.37.1

