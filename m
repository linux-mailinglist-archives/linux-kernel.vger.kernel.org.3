Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3505648FF6D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiAPWIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAPWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:07:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B71BC061574;
        Sun, 16 Jan 2022 14:07:57 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l21-20020a17090b079500b001b49df5c4dfso1549034pjz.2;
        Sun, 16 Jan 2022 14:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=M2veCCmWFE1gjuS1WjHHYX1pPVCrH6un9yG9kmaxmLw=;
        b=AQowX1sr42Qg5V4hFnvSSXhLiRpVnH3vaxSQnU0bB5wVNelKXIprNZxK52/NlnvDDK
         d4bSMzVJDdocK7AVwDLCRcYZEEocaNEvG4jBWKWj2eMGAr/O9lPUWf7zcdPRwepxQPTZ
         lVW2Tiw2xRFQSrLZZgH+FMPBNKkY5VnX4PeK94wEQEwBSg2NjByAQSqCHqGA1qf2LD2Y
         9YvHXKg/Njub+g+ZWa1iCLLC81Fjw2Sz6kyyYqO85dLUVSXk6V32x8qho+ZJt2CL/k0E
         PTQIlgeu6Z4O67Gr/fEQ/t4HCkkxKv0lT7LT4mIf/t53tEzZ/3JZWs+CG1aptf9a0QWI
         AliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=M2veCCmWFE1gjuS1WjHHYX1pPVCrH6un9yG9kmaxmLw=;
        b=as/7QhCwsM8rSwOKNGhYBUZI/9QO28sY8jcNzTBRO4WgeP5WG2Fn9vsOZmX98MVgUN
         n9eoczsX8IdDWe2TEV6YEos/Fdewfj9bjMqM2B66AeKbP52TyVU5V9aNb5/pKMSIjfQy
         SakvXVUxlElfdw5sO+LVWSIImCxSJuU/7lr3D2I1Va+bNBMH1NMqscst09QpZ58Ti2dP
         iHbVbNXBaMzDs7Df0CjdIoDKSVLHLxVDVeq3y/Gof5m/4QLR8GdCz/OKxy4gnfLV55FT
         fBL9AvD2yzcvHdkAfolp3GA7D09R/1s/nq6LfpuGeDmWL9UUaohS8aL5wbiJhHq7Yyzh
         rKnA==
X-Gm-Message-State: AOAM530MUavCeQNL4KUflgpYo4RVkUtiKiwKmQbggGhrFK4xwJ8IMTL7
        USYzfK0XBQgP22mrhUIPrj06wU7eimU=
X-Google-Smtp-Source: ABdhPJwpho4X/3I1qIa9lHTTirRHkdYwPzyZk3fOqiB4tLVa3q3wF19VY924xXO0Chz6mrUef2EXFw==
X-Received: by 2002:a17:90a:de08:: with SMTP id m8mr21885784pjv.102.1642370876551;
        Sun, 16 Jan 2022 14:07:56 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f7d7:da1d:6c29:1bd6])
        by smtp.gmail.com with ESMTPSA id u64sm11275757pfb.208.2022.01.16.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 14:07:55 -0800 (PST)
Date:   Sun, 16 Jan 2022 14:07:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.17-rc0
Message-ID: <YeSXOaSWDSjMykUO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get updates to
Goodix touchscreen driver (addition of pen support) and Silead
touchscreen driver (also addition of pen support and parsing of
embedded firmware to determine screen size), along with assorted
fixes for other drivers.

Note that you will get a merge conflict in axp20x-pek driver, please
resolve it so it looks as follows (axp20x_pek_probe):

	axp20x_pek->axp20x = dev_get_drvdata(pdev->dev.parent);

	if (axp20x_pek_should_register_input(axp20x_pek)) {
		error = axp20x_pek_probe_input_device(axp20x_pek, pdev);
		if (error)
			return error;
	}

Changelog:
---------

Alistair Francis (1):
      Input: wacom_i2c - clean up the query device fields

Charles Keepax (1):
      Input: ff-core - correct magnitude setting for rumble compatibility

Christophe JAILLET (1):
      Input: gpio-keys - avoid clearing twice some memory

Colin Ian King (2):
      Input: palmas-pwrbutton - make a couple of arrays static const
      Input: ucb1400_ts - remove redundant variable penup

Dario Binacchi (3):
      Input: ti_am335x_tsc - set ADCREFM for X configuration
      Input: ti_am335x_tsc - fix STEPCONFIG setup for Z2
      Input: ti_am335x_tsc - lower the X and Y sampling time

Geert Uytterhoeven (1):
      Input: palmas-pwrbutton - use bitfield helpers

Hans de Goede (6):
      Input: goodix - add pen support
      Input: goodix - improve gpiod_get() error logging
      Input: goodix - 2 small fixes for pen support
      Input: silead - add support for EFI-embedded fw using different min/max coordinates
      Input: silead - add pen support
      Input: axp20x-pek - revert "always register interrupt handlers" change

Linus Walleij (2):
      dt-bindings: input/ts/zinitix: Convert to YAML, fix and extend
      Input: zinitix - handle proper supply names

Nikita Travkin (1):
      Input: zinitix - add compatible for bt532

Qinghua Jin (1):
      Input: ti_am335x_tsc - fix a typo in a comment

Xiang wangx (1):
      Input: byd - fix typo in a comment

Diffstat:
--------

 .../bindings/input/touchscreen/zinitix,bt400.yaml  | 115 ++++++++++++++
 .../bindings/input/touchscreen/zinitix.txt         |  40 -----
 drivers/input/ff-core.c                            |   2 +-
 drivers/input/keyboard/gpio_keys.c                 |   2 +-
 drivers/input/misc/axp20x-pek.c                    |  72 +++++----
 drivers/input/misc/palmas-pwrbutton.c              |   9 +-
 drivers/input/mouse/byd.c                          |   2 +-
 drivers/input/touchscreen/goodix.c                 | 127 ++++++++++++++-
 drivers/input/touchscreen/goodix.h                 |   1 +
 drivers/input/touchscreen/silead.c                 | 172 ++++++++++++++++++++-
 drivers/input/touchscreen/ti_am335x_tsc.c          |  20 ++-
 drivers/input/touchscreen/ucb1400_ts.c             |   4 +-
 drivers/input/touchscreen/wacom_i2c.c              |  44 +++---
 drivers/input/touchscreen/zinitix.c                |  22 ++-
 14 files changed, 507 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zinitix.txt

Thanks.


-- 
Dmitry
