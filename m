Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04056D142
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGJU1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:27:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60B12D17;
        Sun, 10 Jul 2022 13:27:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l68so2006339wml.3;
        Sun, 10 Jul 2022 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17LCrEvoVMel3l6IL+XOQZ2NcSPgDUqLer/HDVDPf0s=;
        b=pxysHM6RNJqP2Q3daN8xUazVgVvN3CK9Et8FSHj5UqC8QOFXYzi4GM/oJjWoPHisQT
         rDJg38tA9jP59309aEC7MD6nllyxeNxQzwUj5GScGirauMnPv7uG2dTuAhgKKkVWhvPz
         6nkZ3kC6Fo308TObr+F5hJBa1UF/UJubnz4Va1xG63YNq2esqBNdaLZOsdo2ZH37DPRU
         /IXBmph+o1uPXyhki3utaQam8OG4ApaDmPZQzVp8UOIy9nck4kgIH78CBLHhfbPhMlYk
         hDnAYnkW0F1Q0JRDhbhKzlO/6G7fXjxxb1Fe/r5uz4/OO2K6YBI2CO9DjHhbOjjIeGS/
         AxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17LCrEvoVMel3l6IL+XOQZ2NcSPgDUqLer/HDVDPf0s=;
        b=yg2T4Q4Z9J94mEBtl+8qvO+7eJVNrUiirY0OQhamQomIbAE6cfA85+FNCZSlAfHEK5
         uk1+t2DyRs++CHLUCm2D/9mmGrpwz8RgzL6NDujImPZIAPcWnmr8mAYdusyUCCHnMZsF
         wFQk/qMhfoIQJDucJlvHh4Xnk0dO3WO/V5vOgwH41Lz6ReaHA6sbiZkVhuMXKvsrZquw
         EcEo+20Sz6rcEf6jrkwGNN4PfVGhphT14WcMKXmJwYiH+4cbDogOpCuueY6LgqMktW1c
         q113PI+R8RWG2jSheSGWaquopZ/KsVfP5E6FnOa6MiCer0p24W6Bn5xzaDB0d3w/1KnD
         BqGQ==
X-Gm-Message-State: AJIora+jQjyWGFI14KWmZN/oIPoKQGc8nIwsBC7kWVllECUgmUxai241
        UNb8x3T0lIW9CuHob+0qrOrxpMtKRpyfBQ==
X-Google-Smtp-Source: AGRyM1svu/kw8DN04yfGnD2sDtKp86y/W7Feq1we5jjVm1eOBqgQJnTduYNwBr2m6bUxBbYaxLudqA==
X-Received: by 2002:a1c:2584:0:b0:3a1:9de1:f2cd with SMTP id l126-20020a1c2584000000b003a19de1f2cdmr11706005wml.182.1657484866289;
        Sun, 10 Jul 2022 13:27:46 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2e4000d7544521133919bb.dip0.t-ipconnect.de. [2003:cf:9f2e:4000:d754:4521:1339:19bb])
        by smtp.googlemail.com with ESMTPSA id o9-20020a05600c4fc900b003a2e51bbbb8sm2566021wmq.30.2022.07.10.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 13:27:45 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] add definitions for ROG ZENITH II EXTREME
Date:   Sun, 10 Jul 2022 22:26:38 +0200
Message-Id: <20220710202639.1812058-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Use the proper author name and email.

Urs Schroffenegger (1):
  hwmon: (asus-ec-sensors) add definitions for ROG ZENITH II EXTREME

 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 47 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.35.1

