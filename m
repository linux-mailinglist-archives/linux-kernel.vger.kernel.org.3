Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6562D47C3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhLUQ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:28:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:36229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232746AbhLUQ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640104092;
        bh=DFcXh7aXLsFLWtrJ5eOcz1/TB0F8U0Tsd3glb5s6YZo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XdeVDPeFSFsD5azJHaeC/rtfwNKbBlAgLQwmGAv8r05M4dF1RPHHXpO1hh3W3EPt1
         sI818TQAlIeB94n6UGcyCjK3SQvrwHvxpRkjTuXJIkn0oXxnGHKxU4c6YSNpRERMAY
         b0ptEk5tJ/MUv0ylNb3PibXmNyMtKr0rqyPsDNd0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N17UQ-1mJc2L45f8-012XJi; Tue, 21 Dec 2021 17:28:12 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Pack the whole smm_regs struct
Date:   Tue, 21 Dec 2021 17:28:05 +0100
Message-Id: <20211221162805.104202-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4zVViJ8ypvkTcSFsZgOJVsB7crmm04kRBsmcai3l2H1yiLU9P29
 0rfnPSsBRLYNWnX1EHHL8Tr1F8oG5hVs1zfLLM6Btv3nfUN5Sp0fdlQxBusMBb/r9dlRxh6
 btGK+pwEpk9yIPwJREVuwuGC2Q7Q87eqqIWgRAw+y5TBMhsVzxQizm7r+Mv8zM+cdoYC4BZ
 PsVwJCEoItzyfujf/JKvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hRiNSVv3KBA=:vpRYmGPPKoyVhKoVwKl7Ka
 XcTF6KxUK0EIbFCaro3CZNaNtvLy4toV+yJVm4GqQC0k9zOBMWJzf5mm2cv5IRvlGLuzVrv6e
 kcgilqK5Q9iCLc2cFd4isJsCQoJhKtAQ7SJIoCst7Es0XyV8y6p98d33HRDFwGtYk0atx21DC
 tzgKSIi6Gl4B/TlaQv4oenNih+HjW4vFu4sSiTbQgUsd79aveVL/YVx7KAyI91ESWKy3qvJWh
 hg/6zRneP+P/9/yY4u9I/HBRqL/t+uQ66FkUehOYjwhAgJ5wT66xegi/vOEsyVZEzoaYPgZK9
 j9AK6q42/wWT5gGSnTGmaTm/6SPjTvxXJFf8229CKfYBKoiWRvU7+sVbfnBSVxi8tGsfjmGpo
 +t8KpZKpwopWzQt62qFV4t0M8JTr/tQEJ3ubxYvlVwfINl/XYocLM1m+9iS7PFrsAhFPpigfC
 pwAKu54gx5P4tiuqKMYkO9ZpXefQ8aS2XsI/V28rVnC1pKwJNGPAKeptJc7ObpllVSwI4UJMO
 /emkzKazS+JuU8vcs5KK4ZpcxzQOZ/jPh/zWkeEfiFmdOTicfkcWa2YsUWbGjQpEJqA57IYn4
 yN9F3zykINT1mgtH+0dyfC3v2x2fiVDxoYBPz45C/udsazASRSKu1699M37HVjMEfmXufku8e
 RjL1C+8ZyPoUsMwNeovR/ZMD9qIZw5IkuWIgQyEYlJGSrfevpeesJwJOqKGMrpdlk79vMBrvd
 crC52omZ1ziKXAX9u4KCA0YS0/xOqkWT+ocBiF6CeT8dNkDV+5LO3HPGqb35p8tiUbFP59N27
 bOeco5YEcAgAQ3X+TyZPsdr8ekmkljG8p/CMVZbvk1VJlZo1iHbf7UrfMH8DfQS7QhJCuINgs
 dTkbtH/dTY/ARHXcsO7bxN6gbw4nVSCfr6VWtiWNYdzVg2ob0yvR85L0YkYOI+N4EhLFq1E+b
 vldh7eol3OJ3YR4qTkpfItdSWasV9vood0SB4S0RB0DybjorEMi0BWBLs0Sf9dqMJ2xhFDjBK
 IxmO3Ltpg88hTBOVu1s7dx0923ODjbiOvanS+NonPYq23+mwLfXongt8aUtKK/d4PG6Uos+X/
 9geKdMyYK+oWy0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When desiring the whole struct to be packed, __packed
should be applied to the whole struct, not just
every struct member except the first one.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index d8c6e75bb374..d401f9acf450 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -113,12 +113,12 @@ MODULE_PARM_DESC(fan_max, "Maximum configurable fan =
speed (default: autodetect)"

 struct smm_regs {
 	unsigned int eax;
-	unsigned int ebx __packed;
-	unsigned int ecx __packed;
-	unsigned int edx __packed;
-	unsigned int esi __packed;
-	unsigned int edi __packed;
-};
+	unsigned int ebx;
+	unsigned int ecx;
+	unsigned int edx;
+	unsigned int esi;
+	unsigned int edi;
+} __packed;

 static const char * const temp_labels[] =3D {
 	"CPU",
=2D-
2.30.2

