Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF0557A09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiFWMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiFWMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6E4DF67;
        Thu, 23 Jun 2022 05:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1ED961B54;
        Thu, 23 Jun 2022 12:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CF5C3411B;
        Thu, 23 Jun 2022 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655986233;
        bh=OzQU67FUybi/pveFZOeAoQ+AcUFJcMiZ4XMtbk91knQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PzQkdssZWNGcFWHFq/42zegEeJCP+11zTDP2ix072nIJuDkLl3KWS4SbO0bGa1boH
         s1v4pE7vxaPWWtQ45QYr+ruv/+SLRvUHhHDe1+DlzvCz0a0JeDOOb9tWKbYVm1sLgi
         yVeO3Q1nzC1J2vqHlW+yGWS8mmiy6yYioom5Kr9tMm+De+XXdt5LRn1+jK94sLR4Mu
         Xdw90Nmh98toXlluZSPqkKTP0zffh1cN7BpDVwFQuODXOuUq9H++CvGtbc2u+b+x2s
         5wt+r8tY7NCbnB0zkDZTs+4PgK2ohteQkjmiJLD/CWSKtBjYaYwGdsasDGuiuv9Gad
         GmZucTY10661w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4LfK-0002bj-Hg; Thu, 23 Jun 2022 14:10:30 +0200
Date:   Thu, 23 Jun 2022 14:10:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.19-rc4
Message-ID: <YrRYNhpf9GiyxmAQ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc4

for you to fetch changes up to 15b694e96c31807d8515aacfa687a1e8a4fbbadc:

  USB: serial: option: add Quectel RM500K module support (2022-06-23 13:58:05 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.19-rc4

Here are some new modem device ids and support for further PL2303
device types.

All but the final commit (RM500K device id) have been in linux-next and
with no reported issues.

----------------------------------------------------------------
Carlo Lobrano (1):
      USB: serial: option: add Telit LE910Cx 0x1250 composition

Johan Hovold (1):
      USB: serial: pl2303: add support for more HXN (G) types

Macpaul Lin (1):
      USB: serial: option: add Quectel RM500K module support

Yonglin Tan (1):
      USB: serial: option: add Quectel EM05-G modem

 drivers/usb/serial/option.c |  6 ++++++
 drivers/usb/serial/pl2303.c | 29 +++++++++++++++++------------
 2 files changed, 23 insertions(+), 12 deletions(-)
