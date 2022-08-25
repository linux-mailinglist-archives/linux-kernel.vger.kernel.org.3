Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116675A1B73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbiHYVoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiHYVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:44:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D33D5A9;
        Thu, 25 Aug 2022 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661463831;
        bh=N1QEnDyksyCNit32TXUBx6eisaOwY77K602JqlNkpKw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B1HzKcAMOUELmycof+uW4FAR/SBpJfeISKfqaKZPDtPW1GI8iokNCO+D3beSrhhj+
         kt93LrQ3p/PR/vSAEhtg10LkmB95lnfH+47xd56IDACr01+QH3OIdQPeppcYQvshbG
         bc5pUWwhDJe0qKoJMx2EnnEwkbhAmBSbCg1eIlJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9T1-1oZoxy1x0z-0094hG; Thu, 25 Aug 2022 23:43:51 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: Add include stubs
Date:   Thu, 25 Aug 2022 23:43:40 +0200
Message-Id: <20220825214341.2743-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825214341.2743-1-W_Armin@gmx.de>
References: <20220825214341.2743-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g5s6l+LzQCgzeqrycQCKHXOvmdFO0K+CX1/qkDKw97LgB7ExCfE
 QV42k/z1E3Dbiddflf+0HaazWQjE8kTctHEg2IXLn8k34Y8FSuB4uc2RADKlPlRlDJ+WW3L
 OonT9atkOZzpU4fPCyUW5mCL+2ZlMhG716cJXORFez6fjGl/m9BqhhqDLbwsvgfoBGHYJ0z
 gnMyD2x6EtU9zgHTVBigA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bQskdD2oQrI=:lOvPkUz0HSGZTaXylMaUFj
 r6T5JuQxyM1njRLhUVmW/jaFYR2O3emgOxdOhzM6Igrum46DYlU7T9hYMvZisfyHchwJvGfXA
 s94Td0PpdVkaL3E4bvjUZkPYIiQhgOFxHSDVTcA/+keOLIx3O+NGAh5lX7xZPpfmGjR7ztE9a
 NQ0iY+3MSFxvheBPB/BgQ+xX7K9DXkfSEalRKQapu/ctw3TQyCvduL7XQotyulT3owU1Kb5SE
 jeXtvV26ALiug/fsY7AcFUn46dDDkTzVpu9E5ZFNjFfkd4p9wULhFdFZnEj6o4pHQ49jutuHw
 7nmlIA/YwZOd4sAhXC9dzO4/Ta1ufGf5f0or6tx3nVft9nDg9gah8OEOfFeHtna1/q4Qzgvgt
 3kRCz5WoZbisv1AkZ3LhA0siaWYTJYA+mBxguNJ8aSD6JfAXKOtYqCF6noO2EQ4YqAWN6GUE0
 RmYzf99veDV/g4mfxX5MGWJxbUhaw47ZtJ76ny+3NZHgTIi5qlgo6UE6jeeuSkzmOIfCT//r2
 owNxSfmJW99oIx4rZB0INJhhT8ng3qMxV5SFjERYirulX994M0aCDZGRK9DIXLkFSnvOOCTNL
 wrLw+ZekZn2uYA5LVQSic+QEVreTSwhDwYOOUdjT9420PtN9SYTbP9p7BoMcebgMtj6DjwB+O
 Rof5++KBOQGl9tNJFuXuJ8uhvUbsbiirtzSD/FVoBYPkpJqz+DUJNDwtpCExKH04sX9ZfU1gX
 aD7a/CGkmv4UYIvtNnxxzO8KZsKpDypgKQVFY/bysTUH4V5ceB+lGR87QSIK86Tub3KKXJJdY
 44yNrHL0brb6VM7OdjqxGQtQhgoqsGEXlJktbGxNfiwAMsdud4yuMIfhZD5b4qiNYZJD1uO59
 VGcbF8S0QrUhJ6nIoxoVfxxyuatpeFNfVrKRMfBPDB3s6OjaQw4tvm8wuQubm91U+nExKCrlh
 iirpUtJ2aq/HcTpsVFZA0MHkD6YElzu+dj8Li4iCleVxrw6V/+yfkDdI5wESuvpPxzoXS/PVs
 yU5Ps3Q/vzaJ3AZVJImscgijkJbFtQ0UMNlgS2M+Z4f31zDEhDLm/nAPDtJ73nvSvSB+r3Mx1
 M3RxCq0MgkYBN7ApZ109os6xSzNRIjsIc1CWkMWWW+NYmi5fyd4FW739A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HWMON/CONFIG_HWMON_VID was disabled during compile
time, driver using the hwmon subsystem might fail to compile.
Provide stubs for such cases.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/hwmon-vid.h | 18 ++++++++++
 include/linux/hwmon.h     | 76 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
index 9409e1d207ef..329151416c47 100644
=2D-- a/include/linux/hwmon-vid.h
+++ b/include/linux/hwmon-vid.h
@@ -11,9 +11,27 @@
 #ifndef _LINUX_HWMON_VID_H
 #define _LINUX_HWMON_VID_H

+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_HWMON_VID)
+
 int vid_from_reg(int val, u8 vrm);
 u8 vid_which_vrm(void);

+#else
+
+static inline int vid_from_reg(int val, u8 vrm)
+{
+	return 0;
+}
+
+static inline u8 vid_which_vrm(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_HWMON_VID */
+
 /* vrm is the VRM/VRD document version multiplied by 10.
    val is in mV to avoid floating point in the kernel.
    Returned value is the 4-, 5- or 6-bit VID code.
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 14325f93c6b2..281387ee03bc 100644
=2D-- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -13,6 +13,9 @@
 #define _HWMON_H_

 #include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kconfig.h>

 struct device;
 struct attribute_group;
@@ -433,6 +436,8 @@ struct hwmon_chip_info {
 	const struct hwmon_channel_info **info;
 };

+#if IS_ENABLED(CONFIG_HWMON)
+
 /* hwmon_device_register() is deprecated */
 struct device *hwmon_device_register(struct device *dev);

@@ -467,6 +472,75 @@ int hwmon_notify_event(struct device *dev, enum hwmon=
_sensor_types type,
 char *hwmon_sanitize_name(const char *name);
 char *devm_hwmon_sanitize_name(struct device *dev, const char *name);

+#else
+
+static inline struct device *hwmon_device_register(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct device
+*hwmon_device_register_with_groups(struct device *dev, const char *name, =
void *drvdata,
+				   const struct attribute_group **groups)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct device
+*devm_hwmon_device_register_with_groups(struct device *dev, const char *n=
ame, void *drvdata,
+					const struct attribute_group **groups)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct device
+*hwmon_device_register_with_info(struct device *dev, const char *name, vo=
id *drvdata,
+				 const struct hwmon_chip_info *info,
+				 const struct attribute_group **extra_groups)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct device *hwmon_device_register_for_thermal(struct dev=
ice *dev, const char *name,
+							       void *drvdata)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct device
+*devm_hwmon_device_register_with_info(struct device *dev, const char *nam=
e, void *drvdata,
+				      const struct hwmon_chip_info *info,
+				      const struct attribute_group **extra_groups)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void hwmon_device_unregister(struct device *dev)
+{
+}
+
+static inline void devm_hwmon_device_unregister(struct device *dev)
+{
+}
+
+static inline int hwmon_notify_event(struct device *dev, enum hwmon_senso=
r_types type, u32 attr,
+				     int channel)
+{
+	return -ENODEV;
+}
+
+static inline char *hwmon_sanitize_name(const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline char *devm_hwmon_sanitize_name(struct device *dev, const ch=
ar *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+#endif /* CONFIG_HWMON */
+
 /**
  * hwmon_is_bad_char - Is the char invalid in a hwmon name
  * @ch: the char to be considered
@@ -490,4 +564,4 @@ static inline bool hwmon_is_bad_char(const char ch)
 	}
 }

-#endif
+#endif /* _HWMON_H_ */
=2D-
2.30.2

