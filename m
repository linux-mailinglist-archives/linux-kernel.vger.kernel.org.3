Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267450487F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiDQQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiDQQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:57:48 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3D10FC2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:55:03 -0700 (PDT)
Date:   Sun, 17 Apr 2022 16:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail2; t=1650214497;
        bh=K75n7tetrOKRlGjQ46y3bGIhPuBevmYSEPZotZ2T/p4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc:Date:Subject:
         Reply-To:Feedback-ID:Message-ID;
        b=lnuzA17Id2zUl0X6uo1SjV1Eag15LzOjLg62DFkbD5xanjk7IEFQsmmiD/sBqbQ8q
         cKASQyVQbanTZ3J/j7dNc5Y7C15IWs7kf2BgrxfroUu+JOESP9UVby6rAzOo1Lu7yJ
         vMuAofoapAlhCc9YLOdgYcfB3NgUtZ+nKtj9GZQdN3LMWIN/mWwTpR3OsYwV05fmjG
         vwFGWK9onY5Cq/+LzKC/u5E+0PQCOAyQCpnwOnRGLXLcuznvogrTU3QXJTutO8ckkc
         bUgekMduH369URQemqgCw+X6RHkp5LnOUM+POFrgUZ4LO4P5wviZvNWnMSyNcFoOmk
         q+3GnpPT9cVsQ==
To:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.alaamohamedsoliman.am@gmail.com, gregkh@linuxfoundation.org,
        florian.c.schilhabel@googlemail.com, Larry.Finger@lwfinger.net
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: [PATCH] staging: rtl8712: Remove unnecessary int typecast
Message-ID: <YlxGTMBsLqdOIrpC@ArchDesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of the following error from checkpatch.pl:
WARNING: Unnecessary typecast of c90 int constant.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_linux.c
index f1e352b7f83e..36f6904d25ab 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -659,8 +659,8 @@ static int r8711_wx_set_freq(struct net_device *dev,

 /* If setting by frequency, convert to a channel */
 =09if ((fwrq->e =3D=3D 1) &&
-=09  (fwrq->m >=3D (int) 2.412e8) &&
-=09  (fwrq->m <=3D (int) 2.487e8)) {
+=09  (fwrq->m >=3D 241200000) &&
+=09  (fwrq->m <=3D 248700000)) {
 =09=09int f =3D fwrq->m / 100000;
 =09=09int c =3D 0;

--
2.35.3


