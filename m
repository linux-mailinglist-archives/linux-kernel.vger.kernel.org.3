Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066B55D341
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiF0TGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiF0TG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:06:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD52633;
        Mon, 27 Jun 2022 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656356779;
        bh=R/qipisl2syKO7HuuaFI9NW1bwuOk9k4IT6q8rnJ5lk=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=Q71SYLwhvUoc4KOpTwY6mHTTSQyPMrWJUti8DJKu4PJHYh6ac197bnFKGlDB0S/kK
         iSBgMY5ZcQr22X9qNE23HSDKTI+i0icxFziOhu6RVBkPDD5if2I4Qp5ADEHJuT4686
         df2tS1uEsCuwv55r57Qbg+Y3y1p4UaN2aV+Wq4Hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.176.39]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1oJZ4C3b7a-00MdAn; Mon, 27
 Jun 2022 21:06:18 +0200
From:   Helge Deller <deller@gmx.de>
To:     mcgrof@kernel.org, jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Update file list for module maintainers
Date:   Mon, 27 Jun 2022 21:05:51 +0200
Message-Id: <20220627190551.517561-2-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627190551.517561-1-deller@gmx.de>
References: <20220627190551.517561-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GX33wLBAVhASID2agrbjDjTpqdYIF8ASsWJcP8T7Q0fCa6QHN7S
 VEk2mh6wNObAhpyPImperMU+qyaY+HhMEPSS0tpUovfPCT/++P28oz9Arm5PrMqHgIvA76q
 lB9l+TafR0otFi/CJcvBFV+C2NArNJd5hrrYYPpSw8Wz3zWGNiTh1O8h/y2BzA6cw7m27MP
 jBmK2glRXhbpD2Lsq+9jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5aw0eG7G8b8=:rDHNEVwKNUkgHyGGqy853X
 pGJvpL7VVKE0kug0/VobqDB0R48sIVHfVjsZhxYiL9FMRJWWP8HrinmY9TtFihD7xa6K9ax0v
 eCwJkOj6Q8t15vak/lQSAZfaqq6dDAjfiX8kHyFgVBF97TavhVi3a8vr8JsUU14vrBUtmvbJw
 fr05nKvFQMRlqwuzrNVX8gR5Sr53MLvvIsqnqvN/Lf9MF4TD3KacxS+ljE01ZhqC0/8v9tp0f
 AyRhqh8b2HT495aI2UyzNS0Y/jshhW64+gTZj9gH+5m87ISRJ3/V+d07O7gGCR9mjVX09TlUd
 ZAhWyAwb6ZmbXA+P6i7p8fIiUK6yILUK7ARwy/1hrEcAjkQ+uLYEECqO08CclDOBSnNnM7Hrq
 bivp3apjYzAGRXhvAgHh+XPiAR6THjsN6KvLrls74TKDrLWeeGmwsi6zsggZ7ByWZj9kMqRE/
 /fvdWcMh1kO6eqPwRd0bZfx4RKcIzb5d9JZccpHiITKdsT4b8KaMKklfPkPnaEPzGaRFKpQK3
 eDQLdzkfelJKHoDAS2rRtUOh91JbeFwdBc/3A2zIzRXRVIkAtcLAniiKtF5u/uGxmigA4XPDl
 UGweKxUmxHb0Ia73Hd4dewDMh3tijwM/uGKPHMhcxapDgT+KU+Pu2L88HqyKU+2gkub50LGhN
 S+CveWmJkjln7D9h6oq0kNTx6lH3Dl8s+H8iWzrBHb3LffUOGu1X1ojsc2GmPDFvgd1vXVKW2
 AI+gUFqZrXQiV3/2Xv7YHc3jII47cW0tBQ94LXb6gDnTbJED2D1b1K9q/4gBeT03XcPYva0dY
 Jo85H5Hduj5veesShItRalwWZW790ojtELZCSqCqY4wMfL+WsedsrnnNc05/j3/CkCBmT7fMA
 1gMSfUw/T6Ix3UvCKFllXcwkkmzuZEcRBGdw9/YF0kfesKLKniTQGYzvCLKFipizLb7M5yL/Z
 f8P3O8/cgLF8DJm4cN8Ts9J9O03G4Bl6KKOW6gK5X9su0aUyn6OOeRq3ofOw77zlkFKA6WAWQ
 sJlxlmnk68j95b4PXWt9Cx3nvEc40PdKAYbBzFQHhX7Si2NZkbYw/BmpggpCaQH505cH3RDD+
 jU5EbSe1SugF4L6NrmQIFbqR30o32G5dFxjPzVKzQX/v9+I0DsK1p+p5A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scripts/module.lds.S and scripts/modules-check.sh files
should be maintained by the "MODULE SUPPORT" maintainers.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..6073fc7c0fa4 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13471,6 +13471,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git mod=
ules-next
 F:	include/linux/module.h
 F:	kernel/module/
+F:	scripts/module*

 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
=2D-
2.35.3

