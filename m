Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98865AF6C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIFV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIFV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:27:32 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98FB532F;
        Tue,  6 Sep 2022 14:27:31 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a67so7053560ybb.3;
        Tue, 06 Sep 2022 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OZhi8ZUrZL4q5WcJB62U8kYyW//mZYMgCUiG2KDTe/4=;
        b=odqdvPQkAj/RWdieDgoXHz9tUr/0iwH6Og5cY0gsfZo4BydtaTkHNVKu7uwx/gnG3l
         K7PQHpOIPqSbvxGcqRjRsLShM1kSa9O/49sdn1944IuwTsYtbnwDcVymTPXOdApIVzMc
         Y6qvoY3/OZPAR+RrMPwowGPW8s7YGZmLD5h4zSJobdJQvqWm/IaqWKMbYU4xItWQrtbz
         zDSAbeyrwVwDIR7y5kiuW8e8If5l7mw8Lmor7k0pIqaIUEbU7r8qLbFNy8ORpKPcJOW9
         rOSWQh5mRkiVbsFjSh2AaAIVbx1SngPVL6+EjAYr+8o09XoSNO/WW+Tq26p/HGiqN1Zz
         IRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OZhi8ZUrZL4q5WcJB62U8kYyW//mZYMgCUiG2KDTe/4=;
        b=aH/3cupzus6nFHWvtcCXirtFPDc9KEGEyvwu2ETG41/rGVHMXe9gD8XkSXcbHsLcUJ
         84U4qu1QJrLqMfBOEzzDQ66EYigeZueXyr7qB2dspsHAGfsYvhn09fSLW5fBUWNDn7dR
         dk/1g4ztG+IhXqvJUVW3cOnuqD7nUAwtPaeYqCUUEZ6ogOTeWPmXUx3NBcI/2QCRfRsV
         NmRF0AozrDth1yIuuENw5/ErJkpeWN/hZTSeaTdnEQtYrwlHJQk5LBj5hO2A85/TSV7j
         9OqdSma7wNXUCeRjCF5uitwH5lrCkO/NstDu1S89v6XS2iC9iPFte0i/B74TT8C0QzvT
         kvww==
X-Gm-Message-State: ACgBeo3VzR0dvaub/QCeNNJkSkziVJ0YQK/puUWopDT43Sg/HEPBzrrU
        Nv21GDVQVwxUIXoY9+yt4JUKf4cZrf8+BaIC4K8=
X-Google-Smtp-Source: AA6agR7wf/gc2LuBqbM8UmMdSlmBKmIYqD6S5YaTHXXkssBCDbxPCAhe4HdkuGDEmseN0Yt0wCYEYroDY8MIC846q7U=
X-Received: by 2002:a5b:845:0:b0:683:6ed7:b3b6 with SMTP id
 v5-20020a5b0845000000b006836ed7b3b6mr488653ybq.183.1662499650909; Tue, 06 Sep
 2022 14:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <YxducgSzR6/zyHD7@debian>
In-Reply-To: <YxducgSzR6/zyHD7@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 6 Sep 2022 22:26:55 +0100
Message-ID: <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
Subject: Re: build failure of next-20220906 due to 396369d67549 ("drm: vkms:
 Add support to the RGB565 format")
To:     Igor Torrente <igormtorrente@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
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

On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
>
> The errors in mips and xtensa are:
>
> ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
>
> The error in arm is:
>
> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
>
>
> Trying to do a git bisect to find out the offending commit.

git bisect points to 396369d67549 ("drm: vkms: Add support to the
RGB565 format")


-- 
Regards
Sudip
