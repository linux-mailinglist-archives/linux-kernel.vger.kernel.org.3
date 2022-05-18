Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4B52B586
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiERIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiERIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:39:47 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B91F62A;
        Wed, 18 May 2022 01:39:46 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id a76so940065qkg.12;
        Wed, 18 May 2022 01:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIQU7p2ddRP23ZVcbOH+vqsGdR+AZ+Y5lRt/vXJkT38=;
        b=sDGn8KUY7E/Ex4kXjg2hTbY7T79HvccZEi8ZFXd80Z9E7C4nZ6j2P8uJarsuIUta3D
         wlyWixCaHS0k6Cx1ux6tkGjW7A3wz3f+UVXECG2PSaEf3HaOCoBajZBYur7+v3HWs2qF
         h4GTcwA89FrnxqmdZw0khDS8kbk5Asg9xHEyT0D89QipAlFS80lyscedJofnsC3ME7i2
         JJvNodofk3FmMR2DrNBIYMkmrReOSSrHcbq2sGk/3Iryyb0zkoAoVEfp5lZje6iypSoa
         1FniCeS/wC9C5JAIIfwfv58X2WYfq4lFS4Omhn72wkd3DWU++p+VZRfnk8VjCXyc14bg
         lVzQ==
X-Gm-Message-State: AOAM531EPYiBonzwn4vVgX5imSyTRc+7TiC4oNHBsG5lpW1TR5CHKKNY
        Z2sWcwDG6WUuwD/6rDzoxAa8O032CmLYnQ==
X-Google-Smtp-Source: ABdhPJwOhnuSTqxs7mHRQQza0kR4i3jLi39tD802CY0K4NMBzt0aebaubdXi4FltuNILUzUnz0zN0g==
X-Received: by 2002:a05:620a:254c:b0:6a2:e7dc:25e3 with SMTP id s12-20020a05620a254c00b006a2e7dc25e3mr10932837qko.63.1652863185443;
        Wed, 18 May 2022 01:39:45 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8070c000000b002f39b99f69csm825426qth.54.2022.05.18.01.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 01:39:44 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ff39b44b06so16079137b3.13;
        Wed, 18 May 2022 01:39:44 -0700 (PDT)
X-Received: by 2002:a0d:f002:0:b0:2fe:cfba:d597 with SMTP id
 z2-20020a0df002000000b002fecfbad597mr21222453ywe.502.1652863184044; Wed, 18
 May 2022 01:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-3-gerg@linux-m68k.org>
In-Reply-To: <20220518065639.2432213-3-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 May 2022 10:39:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVWDgwOkA7vydeytRViigr82bMSAEPVQ=r-qsgF=hs_RQ@mail.gmail.com>
Message-ID: <CAMuHMdVWDgwOkA7vydeytRViigr82bMSAEPVQ=r-qsgF=hs_RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] m68k: removed unused "mach_get_ss"
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> The m68k machine helper function "mach_get_ss" function pointer is
> set for some machines, but ultimately never used anywhere. Remove it.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Yep, this became unused since commit 084b3600e2d98ebb ("char/genrtc:
remove m68k support").

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
