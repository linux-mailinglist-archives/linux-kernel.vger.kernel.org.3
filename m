Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10B59C53B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiHVRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiHVRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:41:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821DE46220;
        Mon, 22 Aug 2022 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661190056;
        bh=stxN6+y1GWeGayjroJnONDCpafhks7zou4w81FFKN70=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JGZEekxgaXv6frvWca22vwhxUxPoGCLI9LLH5BpQQZ45qRljWrn73UeB2xLX8dJIO
         zuY8aKHFFuXmKwit4lnuNB+3+xLnrHXFAK+zghm08ph9NsgfMDeFY7iHb2BqMKGNVU
         JYJkwhpxgX7iXC0IPvK65/89UxwUHJsR92tQnGQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N49lD-1pPOq92Hi5-01017t; Mon, 22 Aug 2022 19:40:56 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (dell-smm) Minor fixes
Date:   Mon, 22 Aug 2022 19:40:51 +0200
Message-Id: <20220822174053.8750-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JRH70fYCno2PuVSQnm09rBin/9IRLCgv4TRlGzEvO9Mu8JgfaTR
 HYWH2cehxNJ51KRCeatZG2RpD9DidyAlQ28OI0ujffRppY6Mh9Z2XyvaBsRuuTfjk16S1ld
 yFUtQAqWYjHNwLSLPGpUgB0+t3BpLi3Og8LVVOJER+iRkL23MivvUkHNm4I9/sdkGTg+ag5
 3t9BCZ6dJnnGI8K3x9n2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YXcpkM//nsc=:EA+sBGIgHeMzttb+O/gVNu
 kwsXp8WSMrvA0OPVWC5d4ilFAKk3El+Pr+EJywwOxCzN87955hhnkdflCdg5FpiueZ41oBCSK
 F+Y3XWiyCwobLvK95kbcfpOiw6JX6L6MiXjeHm/k7/xYGRll+8Ugqi9UlhP54JGdZSwGAZEdK
 KxYmVlKnpl36lfyT1Aiu6aOH5MbkBOp2rOGw4+Jr2y5OfBT+NDCUyK9A98EWs23Wcia3ldE5p
 7IKwe95yCnk2W56K3ApnhG1NBZG0tw/5OvPPv4N3MDO2g6VOkY8BfFxO1zJIZY4QrbrakG62s
 7M7fv1pynwgExrCigwMEWSsR7OAQaVa2X0d5qKVLEI1QqYDvYAAaxvAXriuRpUSSpUKjX69Rg
 luEn38e8Sc2XD6OO1MDnL64+atmD1FAL2xIetI+FdTyk4ZUa9VwHaWIwFc3NQeQX++W+4SYkq
 JCM25CkytZwNqE5NgI+TEgKT3Gvt4pAfXvi1hlYj9lGoeSMrIWmo/YR/aMBH8zKG1dhrrs0JB
 SRYd0mVLuZ7GQ4YU7tDzIScuUeXmpKfUXQnRJSVgnp2MnvQVGlqCZAwzkN7iAgt0/emy7cdSi
 mmDFzxjDrR+qSSNvygFDrYmTCcXM84B6Ea18xZLG83NMZ/0U5GfD06NUWSHctOPFMTlibJjTo
 zcRQny3hBrtYvhiKeRE9H08Q+v3IXdNapRI8eejaD5psuhcSnCut6jAh70HerfHqTF0561Irg
 cRhCm+DbyD+62+TXKXLTYwCUWFrxUgtBbmKnbu5iD9xx4G54j/g0F1/z1610Cf8ODhNWpFeWZ
 Vhwf1pnp4TcYE0Hd9L6SiKTVg0BVttKMc1zy3RcQZpZrSTTXkFHJFqPF6Rc0YwuRqyN77heqy
 eBY3N/7IOsAKO21I9mzqBBP7sOYGfny2f1W5mseOlRAjy7WwRzeELdfKO38dt3pNkm8z2K27T
 aeiPXBA21DCFssS+4N7WQ6zNT1CvVVKLYzLTkwoIS1tTRbG6Lgbo7N6owasqmlQrkbGYsVuJ4
 1bsToFAAuB30Efc5qY1PAXNXhuAfqLPU/RDLguivuug3vZpNZNwsI64+WtRmw7aPwGCRtQjY1
 cqUowckoFy+IyNkxwt8tO+CXg6Eg3cVbqkeTY7BOdmAYS/qkpUeEeBgHA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes some minor issues inside dell-smm-hwmon.
The two patches change some warning messages to be more
informative/unambiguous.

All changes where tested on a Dell Inspiron 3505.
=2D--
Changes in v2:
- drop patch which caused probe to fail when cooling device
registration failed.
- Change last patch so users are able to determine if any
features where disabled due to BIOS bugs.

Armin Wolf (2):
  hwmon: (dell-smm) Add FW_BUG to SMM warning message
  hwmon: (dell-smm) Improve warning messages

 drivers/hwmon/dell-smm-hwmon.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

=2D-
2.30.2

