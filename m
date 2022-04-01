Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D84EF6D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354232AbiDAPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353336AbiDAPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:10:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0C2A4BE7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:52:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c62so3254909edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CDTGg7xmd02lguFcPgMwbnDRM6tHMxG1F9pAwbPQoHo=;
        b=T7W8CN+jz5+aiumWrrsmaS77T+E5scb+pwhmUc7sQ00YF6qeVlR/iuX7nMux/sXgZi
         aoXbT2oN81ea9wAj+fdmjo3mi8803aMoqN5bRP+HmiPDTOHrxU4/qO8cTYWxf3yOu74k
         3YTMVUWBBT6ijr8xnLFMnkty+UNhHPWXYJ4yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CDTGg7xmd02lguFcPgMwbnDRM6tHMxG1F9pAwbPQoHo=;
        b=x0R5vR2BuYPgJO6i0EVNn6pT6Q4KXYCVc9Y4ZpNGmHzNy9VqTzavvTkzBWm/96hkkn
         9ffll40wyRP+MLsGz7HysPi2TCSS1022vQFSZCtdwvFHoteXfgu04EAdk54FuxLp1BgW
         3flEeQ3YiAlhmKGrLLZUZDw7bFlZMUdpzP9B5E2mjy1F4JheXE4EtovleT65jf0nxohc
         /5REPpOU1gV4Mi9zeTWOvR0WcYjF1YZoD1PO/6rgft1Y7rtnfs/GH0Wuhysd+HHry2yJ
         mAvGgau0N+ZtleTIzgOJuHC8x+FAYfFxaRjBqpjdAdiElYS2DCXoSK9YSPX9ZHSQR2IV
         K1ew==
X-Gm-Message-State: AOAM533HxwZASrNYD7m4vSzP3daVLHOdKRdSCbYBJjknAqrwv9/7hLYz
        MIiS2FNtsmRj5SSxoxQMu3sbimzFhvMXbip6B54IrQ==
X-Google-Smtp-Source: ABdhPJwiHgIV7HJawa3rB+bvMNReOkRYBuvb2rbFfBdUHW6q0LcxoVGrpPWP1JWfHYg+Rjf+M7hRjLo0TYW/6FnZzJo=
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id
 f1-20020a056402194100b00413282209c8mr21428644edz.13.1648824763403; Fri, 01
 Apr 2022 07:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220401015828.2959505-1-victor.liu@nxp.com>
In-Reply-To: <20220401015828.2959505-1-victor.liu@nxp.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 1 Apr 2022 20:22:32 +0530
Message-ID: <CAMty3ZC6pLJXP=kxwFeZj6CF87ASvoxz9+8Z-7O+DCNwtcLHcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Drop the drm_of_panel_bridge_remove()
 function call
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 7:26 AM Liu Ying <victor.liu@nxp.com> wrote:
>
> Since this driver has been changed to use the resource managed
> devm_drm_of_get_bridge() to get bridge from ->attach(), it's
> unnecessary to call drm_of_panel_bridge_remove() to remove the
> bridge from ->detach().  So, let's drop the drm_of_panel_bridge_remove()
> function call.  As nwl_dsi_bridge_detach() only calls
> drm_of_panel_bridge_remove(), it can also be dropped.
>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Guido G=C3=BCnther <agx@sigxcpu.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
