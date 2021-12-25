Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9447F25D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 07:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhLYGGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 01:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLYGGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 01:06:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073CC061401;
        Fri, 24 Dec 2021 22:06:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so7994267pjf.3;
        Fri, 24 Dec 2021 22:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=boJBDa+ryBUWVv2wc0uChEfBqNox/h/Gzo+WLVdEkSY=;
        b=Nzb2DcQh+I/bGLfECmMILOs5c4vcXGyenJzu1fCfga3c8IxEdJmwZsM32kxkJfAKnL
         ntY22O08H7BPCqc48+If58ash4Sh2eZP4oAwpbLb359zeyzhycckd55/IG06CGDXBl9y
         9O9tsiz8jUzp0T/v5nZoZlxtQgg8zrxPkWdeFo92a0SGiFqsMzfP5HxCsxyDg0Df8iY8
         P3H/sFMSQCWv/rGIdgQ6MbyRFtNnQ1WMIOXahiqxWic2Z85f2vS45+H8VeOoEBgZ9RCL
         /Nl/Qw2Ry9sfs8I/4nFwsXuj2WsvjE+9Gf1kBpKdKbHCiFOCc6B0QMR0MjPxRWRS/aav
         fmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=boJBDa+ryBUWVv2wc0uChEfBqNox/h/Gzo+WLVdEkSY=;
        b=aDq/UbjcZnIBLeU5pfZLMY5Es9ODO0UnunFTvbWpJw9EYHzmVIwJc1VqU9l0akIrdq
         1UZDChbC082Ugbnz0wFxlj/BCmYMJ8ZV2DqKlUX4QyRH6ou0N6aLfmu6EbLAetPAey1U
         ALfH58F7zNBJuNYJkpp3Y3ElEliuHcNdnnM352YO0kcBZSMpiURtKnDHGbxAKtj7fxoe
         nUBx+PpQyvTAZjtfP/ejZNUT/gMd6iJCteR7C5/+U/WoKptxqVW7BP7T6zmOw5d8aA6R
         E5uZwtKRfn68If3WT3OzRQo5CJXg5SdzurLUCPTu+RJ6e3UGKTHE3QfTPX/rsj7xkEmL
         rAUQ==
X-Gm-Message-State: AOAM532OZzQ9zgZNZUsJlb5joSIYpYDdbokJ58I0/tiJKS6vWevm9LvU
        QBXkD9Hqtdzlzpk1BE/mb6w=
X-Google-Smtp-Source: ABdhPJxavXtmz4Z4ZLAfn6GZenGcp9R/2fnyA9FknLSMFZ6F5d44ol0R9jA2DyrLck/d+tZJ94FjdA==
X-Received: by 2002:a17:902:e752:b0:149:49fc:2750 with SMTP id p18-20020a170902e75200b0014949fc2750mr9341730plf.142.1640412405341;
        Fri, 24 Dec 2021 22:06:45 -0800 (PST)
Received: from google.com ([2620:15c:202:201:b9a:98f5:1800:6779])
        by smtp.gmail.com with ESMTPSA id q39sm729358pja.28.2021.12.24.22.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 22:06:44 -0800 (PST)
Date:   Fri, 24 Dec 2021 22:06:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.16-rc6
Message-ID: <Yca08RwxZRZcYB2i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. A few small updates to
drivers. Of note we are now deferring probes of i8042 on some Asus
devices as the controller is not ready to respond to queries first time
around when the driver is compiled into the kernel.

Changelog:
---------

Andrea Righi (1):
      Input: elantech - fix stack out of bound access in elantech_change_report_id()

Hans de Goede (2):
      Input: goodix - try not to touch the reset-pin on x86/ACPI devices
      Input: goodix - add id->model mapping for the "9111" model

Jeff LaBundy (1):
      Input: iqs626a - prohibit inlining of channel parsing functions

Johnny Chuang (1):
      Input: elants_i2c - do not check Remark ID on eKTH3900/eKTH5312

José Expósito (2):
      Input: goodix - fix memory leak in goodix_firmware_upload
      Input: atmel_mxt_ts - fix double free in mxt_read_info_block

Samuel Čavoj (1):
      Input: i8042 - enable deferred probe quirk for ASUS UM325UA

Takashi Iwai (1):
      Input: i8042 - add deferred probe support

Diffstat:
--------

 Documentation/admin-guide/kernel-parameters.txt |  2 +
 drivers/input/misc/iqs626a.c                    | 21 +++++-----
 drivers/input/mouse/elantech.c                  |  8 +++-
 drivers/input/serio/i8042-x86ia64io.h           | 21 ++++++++++
 drivers/input/serio/i8042.c                     | 54 ++++++++++++++++---------
 drivers/input/touchscreen/atmel_mxt_ts.c        |  2 +-
 drivers/input/touchscreen/elants_i2c.c          | 46 ++++++++++++++++++++-
 drivers/input/touchscreen/goodix.c              | 31 +++++++++++---
 drivers/input/touchscreen/goodix.h              |  1 +
 drivers/input/touchscreen/goodix_fwupload.c     |  2 +-
 10 files changed, 151 insertions(+), 37 deletions(-)

Thanks.

-- 
Dmitry
