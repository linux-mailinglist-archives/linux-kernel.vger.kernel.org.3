Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B543849FF97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiA1Rcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiA1Rco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:32:44 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB2C061714;
        Fri, 28 Jan 2022 09:32:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 71E90383;
        Fri, 28 Jan 2022 17:32:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71E90383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643391164; bh=jx+ObSUowWNN5HDiOCL/F/rjuw/ZGOtTP1IJcLZwKHU=;
        h=From:To:Cc:Subject:Date:From;
        b=d47kEcA8taIPAkyeaKVk07a+9R6tdyXuN6A0a9K6XACO4kFQe677Tyg5MsxVGQzeN
         YTlKbPxFG2aa40ujc0bB97ByIXW4mL2yjeEF/nUTlCdG47YQWnZow6T0LxF0RCORWE
         bRf/tNskQCx1jgSNnGuBcOD+qaw9+kAfa/YxHHDbgt05yTwzTqLVx5Cqmmf/QSfUfw
         7xqjgpiTCvqIHSQWa7AI3p5bwjB2CS0rJM1xmWhzBwr2/WZAJlUNUYta4whceD5MnX
         8b4u9BZG1VHVqsAcl0j2lf0/U7aCnlSH2tznsS4xDr6Poo72b8QsHsl+ZdQMUhandF
         lcxVFozAl/Gvg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.17
Date:   Fri, 28 Jan 2022 10:33:17 -0700
Message-ID: <87bkzvojdu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.17-3

for you to fetch changes up to 854d0982eef0e424e8108d09d9275aaf445b1597:

  docs/vm: Fix typo in *harden* (2022-01-27 11:22:34 -0700)

----------------------------------------------------------------
A few documentation fixes for 5.17

----------------------------------------------------------------
Jonathan Corbet (1):
      docs: Hook the RTLA documents into the kernel docs build

Pali Roh=C3=A1r (1):
      Documentation: arm: marvell: Extend Avanta list

Paul Menzel (1):
      docs/vm: Fix typo in *harden*

Takahiro Itazuri (1):
      docs: fix typo in Documentation/kernel-hacking/locking.rst

 Documentation/arm/marvell.rst            |  2 ++
 Documentation/index.rst                  |  1 +
 Documentation/kernel-hacking/locking.rst |  2 +-
 Documentation/tools/index.rst            | 20 ++++++++++++++++++++
 Documentation/tools/rtla/index.rst       | 26 ++++++++++++++++++++++++++
 Documentation/vm/page_table_check.rst    |  2 +-
 6 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/tools/index.rst
 create mode 100644 Documentation/tools/rtla/index.rst
