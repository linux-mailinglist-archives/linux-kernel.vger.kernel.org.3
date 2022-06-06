Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00953E684
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiFFPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbiFFPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:47:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC27814A0;
        Mon,  6 Jun 2022 08:47:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so29715653ejj.10;
        Mon, 06 Jun 2022 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMXoJ5ovah/EPnw+eVVA7zsLZ8X5B88gH27UvNQPmpQ=;
        b=BGShGVp/McO0ebp1bfrzMcVVGNJL7uCdsRPuRgW3RV5eJ3q6HnZR3BvGz3JsycimK9
         tFeS1eVWNNrc1+K+h9F29eBrGXjcr7mdKBXRcA4d/Xu+ojcechXrj/X3tcCpxbEZGKAs
         89XcuSfklrum52HjCpJic0Hkg24iskxELUqdUED6yrDO60z74P7w+rdID5JiryWAotGY
         +/zb+2/nOqw8ItNo3vycr8MRg/ZebES+0ENtjO8mm5IKvrT/tf8iC/OwWbImu6kss0os
         dJ5Gb0nTEqUbbRFSm6+E4VPUusl8QnySUwYItrWMCkVrkV2tR9187BaKLNI2ibgyN/BX
         iyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMXoJ5ovah/EPnw+eVVA7zsLZ8X5B88gH27UvNQPmpQ=;
        b=Qi9iah/RoNArH2rhp0rFw+RZCgta79gCsSPl0ugd2aBwCMgZv/O161FR7QfIox3iIY
         4AuqMng3iE3xL2kS1Lh/2yjQMP26CPim5XQd1jz2uWWqLRHIFwBs4HQ9gClO+lregsAQ
         ynVz0kyaRBMdwug6R7wNe1/Lnmjm8Me7vJRzzfWMNw6TBGmFhNG2ZjH/9VT+l9w3i3xx
         mRkbySSkSfpDjxO7V6kQ0BBlagLVYmr7EBiluSQs96mUEv/ElL9ikU73FbIYXRxpNMXQ
         lBr3GABT7/w3kb9ftXP2hDXEE0lONsihRCHhlY0C5ft7130TdWOzLCNmciS3L1oUOPxB
         Z9lA==
X-Gm-Message-State: AOAM5335hkNijIOuA5KfHXVqa7fJo592IYrMSA3jBYTn3sJpW6t2mFXQ
        4udb+ImJnsuZQI3nguMuAd/bMHX4m635uX+dvbA=
X-Google-Smtp-Source: ABdhPJz5X2jGDojQOqVTsOyfTkcmqZ3IMzoha4y2SNbY4Y4Vn2qld3Y3g05vnax+v60x8GGYgd5cRV4GbdXAjFu4ezE=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr18760471ejc.132.1654530464708; Mon, 06
 Jun 2022 08:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220606144124.29691-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220606144124.29691-1-wangxiang@cdjrlc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 17:47:07 +0200
Message-ID: <CAHp75Ved-Nx8AQ5=y3rLYu6gQxAkR4WxHLk_tF=XSbw5D_EH9w@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250_omap: Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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

On Mon, Jun 6, 2022 at 4:56 PM Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'have'.

I think I have given you a tag...

Please, read the chapter in the Documentation on how to handle
community interactions:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

-- 
With Best Regards,
Andy Shevchenko
