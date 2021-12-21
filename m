Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B321D47BE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhLUKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:33:07 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:50119 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhLUKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:33:06 -0500
Date:   Tue, 21 Dec 2021 10:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640082782;
        bh=pXB8OtEXG/jGofY2Qa9yUBavX37a5hZrYWvWrLa5VZU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=xBoRwSPd+6DJPTYCvqswpH6Dq8sR6EItvUj6RLNR6dgugH8pxKLemZgoR1PEzbSM1
         I/ByCdUHEYd6KlydLypN7g4JoZWdmIvg53M7d5ViyoqBbNvjszgAtd+fQ8OW/AwgMr
         o8OgNADy0hDEoD1i8jlo6Sf9/FPzOqyWcLzHt4rlxyvTygBp5y3unVsLXSPTWuhIQ3
         HQvctBehocbc9XKtTTQ3MXb8lk4EsMo3ey2R5SP3NDzEF6hs6PUz2NzlcXemS42Vpf
         n+aX9BhuyA9OnpIpxbOQsVi/b9EPOEURm2Lr2vgHXMxGFc14vjTE7Y0NB1374cJHle
         rqxXkFL6adAow==
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     robdclark@gmail.com, freedreno@lists.freedesktop.org,
        jernej.skrabec@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wens@csie.org, maxime@cerno.tech,
        tzimmermann@suse.de, sean@poorly.run, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/3] drm/plane: Mention format_mod_supported in IN_FORMATS docs
Message-ID: <goOOXRPhPVm7JnHxD3xB6AeyPfmtyR9whCUnuDXyKv1uhyy1cAUJimC-ITTEFI2m8AUuINYGRViCjFVavsXEKy4PILOJiGM_0031fi900tw=@emersion.fr>
In-Reply-To: <20211221101319.7980-2-jose.exposito89@gmail.com>
References: <20211221101319.7980-1-jose.exposito89@gmail.com> <20211221101319.7980-2-jose.exposito89@gmail.com>
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

Reviewed-by: Simon Ser <contact@emersion.fr>

Please ping me in a week or so if nobody objected and this isn't merged.
