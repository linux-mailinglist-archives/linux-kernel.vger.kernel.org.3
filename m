Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0983A5A1B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiHYVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHYVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:44:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C8C13F34;
        Thu, 25 Aug 2022 14:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661463829;
        bh=oHP17GZle9QsY5mloPe/0OhWATRtEk9UTdf5L/O9hTE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=G3+dGjg7lOpBTtXrXJe4w08cgKQQvbDPooii1V3CWZgZzZFvRtpxElHPfP3IrBOZ6
         KftbS3BM6owS6s3FgGkviysgEI5++ju1aHClks9/FOdLB+CemI9pcT/eDWloiLi8b4
         WtkrBnWCeWhAEL2IKwWAxrathx8WUBQbXFBjYo3M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3KTo-1pQ8lq42Og-010Lyy; Thu, 25 Aug 2022 23:43:49 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: Add include stubs
Date:   Thu, 25 Aug 2022 23:43:39 +0200
Message-Id: <20220825214341.2743-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bDEkywiWyKJRY0hUSsyJZ3TvgWekNIh3hGcBkGWp46d3+gPT1r1
 u3FXTzvMViIKqcQxpCueGjyQjk2MoaPO+pOoDwHF+VpYZOZZ7Ktmuir2Ar1KhWSitpUY2T9
 O3rsEPHhvSIP2/ael3JEAKGJ1BF8HJhUTwAb37fxZcRvs6/l7OK6XJe73qCxFtUohD2B7LX
 l6WF3Gi9PMMjiBQLXFYPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P8m4/AtiHzU=:z4MJAWVc7o2JC88N1aCGIV
 jmtIS734FLnYERRZPdxeaqliGezhXmd38PqIAgZh4MdFRKUbhw2TaTefMNdhkgAazhVo4rB2c
 ouTcGE8hmoMgYZ6yP/YBara5yVs6oCsGlno2hNafu6+qmawhWqNBRYs91lUyzqlOhR/bO+jeT
 SInrDPwCQKR0+Gb8JTKE+XnbYb/kTVCht3joaR1GhuGO/hxpDI1+4FhWp6SxqeBlBSoWtP5TY
 TLNdG7oXe9lhVgoIDhRY8Ye+sa/L4eoQr96UxFgk0m4IFNrp5FmkKuKfyXdSFX4bvlZNdUbKb
 kZzccC4/ZgxUgS1av+tlw/KwOlfkPbdff14NEjCi3w/DtjRW56Ll3sca+UUS9eM/taPFK2359
 pjM0cHRZwnqj3z003TCh0VKD8jTQ/5dt4FZLiIKepuU+Vby4Y9JrYwwtV7mGOaxjfp3NfjAYU
 gr9o6AopiCBa8e3HYLvu+00qFa6PcWxWawt2cy7gY1eujGribtxFTGYGuK1M12JB8e/aecpi3
 5APi77CFAJPwfCYnaEeUyuuPlvKcWWFIj/dtPq7VSUhcPK15D81Bo4CqkPjXv903igbjFPsMR
 eeLzcpe6NHhvq98XYEa12tduOcPVcKEwLkWtQEBRqaYlooIekaSVgKtDgdMDov1cYd1ljiM53
 oePYS9wcK6vaifz8supROIPSuXP5himG8U10VCDd2YLzQk4GZjYxp0mggVFZAkhG85BTCHz+U
 TnCtaRc6zBy94KKfGYITfKQaEeAU0qReCwInJJPKg+7AugjhC7Bl2Hmi6hIPQadfylX6YK6ho
 le+CKScnDQ5wZlK8O/2oYnNLZhpA8UnHYa1Ug0Sp9WDCgF2CNUb+e3/R7bpRJTsmPJRp4FB9V
 R6mOhqVAK2taiwREJywPMxLGJV5zpT4dPZpbQVITGIfEQzS3WJRgDuUiZVI7V4vSauBs9eMkc
 I4LeQ3Ko1k8qSWFWs6iaEP6Y5Jx62ZNJl3oHqz2Uxzn3whR/TU0VRGP98P4ysBgqpkabmFJEn
 ng/FUbdSGOffpls9Tmj2HLhJCheMU6uQdkIG47VMtH1RtnfX/1FlHsxvkQFhFK6YJ0ju8O62u
 7A7OgK3XIX8g2vdvdtVfAfVJ1u42Lgdgta1ly2UP9HW1aqqsZih1yrO5w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, hwmon.h and hwmon-vid.h provide no stub definitions
in case hwmon/hwmon-vid support was disabled. This forces drivers
using those functions to either select CONFIG_HWMON or to use
lots of #ifdef to avoid compilation errors in such a case.
One example is the ath10k driver, but radeon and amdgpu
would also profit from being able to no longer having to select
CONFIG_HWMON.

The first patch adds include stubs to hwmon.h and hwmon-vid.h
so that drivers can omit such workarounds.

The second patch fixes a minor issue in hwmon.h.

Both patches where tested with CONFIG_HWMON set to y, m and n,
and the resulting kernel was able to boot successfully.

Armin Wolf (2):
  hwmon: Add include stubs
  hwmon: Use struct definitions from header files

 include/linux/hwmon-vid.h | 18 +++++++++
 include/linux/hwmon.h     | 81 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 4 deletions(-)

=2D-
2.30.2

