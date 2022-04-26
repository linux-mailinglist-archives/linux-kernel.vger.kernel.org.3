Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48275100F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351743AbiDZOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243885AbiDZOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:54:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2B3C4AB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:51:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso13205165otj.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjUtCSyBnFk8A3kTILIrriQceuNIreHcu/IG7ob7Yjw=;
        b=eEihIfAYOPixN4pXa9pV6rApPJ/mm+Ff36ssgjFVVtp6lXlr8xUkUFSXFY2R5btYUh
         e0bPxX4RJNBOBvjBM5mH0kDJOuNImtnNAUiqKNLl1ts5txepBbOJS0W+CxxJ7IqBj5VY
         mWVQN8+pTokpaJ8lG7CWp+dPeEyOulLirq4omYYkDQxB24tGSJmjVU40upQrW4VZcu2s
         ij4AqBttsogwiH4XU2M2l9Dw6xVQLoAc4G5knFHo3/TNUKhJTJgABL5kngE/mPK9Nnw9
         TlL2svtdIEJAh7kW/Xseb/5gzLETsWfkAL0LcBCzi8v1JEEc8rtYynsAuItgiOfC+3gl
         7vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjUtCSyBnFk8A3kTILIrriQceuNIreHcu/IG7ob7Yjw=;
        b=giCdh29eur5zp3bi68KIkFb2i3p2rP1zG8Co7gwT2pT1JRFGiwvxq4yi+xO4V0jLvl
         xXpVk3YUV1Zdy4fsUIb5JEUATA5D8LMoDXVn4jFBG4/hfNk+0fpUvKLv2BKZ5TP42r1W
         MwtBcumRA947Gd/6QPBXSaAOt29idjUeg6ZQTG1nm1hy6xkCARcDBcY29+kilaX8IhuN
         KRZ2Hd5hh4/jAwFMyDA43Rt4XgQCs8RZc4hOQKnH35LXJvwqFQRswEUEQcN1BIhd60bz
         9d3x97L/nngDOV6DOQp380WkTnmgmpBpQDK3qkF9REiYGKCcYaDupMkJQHHVx1Rh5Vl5
         cdJg==
X-Gm-Message-State: AOAM5301VYMm4ZmaaiYd0pYLzHNi6s5FN2ZClWc2k32A5I0Kmo8s3RE4
        vpmqPGTsGiYYQdTCDOR3XrkrA2R1AEkcoz916DvW2fsy
X-Google-Smtp-Source: ABdhPJwQWZyiDHzcPHPthMVbpOd+wMn9jPepqdWib/QYV5CmxlYnXLUwO6hhH6jHp7CQeRHWTBjQ9784pbyYkooY4Hg=
X-Received: by 2002:a9d:110:0:b0:605:a618:4a68 with SMTP id
 16-20020a9d0110000000b00605a6184a68mr4761422otu.357.1650984661559; Tue, 26
 Apr 2022 07:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220426100616.1411209-1-oushixiong@kylinos.cn>
In-Reply-To: <20220426100616.1411209-1-oushixiong@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 26 Apr 2022 10:50:50 -0400
Message-ID: <CADnq5_NC+LckMSBYXHGDohyTB6PbELwtYqAknBgRvR3q7N_LYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix spelling typo in comment
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>, David Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        John Clements <john.clements@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks.

Alex

On Tue, Apr 26, 2022 at 8:56 AM oushixiong <oushixiong@kylinos.cn> wrote:
>
> Signed-off-by: oushixiong <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 7bd763361d6e..b7a1e2116e7e 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -3,7 +3,7 @@
>  *  File Name      atomfirmware.h
>  *  Project        This is an interface header file between atombios and OS GPU drivers for SoC15 products
>  *
> -*  Description    header file of general definitions for OS nd pre-OS video drivers
> +*  Description    header file of general definitions for OS and pre-OS video drivers
>  *
>  *  Copyright 2014 Advanced Micro Devices, Inc.
>  *
> --
> 2.25.1
>
