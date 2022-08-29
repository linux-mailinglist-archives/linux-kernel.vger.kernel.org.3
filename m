Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202B45A4148
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiH2DHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiH2DHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:07:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786293DF0F;
        Sun, 28 Aug 2022 20:07:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso4085755pjd.2;
        Sun, 28 Aug 2022 20:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=RH/VDeel2O1YnlzpP/dZvddnsVEsPqbgyyssL39vics=;
        b=ogMgcr/LSmQ9RKxiLmV4PL43wTz2r/eCVGTH9s1NPdmE24iaezC/mKa6/bbAkaq91B
         JiiOVJ2ZHUPJw2lELRak3tg33HqOyB7kXxhRus9Emc1+geBFXB0Z+Ycgli3AQIxeyiG/
         x7ZGG/gDbjNpA22B8/A4M2XDEnuPy/OvmMtpbtnkXaZuQOEp3YwDDzUJHiKdES2uVI2S
         WAKfK8tYS/VOFMrMD7I6y4cpkzW92K84nG0axRVNfcGX4kXe1UYrrX9dB7Yj7BB/mCo4
         GHwD2piXz32uPQH+HZr8vPiPhoUCAXfbyUTenF0rabP3MJ4LbwFDwkL0Snk81vCBSFfC
         sQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=RH/VDeel2O1YnlzpP/dZvddnsVEsPqbgyyssL39vics=;
        b=eQ1op5TJ4fdqpDThu9an2G+fLjmNiUind/SrpUOIz5PNK13Cb/DzLa7HU6EG8l7woL
         iE80EMCZHU578xYZWNv6kZ/JE2t2V9IACRnvCT3LdSLbIaVgaaJwDuZTENvNQ/EQfMFg
         HBACDfLjoLhT+j+KHQ8WSa9McAP19AV8qF69oP/mcmEJaL7TxwogVa5bbzzkDrXKAvjn
         6s48gfkGybUVu+DUqJpAm+IFlFnYQvFX+RCmHVKL8//W3v0jejhpRa7DKT3w3rQAvHAm
         a2SVY635dO7ljOEDGqpCKnEZohZ2CtxHKnhBoa4RNOLqaZqcDWqCn/TRKHCU16t8YZ93
         mpTQ==
X-Gm-Message-State: ACgBeo37n4y2gO13BypXDMU6BI8LevXfNIVqpPBXnF8Im4FB28x7gfcO
        cJN/LGvK+00fWVTt3sYUxtg=
X-Google-Smtp-Source: AA6agR7RrwTSHX2RmLF8KcYvZsMRRTcqu2wDk8lu0Xa6HExMsW0EF+EUHgDgyjdntulXQGkNKMq55g==
X-Received: by 2002:a17:90b:2243:b0:1f4:e8a4:8c38 with SMTP id hk3-20020a17090b224300b001f4e8a48c38mr16848427pjb.136.1661742422850;
        Sun, 28 Aug 2022 20:07:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:7020:1d84:ae39:a965:2e45])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001714c36a6e7sm6105839plh.284.2022.08.28.20.06.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2022 20:07:02 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Mon, 29 Aug 2022 11:06:31 +0800
Message-Id: <1661742391-11378-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9471 charger driver through sysfs entries:
- sysoff_enable
- charge_term_enable
- port_detect_enable

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/ABI/testing/sysfs-class-power | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a9ce63c..1f8afe5 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -768,3 +768,47 @@ Description:
 
 		Access: Read
 		Valid values: 1-31
+
+What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+Date:		Sep 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the sysoff mode of rt9471 charger devices.
+		If enabled and the input is removed, the internal battery FET is turned
+		off to reduce the leakage from the BAT pin. See device datasheet for details.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9471-*/charge_term_enable
+Date:		Sep 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the charge termination function of rt9471 charger
+		devices. If enabled, the battery charging current, and the battery voltage
+		reachs charge termination condition, the internal battery FET will be turned off
+		to optimize the battery life. See device datasheet for details.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9471-*/port_detect_enable
+Date:		Sep 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the USB BC12 port detect function of rt9471 charger
+		devices. If enabled and VBUS is inserted, device will start to do the BC12
+		port detect and report the usb port type when port detect is done. See
+		datasheet for details.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
-- 
2.7.4

