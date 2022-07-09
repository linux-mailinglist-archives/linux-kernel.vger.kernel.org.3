Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2C56C90E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGIKnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGIKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:43:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81769BC98;
        Sat,  9 Jul 2022 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657363417; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZm4gVWjiDEO5u30RuW6VoyxTvmlC8q+Qpm+4tGQ74c=;
        b=RGYSTeN8yc1avmOrmXEF+5G8x0qBiLTYlaLGRTfv0Ur08nsmZIN1nQxFVg8sxhc5jgT/23
        IAres0EXXDFv6C4qMzlSVyxiRiO0wanAYIP+cvBF3mdZimJ043vuUB+zjwrV/GN7GtooZl
        8qxjC9mvgSbDa8qr4SiG6c1CC4I7nEE=
Date:   Sat, 09 Jul 2022 11:43:27 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/6] drm/ingenic: JZ4760(B) support and random changes
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <FS1RER.IMGKHPGOL0LF1@crapouillou.net>
In-Reply-To: <Ysk88cZO1iQhX/I2@ravnborg.org>
References: <20220708205406.96473-1-paul@crapouillou.net>
        <Ysk88cZO1iQhX/I2@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le sam., juil. 9 2022 at 10:31:45 +0200, Sam Ravnborg=20
<sam@ravnborg.org> a =C3=A9crit :
> Hi Paul,
>=20
> On Fri, Jul 08, 2022 at 09:54:00PM +0100, Paul Cercueil wrote:
>>  Hi,
>>=20
>>  A small set of changes to the ingenic-drm driver.
>>=20
>>  The most notable thing is that ingenic-ipu is now its own platform
>>  driver.
> It would be nice to know what is achieved by this change, I could
> see the code being a tad simpler, but the cost was more EXPORTs.

Well=E2=80=A6 we now have two separate drivers instead of one driver that=20
deals with two different devices. I thought the benefit here was=20
obvious.

> With the added explanation, which you can add when applying, all=20
> patches are:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

I'll apply the other ones and keep this patch for a V2. You made me=20
realize that I could use namespaced exports instead of global ones.

Thanks,
-Paul


