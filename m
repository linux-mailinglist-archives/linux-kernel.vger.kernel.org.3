Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D0586141
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiGaUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGaUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:14:47 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF9E0F2;
        Sun, 31 Jul 2022 13:14:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-322b5199358so89495427b3.6;
        Sun, 31 Jul 2022 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeGpJdxhfYfzpb5Uf9HD0YunEOMQCAiuTRKThZ+PwSo=;
        b=fJG8A2loRJfa6x4e80+zN7Fvw3Pe/ZYExhC+mfCZ2iElsgf1KCNf1fsWPfMiy8YGmC
         w+UH1PTagz5wAqhVJn+FQPFZWytCvSrniGNXqhaColRl/HYS5XEOARvusybmP1cZMtyY
         wAC1Oe45/yiQ1hqVTmcwiokt8ih3tqwzdwmyet6unIjt/ONPI0qizoHdTxt9mMFtEKKT
         s5a0PunUo4aDGknRnjlMOUsDOsjIJiHV4EL2gtV52I5mYdjv5Rs71NlmFX61bs5T28HI
         Xm+pfpqHIY2QyuBEQEHvgRMfRsZtgAnGzt6oiaqU8YNFOxwL4XTCptdXIlf/IfZ7Z0of
         YF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeGpJdxhfYfzpb5Uf9HD0YunEOMQCAiuTRKThZ+PwSo=;
        b=vVRQEXbVwPdMruvoZqWB9svvQGJfQ5RlDvZQW6p6BW9mXc1wxuwvMNYDGj6QVzwAON
         upl4v4GGX2D7xC+VpHaa1Npd//v05WEK9GSJxRyc2s/iovLEIhMVx5hO6EOZoasfHe6w
         8I0M/yDYoOPjJZ4w41xGNV6uqjw31MG8LaeblUjXYyOyxd7YHa4ZGNC35a63ee6y0Ztj
         ks84suu76uQcTr1v5XVDgfTNUUtq3sjqX2bzu58c5PN5lvxUHn/AaZOk3YKXxZnF0vbo
         gWo/EOTCHJge8zxELUCZiV01t9BjiCN5T6fxE1fVHFWZ7xhUuACSXGUS4TlshTXYonlU
         1jqg==
X-Gm-Message-State: ACgBeo2FpPmwXlq63XB09tuQmCj7PAnfXXZjO0UTfp9fNH29JCqUGwAj
        Z07yyM8tIyj22uuWqvYXreHEcPlh369cfS37xmcLi9aPoSs=
X-Google-Smtp-Source: AA6agR50IYOKvjQ9URod6wvD3PZZ9Q8A9+2ExY/nwdWTW3eZksP2dZd9tvwpELBNjBE3lw7v6MEK+j+2xWCfSLIrsVM=
X-Received: by 2002:a81:75d4:0:b0:324:7783:1e43 with SMTP id
 q203-20020a8175d4000000b0032477831e43mr5499748ywc.1.1659298470073; Sun, 31
 Jul 2022 13:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
 <be60acab-7dfe-6841-b176-4bd1e875d52e@birger-koblitz.de> <CAFBinCB6bJbK2sx+oyCjo97Sv2=ywnCi_4v+E76f78DYMNqJkg@mail.gmail.com>
 <075b8d68-93e5-93a3-a247-6811152b35d1@birger-koblitz.de>
In-Reply-To: <075b8d68-93e5-93a3-a247-6811152b35d1@birger-koblitz.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 31 Jul 2022 22:14:19 +0200
Message-ID: <CAFBinCCorAkiBg+ZXOgKtNYfjr6PUmT2mN1OH7Q3SoMkY-yYhw@mail.gmail.com>
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
To:     Birger Koblitz <mail@birger-koblitz.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
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

Hi Birger,

On Fri, Jul 29, 2022 at 10:20 AM Birger Koblitz <mail@birger-koblitz.de> wrote:
>
> Hi Martin,
>
> On 7/28/22 17:27, Martin Blumenstingl wrote:
> > Your patch actually addresses an issue which I have seen with RTL_SPI_SFCSR_CS.
> > Since you seem to have boards with these Realtek SoCs: could you
> > please clean up your patch and upstream it (splitting into smaller
> > patches if/where needed)? That would be a win-win: upstream gains
> > improved SPI support and I won't be confused the next time I look at
> > the spi-realtek-rtl driver.
>
> Thanks for suggesting this! I will send a patch-set later today along
> these lines, I first need to set up a linux dev environment as the
> development so far was within OpenWRT.
There's not a single right or wrong. The fewer patches a target has in
OpenWrt the easier it gets in my experience. The most simple approach
in my opinion is to make OpenWrt use an external kernel tree (using
CONFIG_EXTERNAL_KERNEL_TREE).


Best regards,
Martin
