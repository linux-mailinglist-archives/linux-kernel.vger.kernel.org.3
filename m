Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF548EFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbiANSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:12:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:59769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236802AbiANSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642183948;
        bh=BfT+QXQondzq2MdcCIjBYr2wbp9CQ606HkEA+VJrpaM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=OyLa6aXFERPG+wAnPEzonDwd5okKrOXtRCfk1yDbGk/oFLgUy3nXBKm/XEjB1TS1z
         spdRg4x7LEXeVr+HNkM3id9pz0AWcQKRVwruNpL7EOULk7hTPr8tPZIjaUQ5gocYpA
         ZN02iQe/s2utpQhxqEAPhxi093H7oZPGHNnDeYlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.186.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1mnYAi28xQ-00VzJu; Fri, 14
 Jan 2022 19:12:28 +0100
Date:   Fri, 14 Jan 2022 19:11:21 +0100
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <YeG8ydoJNWWkGrTb@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:U8AySo36viW77ZA+cTW+h6saPqOmnFC3bwCFYOxUzXGXX3knDVl
 i9qqybvIB/2E3qrz8jDtRQdRcAcjEAa05/653by446WEP4yljRIwDQ97ta1w22qoUDefIEW
 YxiYXMZSnScedrA6obPgqq+rL3aA6kWVFpAq1Gw32hMe5ZPPFvBw+xNUozqO2PKPlAhyMVj
 TBzp9LjSUvt6oV+4qz9qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E8Zc6+s8G5o=:HQGNleRj26OUA3Mh3rlRV7
 LYmyVrRWa4canrQxQYCaREImbO9dnDduWrGj/9QXnFk8ofgN1oHO80do+qIZVz8NjU9cMhWKc
 bQ5x7Wp9ubHG/ySjqqnyWvm6seAoaQeYmIuAueh9f5JbPVLl3s8pKJvXFX8D+3FLkl6gGGPgd
 mGWH4OLry4rRe1Z97Cd6GTm6vPvbJ0R4Zqut1ZWdh6KtL2yhamWRj+PHnSypHsZcgRFIpxIys
 zoIGm4cNdNbUvMUVt1HxptXJe/U7TVa7ZAfs7EnTsnDxQTPkO2bZ0OOG/t5J/y8oPjoJMD4o1
 4VBkwQ5ArxnsamgZ75xfZl42PqurVberV4G8swfnScDxS7JNfG41gWM1Sg8kCocMUZ4o7tuh0
 bJ81JQt+4vHv1R8WWi5lKfjWS8gEgJ9dW7CBbfWJrZ7j6lZBAbCRQFmcfUMPsnYtav8NUPHz3
 WsTXG0Mz4sfR15PdWqApNrzn90diERvInOl0rBm1/Lz9t/hgpPe/IyZnzR+VbkzOCuR3Pm8ea
 TxgSuQA0unV8tNiwMwk/9ShKr3Gsyn4GyfMc3m9UhpgRxJeQH3+wsJkzhCgdtu8YlOrHSXJG7
 ZCHv4vj8B4nC1AeMY7MuwtEMTrUYMXbhYVgpBvUmr9HtMF7UFrMFdviWYiACHzB1vCFi/mgrA
 U2VgjnB9P9garj8bbIoUQ+rMjlej9LXVClKH+3UXOXqOCO44RZ2Bx9VDNe+iZ/jDi8PQeFzBW
 13A35uQ9YsB/TvxMI5W30EXW9KWPXVdXCt5gboaTFWnPKfLPwa8Ko8pQPIXKYt1cLA+jLJrVS
 bkDk7gScowwBPVL6izJIg4TjrACJIKYMeT2CMMxIlpeRM5zpfgcGiXK271mH8Pn3WhwZGLaEK
 JnI1conPnNdJQ7KREIHnHivKc6u5bmN2WRgma6/YKpsYWpsnfhHnDk2gr83Y7FUplmC/QZG6T
 dEkPgQtYKpkDWIeog7jbIAVdQTfmxlLnYdpgFnzlw6nweFaOmERL1iHFiMDRtlWu/a8ElGyIV
 UVteo/sajHbN1e+Ngzb9cxiU00IUkM+m5v8fNgD0u5V/7zcabkLREhmjFq2olIZgduyqouw7v
 PmHPnwHXOGlQ3o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev layer is orphaned, but seems to need some care.
So I'd like to step up as new maintainer.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d0cd537803a..ce47dbc467cc 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7583,11 +7583,12 @@ W:	http://floatingpoint.sourceforge.net/emulator/i=
ndex.html
 F:	arch/x86/math-emu/

 FRAMEBUFFER LAYER
-L:	dri-devel@lists.freedesktop.org
+M:	Helge Deller <deller@gmx.de>
 L:	linux-fbdev@vger.kernel.org
-S:	Orphan
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-T:	git git://anongit.freedesktop.org/drm/drm-misc
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.g=
it
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h
