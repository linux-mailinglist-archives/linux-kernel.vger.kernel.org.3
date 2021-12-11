Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A8471303
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhLKI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:57:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43216 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhLKI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:57:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAC43B80ED1;
        Sat, 11 Dec 2021 08:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64209C341CA;
        Sat, 11 Dec 2021 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639213029;
        bh=z2dCHAn1LQ11rBQOVNmWHpOMlWMHQGwFU34kcBgLbkA=;
        h=From:To:Cc:Subject:Date:From;
        b=mm0oMyPovY2CCH8mvPdODLHgLPv7XFUW6s072E+MjWDP1hUiqnUslt3OfHDLJhNEq
         iW0wLKNZa8jMvpcNHALV/JykDXfTBrqlDvxndd6mlCmscrKU33A4wnlyxdOirWpkAi
         aGvEgD/SrdFWh3LnlOWwT2DlpBsvkslzSmmI/2JNL91Fh1E8Klfs4ZxJ0NNJbRlbUB
         ovVBpJDuNQ9wtqZWCyzg8etHZNYMqI9kFKbfvT8y4P3X4Y5u/5QPJBnd+xBQFwVPCH
         dvnuw2lSowaDezlfQNv1fLJE0ylPsLPvII/QH1WSTjsknbbXhCWUd9tl2AmSS5dr4U
         oH2g9/CHwyPPQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvyBj-000MlI-GN; Sat, 11 Dec 2021 09:57:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/2] Fix some issues with DOCS_CSS and DOCS_THEME
Date:   Sat, 11 Dec 2021 09:56:58 +0100
Message-Id: <cover.1639212812.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Randy pointed a couple of issues with the DOCS_CSS and DOCS_THEME patchset.
The two patches in this series address them.

Patch 1 fix the usage of "make O=<dir>".
Patch 2 fix some documentation issues (a typo and whitespace issues).
           
Randy, thanks for reporting those!

Regards,
Mauro

Mauro Carvalho Chehab (2):
  docs: Makefile: use the right path for DOCS_CSS
  docs: address some text issues with css/theme support

 Documentation/Makefile             | 6 +++---
 Documentation/doc-guide/sphinx.rst | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.33.1


