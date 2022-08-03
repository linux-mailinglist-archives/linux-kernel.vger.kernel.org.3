Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFE588B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiHCL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHCL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FE481D5;
        Wed,  3 Aug 2022 04:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716136108A;
        Wed,  3 Aug 2022 11:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA87C433C1;
        Wed,  3 Aug 2022 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659527929;
        bh=uT6WmBah90ojSmn/01bz2BZzuwpY4jyvKO8tWuTrPrs=;
        h=From:To:Cc:Subject:Date:From;
        b=HjKIOkDaG8oa9ZEOaRz5PpAkEKIgdc8USG9xTTv8V+oc44iLbb2Rutl/GJDmG6KFD
         QaS0B7F3F9/mdt4fH75VTvba67iO1K+cRCckwkmZlyQJES5NivgPWvx+jTYq9v7MD2
         yim3jm+RxzL1I8qOGN5Dqf+1oeAbuZ5KXCVEAjzajxnwS+uOFx+xcWxquKfcUviWOQ
         SwI3Hb6B9qvNiN9WWcu35HTH2fiXR0vuHwHLpjx3akK4U0mYoVsWY9dDCzlVLchj0S
         jqpeSPzrD7c4O+i8siI5mmNP2P2G+Ek2PneDc1S6W7KRqs33ybWbHhUUcO04o6dWcW
         usJait1Cxkv8A==
From:   broonie@kernel.org
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: linux-next: manual merge of the overlayfs tree with the origin tree
Date:   Wed,  3 Aug 2022 12:58:44 +0100
Message-Id: <20220803115844.53246-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the overlayfs tree got a conflict in:

  fs/overlayfs/inode.c

between commit:

  1aa5fef575a83 ("ovl: handle idmappings in ovl_get_acl()")

from the origin tree and commit:

  ded536561a367 ("ovl: improve ovl_get_acl() if POSIX ACL support is off")

from the overlayfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.
