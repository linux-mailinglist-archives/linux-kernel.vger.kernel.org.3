Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7A4D9F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbiCOPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343895AbiCOPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:49:58 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA114093F;
        Tue, 15 Mar 2022 08:48:47 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso24865741ooi.3;
        Tue, 15 Mar 2022 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oBLK/WFMknYvKURGJIli6IvZDSQNi3zYIXFNVj9K60=;
        b=nYXBpvzGCEAvTjaVlPXhhHMWazEYvb5pBevKdKZrjbGvbas2C9XkIkGgKnPSBJx/OF
         ujaLhVNXscYH6hsNZWsciYzPdDO19U+K3SxeC0+Uqu+Jfr/qH9xiKYGckvY/7cXtP5lf
         RCA/RZfA0X8TdmrbV3KdffCBCpo/II30WreXLAhARRalIdmIed+r1m3QitVwpy2IwCMs
         62SDjBWk17V+nXt4xMdulGtjv16tb6M8G7nGa9xeZz3/hszDY/5SZpuIF7RnPuTy11BY
         KCRX/TRy7f0oVaCFoDOTllgiJoJBhSP5ihb0GLutPg4qtuU6eqSGqPKLGO6jYdF+t/KH
         HIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oBLK/WFMknYvKURGJIli6IvZDSQNi3zYIXFNVj9K60=;
        b=Fsgi7nrXK27ipj5UmQcFHjj5vt9ZN3n8oVZZogK/OwmgIZW5XF4nPk8HKuvZsx8PTL
         msTGoLk9PzlAYN32vRrgf2jLTM2iszfACnzAO3JabNln4KXS8R4tOcoB4FAHtVEYIMaL
         TzwXeFFlj8xMYPqBDBkO2ibU4Z4nEu7VK07E7nX11S1lry/wNC1WkX3q4y/PYn8W/GsO
         v5FPK10Xm+v7uEbzTTvgfGjVHFzIpQmLbFv+sbkygxUl8bLrdOG20p1/pCJJXbKfZzaW
         hxaCDzhsBs4eu7yZXzU9VCzWBqRLIW0TY3WubO9xo+JSAU408sTD7UyeG2TMuMZlZgWx
         Hgnw==
X-Gm-Message-State: AOAM531O5u/RH1Y1t89ga/BmYsZLLDYNtVv2std9vqMePPVdy7Diw386
        fnBF1vOnnVlvgHAWCQnVVSC119+D+GLKpVU1vY5U98zV
X-Google-Smtp-Source: ABdhPJwpXOt0Mp8zlogrF70BHsQMg5Vyj96T9pKbpTFbnXrM3doKh9nhd30RmJatM32y9hkuDtFUuCQXArbWCE8AUXE=
X-Received: by 2002:a05:6870:630c:b0:da:b3f:324d with SMTP id
 s12-20020a056870630c00b000da0b3f324dmr1816757oao.253.1647359326455; Tue, 15
 Mar 2022 08:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-2-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-2-Julia.Lawall@inria.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Mar 2022 11:48:34 -0400
Message-ID: <CADnq5_OveiyS80yF=COha1iuAmm7NBay1q0JogkqcxqJ7ie=JQ@mail.gmail.com>
Subject: Re: [PATCH 01/30] drm/amd/pm: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Mar 14, 2022 at 8:01 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index cbbbd4079249..5cd67ddf8495 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1870,7 +1870,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>         amdgpu_smartshift_bias = bias;
>         r = count;
>
> -       /* TODO: upadte bias level with SMU message */
> +       /* TODO: update bias level with SMU message */
>
>  out:
>         pm_runtime_mark_last_busy(ddev->dev);
>
