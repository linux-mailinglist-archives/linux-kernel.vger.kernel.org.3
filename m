Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666B858703B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiHASK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiHASKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:10:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B072114D35;
        Mon,  1 Aug 2022 11:10:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so8768330otb.5;
        Mon, 01 Aug 2022 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=t6ktmqB/P+iluSUoepFDW78LdbJE+Fu7Yw/Iev2hh+0=;
        b=G3vDEWAVfZhvAhqzNmPb7hGt0UmFSl5MbSUIKNUKbWEavHVKbUv8EFbdxwWA3BV5Zm
         4AA1O9X2FZ1l7Haew5HvtPBuyBjIZrYxIJXDshJ0tMzgQZo1AJ8RzVjzLwtHnTwNAtrH
         xFCLimvaq8KdHsXFbshY93wKdkAuLSgZcMI5LjtVq2tUqXz47CVs0Dupa+gFM/UWZV2+
         LaeabaGWvyLyMvdQUFCcT4gh6uoam589Qb40hpoq6xgywAU/XVdPhg8WGKziheYJkVmz
         Sla583hf8d6zY7AJXAJGgNl66WfwzF/oplDlR9XN7XyPrL7PbuF+lOlQbgw9mK2fqHvX
         Prsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=t6ktmqB/P+iluSUoepFDW78LdbJE+Fu7Yw/Iev2hh+0=;
        b=RFy31ox0Dcd7Ni47Gssh8HGq1szeK3PeITzK7yidsWdbJ8/BomH3Dr572p1lSx3jMU
         Hvhn9o9dqFfeuoOOX81uwzl3AaEQBWwdkByt7RjW5wjsXIqO/r+ob77RnMexujfSPfmp
         b4rzT6EE9s8G3SepufREYMhfapbNOr++JvUWY5EUDhkf9eaGoeDqeys4bLYPgNbky9Jk
         vaFimbA76Lt+YQeO7LZUpXyEDWba12oUW++R8bDpDnhcwu2/n1LpLEwRFv7NczCi22/e
         C0K0BgEyfsjnm2GSC2Atk9wizU5f6+/wBeBacwEgiQKuQQFSa/Iqa9TFG+ykjmPFwNtr
         NOTg==
X-Gm-Message-State: AJIora/g0p7F6pvL5dpzmMdA8fecarRJAO91XaqkcfetdhnFYYhOJAIf
        84tVNULbZoTle9SWjRvy0OG6kRpKm5r+35CU
X-Google-Smtp-Source: AGRyM1v7szvswPwf09KMfvoE2EGaTFPnWuf7OyKEK4JiU9jIlFZJVEMli8qPqx2glC6iLP1T0xUrZw==
X-Received: by 2002:a9d:4c8:0:b0:61c:a6d0:c2a6 with SMTP id 66-20020a9d04c8000000b0061ca6d0c2a6mr6289779otm.273.1659377441058;
        Mon, 01 Aug 2022 11:10:41 -0700 (PDT)
Received: from DESKTOP-GSR5SR7.localdomain (097-093-024-013.res.spectrum.com. [97.93.24.13])
        by smtp.gmail.com with ESMTPSA id m13-20020a4aab8d000000b004354d726305sm2823245oon.8.2022.08.01.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:10:40 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:10:38 -0700
From:   Max Dunbar <mdsurfing4@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Fix Typo
Message-ID: <20220801181038.GA957@DESKTOP-GSR5SR7.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correcting "wil" to "will" in the hwmon documentation

Signed-off-by: Max Dunbar <mdsurfing4@gmail.com>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index f3276b3a381a..a4755a5a24af 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -57,7 +57,7 @@ register/unregister functions::
 hwmon_device_register_with_groups registers a hardware monitoring device.
 The first parameter of this function is a pointer to the parent device.
 The name parameter is a pointer to the hwmon device name. The registration
-function wil create a name sysfs attribute pointing to this name.
+function will create a name sysfs attribute pointing to this name.
 The drvdata parameter is the pointer to the local driver data.
 hwmon_device_register_with_groups will attach this pointer to the newly
 allocated hwmon device. The pointer can be retrieved by the driver using
-- 
2.25.1

