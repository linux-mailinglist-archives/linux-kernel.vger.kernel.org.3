Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52EF47079F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhLJRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbhLJRv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:51:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DCC061746;
        Fri, 10 Dec 2021 09:47:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1395ACE2BC9;
        Fri, 10 Dec 2021 17:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC6C341C7;
        Fri, 10 Dec 2021 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639158469;
        bh=BmIdMiKO1bHxAOrA+A9w4P6ev9W7GWoh8IjX7ujddm8=;
        h=From:To:Cc:Subject:Date:From;
        b=ao/OUYv7n2gHb2mrq9gudYZ9kPi6m/n9no7Pl68eI8Vw82O8al2mT3P/E7Db+RIE9
         /VdQrdDwkcAIHPOMHcB3M901xvEiYYNYv145/alcG76/sdp+v8iz6o1djVqwltdDho
         6bahg8rq6bIQC+xbJhkk5SDEfn4fLZInf0KBopjnM5w/xQuyMQNGwNX66VeiOBEm5t
         u7dJCxsLAAbObAtlgmWuRZDXDloSILvpWvPf8+SY8TyTnGlCwHM4wyKLn8n2OlkaTF
         56paOg6SyeRcwf4lXdXGBjvIzoCNbVagKn7cM66WVM+gTOkxaiiBpbYR/FO07JfBph
         g7xaSOHGIaZ+Q==
From:   broonie@kernel.org
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: linux-next: manual merge of the nvdimm tree with the ext4 tree
Date:   Fri, 10 Dec 2021 17:47:40 +0000
Message-Id: <20211210174740.2695216-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the nvdimm tree got a conflict in:

  fs/ext4/super.c

between at least commits:

  7edfd85b1ffd3 ("ext4: Completely separate options parsing and sb setup")
  bdd3c50d83bf7 ("dax: remove bdev_dax_supported")

from the ext4 tree and commits:

  89b93a7b15f75 ("ext4: cleanup the dax handling in ext4_fill_super")
  7b0800d00dae8 ("dax: remove dax_capable")

from the nvdimm tree.

I'm not comfortable with resolving this in something as critical as ext4
at this point on a Friday evening with the code motion that's going on
so I've dropped the nvdimm tree for today, I'll look again on Monday.
