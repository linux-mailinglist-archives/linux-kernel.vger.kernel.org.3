Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1B59B4F9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiHUPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:17:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED023140;
        Sun, 21 Aug 2022 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661095042;
        bh=yqTe4Y/sfP3hHZDfceJU1oV7+HnXjpldjg0d8fZB3gg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hJxr8k+4MWo+5tocF2jHxZ1seKExMfmazK12eE93Y6RZC5G/32sYAa8Om2RGLJoCB
         IBCkze8LcAgCLcmvCJ3YNJN90oJ+3i/eNKchp1YcjvsE3QPVZY6cQtn7eSEcqt8W84
         WJ5porXcKIRFQNDeinipOxBxBdlY6UYqm6PkmAZc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MyKHm-1pOLyo2osG-00ylhK; Sun, 21 Aug 2022 17:17:22 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (dell-smm) Add FW_BUG to SMM warning message
Date:   Sun, 21 Aug 2022 17:17:12 +0200
Message-Id: <20220821151713.11198-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220821151713.11198-1-W_Armin@gmx.de>
References: <20220821151713.11198-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D78pjPjKuTFgXHr7SR/GU5h+qtFoQV8lJto1k6IZCd+thIHInq2
 g0Va5tdEJ17erfR1WSCAwAkjdEWVfR0BN0RqIeN/Nso6MmXrdMew7raYHCRDKAUrJWbVZTJ
 sLlAELg7rYf6pgAjkfyfoSU8iLi1nvUnJ/4TVTEMZe6APMYAl3j13NF/Mg4t33A+g+9nUf5
 hbnjJVBMWUdICjNloWJsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ca9M8rNtz0E=:Vc6UdJeGKvUA64vX+ImCl5
 /4lsoEwayIN1BE74j8AZlZANFYeViv42kw7Yed56q3T5e5d/SY3yt1k5jIb9XDLJybiU9bsNR
 /rVkKQkMFEv9GcJxCuHlyaF0yAMT4jt4JyL+yKJVgL8AQ80F41B382oybrKLGMtiP5R99B5x9
 0ofkARgALDmbQfyanL/HffcEvxfyMP0zM8I8kdymZ5ttno6iwpJWWQtAvfbbR0Bd1bUHZKkVW
 kypghvDzaKhEyfZFgULL62K8Fx4DgJKELhNJJAVsuDpuhHoAa0bXwSDT7Yv7/uBVYuHkX/K7s
 +xeQc47XDMq5ZdTVI+J5+yEieDjoMScQ0bb8qc3onDojXnUg3txX4aNVNW9StuMcdtxuuub1k
 JCVA+H8270K6FbjXjTLClf3F2lz0mbNTsop9mq+zOdigVquogwtaupffyZ3+qzYApDa+hbVub
 QbNAIWW7Jdr84P77YVDfLYUrqvSWPQdL44FCzqbWBq9vLBAca0kfhgSpn2rIwwnbfIrwc5gmf
 JhfJ5sKLhM20Mu/wVXtRKSCS6vxVUtXgn+gm7Q10kujA3kdIbfxoXn9kMw5pnQRSJKr/11Pg9
 n6TgHxzT6qazQKcHbXKX5t59B2DkiaslL0yaV4kYLxmyRUsn2g7ZJnP/BBTs2wEiVQoDWPklt
 QWZkpEEIdyjWOT6P4Z8sWXFZE7T5EMcJv7Pi8FfQYxjkc6j6Mm4b9Vm3dth6IRbqTcvntK0p1
 n9sjKQUFG2R2bI7i5MjJjaNrWUsP8OYM/GSaZGn1W0JlDljyLJkmt/+h41o529c+juFV7H4T/
 uG5ozmXJVXmAS55R5a0izW6c3hPCnaXZVY6tZ+L4SC4wh6V9x1LNxfWfPkEaRe5cyVh9BKc6o
 IThoXM9A+lUWv4YlHXLcOHEPKlYp3UEPapJBloTFOuVPrqzO9h73xPtJBxeptrWt92xzowbg3
 KbE4jW6Qn/h7ordCQOK4AgePfO/14y1rx0ZnveFvW4sAZ9C7tAH+lUUvOl6EgMZDPKrsgynKd
 KzVZyXbpP6lZmmi97SKIkvv7JXRwrlaselkF09vZ1NijaguGyJ9ig288G7ZYxNAMiawjyDECj
 v2qvfxqwpP7ZuT2wROHUmnEjZRqsFNmt1oaRvCdNKmUHMwoimyUrFLgTg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a SMM call takes very long to execute, then it definitely
is a firmware bug which should be marked with FW_BUG.
Also add the number of the buggy SMM call to the warning message
so BIOS developers, etc immediately know which part of the SMM
interface is buggy.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 1dab7591576a..f7bab1a91b93 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -198,7 +199,7 @@ static int i8k_smm_func(void *par)
 		 eax, ebx, regs->eax & 0xffff, carry, duration);

 	if (duration > DELL_SMM_MAX_DURATION)
-		pr_warn_once("SMM call took %lld usecs!\n", duration);
+		pr_warn_once(FW_BUG "SMM call 0x%.4x took %lld usecs!\n", eax, duration=
);

 	if (carry || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D eax)
 		return -EINVAL;
=2D-
2.30.2

