Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508645347B7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiEZAz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345796AbiEZAzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:55:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF9DFE4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:55:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id wh22so270606ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaqQEwN5gGu7MuEou1u1zwwpE+vqC3sAxcFTo02SWDA=;
        b=bhIkJ14BXb4Gmmp5f8z02sxBhmmF8TGvh22Xut1tW0ARNZ219RGX+wDUOBoddOxasb
         PGt9EIIl0NJdNBixbeh6bgcmUh5262AJYw/ZYLvhECdizqGT6ooae01wART2qqLCv8lf
         bA4cAR6zOdWtKEcUl8+nSv9hJS/mSVGl/hNMXAZlXHYa/YajTW7VXpZT7+oysBxRgIn+
         +IE6D8w+1ffUNjJ8HGKCYT16ltx/GffdyDJXa15RTvUM9gYm96e3z/BNOB/UsxEDnPi2
         FYPYdZFd6DEqztc01Reat8aS3WeDkLbWIixPR2WWoGeJtfsvcUm395TiS8r14DN8caIj
         qZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaqQEwN5gGu7MuEou1u1zwwpE+vqC3sAxcFTo02SWDA=;
        b=xqbyN1Moz/oO+g0gfXan7A6a53b0CSQSO0dHn/HtCCZ3GfAu4kfDTPfHhLhldVzxTU
         lIydIEoEnD+NIErKID5NJqMUE+1YDmGjehgFq5yS8s/n+yk2SJzi1Qv+LHXdSycqUkIx
         te/92+eSTl+o58Pr6Sof7W8KpmM1IVHyL5m+5YDXm/OmZwj+xgO0VVXgCoaVBYp1Rb85
         mRLBTkp5MF2a8z34Ss8fudlstZqormOZb6r9LgQyYFFA1IbOZoqEmuAREc3xecxIeyM6
         sZEp1qiO/ytDM7/lsom09U/1AvJywZevTEvMZZ9S4VpRt2pj8m7/b8SRYPfAmYOOYh3P
         693A==
X-Gm-Message-State: AOAM530zUim6y1DipiYFKvhjVrydHxW+iADJBap1VheXePCiPOWrLdRQ
        G0u5Zkj4DCB5zFJy86nlO1lYQxMv0qh6fjlhk0E=
X-Google-Smtp-Source: ABdhPJxbRJIRlPwAO+7B0ZusKYSyfuUNbkRZqmO2LtsmNDK2xa9R6Xz5WYrhI9objzsk+DpgQnEBUMySDnRFwFcUp80=
X-Received: by 2002:a17:907:728b:b0:6f9:a9bf:a8e7 with SMTP id
 dt11-20020a170907728b00b006f9a9bfa8e7mr32415738ejc.696.1653526528840; Wed, 25
 May 2022 17:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <202205021042.xPjJ6Z4J-lkp@intel.com> <CAOMZO5Dg8_vDbW0vau4YFspZZ-RS=in8xEavkyYvBAQB41xTWA@mail.gmail.com>
 <Yo7MFbwDyT+1lzcr@dev-arch.thelio-3990X>
In-Reply-To: <Yo7MFbwDyT+1lzcr@dev-arch.thelio-3990X>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 25 May 2022 21:55:20 -0300
Message-ID: <CAOMZO5ARsRj_M_sX4dNk1039e+NG8C65asx2PG-kVzibQWfBZQ@mail.gmail.com>
Subject: Re: drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer
 type 'enum imx_dma_type' from 'const void *'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
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

Hi Nathan,

On Wed, May 25, 2022 at 9:38 PM Nathan Chancellor <nathan@kernel.org> wrote:

> Either an intermediate cast to uintptr_t or unsigned long or replacing
> the enum cast with one of those should work. See commits:
>
> 2602dc10f9d9 ("memory: renesas-rpc-if: Silence clang warning")
> 10462b3558d4 ("can: mcp251x: mcp251x_can_probe(): silence clang warning")
> 83415669d8d8 ("can: hi311x: hi3110_can_probe(): silence clang warning")
> be5aeee30e45 ("scsi: fcoe: Suppress a compiler warning")

Thanks for sharing these commits.

I have submitted a patch.

Cheers
