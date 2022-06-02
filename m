Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70D153B4B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiFBIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiFBIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:03:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA465AE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:03:02 -0700 (PDT)
X-UUID: 0f79148716ee4eeb924a78bfc653f325-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:8d91ea6a-45c6-4083-95c9-4d273f82035f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:17
X-CID-INFO: VERSION:1.1.5,REQID:8d91ea6a-45c6-4083-95c9-4d273f82035f,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:17
X-CID-META: VersionHash:2a19b09,CLOUDID:50f727e6-8995-4bd8-9dc3-52401047833c,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:1,File:nil,QS:0,BEC:nil
X-UUID: 0f79148716ee4eeb924a78bfc653f325-20220602
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 952207896; Thu, 02 Jun 2022 16:02:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 2 Jun 2022 16:02:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 16:02:55 +0800
Message-ID: <044158674aab0b40d8edcac920855a37fca58cf0.camel@mediatek.com>
Subject: Re: [PATCH v2 0/8] Add a panel API to return panel orientation
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 2 Jun 2022 16:02:54 +0800
In-Reply-To: <20220601094637.1200634-1-hsinyi@chromium.org>
References: <20220601094637.1200634-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

I'm curious that panel driver setting orientation in get_modes() would
work or not. It it works, why not just set orientation in get_modes()?
I find that exynos dsi driver has implement the get_modes() [1] but
Mediatek dsi does not implement. Would you try this?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/exynos/exynos_drm_dsi.c?h=v5.18#n1483

Regards,
CK

On Wed, 2022-06-01 at 17:46 +0800, Hsin-Yi Wang wrote:
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN()[1].
> 
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
> 
> The series add a panel API drm_panel_get_orientation() for drm/kms
> drivers. The drivers can use the API to get panel's orientation, so
> they
> can call drm_connector_set_panel_orientation() before
> drm_dev_register().
> 
> Panel needs to implement .get_orientation callback to return the
> property.
> 
> [1] 
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/__;!!CTRNKA9wMg0ARbw!0ytf4wPxKANnYbw_fgq-eqQARnAXIHv4jwu04ZW6X6dAxZDFsJ0CltY_PvCBAQ$
>  
> 
> Hsin-Yi Wang (8):
>   drm/panel: Add an API drm_panel_get_orientation() to return panel
>     orientation
>   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
>   drm/panel: panel-edp: Implement .get_orientation callback
>   drm/panel: lvds: Implement .get_orientation callback
>   drm/panel: panel-simple: Implement .get_orientation callback
>   drm/panel: ili9881c: Implement .get_orientation callback
>   drm/panel: elida-kd35t133: Implement .get_orientation callback
>   drm/mediatek: Config orientation property if panel provides it
> 
>  drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
>  drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
>  drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
>  drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
>  drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
>  include/drm/drm_panel.h                        | 10 ++++++++++
>  9 files changed, 77 insertions(+)
> 

