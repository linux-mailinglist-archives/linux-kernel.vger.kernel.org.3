Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35D46F732
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhLIXI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:08:29 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34951 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234119AbhLIXIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:08:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D8885580336;
        Thu,  9 Dec 2021 18:04:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 09 Dec 2021 18:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=AnymEuCYCocHA
        Ds+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=EWH4R1T6XLR7/XPYv2+SuW3bSclZ2
        Kvvb5NsB7w82sEJmQn0JTB+0tYZOTesLZT4rKW45XSVxeH1bnS7C74KuCr4rc4MT
        p8BtjGButAGWBNV4uo+rZcJ3rKJswkkAJkPSP+Zqdo7YaZ6Zf+UbAsWH2oQ1IVu5
        y7x1kCiTvV6CbZBdLUT2NhuhIGI0vBByiLkfoLEdr6U32Cu6Rz/ZGFsfDuIYwnms
        wLY7nz1uydR2fz3GqBsSnRTesabSsmAgM5e6agHA8En5BtHs2HlAphAH1MBOpPsu
        m4O5k9GgUc1WCJD0+OoSKxbUvdWgPIcq+VlI1Uso6SDFOSpgDCfEEXzdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AnymEuCYCocHADs+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=HZtl8rio
        tiDaICvgAUzv/4f1nQmSHjhBIUEQFY861mwC2NyYz6pCsrC7nu3u9UtEXyZVB/mx
        BjBVhTTTu0BpzEwPwkHvBsIVW5nwvpZQgy+QrLPmAH1nl952z6L38W21OrhYwnhc
        peJfhNpeHrz2BC7QfBdFv4KCbeG/ZZhUQWLtQy4lYqiwpdWIWIqCWQd4ToWrz5GP
        9N+4GLDRjrKZai/PggjolYf5hbvep3tSuZMRz/X/MuyX5iv7HYnYBXPwaOZiP3m8
        wAcugQbbt7v/J1Mf/NXWwgXTu4BjEh+XMdDtHqmxke9L9OqmXsy3lbasdxV1vKnd
        T6WCa5FKe+ZVTA==
X-ME-Sender: <xms:iouyYeTVgH8ecDbOlF7wKOSH2hbfe-phC6rhzNtLNbpHdlCYt1dIIg>
    <xme:iouyYTwGLDgDIEHg_Eaw_iNPBtu0RXQqNkJba78sHdTf9RiHSZNgQzS_JVIPJ2IdD
    x0vjj438dKjHVxP0g>
X-ME-Received: <xmr:iouyYb3nCDeuVSMgAhBPzHQBkjPbsZgdOD6I8i1CDXXu32PtmMKuxZJb-VgDZp3rmYzEfzr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:iouyYaDlHTwHozoQD7OJ2ylBL_etQamuyf48-S6eHzhvK4FtAUES7Q>
    <xmx:iouyYXhJzCDzQtVD3NYsG4zcpqTAUAAJtH0AY-SZdLojN1sLOvUsvg>
    <xmx:iouyYWq0g8wwEte4zQhjjH6ln3n-DKcn94VCAAu62nPln3WBKoAB4g>
    <xmx:iouyYQaZscSeRo5m2okFZdWcKobvbA7nU8mLQF60niy2bvnUQLaDjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:42 -0500 (EST)
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
Subject: [RFC PATCH v2 7/7] arch: powerpc: adjust fadump alignment to be pageblock aligned.
Date:   Thu,  9 Dec 2021 18:04:14 -0500
Message-Id: <20211209230414.2766515-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
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
index 8d61c8f3fec4..9198f20b6b68 100644
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
2.33.0

