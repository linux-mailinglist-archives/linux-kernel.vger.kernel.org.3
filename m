Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1F59C53A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiHVRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiHVRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:41:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFBA46227;
        Mon, 22 Aug 2022 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661190057;
        bh=8NqP/LmFNkUsKE+lqDM8Vx1Qa5L+gzbvOwhUVr5t++g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N09sy2atR4PkdU5rlHrMkfG5BG2l4uP0Le5tWXlODd2QbCPxWNgkD/SMsCLRIzwoC
         N5E9af2LcxAJxaN9VgPTRDSHOPXwp2TZULO6Hp7QCU/maBWGW+o0k6migFbvoHTbtG
         W5t05W3u5F7u94JTNfu6i5sQZ+94JY0tjHPNjX4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N95iH-1pUKGE3TyJ-0165DX; Mon, 22 Aug 2022 19:40:57 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (dell-smm) Add FW_BUG to SMM warning message
Date:   Mon, 22 Aug 2022 19:40:52 +0200
Message-Id: <20220822174053.8750-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822174053.8750-1-W_Armin@gmx.de>
References: <20220822174053.8750-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ujim6dMBvYZkQaEGMgdZAwDX17AMjv92ZepvD1xFZ7Ip+eD1x7u
 f2h1L4fv9YVLJ1xQFX6F1M/i1gmb+cDJ5Pe+94b7sD6KKrLbF1al6/khHhuO+FfjWMhQDcW
 wzIbHrMao8ubKItC5GAd9/qrjhSjSvWT+Ud7VEx372zVd2WGYt0TDEpP7wMtR8g2UVAGlu7
 IHZbRDHsaR9iIHYfE2q9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZZ2aeCu8VGE=:X1qtjCMDaP4azV/etqeWSj
 b9YfX2H2NgwegaAa9aVOvES2OUOMUBgL3kV4eCC/aHNz5PcNi/sM1OLUy8nUeu+dh6Jrs61Hv
 dYxdNEZZG4Ceif2DC5CxIFW1IdawvkWjAlp0ETS/2z+KbCltH3GB4lCErhyWXLO3zE6j8Soe/
 wOTQOhrcFqPS5Zz6jlzN3gcPiUfD02eYnriGajpcpO7oTiAvnvfLDs9rd7heXuDT2RHCp6JzE
 UXz0W5nFBfYADF6s2lasSOQZXTXtAukgT7yRulLu7yQCXUsrNE83oj55FF9MSfsu85rIdUXK7
 fSfXB/Xz3Q+yex8eQD7k/qsTn24fXCJVBelDs6w/6BwuoYllu0ESSvm1be03E7A3hw4TRwOUn
 6jZtH/0J03FyylbZuihUp70XtLu5WH1KOv/37CH0o+WWb6PdmHwnpDZO5RAVP/1VXXz4yNkO4
 kqGZTLpnNyTVw7S+FUrx6B0/C/KXw1QpRnDQuwjtN17hx7cfySw6GhBS0knNZIHsSifnUFPtg
 fMUsVErBFtGRd21/1IpQGI8A0iNvgG43zLsdji5BPKknuUn2aVYFTN9rmMlZB//uzh3CdVc9a
 D86w3MHeFp4RM2pXyKH57F4rP64i4av6FxZibwKW5mrTiDzG7yAJ+Xr7649tKSqbIF2nRoTEW
 GB6XPETjLaFpm0henaUZ8NgZs8mMttTmmWAcbUR0uS4XcBJp094kv6JnAk/3RIFFLaprJ9JcW
 MCyGSDXPtWvFBHr463P6oVRbhzJoEqVFf0GfM/lYJssjvEeLOyHwR3Nz6OQJz3ua6c5aDlU7i
 axv2ac1BFObq0WtdgT9437GsiZE/2piHE6QSVAsZMr380AJPwebbNDCxXZJqdIdNnjMlLEpQL
 FGapNeTYFYjjDYcrc8txwBnwG7IVVigZ2nFNRR+KYoevGRKOHYif/OpAc7e5GESxnc6/QOxoG
 /j3k+cxgjMsvTMEL+8jtFFsdoX57WM+YyVh1GXlQiBkidk/L0MQ5GvvTZO9HV94KCFEp8SxHX
 BDvu56YQKg2FR/nQJs5s6d3tHmwFXiAIzoM+fAPMWcKIH14Gu1q7PsdeO0nJN+a2+mMg32wjP
 VSaEnG18qlc+c+B/UyNjPn6fkiIW621HzjR0MGqgscjj3Q7WfLM1CwuxA==
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
index 7f8d95dd2717..9cac80358072 100644
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

