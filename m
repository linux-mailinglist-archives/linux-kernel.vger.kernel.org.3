Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF49517CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiECGDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiECGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:03:34 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CAF2B18C;
        Mon,  2 May 2022 23:00:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q8so16849420oif.13;
        Mon, 02 May 2022 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN2uxqbXiWABcWmtrX9ldqSaetjnPOTD9o54K6GkkWM=;
        b=Cc+lqV4jmh7tTRtusdgLPsU09Ao7mmzkBMVuiYbgQ3MOxpk19XYkXgFkxMcdFz951f
         kaRREPZwPzDrh+/I7zG5sHlfWojOqPY9VXlTp323cttBztTmI3lfzNka9Axqw2q60M3f
         gDftXePfhx7VZuDSznP6zBsVB8KTh9qAqDAV3QIL11DUYL/ZxxOBpY62z5c6+4PlYn5x
         W38oqL6DYNNffDgHor3oDsZaX9WUkNiSwreJrlZcB3Uzy/TXT07faUs95Pu3zMxRnUev
         Boj97htxHJKTaCzLlViuWgR3C7F6tfXEDmx7k+pBM9xxEigwm1LUzUTu/WsZu/jtVgKp
         5lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LN2uxqbXiWABcWmtrX9ldqSaetjnPOTD9o54K6GkkWM=;
        b=FcKYOi8KGM6ZBl9IqOK8ORbyDwktmUo72K4C4DAmnGWO+Yh6jsn9Hem7bY1TEKnjdS
         f9wwucQ/ovaIeAfBlf8bkbZKR/FLUfEN1+DxIflfi/qU2SYz8KM/Y0CDq38ZEGHKbBTA
         0ptzq9Lg8fBoX3E3Tm+CTv/MiK4vbG49NdgPCfE5DZdWWgTefI+W2JqIrqQa9jFGiTnc
         3hSTg/mJbRjZyfApyJX5t/kthm4BQhNtXXDbD2WMKpxRUlJWcVUvaPp7OVS92VxqRZgC
         SATGwF+W7bsbu+F8H45pqrNlu1n1etMV4XpLou0UXJlVro3vVid7L1HY336mIX3b520y
         CpMQ==
X-Gm-Message-State: AOAM530YsGckNZCz+bE2M7a7j4zPney+S3aJ+NzGcbR42aYRW4EAUw5E
        QjfxRw/FOMN1YLNyGS+H2pSQsSwRm5TUkg==
X-Google-Smtp-Source: ABdhPJyQWHpU9pVsTeRvFcyXROK12gKspnEqkpcXRart9RnRKX4DnErP4M0zYhehYUFL2dAnfcmTRw==
X-Received: by 2002:aca:5d85:0:b0:325:bf2b:253c with SMTP id r127-20020aca5d85000000b00325bf2b253cmr1190107oib.85.1651557602655;
        Mon, 02 May 2022 23:00:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a056830208200b0060603221260sm3698698otq.48.2022.05.02.23.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:00:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.18-rc6
Date:   Mon,  2 May 2022 23:00:00 -0700
Message-Id: <20220503060000.2839547-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.18-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18-rc6

Thanks,
Guenter
------

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.18-rc6

for you to fetch changes up to 08da09f028043fed9653331ae75bc310411f72e6:

  hwmon: (pmbus) delta-ahe50dc-fan: work around hardware quirk (2022-04-27 04:52:18 -0700)

----------------------------------------------------------------
hwmon fixes for v5.18-rc6

- Work around a hardware problem in the delta-ahe50dc-fan driver

- Explicitly disable PEC in PMBus core if not enabled

- Fix negative temperature values in f71882fg driver

- Fix warning on removal of adt7470 driver

- Fix CROSSHAIR VI HERO name in asus_wmi_sensors driver

- Fix build warning seen in xdpe12284 driver if
  CONFIG_SENSORS_XDPE122_REGULATOR is disabled

- Fix type of 'ti,n-factor' in ti,tmp421 driver bindings

----------------------------------------------------------------
Adam Wujek (1):
      hwmon: (pmbus) disable PEC if not enabled

Armin Wolf (1):
      hwmon: (adt7470) Fix warning on module removal

Denis Pauk (1):
      hwmon: (asus_wmi_sensors) Fix CROSSHAIR VI HERO name

Guenter Roeck (1):
      hwmon: (xdpe12284) Fix build warning seen if CONFIG_SENSORS_XDPE122_REGULATOR is disabled

Ji-Ze Hong (Peter Hong) (1):
      hwmon: (f71882fg) Fix negative temperature

Rob Herring (1):
      dt-bindings: hwmon: ti,tmp421: Fix type for 'ti,n-factor'

Zev Weiss (1):
      hwmon: (pmbus) delta-ahe50dc-fan: work around hardware quirk

 Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml |  7 +++----
 drivers/hwmon/adt7470.c                                |  4 ++--
 drivers/hwmon/asus_wmi_sensors.c                       |  2 +-
 drivers/hwmon/f71882fg.c                               |  5 +++--
 drivers/hwmon/pmbus/delta-ahe50dc-fan.c                | 16 ++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c                       |  3 +++
 drivers/hwmon/pmbus/xdpe12284.c                        |  2 +-
 7 files changed, 29 insertions(+), 10 deletions(-)
