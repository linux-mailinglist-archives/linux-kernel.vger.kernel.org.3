Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF459C98C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiHVUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiHVUFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:05:51 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D734620C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:05:49 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11c4d7d4683so14237167fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1naA9vNk3/eH1I9D52GSl1kXImc5DsL+BHAHMfWytNg=;
        b=FiL9UObuk3rpCWubxZ8WQ+aemJSVWBIbauSNQt/grOIvCnzA79D7l8a00R/sJEoeII
         lcMZJgKezXZ5AXKJzJSiFwtJphdeeRSUBzRwFqCiPCQFBAXwJ0//1YeBpwznoBRQhwrv
         CAchVzvYi3Z/R/49n2gQ0GOAS3n4xbdTjcfNWIsrfkiFZs+cl3DOdWFS0qmc5h1gOBos
         z4x8GnKVitthJaWRr8IfQ79VrvBt8z4dowPq45yXpuhQI7XyvUZVZAik77xaDsFZTRk8
         2UiRHMJo6tiLzthK8QEdovMA1tboLi0ey97QxHLRypsUluIr084U21cdg41j9tk8SiI9
         Vlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1naA9vNk3/eH1I9D52GSl1kXImc5DsL+BHAHMfWytNg=;
        b=LP7IUuNOLm7l3TJfguCsDx4nqXsP8cJBKn1ClkrTFqiCP2tSrOtnTaal7JbK3WBjVe
         JZK3E0vaOuzAoXtd4LIqQwgRNXOE+QdWK2FIYaUKfeZw8lpAOHvWt9JVQMI6cIayHB/w
         2IZSYVuR98kHSh54gtFwadRUm4rj06lf10hRNhbYY2JabofnbqAvx/1XJaiw8UtI5EhW
         xFS987IFi46Lptrr6ewpcGa5O/ZCe8Ve2xdyZ1IYVwDaSNqJ6ZBsz2OlsdtdAOU5K163
         DBKaXrRrwhN8R29UaVBF08JhRKM75XUT98ZnjhfX4gfZgJa5Ln3obc+uhGouCxnK2w01
         z7HQ==
X-Gm-Message-State: ACgBeo056Syv1KGFVPdBk+7pBFRo/zghHkpLnqgnBt7dWa9CgPKcbUNm
        e6Jbd30dEeexnsgXssPVz5tkgJSZNcfnGtziWc4=
X-Google-Smtp-Source: AA6agR7sPlq70WfnkK/fn8Kr8gLJ6XcQxfG0rnSlznVKc2vdkpVpZQAvPXLCiRSQSruyWOMySRZTiuZGaBBHxpqsue0=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr21365oao.106.1661198749228; Mon, 22 Aug
 2022 13:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220821062528.13416-1-tales.aparecida@gmail.com>
In-Reply-To: <20220821062528.13416-1-tales.aparecida@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Aug 2022 16:05:37 -0400
Message-ID: <CADnq5_MMAjk3-YzgCEtkk9228Mwwnc3oTSXkNG17CdTafYjoGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unneeded defines from bios parser
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Alex

On Sun, Aug 21, 2022 at 2:41 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Removes DEFINEs that should have been removed after they were
> introduced to ObjectID.h by the commit abea57d70e90
> ("drm/amdgpu: Add BRACKET_LAYOUT_ENUMs to ObjectID.h")
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  .../drm/amd/display/dc/bios/bios_parser2.c    | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 09fbb7ad5362..ead4da11a992 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -44,25 +44,6 @@
>
>  #include "bios_parser_common.h"
>
> -/* Temporarily add in defines until ObjectID.h patch is updated in a few days */
> -#ifndef GENERIC_OBJECT_ID_BRACKET_LAYOUT
> -#define GENERIC_OBJECT_ID_BRACKET_LAYOUT          0x05
> -#endif /* GENERIC_OBJECT_ID_BRACKET_LAYOUT */
> -
> -#ifndef GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1
> -#define GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1  \
> -       (GRAPH_OBJECT_TYPE_GENERIC << OBJECT_TYPE_SHIFT |\
> -       GRAPH_OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
> -       GENERIC_OBJECT_ID_BRACKET_LAYOUT << OBJECT_ID_SHIFT)
> -#endif /* GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1 */
> -
> -#ifndef GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2
> -#define GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2  \
> -       (GRAPH_OBJECT_TYPE_GENERIC << OBJECT_TYPE_SHIFT |\
> -       GRAPH_OBJECT_ENUM_ID2 << ENUM_ID_SHIFT |\
> -       GENERIC_OBJECT_ID_BRACKET_LAYOUT << OBJECT_ID_SHIFT)
> -#endif /* GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2 */
> -
>  #define DC_LOGGER \
>         bp->base.ctx->logger
>
> --
> 2.37.2
>
