Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AE64B2906
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiBKPXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:23:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243352AbiBKPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:23:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A7D82;
        Fri, 11 Feb 2022 07:23:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AB04B82A75;
        Fri, 11 Feb 2022 15:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065D7C340E9;
        Fri, 11 Feb 2022 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644593016;
        bh=/gZ0MVlM+SQJUb3i2cHlq1JpX/TQW6sihFSKnBairUg=;
        h=Date:From:To:Cc:Subject:From;
        b=VfXaBWysYErFd7M2O5Jth+eoyG4iVNqV/lvwyhUuwkBUXiQIbiLvj8V7ySEIFAYoq
         rs26yrs0d6uY8X/dMH7EUCBC54Si6Dbo377Kuc7cGyiEuFCKP0ieM8ijRdMziSwCEf
         RPtdoE/GIOPAm2rZW94O2Zs679SG/c5j3N5G+rd8BuOcvKPIjTRM28bAiLWfJ5M1Pm
         oBnMgXThXzPWTuzxSrWV00wMpIVe7CYaft30Q3zUc7KhzZ3RzvJr0Tt38reCq9vyJY
         ARcEFXAqZ9Bkg456vVsQ9TS9NtgP71Dva8YlbK26Wf3lf7qyBAXMKelCLsFOhZOame
         MOebutMZDkwcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nIXlk-00042x-Jy; Fri, 11 Feb 2022 16:23:32 +0100
Date:   Fri, 11 Feb 2022 16:23:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.17-rc4
Message-ID: <YgZ/dFV1smMu64Bi@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.17-rc4

for you to fetch changes up to 6ca0c6283340d819bf9c7d8e76be33c9fbd903ab:

  USB: serial: cp210x: add CPI Bulk Coin Recycler id (2022-02-01 11:56:23 +0100)

----------------------------------------------------------------
USB-serial fixes for 5.17-rc4

Here are some new device ids for 5.17-rc4.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Cameron Williams (1):
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320

Johan Hovold (2):
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: cp210x: add CPI Bulk Coin Recycler id

Pawel Dembicki (1):
      USB: serial: option: add ZTE MF286D modem

Stephan Brunner (1):
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices

 drivers/usb/serial/ch341.c        | 1 +
 drivers/usb/serial/cp210x.c       | 2 ++
 drivers/usb/serial/ftdi_sio.c     | 3 +++
 drivers/usb/serial/ftdi_sio_ids.h | 3 +++
 drivers/usb/serial/option.c       | 2 ++
 5 files changed, 11 insertions(+)
