Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A533152B517
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiERIfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiERIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:35:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2A4ECCB;
        Wed, 18 May 2022 01:35:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l14so1343343pjk.2;
        Wed, 18 May 2022 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fP2fbOCLOJBQ4ZmPFu380tszq7XyGeACGdg9Wxs7b6o=;
        b=pSFmTzZIFnrcw2fal89T3gmAqy5brVXf4T3ueXyCgI5iaaqddc4YvjjZ3/MprJ+lj/
         asTRvgaVph7wKEuajTO0Y2TFTrCZzah4TedzrPk2SX8B71fIbmBWNYzCjFwiKwc84AHd
         vsk2yM1whBiAZSuzsETaTtY+MsvzCvw99bWMEGcEi/ve5ZCJ4rMv2sp9TbaHXA/2PovF
         lBVk6bBjbX+o+VJ31SdJt9o/hj3bxXRIMVetnjdOqE8AEd62nrDWaXO+kBrb0MZ24hvM
         8ociGDH6kj74sNnvU68rbBj8ptiKo8QXCKyTrFTjyTsoiImKQrDM84dsPtDuCrUCrcKX
         Jf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fP2fbOCLOJBQ4ZmPFu380tszq7XyGeACGdg9Wxs7b6o=;
        b=RlD9cc2lXbQYg7fEqb2skStALfaNnLy9nWAkoqYK0G+Aqu472UFoOOKkiD4uZS8dI0
         qLLIC/P6nKMk+u7RxR80N1d5XrdkDaS/n7D7pNoKyGrE3VB+gqEi/sQczOv0UtBlsQqT
         YLYRn1sDbVYwIzL5NQvBcjcEFf2WS2E9ZAW2lfB7bi4TBydAQ8BVcLgBGAYlCejDnJ/Z
         PZYAonH6AGd+k9N4iJ1x6pOYRqHmeDhkZV9ysIs9jRU6jhznDvnifBy4nvfvxvxbr0yi
         /4jLNGtn9j/2aG0FiBHfa5Z/rwYyo6+oU9nUUYINAY6p8QyHRN4h2CF9KbgFNTEM01IP
         059w==
X-Gm-Message-State: AOAM532STFw/GUbWXyhiqsyjqPgJFJd0z2+GVbRfslz/NB06/qDtJC8L
        VGGKWe13QJA/K7wLnM92RFhdLa+xCKM=
X-Google-Smtp-Source: ABdhPJz6YKcuquMaQGW6SbulhPY0jRLE8ZoBzgdNAHmDuzlfS5pP1Gae450qtbDHl949zNgMORmsfA==
X-Received: by 2002:a17:90b:3a86:b0:1dc:228f:6a1f with SMTP id om6-20020a17090b3a8600b001dc228f6a1fmr40671731pjb.230.1652862938273;
        Wed, 18 May 2022 01:35:38 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id gc10-20020a17090b310a00b001df313f6628sm3029837pjb.21.2022.05.18.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:35:37 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH v2 0/2] Documentation update for Chrome OS ACPI
Date:   Wed, 18 May 2022 15:35:22 +0700
Message-Id: <20220518083524.37380-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
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

Two documentation patches touching Chrome OS ACPI sysfs.

  1. Patch [1/2] fixes htmldocs warning reported in linux-next and should
     be merged before upcoming merge window.
  2. Patch [2/2] rewrites symbol descriptions to use imperative mood. It
     can be merged when appropriate, independent of previous patch
     above.

Changes since v1 [1]:
  - Firmware typofix

Range-diff against v1 [1]:
1:  88fa56e47fd5ad ! 1:  10eface6e5ad4e platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs ABI
    @@ Documentation/ABI/testing/sysfs-driver-chromeos-acpi: KernelVersion:	5.19
     -		  * 32  - Developer switch was enabled when firmware booted.
     -		  * 512 - Firmware write protection was disabled when firmware
     -			  booted.
    -+		hardware switches when the firmare is booted.
    ++		hardware switches when the firmware is booted.
     +
     +		==== ===========================================
     +		0    No changes.
2:  9b4751a2cefc7a ! 2:  17d581296f6dfb platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI descriptions
    @@ Documentation/ABI/testing/sysfs-driver-chromeos-acpi: What:		/sys/bus/platform/d
      KernelVersion:	5.19
      Description:
     -		This file shows the switch position for the Chrome OS specific
    --		hardware switches when the firmare is booted.
    +-		hardware switches when the firmware is booted.
     +		Returns switch position for Chrome OS specific hardware
    -+		switches when the firmare is booted (integer).
    ++		switches when the firmware is booted (integer).
      
      		==== ===========================================
      		0    No changes.

[1]: https://lore.kernel.org/linux-doc/20220518031750.21923-1-bagasdotme@gmail.com/

Cc: Benson Leung <bleung@google.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>

Bagas Sanjaya (2):
  platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs
    ABI
  platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI
    descriptions

 .../ABI/testing/sysfs-driver-chromeos-acpi    | 113 ++++++++++--------
 1 file changed, 62 insertions(+), 51 deletions(-)


base-commit: 0a4cad9c11ad46662ede48d94f08ecb7cd9f6916
-- 
An old man doll... just what I always wanted! - Clara

