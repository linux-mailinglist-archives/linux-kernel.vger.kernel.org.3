Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25A4C1DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiBWV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBWV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:27:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93AC2C108;
        Wed, 23 Feb 2022 13:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90105B8212F;
        Wed, 23 Feb 2022 21:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDF3C340EC;
        Wed, 23 Feb 2022 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651603;
        bh=W8tC/FVRHIFkQM3dTfI++6vT1L4EeKBHfJDqBbt6P+M=;
        h=From:To:Cc:Subject:Date:From;
        b=afbgL0QDloqMaeO7KrrXNrEKQt8/s2AE/9WA/oLvAhWBxzZFyvonBHDx+90A8ipIG
         4X4Q12mLmIFaBmnWK795VWjuPnBtHQJt5eg+PciwCwa0GM1ybzodMMp584i2owveza
         4F0UUby5W53ygP+/5n77ahhe2ncnmY3ZHthaLwSGgkFA9WpnnEuXkDHpIVquTDdnr9
         zi8z10LUoBwuEc4h6uX86/JP9E3O0t5c1MhxeggIvyUU54R7o2wbzQJ5OEsgZ7dJwb
         0a7fwqZiLu/LU+mcSa5s/fi2jXuMfSNCr5wBiU7Syy6kxm1/epizN8+UaXnvqPTVtg
         MHzMNWzq+Pqbg==
From:   broonie@kernel.org
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Walle <michael@walle.cc>,
        Vincent Shih <vincent.sunplus@gmail.com>
Subject: linux-next: manual merge of the nvmem tree with the char-misc tree
Date:   Wed, 23 Feb 2022 21:26:34 +0000
Message-Id: <20220223212634.398789-1-broonie@kernel.org>
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

Today's linux-next merge of the nvmem tree got conflicts in:

  drivers/nvmem/Kconfig
  drivers/nvmem/Makefile

between commit:

  f78451012b9e1 ("nvmem: add driver for Layerscape SFP (Security Fuse Processor)")

from the char-misc tree and commits:

  1c565569b4704 ("nvmem: add driver for Layerscape SFP (Security Fuse Processor)")
  5293c629db958 ("nvmem: Add driver for OCOTP in Sunplus SP7021")

from the nvmem tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

[Took the version from the nvmem tree]
