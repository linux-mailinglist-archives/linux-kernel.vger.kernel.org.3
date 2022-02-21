Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8D4BEC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiBUVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:20:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiBUVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:20:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA4AE74;
        Mon, 21 Feb 2022 13:19:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9404C611F0;
        Mon, 21 Feb 2022 21:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1DBC340E9;
        Mon, 21 Feb 2022 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645478387;
        bh=/3k3i5+18OgZKxICGkCzfT85CiOhYAfOPUTLxe9uoPA=;
        h=From:To:Cc:Subject:Date:From;
        b=JPPccXKveFIyLOvszoUVscl6NqZDH+dApIdkUvl3V0WoVEAWi1M6VPRM27X16Shoy
         U/MUdR2zTKuJY/vK1nH38OoWKkm6FbkXACGTItvA+P/SeLWZJ9mtZ1MqscEpAJWDBl
         npVId+WFaj4Ms3zZPdjBKrHeKEt6mBZ5jtW7VBk/xQhQzVaxH+549GVXlqUPUwfdFN
         mh98HTsQl9sE49xQP7lN2bpGfiJgRglWdGELRbhSkCX2aXwqrxwCHZAT0oyN6I8Bbp
         GXskM/ByzFfYjrb6vScuocM0l9AodPttIZLPEciBa9PJK+I1btnG/zhDhlYlql4w+s
         KE59tf9c8Q6Ag==
From:   broonie@kernel.org
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: linux-next: manual merge of the iio tree with the origin tree
Date:   Mon, 21 Feb 2022 21:19:43 +0000
Message-Id: <20220221211943.2092199-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  .mailmap

between commit:

  984d1efff2304 ("mailmap: update email address of Brian Silverman")

from the origin tree and commit:

  f3366f8e64645 ("mailmap: Update email address for Cai Huoqing")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc .mailmap
index 8cd44b0c65797,76dd303c7eac1..0000000000000
--- a/.mailmap
+++ b/.mailmap
@@@ -70,7 -70,7 +70,8 @@@ Boris Brezillon <bbrezillon@kernel.org
  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
  Brian Avery <b.avery@hp.com>
  Brian King <brking@us.ibm.com>
 +Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
+ Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
  Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
  Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
  Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
