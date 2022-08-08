Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89758CB85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiHHPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiHHPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:47:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DAE140DE;
        Mon,  8 Aug 2022 08:47:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b24so340805qka.5;
        Mon, 08 Aug 2022 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2gTAHN16Z4aleevBumMhtMAtPGIRkMKXKmyBCqJALLk=;
        b=bB6Cte3G8j+p+x5rp22MDx0ExndV+gCJb7HsDVVAsO5NqoVHjZU3p05ta5/6Uu4/Cn
         y8+UgsNiL2ydDIq77morV3fKGOOUxMAlgTwQMEAn2v9O6q7QtXl/h4Z2+vTNSZssHfI4
         oPvJvC0UXUbCZMIU2rP/pRG/lQcCpvlrBE/u37rFdiq2luFJ4z8i58mzA5Z6WsrW0+eQ
         Q73uI5uxx0G1UzHOrcBlz+Yu1gfF2Jb05QrlxaGOhnyDl+CBUHIJXCwKlilA0Ydr0yZV
         hp6puUix0ny/gZOtv4Bu6blPy+KKf2DdnwlBXqEqltKX5npkCIDPRYtNqaSI4wz5mzQW
         2rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2gTAHN16Z4aleevBumMhtMAtPGIRkMKXKmyBCqJALLk=;
        b=Gw9p83EWgLHpCVUQ5S+5LuQm0kqYlOdKjiE29l/bANfLGYcNzXD9ngpf55rE843MMQ
         6D6dSOx9t9Fdg1YRRrbIaR7PdN4c7HoS/6QFu1NZ/1LI0fWrK+Z2IpzAvEy+mkCVs5rR
         AalolL/i/iaiWRo03BloU1dPKEOPTsDPEF7hMn7o3ohS7FVkd7E4m4CJJ8+4Doj9yLuR
         Dia1Ir5+Xvw0mhwpe/64l+kqf64PCjkF3OKync+OpadxCrfLQKUtTgu85H7SoNbsqYA+
         TQ2fG/0T3LIhMWa3Jl8anZYC0KtMm9J61GvPRT6MV++qlt9fKWkRaKWh6Jbe3zHD3Lzs
         aF1w==
X-Gm-Message-State: ACgBeo0ktYqQQhOC0IV6dtjML3Mw2Zd1Dk/GNAgLEt05Np+y5XIZyaKc
        zsCJpIexmAixEx5JaQKUuBfakP833pCYHbVFMvc=
X-Google-Smtp-Source: AA6agR6hB6P/jeWB0D8zLhbtkolxa1wq913xb7LZUQ5hFmDpBvim9OlvB/jpRj8gcQjSwRUQJ1CVi/pXrlQiTCBtTVs=
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id
 a135-20020ae9e88d000000b006b94a0bcea5mr4328979qkg.748.1659973619276; Mon, 08
 Aug 2022 08:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220808031132.10075-1-luke@ljones.dev>
In-Reply-To: <20220808031132.10075-1-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:46:23 +0200
Message-ID: <CAHp75VfiNdBM+i=S4pkze1qZ_0tmEEtqAK8BF=wkwqY+BMB0SA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] asus-wmi: add support for ROG XFlow tablet mode
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 5:12 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> This patch series refactors a part of the tablet/lid-flip code to
> use an enum to set the different behaviours, and adds support for
> the ASUS ROG XFlow (X13) 2-in-1 laptop.
>
> Changelog:
> - V2:
>   + Refactor the base handling paths of tablet modes to use enum
>   + Add support for ROG XFlow using the refactored code
>
> This obsoletes a previous patch I submitted:
> - https://lkml.org/lkml/2022/8/3/94

Good written cover letter, thanks!

-- 
With Best Regards,
Andy Shevchenko
