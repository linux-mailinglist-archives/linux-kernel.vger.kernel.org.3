Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023944AA81E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbiBEKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:36:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:43717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbiBEKgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057392;
        bh=9H7cICTDVgmHRDhmL0NozmHU5f8YJKtTFxCCe/KGh40=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NVB+fEecn9aD2SjxQUwmZcZP+TKWJOxn+fRuJbLTYMn4Bbrx99P/18MAz0Pb5GmUD
         E9k5bu5P8tmmrW5FQ7p+xzz4QgqC07h53OuVs3lYa6q4WsFpiXUnDwT1Q3Qqu5zJjm
         Rs1hRclJX4VDZ34U9yQSZ7qRNusrGXK14xldoh1o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1nGIQi08WW-00035X; Sat, 05
 Feb 2022 11:36:32 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/7] clk: Declare mux tables as const u32[]
Date:   Sat,  5 Feb 2022 11:36:06 +0100
Message-Id: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/h8Kx3Dp4vLgS/DLX4PZl6iFN/6UxoPSJrqjjZuVVAbXZ1DfIzT
 COIlkuzULvS4se7nqwcHAy4umtKBjWe+edlH7oREVi+hn4q2YU7LmZOJB+ZUD9c43c9qD5A
 rQ/aCxpAVqCDdiOw4JrCZIkJrUh9eJPXcOrnve/wJmBMQIJ83jnNm97le/CknVgl79i4p3F
 +6qT9vBp/c6XNJM64CntQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nVrT49EqKyg=:nB/1FQAe4DYQGi5zTS0X8o
 8qB7Ctid6Wt6dVwEXoH6gy2kVxVU8crSufb1ixQuYCr6yh4ojo/2nvr5yz08pWptnVg372mFU
 AdqWEqzq7lzBfvhVrMTXhGdtskURm8N2ahwKK1qgOR2ggw3zwrlfxgxAiUuVvQJQf1MluU0dO
 xufjQg+7TTO/5AEdDHPYcERV5I4sYgM0LQxETolCifr9bI0Eat03r0IDAuvd289wycEqaXu/d
 ZRLPbuSYiyvEX/591VStr+NPt/KmJhFLcnKO3g+DvszR0nOS67sXwZJZv8IFlATnlu0XgUXZc
 NM2DudVYVB+LkCqNUwMLXqam8pJnPihGSkZ0KJmcLElOj9CCwsjy+2cR5S+iFiwp7SmJmQmP4
 TSDRyCHmunMBLDfkGJumHLsKM0s5Tl2ZKBjE2zBVgt/1tps4Q+JU3NueRzN1T2y3w3qocmoTu
 M6cnccx6GiLNfAT0aBnPmPmjJ284HOPiAhr+VWOwl+bNJcOHVVjMlgRANIBO6XpF10tuR+0M6
 kGMbvV8fr4kid2Qy70mTghUHzPY9fX+GaSU5S8wmExEJA1Can7c73fHqOChO7yM0ghQt8tPp0
 kXkcDlazSXynLiBrT4ydSOewv2mk7kL3MOqjwbQULu6upX2tAEUJIBcqOSCQKLsf6dpT51fSl
 bVVamMCrZEvs5YqEB1hXFbWPpP2oE3j78DQc1r12/Ci/xMGhBFPXQ1WJUmDrv6esemHbRWqH3
 YMzwz/ZONDBV4Q16Z8/x/t/v76vOPRvS2Vs7pPL5ZPnItfPb3ruEKQoqZsaVvDGMU7ackOEXF
 pZHCnSAe+R/DrQjhJqRv0dsitNMm+KkSxnk9f9WolzUtnEZnixJpUskeldkO806CXMzx4UOhz
 g/Ro8rfGsSKGSWiYm8kAclldord99xGZ4HhtV5PgaGPSsGdnvdl7lD35L+6awmiah4A1D3q9Z
 6n46DOfUhj5jbPSRJykr2Zf9+ZevY1/hM4IunA/96xn+hRLXst8WGiud4m+BYfk71aPl3mSTR
 BTIg0eWEp4yd64dUL/BKnakdfTly/v0814YzPrbnhWWW1boGfhhaaRmAmwk1pTkP9ybH+uXBa
 8ufIN/iHZwf3a4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the 'table' parameter to clk_register_mux_table is never
used for modifying the table elements, and so it can be declared const.

In version 2 I'm addressing two warnings in the clk-lpc18xx-cgu driver
that I previously missed.

Jonathan Neusch=C3=A4fer (7):
  clk: nxp: Remove unused variable
  clk: nxp: Declare mux table parameter as const u32 *
  clk: mux: Declare u32 *table parameter as const
  clk: hisilicon: Remove unnecessary cast of mux table to u32 *
  clk: mmp: Declare mux tables as const u32[]
  clk: qcom: Declare mux table as const u32[]
  clk: pistachio: Declare mux table as const u32[]

 drivers/clk/clk-mux.c                 | 10 +++++-----
 drivers/clk/hisilicon/clk.c           |  2 +-
 drivers/clk/mmp/clk-of-mmp2.c         |  4 ++--
 drivers/clk/nxp/clk-lpc18xx-cgu.c     |  5 ++---
 drivers/clk/pistachio/clk-pistachio.c |  2 +-
 drivers/clk/qcom/kpss-xcc.c           |  2 +-
 include/linux/clk-provider.h          | 12 ++++++------
 7 files changed, 18 insertions(+), 19 deletions(-)

=2D-
2.34.1

