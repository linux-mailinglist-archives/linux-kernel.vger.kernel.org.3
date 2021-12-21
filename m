Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8E47BE72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhLUKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:50:20 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:52030 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbhLUKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:50:19 -0500
Date:   Tue, 21 Dec 2021 10:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640083817;
        bh=ZEcgOMvHY47msIgqhP/3pIODSeXz7fi5u0H8GBjNuRU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=SBHvptVIkapHe/jUeD2AGv0WbAC6XHW+f4xSrxSlzFfAHcK20X66045AEcJWTFuZf
         XoHP/hJdsVROErcXFpCRZJruZCB5ft3vTkCmHOU1TRlZKLDTkFA6sRLUW59CfJcbO7
         lZpaDMEA/XQg2KLgr+p5S0bvjGHBZDERfEZ0Fe5hxH7q/JRar5wkOoYRCBQLpYsVUs
         kuSM5atK05eywQ1J4mUbnWLJMw7C2k3kI3IrNKeXApVYZEjTCcK+cv8oICsiUhW1FZ
         JTIqQGkYgmkEQSp8bgGV2yJLBJcHXulBTF41OpkArAtnoPgBqTrPLjbQBENpyt8O8u
         vYHiAj1FaNi+w==
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        freedreno@lists.freedesktop.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        tzimmermann@suse.de, sean@poorly.run, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/3] drm/plane: Mention format_mod_supported in IN_FORMATS docs
Message-ID: <9_OAfk8h0URTETEHMPKLX0zP7-pirLOCmv0iAiOCuRRcuuVRBjYBXk2YWAAogEANzumyffgjeRZD0nGtKTk5AeGdTLsN5Q7gVnQzr_x45WA=@emersion.fr>
In-Reply-To: <CAA8EJppMsqot1isnMYeSWVJm4tC-PoqUDL9jwd5HJ72tca0HQQ@mail.gmail.com>
References: <20211221101319.7980-1-jose.exposito89@gmail.com> <20211221101319.7980-2-jose.exposito89@gmail.com> <CAA8EJppMsqot1isnMYeSWVJm4tC-PoqUDL9jwd5HJ72tca0HQQ@mail.gmail.com>
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

On Tuesday, December 21st, 2021 at 11:48, Dmitry Baryshkov <dmitry.baryshko=
v@linaro.org> wrote:

> I think the fix should be applied to the generic code.

Related:
https://lore.kernel.org/dri-devel/t1g_xNE6hgj1nTQfx2UWob1wbsCAxElBvWRwNSY_E=
zmlEe_9WWpq8-vQKyJPK6wZY8q8BqHl-KoGwS5V91VgN8lGIl3PJt7s2fkdsRd3y70=3D@emers=
ion.fr/T/#u
