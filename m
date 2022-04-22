Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8350BB73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449327AbiDVPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449322AbiDVPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:17:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A145D674;
        Fri, 22 Apr 2022 08:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8AC3ACE2C1D;
        Fri, 22 Apr 2022 15:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57CAC385A0;
        Fri, 22 Apr 2022 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650640469;
        bh=lBzqskWQ8Rw1H2jBSdnakWav4FYm3BY5XQ2EH7FrPVo=;
        h=Date:From:To:Cc:Subject:From;
        b=Qery+LaJ7zkwWr9n6NAqPpu4VZP11V0NHDPOoemrooyM9OlJiDapoZmgDd3M9cYp8
         FUk6rodf3lwhwAKSbJhpxtnG9NO5+q4BInZqvuNdfkf3L88P1TUHECdDve8spWBUha
         3q7UiCOCZa7brHe35AgRDfbxxwp/29ImcIE4pHEmtf7AR/bisIbxXxgCToNoeb0kvU
         m12lQSrviU9NGKDHavkg1Oc8Z3lFoTDi++nJkfGk8HvQ1rqJOHXR45yLq/ZLY3x70D
         OaHKKBVJcmOEAwuLDHwxTd+hCIqKs3BLDJEK5RgmFvp+vmY27F+bwjonVuEIlgDy/D
         cw5GlpcYc/VlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nhuzI-0001Gq-FK; Fri, 22 Apr 2022 17:14:24 +0200
Date:   Fri, 22 Apr 2022 17:14:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.18-rc4
Message-ID: <YmLGUMFqVl6NrO3M@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.18-rc4

for you to fetch changes up to e23e50e7acc8d8f16498e9c129db33e6a00e80eb:

  USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS (2022-04-21 10:08:06 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.18-rc4

Here's a fix for a potential overflow issue in the whiteheat driver when
using the old ARM ABI.

Included are also some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Bruno Thomsen (1):
      USB: serial: cp210x: add PIDs for Kamstrup USB Meter Reader

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1057, 0x1058, 0x1075 compositions

Kees Cook (1):
      USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/MV32-WB

 drivers/usb/serial/cp210x.c    |  2 ++
 drivers/usb/serial/option.c    | 12 ++++++++++++
 drivers/usb/serial/whiteheat.c |  5 ++---
 3 files changed, 16 insertions(+), 3 deletions(-)
