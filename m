Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D854BEE94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiBVArf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:47:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBVArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C51E1F;
        Mon, 21 Feb 2022 16:47:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C3E6B810F5;
        Tue, 22 Feb 2022 00:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D16C340E9;
        Tue, 22 Feb 2022 00:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645490825;
        bh=Z8IHyAaQ54jrFYPeM8l++d5bqOGV17TfZq//aIzYBDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NWf+H+Vuf8O4mNgDN6B3K5dqjOQ1aLjWxUQ5dHYtHa1yQpZ+thokxBlgfpRVYwhV9
         1+a+vOTLkszmrnp/FL30kqKX8m+kwXIWSFpI7It2YIcTJV1zZSmdpIZn4Td9oGlXR8
         IXKmo/3qDn5t8Rq9Gg76mOQAW0bt7T8GaVRzrmof7L85nJplzQQ08t6BJQVhVw5eah
         CiECkFLmYN9MsCCObuq5k0q5E3v9hrLVvHKWaj1HoQRtE/NViGcKzoUldii5XXHDU7
         IJuRK/eiseBDgsKaNVXbxqCn6Ewlf6w1j4XUlpxwOdFtIawy4y/bDKOzOJ0o/qEjzt
         oC0LBmdlfN2Pw==
From:   broonie@kernel.org
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the origin tree
Date:   Tue, 22 Feb 2022 00:47:02 +0000
Message-Id: <20220222004702.3360917-1-broonie@kernel.org>
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

Today's linux-next merge of the bitmap tree got a conflict in:

  arch/parisc/include/asm/bitops.h

between commit:

  47d8c15615c0a ("include: move find.h from asm_generic to linux")

from the origin tree and commit:

  a7c7d06a49d69 ("include: move find.h from asm_generic to linux")

from the bitmap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/parisc/include/asm/bitops.h
index 56ffd260c669b,c7a9997ac9cbb..0000000000000
--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h

(used mainline version)
