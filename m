Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B52565558
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGDM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiGDM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93669DBB;
        Mon,  4 Jul 2022 05:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A59B612AC;
        Mon,  4 Jul 2022 12:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE31C341CD;
        Mon,  4 Jul 2022 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656937700;
        bh=yQ5mAGdXNAnpq8SFpGC2WWB3XiOgrqUrNVMcn0hvwRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsiSe/NgXMl8kYo6lD+/wqnajBJhuZ+P9syws5D1c93fUnNzb5/1LJ3PY18AIwLlW
         NttPZK0dVnP/Hc+AIulYF8q+NVA3v2a+4flAgXg0mgKz1knerTOea1MKaQGEQhUxdf
         wO0zt7/tHNTnyG6uKyeaEMHSAq6DEldpmMJ68vewXoFQxGaKFoUinSy41JevdShZ13
         i1m3aakHP7a5G2jOLq7qmU72nHoMFPaxG+BBSuasoX3TT1iLd9YrNAZcaWikpbz3mm
         GbRl2F1nRJKjHXHOrpmrU5OdJdS8GI++Qbg8L0zRwQLQx90nidRLbRmJHdwL7DMMY3
         v5DUputjAPAcw==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-317a66d62dfso80543327b3.7;
        Mon, 04 Jul 2022 05:28:20 -0700 (PDT)
X-Gm-Message-State: AJIora8CFSe7tGyMekj+mAP0tYq6RTEjgOtNR6EKcHc9oCciWv8FDqAV
        dZzdjMKCIBtqg1zL64CnOvt0NvEyosOxpqYglKg=
X-Google-Smtp-Source: AGRyM1tYCIBxSqSTZRTIEwFGAVCtaVjM9UD/AlGpmHN9furm1OWL9aIe4iZUqSP2k5UTc7TGZN3LNzjHXw5LeYkjKo4=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr30962907ywe.320.1656937699632; Mon, 04
 Jul 2022 05:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213118.2352683-1-morbo@google.com> <20220321174912.164113-1-morbo@google.com>
 <Ypp3MA9s01bWrm2i@penguin> <CAKwvOdnwCVFpMgOih4bf1RAzb6n0Q0+AqaHZxGfnafT+XzAL4A@mail.gmail.com>
In-Reply-To: <CAKwvOdnwCVFpMgOih4bf1RAzb6n0Q0+AqaHZxGfnafT+XzAL4A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 4 Jul 2022 14:28:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ZDRzWeo3hQGnsQsU3h6Sz5JfY7-N0BNZJ=diSdLrurg@mail.gmail.com>
Message-ID: <CAK8P3a0ZDRzWeo3hQGnsQsU3h6Sz5JfY7-N0BNZJ=diSdLrurg@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: smem: use correct format characters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <jstitt007@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 2, 2022 at 12:05 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Arnd,
> Would you be able to merge this patch through the arm-soc tree? The
> maintainers appear to be MIA here.
> https://lore.kernel.org/lkml/20220321174912.164113-1-morbo@google.com/

Applied with minor conflict resolution.

       Arnd
