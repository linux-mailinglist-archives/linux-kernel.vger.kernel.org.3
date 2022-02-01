Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB84A67FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiBAW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:29:26 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:23399 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbiBAW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:29:24 -0500
Date:   Tue, 01 Feb 2022 22:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643754559;
        bh=MGtp5mMwNn+8qDhigeSXS0uKyHzpDrXsYo+t1ISZnqg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=l0iICYndrhAtRRrRBbQ7jYwKoH6YKKhnrBfLHSNjH7IjZ+TC8QiODbSZ1SxHk0Hvw
         DFDsjKq29VC01r0LzwvdRfAORPmS4GVUgrt9waPKhUhtaqeNq03wWaJSsYJtBpwTla
         XunPVeybo2QOVbgGgGxIwNNpyzNSH5vj0Ac7fVWWtU36ISv/e40HPrLX+XUr94R7F0
         GvWUQmGrTNHucyTejYVfezQqaVmE/HW4L1VKbvx/87SiW3bVlRHkW+sXVNqcZvvEzr
         pUEj9qjNZYW2o2UU+D+mQdqc2E2vZ8ujSj8FmXKPgnLD501TOFva9dO38vCbhP4fRu
         PkJOcSAyPRMNg==
To:     Sam Ravnborg <sam@ravnborg.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Message-ID: <0yOiGD-56rTdV--oDietLeMO46Z8iFNnCNVVRg3Yh9D13AghGCYm5aP67SoswHY7Ye3vc3UEKzgtI02-F6vJ4b5xGLlE5yg6n2HznaWzYvg=@emersion.fr>
In-Reply-To: <YfmeztkVXwZzAwYe@ravnborg.org>
References: <20220131201225.2324984-1-javierm@redhat.com> <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org> <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org> <YfmeztkVXwZzAwYe@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,T_SCC_BODY_TEXT_LINE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 1st, 2022 at 21:57, Sam Ravnborg <sam@ravnborg.org> wr=
ote:

> As I wrote in another part of this thread(s) - typing the patch is easy.
> But I do not understand the userspace implications so I need someone
> else to say go.

User-space shouldn't really use the connector for anything except making it
easier for the user to understand where to plug the display cable. I think =
a
generic "panel" connector type makes sense.
