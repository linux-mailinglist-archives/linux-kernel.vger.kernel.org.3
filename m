Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347655AA396
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiIAXQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiIAXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:16:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759395AE2;
        Thu,  1 Sep 2022 16:16:45 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 6844F2B8;
        Thu,  1 Sep 2022 23:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6844F2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1662074205; bh=7kM3JEnkZ1mJiPAKm3Hv87DI1fmk3K0d1UFBmUeGq3w=;
        h=From:To:Cc:Subject:Date:From;
        b=HjnRm92wSWr7UfpYKnqSnDlfFn1quxb+gfwlusz78TyUwh0g/lI7YyYvjLa9R1ex/
         eoDrLEzaSfo0AKRfdsXtPPBbJHa4elEriU2T3c1z729gu8MGhw0OdbYLu/Zem9VSm5
         LG2ZIMYL79XZ+GD7DTQ0Y3/MpLwAQ8m5xy7MXn/NUR2S70mRdzL6NST/doe4Q0GaHe
         eygTMwcj84EfrDNW7mBL6O0zPUroJ2U/DuUpk2bEihy7XjajJVDdCK02ttJQHEGzi+
         +cvityS0eo6pCf5Y7DOm61oKghuav6vow768/VGYpL/9hnohwbIbjnWKGv/c18qJOz
         wpU4cIgK0+teg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/4] Rewrite the top-level index.rst
Date:   Thu,  1 Sep 2022 17:16:28 -0600
Message-Id: <20220901231632.518583-1-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level index.rst file is the entry point for the kernel's
documentation, especially for readers of the HTML output.  It is currently
a mess containing everything we thought to throw in there.  Firefox says it
would require 26 pages of paper to print it.  That is not a user-friendly
introduction.

This series aims to improve our documentation entry point with a focus on
rewriting index.rst.  The result is, IMO, simpler and more approachable.
For anybody who wants to see the rendered results without building the
docs, have a look at:

  https://static.lwn.net/kerneldoc/

Those pages are rendered with the "Alabaster" theme, which pays attention
to the html_sidebar directive.  I am not proposing a switch to that theme
(I just picked it at random), but I do think we should reconsider the
default theme at some point.

This is only a beginning; I think this kind of organizational effort has to
be pushed down into the lower layers of the docs tree itself.  But one has
to start somewhere.


Jonathan Corbet (4):
  docs: promote the title of process/index.html
  docs: Rewrite the front page
  docs: reconfigure the HTML left column
  docs: remove some index.rst cruft

 Documentation/conf.py            |   3 +-
 Documentation/index.rst          | 157 +++++++++++--------------------
 Documentation/process/index.rst  |   1 +
 Documentation/subsystem-apis.rst |  56 +++++++++++
 4 files changed, 116 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/subsystem-apis.rst

-- 
2.37.2

