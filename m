Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9109B4D3656
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiCIQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiCIQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:27:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924412BB1A;
        Wed,  9 Mar 2022 08:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F121B82224;
        Wed,  9 Mar 2022 16:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87DBC340F5;
        Wed,  9 Mar 2022 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646842948;
        bh=Yu0TsGuK32wvpI2+J3C3f/SaYvUuvXGxBS3dMIFnfLU=;
        h=From:To:Cc:Subject:Date:From;
        b=h2MtXokjWYFs0We/K82MchVDJRT1q2LJL8bcsbZCMfN5nEsD6B+w9AxkaN1rlEnqu
         WSb9e+zw67BL7Gx33sqqqjc8SfbrYHCzjzJDJZzLrq3c70IQaRzteA5VdXj8y+TS0N
         d/LxuzQRymJujghUd2UKHCaeE3MCFl3FhDwEWhzl9X/5sQsYSdTeOSzeaz6mltrBXy
         rljTXKzcUASWuiuzfVi2RChiUxTRg/0V2o1/Akok3DZN+ZPyNtS+IlUCPuIFeIM+m/
         S7uryCUvdbPHrSA2jjRWhdH/e2q5yJ8VSgvAvhLcnC9SXCW2JLqG3vtWxwWwk2KgrH
         w+HAoifCtfwaA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nRz50-00E6Ab-6y; Wed, 09 Mar 2022 17:22:26 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH 0/5] media: sort Makefile entries
Date:   Wed,  9 Mar 2022 17:22:20 +0100
Message-Id: <cover.1646842741.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Entries at Makefiles end being merged on random order. 

Sort them on alphabetical order. I'm preparing similar changes for Kconfig
entries too.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Mauro Carvalho Chehab (5):
  media: xc2028: rename the driver from tuner-xc2028
  media: platform: Makefile: group some Makefile options
  media: Makefiles: remove extra spaces
  media: dvb-frontend: remove TUNER_ from some DVB frontend Kconfig
    options
  media: Makefiles: sort entries where it fits

 .../admin-guide/media/i2c-cardlist.rst        |   2 +-
 MAINTAINERS                                   |   2 +-
 drivers/media/Makefile                        |   4 +-
 drivers/media/cec/platform/Makefile           |  16 +-
 drivers/media/common/Makefile                 |   4 +-
 drivers/media/common/b2c2/Kconfig             |   4 +-
 drivers/media/common/videobuf2/Makefile       |   6 +-
 drivers/media/dvb-frontends/Kconfig           |   8 +-
 drivers/media/dvb-frontends/Makefile          | 192 +++++++++---------
 drivers/media/dvb-frontends/cx24113.h         |   2 +-
 drivers/media/dvb-frontends/dib0070.h         |   2 +-
 drivers/media/dvb-frontends/dib0090.h         |   2 +-
 drivers/media/dvb-frontends/itd1000.h         |   2 +-
 drivers/media/firewire/Makefile               |   2 +-
 drivers/media/i2c/Makefile                    |  92 ++++-----
 drivers/media/pci/Makefile                    |  18 +-
 drivers/media/pci/cx18/cx18-driver.c          |   2 +-
 drivers/media/pci/cx18/cx18-dvb.c             |   2 +-
 drivers/media/pci/cx18/cx18-gpio.c            |   2 +-
 drivers/media/pci/cx23885/Kconfig             |   2 +-
 drivers/media/pci/cx23885/cx23885-cards.c     |   2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c       |   2 +-
 drivers/media/pci/cx23885/cx23885-video.c     |   2 +-
 drivers/media/pci/cx88/cx88.h                 |   2 +-
 drivers/media/pci/ivtv/ivtv-driver.c          |   2 +-
 drivers/media/pci/ivtv/ivtv-gpio.c            |   2 +-
 drivers/media/pci/saa7134/saa7134-cards.c     |   2 +-
 drivers/media/pci/saa7134/saa7134-dvb.c       |   2 +-
 drivers/media/platform/Makefile               | 147 ++++++--------
 drivers/media/radio/Makefile                  |  42 ++--
 drivers/media/rc/Makefile                     |  45 ++--
 drivers/media/rc/keymaps/Makefile             |  33 +--
 drivers/media/spi/Makefile                    |   5 +-
 drivers/media/test-drivers/Makefile           |  13 +-
 drivers/media/tuners/Makefile                 |  66 +++---
 drivers/media/tuners/tuner-types.c            |   2 +-
 .../{tuner-xc2028-types.h => xc2028-types.h}  |   6 +-
 .../media/tuners/{tuner-xc2028.c => xc2028.c} |   6 +-
 .../media/tuners/{tuner-xc2028.h => xc2028.h} |   2 +-
 drivers/media/tuners/xc4000.c                 |   2 +-
 drivers/media/usb/Makefile                    |  25 +--
 drivers/media/usb/dvb-usb/Kconfig             |   6 +-
 drivers/media/usb/dvb-usb/cxusb.c             |   2 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c   |   2 +-
 drivers/media/usb/em28xx/em28xx-i2c.c         |   2 +-
 drivers/media/usb/em28xx/em28xx.h             |   2 +-
 drivers/media/usb/gspca/Makefile              |  88 ++++----
 drivers/media/usb/tm6000/tm6000-cards.c       |   2 +-
 drivers/media/usb/tm6000/tm6000-dvb.c         |   2 +-
 drivers/media/usb/tm6000/tm6000-i2c.c         |   2 +-
 drivers/media/v4l2-core/Makefile              |  29 ++-
 drivers/media/v4l2-core/tuner-core.c          |   2 +-
 52 files changed, 450 insertions(+), 465 deletions(-)
 rename drivers/media/tuners/{tuner-xc2028-types.h => xc2028-types.h} (96%)
 rename drivers/media/tuners/{tuner-xc2028.c => xc2028.c} (99%)
 rename drivers/media/tuners/{tuner-xc2028.h => xc2028.h} (99%)

-- 
2.35.1


