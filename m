Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58764CD092
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiCDJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiCDJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:00:12 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23971B0D00;
        Fri,  4 Mar 2022 00:59:25 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id k9so4045228vki.4;
        Fri, 04 Mar 2022 00:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erWZ8h2fOg/ZHNDy2FIiSGcRo02ET8qlTB1A0XqFghM=;
        b=2LWOm6apWM0VyIfHLmrPSjtTA1PqOWPdDtrU4FmdhkmvZzzr03oRinjbp4YgLejbOg
         qZ9dQH4c3gwm8z+XSQqx2vVq4JFnIgOYTZNFpbi3OCDZsX+AosVHW4Q/phCqV9yeq4gI
         /VRjAOfy6FH6QOhdvPykyzq160D82jt3C/cyT3LEjxUlki7/R0mxu0tr8i6AK6H/uMoH
         bOMV0WkWNbRp5pDJB4B2ovIeZfAdJjBzcWga12SMeV/DDaF005ifPfwUSbC/fZLnonza
         ED1cRA7yqEp6crKVcqIwpZZSRIFVMN4FocxcWwE3NOk3Vp0XK7shI8/IBcnKuGwguJtg
         8TBg==
X-Gm-Message-State: AOAM531CM6Vrv+eQ0xGyf+A1zJT9+TuQRDIAUR7rmKz5A+P4FdkTQPpi
        TbGyndVYvJt4OEn/+/RDPvRT+tP9N8Fnyw==
X-Google-Smtp-Source: ABdhPJzhKaqca3vuxFyUXg2pSHxMO6oqktifPF8FrY0+9sxWNIXxUqonuSTNrkPp8P3xEstvwsG5uw==
X-Received: by 2002:a1f:1e4b:0:b0:333:6c3d:bd45 with SMTP id e72-20020a1f1e4b000000b003336c3dbd45mr9137021vke.29.1646384364165;
        Fri, 04 Mar 2022 00:59:24 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n22-20020a1fa416000000b0031e658fd080sm650486vke.43.2022.03.04.00.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 00:59:23 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id 10so3283969uar.9;
        Fri, 04 Mar 2022 00:59:23 -0800 (PST)
X-Received: by 2002:ab0:77c3:0:b0:347:6f7e:6189 with SMTP id
 y3-20020ab077c3000000b003476f7e6189mr8471007uar.28.1646384363621; Fri, 04 Mar
 2022 00:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20220303221417.2486268-1-robh@kernel.org>
In-Reply-To: <20220303221417.2486268-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 09:59:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+LCumdzAFtqnRECxsUzpYD_69nVgy9zE0-KXewE1FVQ@mail.gmail.com>
Message-ID: <CAMuHMdU+LCumdzAFtqnRECxsUzpYD_69nVgy9zE0-KXewE1FVQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: kbuild: Print a warning if yamllint is not found
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Rob,

On Thu, Mar 3, 2022 at 11:15 PM Rob Herring <robh@kernel.org> wrote:
> Running yamllint is effectively required for binding schemas, so print a
> warning if not found rather than silently skipping running it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -3,7 +3,8 @@ DT_DOC_CHECKER ?= dt-doc-validate
>  DT_EXTRACT_EX ?= dt-extract-example
>  DT_MK_SCHEMA ?= dt-mk-schema
>
> -DT_SCHEMA_LINT = $(shell which yamllint)
> +DT_SCHEMA_LINT := $(shell which yamllint || \
> +  echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)

Do we want to encourage people to use pip, instead of their distro's
package manager? At least Debian/Ubuntu provide yamllint packages.

So perhaps drop the install rule?

>
>  DT_SCHEMA_MIN_VERSION = 2021.2.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
