Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945B24E6ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354518AbiCXWqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355494AbiCXWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:46:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6669EB6E44
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:44:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 93AD45C01A6;
        Thu, 24 Mar 2022 18:44:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 24 Mar 2022 18:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=RypWuAcjXYhvuM
        rAXCozdcgxcIlBzpaT89Q2nmHZmv8=; b=fpM1vU2l469OTi4Dk20tKbnWx6Cf4s
        oi57ccCLS0JJqje6SEiE5Yke2v5GYqFPSPwV+z8XDDJLF6fsw4BtWMQg+irZh3Bs
        X31g5FhLshTcW3irOuUP8tVsISzaNiuNygHsfQP+6AbveEms1Yl+lUreyDY4Yu7G
        G9Z8ml9VC8LppFEy7WYkRQffqW+wkjecn+44vf+2NnTtbKICbJ2bv/N1u2vPS/PY
        wdrRDMFBZwIoOto/IqkK+BgQG6OiYi0fe808qDjWWlNumNU9oRrrlDmyzSgcfESr
        mhSB71l4RbZiIDAr594gasNHoYBDQ3ikQfVahMIZ8jnT7BzaxrpB9xAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=RypWuAcjXYhvuMrAXCozdcgxcIlBzpaT89Q2nmHZmv8=; b=XOwBPPeM
        mnbXwJ+PLdSRa2BMxFUDnjYPV0haB7FbevY5sBbo2sCdUaiIBIWz8NEAwqZecKqu
        1VP872OeciQ8aB0XJVnu/+BfNNIH0+qOj8MtS1ZtT6DSguR16f9aRdWGuOS5NJet
        IIkB8IfincfHM+YZDZyCVoGF7UJITy9dZBTMwT2qW7SCBi8HvG8Cqx4W92wbdnqD
        gEjAS1eizVpCo6CWuSi2cw0FIfjylM9gY8IHq/E0/7X7DsuCVBgGPGqzBWrJ8u9M
        9fNAjv8raJvc3eC9nHsiBLppHj0KqGjypmcpL+1DMfVmvCg8fh2BrcVGC7MLjyeW
        V6rfLteZ6mDDkA==
X-ME-Sender: <xms:WvQ8Yi2XRm5JsTR2Z_3it_8RPb1q5xCa9_TRFJPh8rd2st77xEv3ng>
    <xme:WvQ8YlHoUgvzeyRFJvOQesgag3reZOngojes-7PK3htle1zcwnY0cWDqFB_go5wMD
    8eEenBrcIe-psl2pw>
X-ME-Received: <xmr:WvQ8Yq4IEq-F1HnFDpDYX2-1wAjpQqkSnlS7lE40aPaMu7Ho7QOk4ulaEPmTxWeEc3C3-qU--raFVFQ4SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeije
    euvdeuudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:WvQ8Yj1yxec6eSB7PxaDIS66-voAyy0vm2FLJxQcQLBpmjJEz-5zPA>
    <xmx:WvQ8YlE2NIYgLOdChQNljm-84XINzI3NMjx2Sb0a8yrB_cbYJGENnQ>
    <xmx:WvQ8Ys-Cmt7nzO1XkHJ510go-me7nMWweIXuCm1cN-_5ayBVgTmgYQ>
    <xmx:WvQ8YkCcvyQCRIAVIGvAdpB18NkSBN2rBp27YBPiYdbBGMTr2P_dvQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 18:44:42 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v9 5/5] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Thu, 24 Mar 2022 18:44:35 -0400
Message-Id: <20220324224435.17794-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324224435.17794-1-zi.yan@sent.com>
References: <20220324224435.17794-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

alloc_contig_range() now only needs to be aligned to pageblock_nr_pages,
drop virtio_mem size requirement that it needs to be MAX_ORDER_NR_PAGES.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e7d6b679596d..e07486f01999 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,10 +2476,10 @@ static int virtio_mem_init_hotplug(struct virtio_me=
m *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
=20
 	/*
-	 * TODO: once alloc_contig_range() works reliably with pageblock
-	 * granularity on ZONE_NORMAL, use pageblock_nr_pages instead.
+	 * alloc_contig_range() works reliably with pageblock
+	 * granularity on ZONE_NORMAL, use pageblock_nr_pages.
 	 */
-	sb_size =3D PAGE_SIZE * MAX_ORDER_NR_PAGES;
+	sb_size =3D PAGE_SIZE * pageblock_nr_pages;
 	sb_size =3D max_t(uint64_t, vm->device_block_size, sb_size);
=20
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
--=20
2.35.1

