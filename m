Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927754FAA7C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiDIT15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDIT1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 15:27:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBA0CE6;
        Sat,  9 Apr 2022 12:25:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97C83482;
        Sat,  9 Apr 2022 21:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649532342;
        bh=NGodcPcuMgVqLfK/lv7UN9kdDu88L3Dqzl9+IQ2YupM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NRmKL9A7lhYf+PoplZGSUjnG0X16HiM7lQVyqjrBWsezx6Y6oyGDkh3KmDw5+M2La
         pCYVJhBhNx9XeZz7wbBYzsvHqNiWgek1IZIj21F/TTVLsLAeLW42AdHWVud5fm2ugG
         8oEP+LUeldopF4qALrsI66E1DZZdDTRyuGUDNy6g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <21f190a8bb9ddaa43949b4455983bd66b4e11798.1649440397.git.ian.dev@arkver.com>
References: <21f190a8bb9ddaa43949b4455983bd66b4e11798.1649440397.git.ian.dev@arkver.com>
Subject: Re: [PATCH] media: media-entity.h: Fix documentation for media_create_intf_link
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Ian Arkver <ian.arkver.dev@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Ian Jamison <ian.dev@arkver.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Sat, 09 Apr 2022 20:25:40 +0100
Message-ID: <164953234079.22830.17385702287665697579@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ian Jamison (2022-04-08 18:53:45)
> The documentation comment was inserted between the return type
> and the function name. Reunite the lines.
>=20
> Signed-off-by: Ian Jamison <ian.dev@arkver.com>
> Fixes: db7ee32aa185 ("[media] media-device.h: Improve documentation and u=
pdate it")
> ---
>  include/media/media-entity.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index 742918962d46..9bc9a55df71e 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -1030,7 +1030,6 @@ __must_check media_devnode_create(struct media_devi=
ce *mdev,
>   * removed.
>   */
>  void media_devnode_remove(struct media_intf_devnode *devnode);
> -struct media_link *

Eeep. I guess that was some sort of merge conflict resolution that
didn't quite get it right sometime.

But definitely a good fix.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> =20
>  /**
>   * media_create_intf_link() - creates a link between an entity and an in=
terface
> @@ -1061,6 +1060,7 @@ struct media_link *
>   *    the interface and media_device_register_entity() should be called =
for the
>   *    interface that will be part of the link.
>   */
> +struct media_link *
>  __must_check media_create_intf_link(struct media_entity *entity,
>                                     struct media_interface *intf,
>                                     u32 flags);
> --=20
> 2.35.1
>
