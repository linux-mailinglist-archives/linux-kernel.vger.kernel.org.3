Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17452EBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349054AbiETMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiETMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:12:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707214640B;
        Fri, 20 May 2022 05:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F1A8B82B3F;
        Fri, 20 May 2022 12:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6ADC385A9;
        Fri, 20 May 2022 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653048738;
        bh=JP/UIl4KDxvbN8nMb/Ta3j84yv1AshL7YzWZ8cVWRJg=;
        h=Date:From:To:Cc:Subject:From;
        b=qTfnD6uxQAihQw+ANRC/4C0eftfr7QqZ8/EArV9KB59sYiLvJ06MBnrzQOYfpEeoV
         yY9JV5GTJw7AWvszciiVeIqB67wM6feJakrE4uEN5SuORswCG/j5MGd6XD3+vAxHTb
         AojdJ4oilNJKnuNCAPslnI7kVardar4y87EkXrnHAFVuLd8bQ682+YZ7GWlhMQ/qD7
         y1y9oOLKypP1s26pX0LIGQLuShF/0z/dMWvvgf0azuXCx06A2PPNRKdokzsJxqi1MY
         sPejm6GqaQo4EFwaBh6ABEVyREj+9vNKcMS8Xu7ZhwSeH6eLydjS/ZGy9bDctdzGI2
         /ZXPfzR4THuOg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ns1UQ-00065o-BQ; Fri, 20 May 2022 14:12:18 +0200
Date:   Fri, 20 May 2022 14:12:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 5.19-rc1
Message-ID: <YoeFosQDeA5fQqCw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc1

for you to fetch changes up to 33b7af2f459df453feb0d44628d820c47fefe7a8:

  USB: serial: option: add Quectel BG95 modem (2022-05-19 08:03:32 +0200)

----------------------------------------------------------------
USB-serial updates for 5.19-rc1

Here are the USB-serial updates for 5.19-rc1, including:

 - a workaround for pl2303 devices with unexpected bcdUSB
 - a new modem device id

Included is also a printk clean up.

All but the modem-id commit have been in linux-next with no reported
issues.

----------------------------------------------------------------
Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 modem

Daniels Umanovskis (1):
      USB: serial: ftdi_sio: clean up printk format specifier

Johan Hovold (1):
      USB: serial: pl2303: fix type detection for odd device

 drivers/usb/serial/ftdi_sio.c | 2 +-
 drivers/usb/serial/option.c   | 2 ++
 drivers/usb/serial/pl2303.c   | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)
