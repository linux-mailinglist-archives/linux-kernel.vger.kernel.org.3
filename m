Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82784B7753
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiBOTL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:11:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiBOTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:11:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489003E0E5;
        Tue, 15 Feb 2022 11:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952283;
        bh=6fGu6K0PKSEsXqjErmDJVMyr5oYaYNQlunwuBOunZpE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DU2NaHiajBFPAAHiM08wkRObpCIbZIxgdGa6cJFHSygdJqUrjd4u0Fa7CpYED1eTE
         ej3FD4BcgrFXei8zZLul2rLsMqeWNSCNkBDh0la2/6rg9X0xleV/s57bFTm28Bpe84
         q0h0c/vPMMRHCKqzYAUcuWVBltuicpaRsvBdVhLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7zBR-1oMxj60L6h-0154lo; Tue, 15 Feb 2022 20:11:23 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] hwmon: (dell-smm) Miscellaneous improvements
Date:   Tue, 15 Feb 2022 20:11:06 +0100
Message-Id: <20220215191113.16640-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CHmcC4XzxML/yHRgbG9ZHHLSDkLPAe1H4yKVuwfvv0mctIl1zdN
 bBtZfqoJHBwVp2MGZ8bbSJMUn/qBU1jZ06e8vKOA35fHwgOf/aVvEFmLD2bbGhWYNsXYWpD
 O/lVkCNIvbjS3jhuP2h4MjiGweWHQlnrc/zpKe5Qs5S7m4Hd9QFEXC4bunNbJh0woveWHKU
 dG/19dCipwgz/MdNEdmSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AF3aaWmX20E=:tlhzrWKJMg4IqCV+c/sq+i
 R3uIbhLZn2G4mM9qXup4yloUZ5sqwJ06R8G+X7QatE4zD5gd4RrE2pBjx+ce2+qebwcdC2SjO
 bRFDenEjkVaCYtYJm6hRRW0DFu2FB0Bu3i67fU1ADUFFFcc81Xj0nC1sa8wg0O3tnuemoyac5
 rLEmZG16sGgF2QD1q37Z5IOivJkSKj66fvmT0jIZQLJUhh0pFz+b2I+rPJRFVxsuXMeqlv0+Q
 qfQTMgB4F3a4dI3Q9R0j6feC3SQpRXfwJ41NUqoZfZ5uEBE8bLtDt2dQtgxk0gv4+0ojOwG/E
 9ateK2/GJjlZW5bRFHm8zoxyCUfLQP8IGZdWojQiYjaE56Z9hL6MbOW+OU2S3d8B+OIAy865s
 b0dguN3w6w18yKqW6ZssGYbQv+ZQv0HYFadKVKBI0AUFZsAnjKXnqirtMgm6nh5YMnkk7jYbZ
 4Q2w3n5aMtlx+o11+t8O90XvWAWyzlGgjN6AkFZpPgrDWmDbbcPV8CQLSVbsmu6ANtJ3uMrvo
 33ZqVljfbShIMVjIjBK+GlmGIJheulVQZGl/BT4wfkDf/VAAbhsHduYh77TKOa/6OjAmYBhzL
 r8l5+xQaYKIJYCOxO7jxYC80iHfiNfjnElHseUmQMaba3W3aGJiC3tLFx2+RcyAgSX8PaCbsj
 OM5YDmhXhTolEoS78rzFaz3TLkOE7wJ5l3clLW/ghg3lwGNuDO0Hd+g6MuUoGFxYPp2qRa0nM
 YpJnWW8ms5ch+vyr1guGC3C3GQ6t/FPu5XD25QEk1QHpSXrXpcNYme8Zx+ShxDhePjzrjIH0V
 6qwdUT8LOlCE2i6sroxSaC4srBT+Pj0KER9AFDrq4w9BVYQeS5ImWHwYrVsx3zLG9b5PkkGKD
 HHims+nJzyOATItRNJsR3trlrtsq1I44Vz53xaM/oksxOBgdT9OqRgRlTMn4JHaancQqKUdv/
 JmImq3glZJBBshAq+T+HoAhox65gblBj1HhF+Jj7q9/NZgUFdBWAkrNGYBoZhEpk/Iso5I8ow
 bvjipISsi7dI8somBzrXUyLnOgkLOkIS2kzDAGp4jvizWL2ibjFCU8pEH7EN2udhW9MW5B/CC
 siRajxLs+NWmJM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains miscellaneous improvements for the
dell_smm_hwmon driver.
The first two patches allow for testing known SMM code pairs
for automatic fan mode enable/disable without having to
manually edit and recompile the module, which makes testing
easier and is compatible with Secure Boot/Kernel Lockdown.
Because of the later, users cannot specify arbitrary SMM codes,
but are limited to two promising code pairs (for now).
The fifth patch improves the inline assembly code, so
saving/restoring the registers is done by the compiler,
including the flags register. As a side effect, it now works
on both 32 and 64 bit x86, while being faster too.
The remaining patches are smaller improvments.

All patches have been tested on a Dell Inspiron 3505.

Armin Wolf (7):
  hwmon: (dell-smm) Allow for specifying fan control method as module
    parameter
  hwmon: (dell-smm) Add additional fan mode command combination
  hwmon: (dell-smm) Make fan/temp sensor number a u8
  hwmon: (dell-smm) Improve temperature sensors detection
  hwmon: (dell-smm) Improve assembly code
  hwmon: (dell-smm) Add SMM interface documentation
  hwmon: (dell-smm) Reword and mark parameter "force" as unsafe

 .../admin-guide/kernel-parameters.txt         |   3 +
 Documentation/hwmon/dell-smm-hwmon.rst        | 202 +++++++++++++++++-
 drivers/hwmon/dell-smm-hwmon.c                | 178 +++++++--------
 3 files changed, 290 insertions(+), 93 deletions(-)

=2D-
2.30.2

