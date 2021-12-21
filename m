Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9647C1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhLUOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhLUOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:40:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:40:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BCE3615AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 14:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B706C36AE9;
        Tue, 21 Dec 2021 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640097631;
        bh=vm7Pv6x9UUxMHds7eeedeRmE+hgHPkywlCag7xSmG78=;
        h=Date:From:To:cc:Subject:From;
        b=A3/432lOJXs/7A+0AMk6AGO4ILACUnyd93ZQCB7a+EaKaO2n4trdzY32B/Lew4PTB
         Xc/Egq4Lf/ID3VNbLMT/WhFmQy3YD7gZMMoeYzYTRqPiyJHQqPjX6yX1ilrws1qc1G
         FgfJmy0dLtiqF25vO151EKMwZBCIXHjpF4rRMYEPRSd+GwCnYMqLV3fqBWB550Csih
         B0Ucx1Ea0f9YiL9JZOZ71fLzUh7UKmjaJTspHIhaVYev36bumRhsh9cqaZ1l8r1Hxz
         W1A87TTeoYMpQhaTpeg86fwJ0LdzpIva7y9s4dMvUIzUPnlfjvLRf2gUQplE5CkJYC
         mttmOd+gH8C5g==
Date:   Tue, 21 Dec 2021 15:40:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2112211532410.16505@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fixes for HID subsystem

=====
- NULL pointer dereference fix in Vivaldi driver (Jiasheng Jiang)
- regression fix for device probing in Holtek driver (Benjamin Tissoires)
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Jiasheng Jiang (1):
      HID: potential dereference of null pointer

 drivers/hid/hid-holtek-mouse.c | 15 +++++++++++++++
 drivers/hid/hid-vivaldi.c      |  3 +++
 2 files changed, 18 insertions(+)

-- 
Jiri Kosina
SUSE Labs

