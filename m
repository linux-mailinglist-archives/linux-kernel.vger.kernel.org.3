Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB054A5D85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiBANij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:38:39 -0500
Received: from mail-40136.proton.ch ([185.70.40.136]:56908 "EHLO
        mail-40136.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiBANih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:38:37 -0500
Date:   Tue, 01 Feb 2022 13:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643722714;
        bh=valyEaCvKP8AYN0OMsIUT594MFxMMOA8Q9u7vU/eGYg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=HAJ++8dKYEbgWakn1yr04UCjsKEwyph33Wsk6UItTqFp0ZS3a8xjeqbsdJcJrzDGr
         y4feUF/RnhNBbVCl3JyDXkDYNWltXAGmzAxECiCcSCqkzsCI6Z7otuDEX94Y7CN7TY
         cQuBnEMgPSIRhqV757BuH6TmECxr7DdX/aE1/4juY524DHHNrmHTUAcdsh6SI3kAhb
         5XOKfHlqatkp1p9EB36YhTPP08KOZo5kJMaL6S3C5G7NMQWWRhAp72S/Rh9R55yiAv
         RHTEfW+2/zzPivL5ufg/LHBGjBASmwcIsJgIg3slHRS3qeV22Py+q3F3cRACfqXNBX
         Z36ISSx+sXmEQ==
To:     =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Message-ID: <vbOCbsYZGDCHDj8wKOHAZ1u2HMTc_UKM5umAyMug7KZn5ABy4sDMMdNOtwLI5kH_ifctnfmzQejqC_HP1vhXNt6k7vEU0WqFVNUwKnibIn4=@emersion.fr>
In-Reply-To: <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
References: <20220131201225.2324984-1-javierm@redhat.com> <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org> <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
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


On Tuesday, February 1st, 2022 at 13:58, Noralf Tr=C3=B8nnes <noralf@tronne=
s.org> wrote:

> It turned out that I wasn't entirely correct here, mpv didn't cope with
> unknown types. In the PR to add support Emil Velikov wondered if libdrm
> should handle these connector names:

Opened this MR to try to make things easier for user-space:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/222
