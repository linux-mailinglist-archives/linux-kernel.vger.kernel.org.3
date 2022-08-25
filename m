Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2415A1B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbiHYVoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiHYVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:44:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123813F34;
        Thu, 25 Aug 2022 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661463832;
        bh=jWvRUQJzDOtaEy3pXgAUIpJPwFP33xU9hfELC3WPiDw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZzQGLdyn6VT0ZhQVnSTV2xqYHD4cXeZXS+GJlsSDB5GXidYvXCoLHJ71FLr67Qk8M
         OpvPZjcbylfBthx5S8Zd25z2wQyp+9RLjXhyAivBD+MLOeG6FWpJWf561fmVNH0ImZ
         w0mdnVkL/uuv63ksyHM8R6jRPBsHTvS1GtPsqT04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MryT9-1pCC7R2hPB-00nvkB; Thu, 25 Aug 2022 23:43:52 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: Use struct definitions from header files
Date:   Thu, 25 Aug 2022 23:43:41 +0200
Message-Id: <20220825214341.2743-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825214341.2743-1-W_Armin@gmx.de>
References: <20220825214341.2743-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z4saCYK06JySxAMMuQQu9/i7gk6+S73O/Y/zoOHr7fFJFm9gyNJ
 z/e4NG5xIFYMYYdxZjtj0yRfVmgQ1/RgBh9++HD1rTiLWbTW41FuEsDPSjgPa/Aok7ShMfS
 FwcYAILt1nQMBFhQq9hIWjq5RrW+6GfTTvueTsSPYH6Q03gQAPsWyVzIIA/vn/HpE51O7ki
 WRYLetAOT+WLzQlB8yyKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BG9FJL6A5Zw=:WP2z1/CbQmxygIngGGkCac
 wnP5Ie4Oc9KC8RAc3l+FmgLJTPLqPFWHYFnRRc75NYZvm3FOyXrRapCgWUVE+nhvA/Tkz83yO
 KM2DWuoL3IjVEJ1R9UP0pUS/fIaQq34YWv9k6x6puOB9npyyGzIg2wZidP7r9KKRuqeWOFt6W
 8hq22BeMXsGgb6ZNpZiuTQlWttvtwVWrb7RD9dX4lDzHXhhX1CIvqqwW1yd9cOcfFieS1Bcvc
 VH0LjiZSDb2ko345Faxwx/+6aiz6By5spmr2e3NvwWa9Hqg9V748p/ff+RcbjQKys68krMztP
 jXvaeJxggw5uxuBTseiAXiZOefdY2IBHFIRRJG7A7CBaxqvZP/WNrKKl02KL1GbPUSyTgJZiU
 YJpnQtQfcx1CrJT7IBNvlh6qzAk0D9njybkISdAowE/cVEpNDBzmgopr9qSRiwraRnjSPaeg7
 sqiFsu+PUreSk9TYtloujcAIutnWx0YUKkZ8YEdilOOgEqSYyWBSgzjgyp+djGcyOjTt7JPti
 n4sfMNk1UpHRzC7U3XCrc2d7uYXtXitj5Hb97t+emFLiOCeg1dvfbHu54cPbjxSawOeq0QLqj
 Y7ATFhWfmAKwEarT0gdyCnf97CoAbiZMKxnJ89TJVZgJhinPYZcrtMaQA2ufQYkyU+VDhuAGS
 mV0EEgxX5bfAd0XK8AcCm9VMUPeGXpl3EJNQqHan5zthB98Pq1Rrivq+lNnpOis6/j8ZsxAWY
 u2NPgT+CYqycty4EXMIfqqdnIs8cVHrAapobR6jOUXcZGDNoYL39YNTTpEJInZtPgx9G8uJAr
 0lGGo4DDLshCK1/kEhMidWgJ491fwu2crEko1kIsBDWHxOe01z3dxjLk/5WEkJCDdsvduKpuF
 eY6BrI7evOR30S6i3U6GwTqopY6pzLXDs6zQncIjXc4gh0AVIB2NDBcdwoVMpsw8aqOLjJ43t
 DptmwAWn8tTicaFwvzHIePQnZ7/wGP310zFOKJnLsdDUfZ9CDi6whAIUIRq8bwuBKzMvd/Mcu
 w0TbKBwKZsZjVj9fya1URl1E0VvuxI1S9K+GHWI/eSO69ozyW335JYCfAmpwJWAyr6DlwMipY
 reXT5k9uJpBfitzepLBcUe7IBJipvxcVF+bSM7HZD2A4MjCto8zOaVczg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structs attribute_group and device are provided
by linux/sysfs.h and linux/device.h.
Use those definitions.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/hwmon.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 281387ee03bc..e8acc35af12d 100644
=2D-- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -13,12 +13,11 @@
 #define _HWMON_H_

 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kconfig.h>
-
-struct device;
-struct attribute_group;
+#include <linux/sysfs.h>

 enum hwmon_sensor_types {
 	hwmon_chip,
=2D-
2.30.2

