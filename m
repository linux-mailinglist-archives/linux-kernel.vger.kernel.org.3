Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB4485B09
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiAEVtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:49:13 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34605 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234117AbiAEVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:48:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4AB4D580571;
        Wed,  5 Jan 2022 16:48:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 05 Jan 2022 16:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=8yuexR1+nrtHG
        SO8wGNcV0MvB+tGU4p0S4nQ2u6/h9Y=; b=kNcgqXMU4/n+0YyMRK0TyVMysDqOh
        yGnxu3188w1RZak/r6C5GGCMGkYAvYZrGUXVsCm5C/Jb9fk2x8P+Zhkbv2juEiHF
        Xx9yXwsMcFZDgw14URi8KOX4Gq3BjiqSdCn8GKzv3NQXWRkliOB0JVHVM8uS81kz
        FXWoyZvcC8pdi2IY2HIDM9KJjv4NSShQ3V/ljJO+UE1AAlyWOJHG3t1nZ3upZM6c
        K6hHMhVO16bR2AATD8DVfvQ/aYyij27BJTE7NIUx0TvMRg4mNtuYCz5coZkOImzw
        Rby2nrBx/WVcBJxX1xpgf8EFekNemKmfyEiUBjB3mQtzUXARZkQ3mfEPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8yuexR1+nrtHGSO8wGNcV0MvB+tGU4p0S4nQ2u6/h9Y=; b=PhZUATg9
        FmZKLL8OPTeqjkwnPLyfUAOaHv5EhgMImn/cYWCeGVksMiYYzIciYyMSBtwa1hDH
        zCMqdscamUNJ9VbKXUa+IXBcuZ4nNEh60LtYJw1Gyy7ZrarTM7wCpYBEirVm+okP
        YES7YEJcbaR5e1IzVbtjM+zqax4CfbcEuaxE6NvYyGcm+/aJJ5AVvkeBkZgiJuFq
        6idpjFtqRH2qzA1FEI/Uln2s5XO78fxP3GhFfLNoCsG+v6WvjpSukS8udRI4XDeu
        yJj7Gmw41fOmt1fCiz7dqFk+yuPnwHiyM29QUQlFw2sp8YKAXCccMuYCYuzG/BA2
        DQReGxxAcIFXcg==
X-ME-Sender: <xms:LRLWYQPVidpmgi01iA-MzZbuDuRhT6Z_IJjKkBfP34fKrxdB3GTGRw>
    <xme:LRLWYW-AyiLLpcJde4tItRbz_921Vw_Be1O8-D_3ARqY5j5MeIw-G6ZDKLkPiAqMM
    fabpTHp8Wvjadrqgg>
X-ME-Received: <xmr:LRLWYXTBUF87OXxBul7SmmYv5X2QdNgcUKdPg2JXNJS8qbfmKQuYz1B3f8TGEP5BJp_-22cV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:LRLWYYsCBFereavIdxgPqU4MOOT3p7BIVnUwwIExBXietPI4jPWS8w>
    <xmx:LRLWYYe7ZcX5PSG-JXwLG-eqVMgwlXFXAbwWTb-NcNTuScSBOo3bQQ>
    <xmx:LRLWYc2-Jua3FPZLC43ywFWwFVHK36Ata-2S4GvbOxjWi2yu6fx06A>
    <xmx:LRLWYe3ONauEy1XZrRc2lxpCjRBxgKLaO5tTCuBjiiinzKzKitiBhw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:28 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v3 8/8] arch: powerpc: adjust fadump alignment to be pageblock aligned.
Date:   Wed,  5 Jan 2022 16:47:56 -0500
Message-Id: <20220105214756.91065-9-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

CMA only requires pageblock alignment now. Change CMA alignment in
fadump too.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/powerpc/include/asm/fadump-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/incl=
ude/asm/fadump-internal.h
index 52189928ec08..fbfca85b4200 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -20,9 +20,7 @@
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
=20
 /* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE << pageblock_order)
=20
 /* FAD commands */
 #define FADUMP_REGISTER			1
--=20
2.34.1

