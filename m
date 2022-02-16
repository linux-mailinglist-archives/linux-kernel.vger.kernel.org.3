Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32C4B8C10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiBPPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:08:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiBPPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:08:10 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94AE201933;
        Wed, 16 Feb 2022 07:07:57 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id c14so1637550ilm.4;
        Wed, 16 Feb 2022 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLlHTPf7eon4BbIAezWnNI6iX8qt53HUKJyH0lHJ1kE=;
        b=FxftwHhVSJtn4s/UQgc74G86BO3nMi1IjDBzf5aiykwhXfuYMQRDh0qTFi2WGmloAd
         QYzv5E+G0BIW6ouvOWqhvCFaBZ1bZIVxRwwHa19bD39hNy4x9oc7GjQoxBqJHraVNf7e
         qBEroHtGFtMV+sOO7QIzO7gbL+P05VOytvsM90yBk2751anQqUhybQGu/lbzKrqHaiGT
         85n2w2fZmSP6Ttr8n8QAonEo2kQerVujdGjKNnWrq2gHg7uSSiFy63pwcd58z1LCEREh
         DcP897A375D2yO+9pts5uccocLMrEhz+dby9y+xRNew/qZ/YtGWdg6gwsoUBNroc5MBd
         +3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLlHTPf7eon4BbIAezWnNI6iX8qt53HUKJyH0lHJ1kE=;
        b=XpvfrJsJEpTvKW7QnVuHzN6OFO94S2QGmW20yeHjoOqBxWdKNq6kg1EVxJTZqpRn3h
         K54RiSP8K9IvWvkEi2J9WJ6oy1xcx/P9ppQdJ3Hj/JI7Nszwb2hVhpYF1ahbMgqllE5K
         ZD0nV8l6G8CVNkcR/9v0AmoLTjj2ALwyf4U6far5D7JKsLKqbz/TdzuN0ZpPX6sTBgNF
         vhXrV3MHPmpS8o++j1mkGfaFhA3uQtu6zw3XWEMYavoG/BZ5jA5macElUa1jtSd5rqb8
         enjzH+KCs8NDrlYRfo1WBjqQ2v2XLSu8jEoWydWztXXDG96yf9ZvPyFOTeNMyRzT+lCQ
         ktCw==
X-Gm-Message-State: AOAM531mAL+GM8y17jBUQQpCuyi4UmN4JRFLLSNjuq6Rbv+MC26MQd3E
        3HFEn8MBmnnINGTG7yh4JpT1/bxJsXrgnBR2IdU=
X-Google-Smtp-Source: ABdhPJwRp/cm8AHG+LOwLkypP9TU/FUwriNxWg6yltkkZWO+mL0KK86q/TUEgAlFJp7c9ZsxM7VD6m2amC8NH+0/Zvc=
X-Received: by 2002:a05:6e02:1985:b0:2be:1909:ede5 with SMTP id
 g5-20020a056e02198500b002be1909ede5mr2015977ilf.151.1645024077110; Wed, 16
 Feb 2022 07:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20220215204947.1719516-1-ndesaulniers@google.com>
In-Reply-To: <20220215204947.1719516-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 16 Feb 2022 16:07:45 +0100
Message-ID: <CANiq72kKRFy6jm6L46Tvx11Jo+zwA8NO7f2Bcb17a5jV7BXUTg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: refresh docs for LLVM=1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>,
        Philip Li <philip.li@intel.com>, julie.du@intel.com,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Nick,

Thanks for sending this so quickly, no warnings from a quick test:

    Tested-by: Miguel Ojeda <ojeda@kernel.org>

A couple of nits below in case you do a v2.

On Tue, Feb 15, 2022 at 9:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> * Word wrap a few columns over 80 lines.

Top to bottom writing? :P

> +For example: ::

This may be simplified to:

    For example::

Similar applies elsewhere where a colon + :: marker is wanted. Not
sure what the preferred style is, since the file uses both.

Cheers,
Miguel
