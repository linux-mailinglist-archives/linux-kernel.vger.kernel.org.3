Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA059585BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiG3TUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiG3TUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:20:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05F6101DF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m8so9278967edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=zEv3y3d4lNBhF3QA9eeB4K5jO3MyXebCpviRLBi5Fd8=;
        b=ETK2IwoiqFreK+LdBxvQp69R8sQXA7iT2jSauG/Go+LOLNvH2LrtrDW+QryRnXLqWu
         vGLLEjprU1sZ+4pWM+PT4/ycb0IZON13ja8QO7rr5TLo1ETPZ7FgUp1G3PT3msHAwBDh
         8AiiJ0nQuxnlhezW8En0tMLR5Whjs5nic7imP41lURhGnYAh27/JWhRsAVXyaLItboOY
         MkhJofGZHNNiNM73eJYf7ylfBDzG+BdSq+YrCEgO3Hll2ErWRFW3xUjkCITfuiBFoWES
         G6FRQZbp2mvLLaa+60IiL54E3Bxu4SsZXX2wqPGh5UkyDulYpnxOnO202ZripDjsVLUz
         1IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=zEv3y3d4lNBhF3QA9eeB4K5jO3MyXebCpviRLBi5Fd8=;
        b=Ko2KJvHiyQ9FavGclZeQsi1Vn4+rrdH2hvC3FgzoeF1zEt9u+IWDV9aWlK8d4J67hY
         p94fC4GQKEeu+9Msnp8KQk69fCl8byarVZu5xcaOxz8Lo0IQyyCAU+m8PDW3JHPKR0b/
         ipa9vDZJf+TWRfiNZFZa4rmuPUWxKZ7o8DNDXlwqSuD0/18a/TlFGltmKGn8g1cCl0rR
         IvbB2NA5qXMdb+lS9nk8xhsRCKSYQXCwZZafBB6aasdPKy4ukM3/QMLouw1loH5YNdUh
         sJpqWaVIh+Z1APjbXPna+9ehiQqk35kPpgztOBUnnsWoi/fHDdOkdh2IOinWwt1NbbGS
         IlbA==
X-Gm-Message-State: ACgBeo0DQKD+87psPuppnR7iUYq9+3qG0+ycDV9+KWuivfzN2HuLfbj8
        f+kVUuL7pKZuCgJVma9cTyg=
X-Google-Smtp-Source: AA6agR4JYUmtMB6i+qWDdcsOlKx+QbqKkxm1aWgSfzDHDl9XxBVV8Q6wZcvxCw/FMcTKb1ziFfB3+w==
X-Received: by 2002:a50:bace:0:b0:43d:370a:e1c1 with SMTP id x72-20020a50bace000000b0043d370ae1c1mr5947702ede.193.1659208841143;
        Sat, 30 Jul 2022 12:20:41 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b0043bdd401cafsm4214506eda.47.2022.07.30.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 12:20:40 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:20:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: vt6655: Rename function MACvEnableProtectMD
Message-ID: <3e5edc9a6a0cefa5474d125321a8b6d6caf58e19.1659192760.git.philipp.g.hortmann@gmail.com>
References: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/mac.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 5f64204dc312..7633602e47c1 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -228,7 +228,7 @@ static void vt6655_mac_en_dis_bits_u32_reg(void __iomem *iobase, bool en_not_dis
 	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
 }
 
-static void MACvEnableProtectMD(void __iomem *iobase)
+static void vt6655_mac_en_protect_md(void __iomem *iobase)
 {
 	vt6655_mac_en_dis_bits_u32_reg(iobase, ENABLE, ENCFG_PROTECTMD);
 }
@@ -1478,7 +1478,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
 		if (conf->use_cts_prot)
-			MACvEnableProtectMD(priv->port_offset);
+			vt6655_mac_en_protect_md(priv->port_offset);
 		else
 			MACvDisableProtectMD(priv->port_offset);
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 31e75df5f02f..66e03e8173ea 100644
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

