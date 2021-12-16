Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC08477C83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbhLPT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:27:13 -0500
Received: from foss.arm.com ([217.140.110.172]:47724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231376AbhLPT1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:27:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4B512FC;
        Thu, 16 Dec 2021 11:27:11 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.6.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B64C33F774;
        Thu, 16 Dec 2021 11:27:10 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mchehab+huawei@kernel.org, nfraprado@protonmail.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] docs: automarkup.py: Fix invalid HTML link output and broken URI fragments
Date:   Thu, 16 Dec 2021 19:27:03 +0000
Message-Id: <20211216192704.413216-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking modify some of the docs and add some links to subsections, but I noticed that this
was broken. I double checked on the kernel.org docs in case it was an issue with my sphinx version.
The commit message goes into more details.

I made a fix, but it does have one small side-effect. The original commit had the
side effect to prettify some of the page links. In the example I gave in the commit message
"L1TF - L1 Terminal Fault" now becomes "Documentation/admin-guide/hw-vuln//l1tf.rst". But this is
true to the rst source:

  :ref:`Documentation/admin-guide/hw-vuln//l1tf.rst <default_mitigations>`.

Technically the bit between the `` and not the <> should be what is displayed. So I think this is
fine. And the original breaking commit only attempted to touchup plain text page links. I don't
think the intention was to modify existing references.

Thanks
James

James Clark (1):
  docs: automarkup.py: Fix invalid HTML link output and broken URI
    fragments

 Documentation/sphinx/automarkup.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.28.0

