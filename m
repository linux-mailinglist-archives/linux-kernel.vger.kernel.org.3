Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAB59B4F4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiHUPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:17:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5222BE5;
        Sun, 21 Aug 2022 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661095038;
        bh=qiFAEB6kLO6vd4/naW3KidfbELsu1my2GKINEWhHBiw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EwuiN9UhZJFzqWKrxsIoUeHv5FtAlnXPWGhg3VvXAUnaMKyj3tI/cfsG9000Tlh03
         vHlZb3jH/E0/Aq+UH079/G9DAuOV7TYXPOturRjUOoUfrAbvSWsY6g8Ts7LllB338E
         W4EE3/dmAuYDAlBoMx/hTwyDMvc2XGf+bQ8qgV94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N4QwW-1pQ21I0lD4-011STb; Sun, 21 Aug 2022 17:17:18 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hwmon: (dell-smm) Minor fixes
Date:   Sun, 21 Aug 2022 17:17:10 +0200
Message-Id: <20220821151713.11198-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9rfTF+/+9RrIhC2h/TLGuZ0tcDzh0C12tVlTQXoXPFePOP3UgRJ
 jpvmYk0zrr5TbTZ3U/JVf46DUQ+sgXZXM5CbjUndtkBBEBW7pa8i5Y3t9+N4D8n7ls7egPy
 pt5IllEzz315IHsR885vEps25mqcuuCNlMbAMdqtD8o3U9tu/kBIbqTBel1hxpW5/Sj+zN/
 aX4MzdLaL57AXhIJJl5pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0c5Hh79L9A=:6ft+RkrTLDw3t3oW+OhpOC
 pwGi5f0nif4K6P+vGObAqIyr+B3hDiY4vJpJZRdGv3CgDQfg5pmTrSPYkQSksKL+W8AfiRGD8
 sQdjuSXuuN2gTmqj5oExe2ZpLg8RDoZSCv/fDQcV9NT/2PdXISTHPKFUOedd7G4qOpddr6M2y
 x85RYYANxCV5q34RYaBiTFZUIhpbFiVtLL5f4IoeuRhWGH1v0U0RrkfBXIsms3NTi78iaVplL
 sqAy75Fy0NzzltmyWCvLjhRIMPBC1nm0wLGl9mab2wuiqY983Wt4CaXNah3IHpayUMJY9ediA
 wZUMNm2RdyYZjt10Y06n8tScYsffE9j425r61LRjwL1jWvnI5kMSWbNpA6urIjNUl2v67DE0T
 PAR6WvKigzvZXfAGJQ1VhRwRZlFTyBOGBHbgaevsvmj9h3gsKBupfd7qLieaXuYkz9Ar0073Q
 wfl+uE7xN03L2Os6xJGteWH41LnDxIcluxE89TJNyXf/wd1OYziQwXcpPwBto29SPy0YATQsA
 1wLtznT/aO9Pxnouol/LQqxA19FGYzproWAyzYi6bs74YQIFPBTVrNFv2dfWnrSXZATdc6g3q
 npERy5t6xPpalk3JoFqJERqktQ9uZ+vHUcAG/S1s2uqExznG+PyumZkurnvH7GnNkg3CMneCz
 5aRau3yWQRwBhrPYmvntN+fvKl+XXWkHvzQ6GWpjPqtIOrc34RnK/e7LkIaONH8KRFklpTxRJ
 +XzaV3NM5ggJKFd1ry4PNCOQE/C31lYlTNer3dUjbRAp1Coy2PfT7nVZeR25VdCJf2JaQk7iI
 Zg92pbD6gEI7T8SXgGEYCN7YN2yo30vHmXm/1hv/Re2CjpZFtB5CN5ROwxFdIVZn9z2LNLxC/
 BYCb8QSTgaakziLN+RKM7Wlg0hG9oddavq/KnBTMUAqNTkmK/yIIZDyfFNIeV3YNbju4ZWcQZ
 3F9WAdfrZpbDQDTorfqVT8pbZ+GWGHphfClaZYSUmr1U1tL09Y4o7pzQ9DLPRe2+2/SzvOd5i
 WyKpah9bQQ8rFsT67trIHoRhQaGC52EuzDXk8U5Is3tmVUFkiSi/sty7ayMdxD65VBcean+Qi
 c+WJeyXLAauLQPzpmClvXGoBJm6RXagJx95UEIb/ApiHLArwfIHUj93QA==
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
The first patch causes the driver to fail probing when registration
of a cooling device fails, so that userspace can actually depend
on those cooling devices representing all fans.

The other two patches change some warning messages to be more
informative/unambiguous.

All changes where tested on a Dell Inspiron 3505.

Armin Wolf (3):
  hwmon: (dell-smm) Fail probing when cooling device registration fails
  hwmon: (dell-smm) Add FW_BUG to SMM warning message
  hwmon: (dell-smm) Improve warning messages

 drivers/hwmon/dell-smm-hwmon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

=2D-
2.30.2

