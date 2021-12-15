Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3D475EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbhLORXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:23:48 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:31808 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245450AbhLORXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:23:13 -0500
Date:   Wed, 15 Dec 2021 17:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1639588991;
        bh=T5RefPxZCRBl7q2I8B3Qg3644cjKYhTB6AMn29c9HkI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=cpGnbwtKgXkLjeQACOTemdbumHMZHaEdxOv0baWixaBT0ddxkHMEEw5+qxKC5Ux0w
         bb1s5ltzUjieUVGyVRpYHDGRh2468cTasIODPMIMt98cyJjw5LQL496l4c5tnW6gRg
         vngTwN/CNUsqW/rzXfs2jCL32pdYeg9mwUGhnxB9y3me2RWJlPD2FBqFQP5mgEnKIB
         f0aDeIhsl8UnzHFO4okNmXKaINXJHVWWJyfO5c5xbri+2jfHkm/JuY70eAy2Ot00Jm
         4U8X+m3sNG941PuBzJGuNYxnFCSasrvQpXDqXNeRbVceWIbB/pMpqCzmAAHfcBfgeQ
         WbAabZbgfs2+A==
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
        cphealy@gmail.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/vkms: set plane modifiers
Message-ID: <3jzxPysjC6vyPfQXQoY5tuHmyXNupFZCZ3babQzWfWRMnI8epycdbhcSF12HWKrjojVo97MlLrJE2HGtM7jcliGZXGXUJSkNcAFn5eTZSu4=@emersion.fr>
In-Reply-To: <20211215164213.9760-1-jose.exposito89@gmail.com>
References: <20211215164213.9760-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You'll need to set the format_mod_supported hook as well, otherwise the ker=
nel
will expose a bogus IN_FORMATS prop with one modifier and zero formats.
