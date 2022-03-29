Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05C14EB5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiC2WbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiC2WbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:31:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202D3388D;
        Tue, 29 Mar 2022 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ELpi3PxAhFEnZCSjxU1a3yYtIvZmDTtwh4UVtOU3G+8=; b=OQPr9lKBx/70xOs+02egJpxbfh
        Cv3uFjMyI0ypQo/PNg8IHXmYYsqrRGpbJEgz/dFAqkbEXpsNu2OmRhs9vSxFkK6noDIwLC7Jwhx6N
        DHtgzuEakgL5uuyjEgHbNYVzL/qPis0CtIHWjtD4iQjyg4NZJA15y20DSVS1uQm3iMzrcFekArPQu
        5rxi2di+qsEQM/tNbdfg+6dTOGGK5EmK5k+Y10M6dTdfYKUK9qur8y/xqmh/u3UP9B23+teMjYa3g
        WjNT0m01AIPe9hyZ78ELALLUn9iAMh6QpY/+IN0mky1efsl1U68xQNdvu65KDwmmk870QIX73EXCz
        uEk+SE8g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZKKv-00DdvM-9q; Tue, 29 Mar 2022 22:29:13 +0000
Date:   Tue, 29 Mar 2022 15:29:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Vimal Agrawal <avimalin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [GIT PULL] Modules fixes for v5.18-rc1
Message-ID: <YkOIOQPY9N66jp1f@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

As hinted before there is nothing major for v5.18-rc1 as it all got
merged late into modules-testing, and so did not get much testing. The
only change then that qualifies for consideration for v5.18-rc1 is a one
line fix from Dan Carpenter.

Expect a new world order for modules for v5.19-rc1 though.
All that stuff is starting to get exposure for testing already.

Let me know if there are any issues with this pull request.
Hopefully I'm starting to get the hang of it.

  Luis

The following changes since commit 13776ebb9964b2ea66ffb8c824c0762eed6da784:

  Merge tag 'devprop-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2022-03-29 11:30:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.18-rc1

for you to fetch changes up to dc0ce6cc4b133f5f2beb8b47dacae13a7d283c2c:

  lib/test: use after free in register_test_dev_kmod() (2022-03-29 15:13:36 -0700)

----------------------------------------------------------------
Modules updates for v5.18-rc1

There is only one patch which qualifies for modules for v5.18-rc1 and its
a small fix from Dan Carpenter for lib/test_kmod module. The rest of the
changes are too major and landed in modules-testing too late for inclusion.
The good news is that most of the major changes for v5.19 is going to be
tested very early through linux-next.

This simple fix is all we have for modules for v5.18-rc1.

----------------------------------------------------------------
Dan Carpenter (1):
      lib/test: use after free in register_test_dev_kmod()

 lib/test_kmod.c | 1 +
 1 file changed, 1 insertion(+)
