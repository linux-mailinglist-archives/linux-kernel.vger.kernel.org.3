Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF0544C52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbiFIMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiFIMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:42:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3482DAA5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:42:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1FE66E001B;
        Thu,  9 Jun 2022 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qivlgdc/cztAuyEVTvXwN0p2uVuSMV9HgTJpX4k6pDM=;
        b=Jj2sZBM4vkrS8sixZpkHNa6eZ3gYoPy0pMoREerBewJ5iU1VVEQgQe1oauXSQ9rrPN7Qrv
        HQAFc4JiJzacfcDxjXm8m1+x544Zqf3jn7MpToRpm4ZglxefAM8RL/mROKoKECuAoaxVxV
        +DIRu7CdNFCOxwIN6yiR+9p4KD3gbRiiH4zpUJrVy5I5wLD4XOpmfmpliABQXdZfXDGqLu
        efj/Lwb0Fvx7gQ2ekvubXpeEA44Y43mYC7PihymGlo0Lm/4s4/gAKgKj+BHI5cKZiDu83W
        aN/TOUuIXJxEtSkLV/3DSg3bIju9q9zMCjUnPdRxdnJV6KH3aFeVOPQ8/DWxzA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: ofpart: Fix refcount leak in bcm4908_partitions_fw_offset
Date:   Thu,  9 Jun 2022 14:42:40 +0200
Message-Id: <20220609124240.132923-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605070726.5979-1-linmq006@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd2b8a88a113d20dad823e32cd6b63b94c2da49b5'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-05 at 07:07:23 UTC, Miaoqian Lin wrote:
> of_find_node_by_path() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: bb17230c61a6 ("mtd: parsers: ofpart: support BCM4908 fixed partitions")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
