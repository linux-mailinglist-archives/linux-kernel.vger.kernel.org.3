Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB0502AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353971AbiDONDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353881AbiDONC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB15366B4;
        Fri, 15 Apr 2022 06:00:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 11so4835132edw.0;
        Fri, 15 Apr 2022 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++CzUJufZhxNIKK4fdK5soeF70/QzKxZN1v8C1osnOw=;
        b=TJC4eMe4/06lDnkOyJLD0ekSRuKWyDQkX34syiMw+uHF1TJqb0CAHYPzFsdLuBb2Aq
         bWPK0pZ1fzrslpmcgnPtFf9RGCnuQdoJ9ntpv/rXC1YXuePCBrbYEPOVmIa5Kp/2lQpd
         RlhU1qPJVhQ/+k3nkGTwgGQ4FS4M/THOvPF9heFLqLLZQFcuoigLPLc3aVXBN3i7H1ux
         VTd+j0xdiNt00qXCmglC+03MCmY2dCzPy+d+9X9nGeGBTUUrW5Bk0eh3H0gMt3tP1HgZ
         kGjpB+vwAdKoRSxJcq8NB2ZjZVYzJo3wHhAYs2tBg2/qc54ng9EPFjIWgDOhWOjZtDKl
         Wnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++CzUJufZhxNIKK4fdK5soeF70/QzKxZN1v8C1osnOw=;
        b=TQ+wS9DrcaO8Gzi/XUgfhqp6DAtG+xaS6SVkribYTJL3d3ezowVUUSI18XKppcI7W6
         4N2PoT9UW1GVDPkBVsH3zD9DYHqM0iM7twFmUOr6PCqveZgpO3a0YNKYFYUkq1mYYYxP
         KREY/4hYwMBbDtmRbbzVOJ7AYJuCuRVQZezF8jIM0rsyfnUUUu72qxBQwBcuk25+z+VT
         U6Q9NW29hipqLhDhanm9AOfkgnhJoirAAtPi0ocZX9BqRHsCTF8Xsm86g3RC3AP8pg74
         KSTjr3WvsgcilpN3XiH3a5dquC6Jtil1dVkgdqQq5WtvszO9PJoB4tW+OoPaOski7qDy
         bRUg==
X-Gm-Message-State: AOAM530okKyWePNYn2OiQg/+oVg8haa/B0J23+H19i5l3nZxmBLNYxjp
        Ax5voL9LYHxldK5wW5ZYioSCyOjXPNq/tQ==
X-Google-Smtp-Source: ABdhPJwIIQRUAbe4NzYkUf0Et3bVDhwtw44J/DpT/s6lndoLLtC7kWVic7SmpkiSYZM1NgzhagZaQw==
X-Received: by 2002:a05:6402:28a4:b0:41d:7ae0:6ec9 with SMTP id eg36-20020a05640228a400b0041d7ae06ec9mr8263450edb.410.1650027628419;
        Fri, 15 Apr 2022 06:00:28 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:28 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 05/14] iio: document pitch, yaw, roll modifiers
Date:   Fri, 15 Apr 2022 14:59:56 +0200
Message-Id: <20220415130005.85879-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

This patch introduces ABI documentation for new modifiers used for
reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).

It looks like we have some unit inconsistency along various IIO modifiers:
it seems that incli is in deg, angl is in radians and rot isn't documented,
but at least the adis16209 driver has rot in deg.

Here we use deg (so angl is the only one using radians).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index aadddd43bf22..2a6954ea1c71 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2039,3 +2039,12 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) euler angles readings. Units after
+		application of scale are deg.
-- 
2.17.1

