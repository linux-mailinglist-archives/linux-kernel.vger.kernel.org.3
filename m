Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984F2472C76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhLMMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhLMMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:42:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18733C061574;
        Mon, 13 Dec 2021 04:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68149CE0FBC;
        Mon, 13 Dec 2021 12:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B6C34601;
        Mon, 13 Dec 2021 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639399317;
        bh=zfeR8W3r515UfkzI0HcenzOwI90h2TOBfLchmxtgYF4=;
        h=From:To:Cc:Subject:Date:From;
        b=lAWVRcPg0vQ6de64FcoYMdRzOaJfAzRExov8qo1xqFVSmhSHFieJru84gOHH56A2E
         y5lMVfCD3nSY24mNy2ylsLfbtu/5UPP0LKfsWLQXeKZqYIxGuZoYwjEuLnDabLSmbw
         iiw3zGtR0REvxMWQStfXFBek1+uIhS/2nISGXbuc7wQxgaA2qk1bpm3CgLLqBCiqJT
         VygBmEAUcmx5gffflMg4YoOIx6T6ln4UTECtS42uMXHwJde1EF2Yy618qgoRfcUKII
         OpCi/ywnMBL0tV6OX1P5xRvvSnlwlRInlHRQF48y5jNGUl35/gEEc5o8DBvgHe6nYZ
         09b4etCvKNR0A==
From:   broonie@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     "J . Bruce Fields" <bfields@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the cel tree with the origin tree
Date:   Mon, 13 Dec 2021 12:41:51 +0000
Message-Id: <20211213124151.2045975-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the cel tree got a conflict in:

  fs/nfsd/nfs4state.c

between commit:

  2e3f00c5f29f0 ("nfsd: improve stateid access bitmask documentation")

from the origin tree and commit:

  98beab5dca06f ("nfsd: improve stateid access bitmask documentation")

from the cel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when yGour tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/nfsd/nfs4state.c
index f07fe7562d4dd,3214257767743..0000000000000
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
