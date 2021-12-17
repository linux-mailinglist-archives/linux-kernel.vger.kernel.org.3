Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7547870B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhLQJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:27:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43744 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhLQJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:26:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0883262087;
        Fri, 17 Dec 2021 09:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7184DC36AE1;
        Fri, 17 Dec 2021 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639733217;
        bh=zqzHpp8Szzl4sjlKWRVrr59gMWHk2eD5G2vqdLyXgdk=;
        h=Date:From:To:Cc:Subject:From;
        b=Ln7WB1yf50VS9jZCxqNGy29wGR3OCUFdQN6pVh3inuu2U1266HsrvNcArQpYeorAv
         dHs01b9iYjNUKecOotcAjSq+BW7vTCZeKitpZGJhQ1Gk1spAOl5a7hTs1zwVGeaOZX
         k6C5xkqIsoTofkD9BzTUidazncB2uuRLJ7zYf6R0canbiN2t9tr+1TqbY+4+nWEdDX
         2aTmNJWdS/pd594eJ0udFFxl5mdl8vb8nkcvA0emUSguXV+Xd3ag91AaEkPZGMbeXJ
         pcG3qssQOPUtQiv/fMGvtSa06HckyaXQOvq++7eY6Zih6bANQ5AfZs2fLrdUkBlNfj
         Nwf8CSd0Cm/eg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1my9Vt-00019q-DX; Fri, 17 Dec 2021 10:26:53 +0100
Date:   Fri, 17 Dec 2021 10:26:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.16-rc6
Message-ID: <YbxX3akVsGBNa+KH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.16-rc6

for you to fetch changes up to 2b503c8598d1b232e7fc7526bce9326d92331541:

  USB: serial: option: add Telit FN990 compositions (2021-12-14 09:22:06 +0100)

----------------------------------------------------------------
USB-serial fixes for 5.16-rc6

Here's a fix for a reported problem in the cp210x gpio-registration code
and some more modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Daniele Palmas (1):
      USB: serial: option: add Telit FN990 compositions

Johan Hovold (1):
      USB: serial: cp210x: fix CP2105 GPIO registration

 drivers/usb/serial/cp210x.c | 6 ++++--
 drivers/usb/serial/option.c | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)
