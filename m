Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D964A80A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349603AbiBCIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:50:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44736 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiBCIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:50:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD3361889;
        Thu,  3 Feb 2022 08:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B5FC340E4;
        Thu,  3 Feb 2022 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643878237;
        bh=sCovqp/LVTNAY55LPVwBXo9M2vjhcuupN49Og7ndHOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PscAmiMQQh/LAwSnOR2Hx/QobSPRVEjzv8xVkIAU8KmhMgFSDquRJDgj8vEt7gqg7
         lzOSornWD2WbXflu/64XWLujgU7qquHEHQ1XFiPE738mMFPnsZu9dLExJx4ic+DCs1
         Tpvy9IrAd8V2fnZ2Gn7g6Ws2kIeziKGw3nVf/ncc5o47+YoiGy9ZCyk4saFxjlyR8q
         SSCmSrdsZtogivh7nsxdSF1okMq+/11E5VX5ZPn3o2qtTgC9y8ZZKkpQ6eHWjeV3WM
         gcQCMGd8dJVKaqjSvLmIBlUcKARzYiCwNUfYCSagConwybnuBx1778Hs5e92uw3xqb
         9zOccEn7sa+3g==
Received: by mail-yb1-f182.google.com with SMTP id v186so6836718ybg.1;
        Thu, 03 Feb 2022 00:50:37 -0800 (PST)
X-Gm-Message-State: AOAM533hCBjy360wfx6dWjoBuWLcx7eenefHB9osCssKI8O3lqnhQhE/
        CahZcjbp5Hjr144p8qhx0I+330nnh2jKVxFw7iY=
X-Google-Smtp-Source: ABdhPJz2rKW+6cJx7IEZ6y4WcndcGsOtT6b+W6v6GwyrkBFEapQckp7QFKUxvL8lVgv5cGNlZ3EXEHt5rAkHNmvxEaY=
X-Received: by 2002:a81:4b4a:: with SMTP id y71mr3698140ywa.418.1643878237062;
 Thu, 03 Feb 2022 00:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20220203082546.3099-1-15330273260@189.cn> <20220203082546.3099-3-15330273260@189.cn>
In-Reply-To: <20220203082546.3099-3-15330273260@189.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 3 Feb 2022 09:50:23 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfN+Ax8i_Mcax9LfbSG8VwM86YgUxuRUfSF_YEx4z0EaQ@mail.gmail.com>
Message-ID: <CAJKOXPfN+Ax8i_Mcax9LfbSG8VwM86YgUxuRUfSF_YEx4z0EaQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: ls2k1000: add the display controller
 device node
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 at 09:26, Sui Jingfeng <15330273260@189.cn> wrote:
>
> From: suijingfeng <suijingfeng@loongson.cn>
>
> The display controller is a pci device, its vendor id is 0x0014
> its device id is 0x7a06.

The same as your patch 3 - these are not bindings.

Best regards,
Krzysztof
