Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE249065E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiAQLEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiAQLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:04:06 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3906AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:04:06 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d11so6076960qkj.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVVFFLPkAhrjO1v7t1aDsmduyj0ieOuL7PziCjm6/tg=;
        b=W/81fg0Hk0sIXPbIeJrLwn4SfVlAT+y3A5lZ5OhghM9yR6857m0qZvilEcG4GRNMo4
         EivmcO1ftmIggwQWWMfy4xd0lQ50oEeHCuhyk2b8I+5J8HkWiKMA75V8BvI6ij6LYcbd
         +fMOayUylLTB3E/E/FeCSwm1Y+548SOr36hRT5npIbu+rtSsUgVX0/KARLfhBxsgdLS9
         aO7c0AuwPk5R5STzHDRQe+Lty80mQ6dC31Z+IvT3+lHIbDS5JSn9D/Tkvs3D3cAwKs2s
         Ez0G/nit80T9J9DlqthpEHh0raJKH+C/bZzKCQCh/vSPY8UdMDRejTVBhgLGOFJcQirK
         N6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVVFFLPkAhrjO1v7t1aDsmduyj0ieOuL7PziCjm6/tg=;
        b=Wxf+QZsJEGN+D6UbMJfafLG2SHEFBCIlOe09kszWhYz9ljy26nIyilnlJK6LfqbfbR
         OuCTLPyZUvP8DNbQLVq71/TAGZa6v+FPE5AzzA5tmhAKXRHTBVmUexVVLDat9yVEkqX+
         PUMckePK6fKdsmh3TMOu6xiJUeUacrQtFggpdZQYnPzNzEESibfPBaTFf5iMpxVpwHgT
         drwfhmtEbR81VANKzXC+h3g2gqRqTt/zLFTpBW4/uYLUojR+tUlOiDc2vak9UWg9t3KM
         3Uu4qwqIEB51T2coLIR7FiZy4BwIvaEMIKSZOkCburZTBXio78jmRPQdNQ0IBhZyBHeO
         IQ4g==
X-Gm-Message-State: AOAM531SkVn905ZenctCWwPSfavvedIcp+1Lh9SgKQFKOUWqjWASwBBc
        lxfZysyMGxGbCTYL+vvkJx8=
X-Google-Smtp-Source: ABdhPJz/pAE65j0ZQrMN/H6l9uLJ86U3AgN3jVqlcUFlNN1OGK6FGXX48zniSP4M+enymXdqkWSPcw==
X-Received: by 2002:a05:620a:4707:: with SMTP id bs7mr6890633qkb.69.1642417445471;
        Mon, 17 Jan 2022 03:04:05 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l16sm8198120qkl.114.2022.01.17.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:04:05 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     krzysztof.kozlowski@canonical.com
Cc:     s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] sound/soc/samsung: remove unneeded ret variable
Date:   Mon, 17 Jan 2022 11:03:57 +0000
Message-Id: <20220117110357.863990-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from io_remap_pfn_range() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 sound/soc/samsung/idma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index c3f1b054e238..402ccadad46c 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -244,17 +244,14 @@ static int idma_mmap(struct snd_soc_component *component,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned long size, offset;
-	int ret;
 
 	/* From snd_pcm_lib_mmap_iomem */
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	size = vma->vm_end - vma->vm_start;
 	offset = vma->vm_pgoff << PAGE_SHIFT;
-	ret = io_remap_pfn_range(vma, vma->vm_start,
+	return io_remap_pfn_range(vma, vma->vm_start,
 			(runtime->dma_addr + offset) >> PAGE_SHIFT,
 			size, vma->vm_page_prot);
-
-	return ret;
 }
 
 static irqreturn_t iis_irq(int irqno, void *dev_id)
-- 
2.25.1

