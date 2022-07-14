Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB257504C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiGNOFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiGNOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:05:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A5382;
        Thu, 14 Jul 2022 07:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0402EB8259F;
        Thu, 14 Jul 2022 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FCFC34114;
        Thu, 14 Jul 2022 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657807535;
        bh=D5GgF02NPdE9LjaZDIxMtrmQj0pAf83Dl48OJxwjnTU=;
        h=Date:From:To:Cc:Subject:From;
        b=mWU3J659D19e9YIWg5I+0qFf1bBw1wGqqd5y/M9yVoW5a4OGi4ZJ9Ojz24qMTq+Ok
         V7/5H+zN0hGakxWi4FY9FekRrtApFVryRLB7novLvm/SvxjwNDQY3XhaT+X8Z2yPWK
         tlbIUFanj6nrRUEkdR+1hm6WEoTs17i3Jyi+8DPAdycb690evsjOYbxve7lUFOaXuz
         TBFvdoJGgjuH4MKhxliNEugBEeNI7CjSSSeQJTelegaKl86JVx91QADcYlsvTVrrYL
         DXMUhh19PhlCNs0d9NN1lDqtdOkSTexFLHR507pbMuA/gGnhU7gqj2o/gGQN2sSuAx
         bsTO0200PsvjQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBzTI-0007zu-Ul; Thu, 14 Jul 2022 16:05:41 +0200
Date:   Thu, 14 Jul 2022 16:05:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.19-rc7
Message-ID: <YtAitIrTRRVkaUKJ@hovoldconsulting.com>
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

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc7

for you to fetch changes up to 7c239a071d1f04b7137789810807b4108d475c72:

  USB: serial: ftdi_sio: add Belimo device ids (2022-07-13 08:20:32 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.19-rc7

Here are a couple of new device ids for ftdi_sio.

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Lucien Buchmann (1):
      USB: serial: ftdi_sio: add Belimo device ids

 drivers/usb/serial/ftdi_sio.c     | 3 +++
 drivers/usb/serial/ftdi_sio_ids.h | 6 ++++++
 2 files changed, 9 insertions(+)
