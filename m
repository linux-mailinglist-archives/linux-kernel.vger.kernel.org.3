Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4047F3B3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhLYQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhLYQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:07:28 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF1C061401;
        Sat, 25 Dec 2021 08:07:28 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s73so18191447oie.5;
        Sat, 25 Dec 2021 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWAr+F/sFkIDhJFUa/ld0SbXsdO26UYsk+EaKlbiKfA=;
        b=GBg0LFKpw5VRsyFNZMK4SrFgzX5teZB3rwK8OJeGKz+xNCJuAgPKCtz5pN2QjKTq2g
         k2Wxt/OYRVR/6S/KS8RrlfJj0fKCB3QxXZFtk+ndbm7SGIMWXSieu8ojBnAsjcKr4/KI
         +zGU8H5RSslaYRy8qO17U8hwaf5HVNMQ+VpTkJwSeteEIMwPDzPcWx+zfml79kbyLzbO
         //vzfpnTrwOfOzHp9sXnjalJG189uvs1X46PYq34BSinoVJvYw+bCUv5sC4fSiQYTTKA
         FrG544lYI6314TfAyAum/1Jswxu+vgJsxqWgPRHKO2uEiAnJqedC5c74sW2vNyFvBsjG
         I3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OWAr+F/sFkIDhJFUa/ld0SbXsdO26UYsk+EaKlbiKfA=;
        b=idxHhpH9TIJSXracx4ktQ9MMyMRM0b8MnHZv8eoJyEJRNr12LDzpwyUkgli7lM3Up+
         SvBbymQi6sTqHDky9vgAcSKLylw1RcdAdc3ozc9k+Vj4gm4Y8cs4ExJc133iBhoB4gl7
         Q/fTSwJPtgMQclt9vdI3rIDqIP3heO8YlXk7+kkddV+spHggTU6jlAw7H28bBuY63u9W
         ChCpP+LmpR4ojoJxWcPxziWCy+63w3PRz9H6qDod8rmwZ5JO0r6yYpGuHxilV5OOSa7g
         5kVS8mV74s2ZhlQBxzDVEsxg6mW42/bHjMX+IT9yjVRu994gBLt4jZualZ63MM0ldawe
         Vjow==
X-Gm-Message-State: AOAM533Rew+JNs+zzUronHYQzCewAyD087V/uZA2ES7sGqQUQ9YLPeTJ
        0Zg/Ce07pic4yFeDZjeF9hTS/HvBRCY=
X-Google-Smtp-Source: ABdhPJxSluJxEpJF8+ipkK9HmPg9F1/zbF3qYQDjrIkcVC2lnf7iBV+iVnp/JsN+9i0WvRhcabSoGw==
X-Received: by 2002:aca:1708:: with SMTP id j8mr7737469oii.62.1640448447306;
        Sat, 25 Dec 2021 08:07:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm1979551ott.13.2021.12.25.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 08:07:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.16-rc7
Date:   Sat, 25 Dec 2021 08:07:24 -0800
Message-Id: <20211225160724.3120253-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.16-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16-rc7

Thanks,
Guenter
------

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.16-rc7

for you to fetch changes up to cdc5287acad9ede121924a9c9313544b80d15842:

  hwmon: (lm90) Do not report 'busy' status bit as alarm (2021-12-12 16:22:53 -0800)

----------------------------------------------------------------
hwmon fixes for v5.16-rc7

A couple of lm90 driver fixes. None of them are critical,
but they should nevertheless be fixed.

----------------------------------------------------------------
Guenter Roeck (5):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function
      hwmon: (lm90) Prevent integer overflow/underflow in hysteresis calculations
      hwmon: (lm90) Drop critical attribute support for MAX6654
      hwmom: (lm90) Fix citical alarm status for MAX6680/MAX6681
      hwmon: (lm90) Do not report 'busy' status bit as alarm

 drivers/hwmon/lm90.c | 106 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 44 deletions(-)
