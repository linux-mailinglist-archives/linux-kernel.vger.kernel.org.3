Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E525091B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382349AbiDTU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382367AbiDTU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:59:27 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA244738C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:56:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h83so3213311iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyBXxxIH/nLXI3G0qXD2cOtw9sd5zWd0oLZhbOg6kmM=;
        b=Nas5cf2D8yuFWDtgt5Rq8i1udp0jfH0r++qOT7EtKk3M1w5904AY+C2TM5LTb3SHy/
         eZFgsfhblj24Lq9GkYIOWFG6cVxnngLzUXL9ciEf3HYxYaaSGt2ohuVHEqEFRB0PvSVR
         XBHKsVoOCOjPCJ5iVbch9d8881Vjc/PDkiQDqEwLug5o0GXCFxG3yD2EGVJIkNd+JyPy
         oTIJrc9ZyvlQO5HWfRFB5DGWLruqOsSbkCwWuEljLB9FX1OFYwuEK/xZSH3QZaEf04MR
         7vnJ7w6g0D5XWRUtimE1ey3EVwq/UnOSfHkICByDbb/i0p7yzhZcxv0IsXyD7l8Fs3zS
         Vklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyBXxxIH/nLXI3G0qXD2cOtw9sd5zWd0oLZhbOg6kmM=;
        b=4WdMH0gAi3gw6pebRvOm0NfEHPyoE5015MBfGw1MrB1esS2XA+gEP0ndWglnXkMnzm
         q1VK/iE58RCgM+51qlHa9pAr15pK/NpZJLCjFSW9SQkxcq/CW1eTdUAu8Xf3OAM6Z+Eg
         0kMalTFHD77HUAnuwITIczxRKhdF908C2NTH2xWEdkPUcmsRlgyx7HGyJDkgztK3PSaO
         gB349DsfyGu8q/cXvKdt4t0b1PSSs8tuZEp45d1LMyGWY1AhnGMNni1fwPIzg+zyg2r9
         ezMW4H4jiV4qmS2IZWqK1tIyPZbUfOmQzPpvJ5pb3EApTiricJrqaNfiRhNg6UsAU7mQ
         RhEg==
X-Gm-Message-State: AOAM5321ekqyqUXJeAeauBGo+AWrHEUMFNYmz55z4k62Je0FsGU4gYYF
        Z1cgs79SeswYmk3TaDiGHAaGLQugraeK6WM9NR4=
X-Google-Smtp-Source: ABdhPJxkhTGy7FOTlWARsPgxbu2EhND0YDaee5yx9j6CACvFF2cHYCBtYiFwvCbBrAxDCZt2bzo6miS29qrYah1J974=
X-Received: by 2002:a6b:6b0c:0:b0:651:95fa:bf33 with SMTP id
 g12-20020a6b6b0c000000b0065195fabf33mr9832103ioc.64.1650488183860; Wed, 20
 Apr 2022 13:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220420140521.45361-1-kernelfans@gmail.com> <20220420140521.45361-4-kernelfans@gmail.com>
In-Reply-To: <20220420140521.45361-4-kernelfans@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 20 Apr 2022 22:56:13 +0200
Message-ID: <CANiq72n98uuJS4ao7p==nwwfWeGfekm6X8xz667Hn7EPM+qQRA@mail.gmail.com>
Subject: Re: [PATCH 3/9] irq/manage: remove some unreferenced code
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        llvm@lists.linux.dev
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

On Wed, Apr 20, 2022 at 4:05 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Neither remove_percpu_irq() nor for_each_irq_nr() has any users, so they
> can be removed.

For `.clang-format`:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
