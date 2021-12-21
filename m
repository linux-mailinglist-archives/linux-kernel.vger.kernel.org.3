Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3447BFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhLUMuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:50:40 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:41403 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:50:39 -0500
X-Greylist: delayed 7221 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 07:50:39 EST
Date:   Tue, 21 Dec 2021 12:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640091033;
        bh=7gcclE6TcAlSC7JYqTkNySi57ryYwSWINX7R0nMpD5E=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=Ycmm3GUESwV8+w92bwSyXIx+xNsupOHp+UUSmUkGWEXjPLaR8ta356CiC3fpkFx2f
         3xY2lvgVc4ThL7SnL8bCLwvCVhySBU6MADv6nVptNJCAu4Vi7AAGiJeZXv8rUgbh60
         +71YiClgMCfBVGyPX7KfcP/fpeRBiUK38QDOkaSQND9WZojaubve1m5sF2cieb0YVj
         hoolDm34LJ1Qvc1y+vX5tIS9JavXfN+mJj5VFHCTP9pXRV0QO2C2GuhoGUOXHGQ7UN
         OmTQ7oJMg74pvc1t+lM+jU7atn49HZVegSX+pKMtl+cLaitSQDxhS5v2RniVIworeL
         T/9X4GR1NmanQ==
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
Message-ID: <zEXvJPFVMVjCARLW_PC1SWMnWn5sbkbHy6SPAyG_sv-iWXEcFIagb59MZorV_yjb7WYPlwcnNeKky4vTnnAHdDe8pY7UVNd-y8pN21TSdtY=@emersion.fr>
In-Reply-To: <CAA8EJpphECjTnr=EPaToxeqoQshSt-aF_41mEjO41GukZqbvTA@mail.gmail.com>
References: <20211221101319.7980-1-jose.exposito89@gmail.com> <20211221101319.7980-2-jose.exposito89@gmail.com> <CAA8EJppMsqot1isnMYeSWVJm4tC-PoqUDL9jwd5HJ72tca0HQQ@mail.gmail.com> <9_OAfk8h0URTETEHMPKLX0zP7-pirLOCmv0iAiOCuRRcuuVRBjYBXk2YWAAogEANzumyffgjeRZD0nGtKTk5AeGdTLsN5Q7gVnQzr_x45WA=@emersion.fr> <CAA8EJpphECjTnr=EPaToxeqoQshSt-aF_41mEjO41GukZqbvTA@mail.gmail.com>
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

On Tuesday, December 21st, 2021 at 13:33, Dmitry Baryshkov <dmitry.baryshko=
v@linaro.org> wrote:

> I'd still suggest to fix create_in_format_blob()

Yeah, I agree. I thought there were a good reason why create_in_format_blob=
()
behaves this way but can't find anything in the Git history, so fixing it t=
o
behave as the documentation says would be best.
