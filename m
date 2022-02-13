Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D54B3E59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiBMXNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:13:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBMXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:13:06 -0500
Received: from relay.hostedemail.com (relay.a.hostedemail.com [64.99.140.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084554BE1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:12:59 -0800 (PST)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 36BD822BF6;
        Sun, 13 Feb 2022 23:12:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id CAC7320024;
        Sun, 13 Feb 2022 23:12:49 +0000 (UTC)
Message-ID: <3141331e10cdbc7a3859887d5e8038eff777e3ad.camel@perches.com>
Subject: Re: [PATCH v7 7/7] MAINTAINERS: add maintainers for DRM LSDC driver
From:   Joe Perches <joe@perches.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Sun, 13 Feb 2022 15:12:48 -0800
In-Reply-To: <20220213141649.1115987-8-15330273260@189.cn>
References: <20220213141649.1115987-1-15330273260@189.cn>
         <20220213141649.1115987-8-15330273260@189.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CAC7320024
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: chsen43n4o61gbue1shux6emhu6imiza
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+3MfhZMV+dCCy7Z4SG+v/Vjs/O+3cQmPk=
X-HE-Tag: 1644793969-740389
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-02-13 at 22:16 +0800, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -6453,6 +6453,15 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/lima/
>  F:	include/uapi/drm/lima_drm.h
>  
> +DRM DRIVERS FOR LOONGSON
> +M:	Sui Jingfeng <suijingfeng@loongson.cn>
> +L:	dri-devel@lists.freedesktop.org
> +R:	Li Yi <liyi@loongson.cn>
> +S:	Maintained
> +W:	https://www.loongson.cn/
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	drivers/gpu/drm/lsdc/
> +

M then R then L please

DRM DRIVERS FOR LOONGSON
M:	Sui Jingfeng <suijingfeng@loongson.cn>
R:	Li Yi <liyi@loongson.cn>
L:	dri-devel@lists.freedesktop.org


