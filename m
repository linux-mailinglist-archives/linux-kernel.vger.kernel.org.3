Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE850D436
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiDXSn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:43:25 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860AA15712
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 11:40:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i196so13731196ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ysq6r/KGEWvs3JKm+7GsajBhnC1rqVgQKhxLMm/5600=;
        b=bUZfYeZfZWfa6hk+J6GAlHPPJFwphY+7fWPaBSwJpdBtX5M1te6iI9zhHvbzPqrcDv
         zPyViDP7AnKsZjxb9ErLTH7eC1OQeX6rqBbpQwF23l5zEuVOsXp9fKqu2Coj9jedISIM
         HEgrv654jM8khYCmokvsmJsBmU11xda+NJHCAs3b03fflbQQCypZgOYW0S7ymvDXwqaO
         rpN3Pv2GPQImHdzTrblpzkQBOg1VXIAUqlUMR5tWKQVxpULRbV1PvRn2SmLTVNmjCJT8
         ysQV2Of2e6oIvnX7OCP2d6dQ/anWxgFc5o1/cuXXdMA/inTaG0vkljDSYULAGRXhM2Xw
         CP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ysq6r/KGEWvs3JKm+7GsajBhnC1rqVgQKhxLMm/5600=;
        b=36zohdtr/hnDgYIC1uxBHSuDRXB8IS17E9ijreg5avctb4JO+FCY6KRnBdzjh1wvas
         qfEClQ6vfRBdmTlzLSvjDMufjiLyzzIuav0TiPsrNkHZOO/82l5B6viV/5mTlEJTAxa5
         Am7o5revfB9jaZi3FqCvjh3zMm7wXdCCZ+lQbdYy6KHlvRwoTInPvXD7OwdBothyHER/
         lZneE2AJW6E9Eb4a4UBE7cLtxIWYeMawiA4t44wuzzvi9Nko1kA7ranWd5RNl7hBTYLn
         1CKkQHKQUaFdtlkMQY6n54bV69Q4XeHFXnzwLyCqZ7slJBhA7r2UkK9uZK1h5zQLrClk
         9saQ==
X-Gm-Message-State: AOAM533GLtAuVuBNCYxHpZ6X7DQQ7dZfmm/J3kGs9DS9ZIoEvMwpbMoK
        Qj5yODg87DBIn4sy3z0N17Q=
X-Google-Smtp-Source: ABdhPJzrLitNERpkOJd/1LPHq0rM//0XPtdGApNYOedaZW7ozTM8UiimVn2OEGDIOcP2Cl86SRf8/A==
X-Received: by 2002:a05:6602:2dc4:b0:648:adac:bae8 with SMTP id l4-20020a0566022dc400b00648adacbae8mr5951706iow.9.1650825621787;
        Sun, 24 Apr 2022 11:40:21 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:a0fc:5934:6989:31dd])
        by smtp.gmail.com with ESMTPSA id b7-20020a92db07000000b002cbee0fdb4bsm5064735iln.70.2022.04.24.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 11:40:21 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/boot: remove unused function find_node_by_linuxphandle()
Date:   Sun, 24 Apr 2022 13:40:14 -0500
Message-Id: <20220424184014.968274-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The last user of find_node_by_linuxphandle() was removed in v4.18-rc1
by commit 30f4bbe0472a ("powerpc/boot: Remove support for Marvell MPSC serial controller")
four years ago.  This function is no longer needed.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/boot/ops.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 6455fc9a244f..8334bc3cbe49 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -200,12 +200,6 @@ void __dt_fixup_mac_addresses(u32 startindex, ...);
 	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
 
 
-static inline void *find_node_by_linuxphandle(const u32 linuxphandle)
-{
-	return find_node_by_prop_value(NULL, "linux,phandle",
-			(char *)&linuxphandle, sizeof(u32));
-}
-
 static inline char *get_path(const void *phandle, char *buf, int len)
 {
 	if (dt_ops.get_path)
-- 
Frank Rowand <frank.rowand@sony.com>

