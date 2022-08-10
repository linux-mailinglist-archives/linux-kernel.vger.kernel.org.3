Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1285658F350
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiHJTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:47:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ABA8053E;
        Wed, 10 Aug 2022 12:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2BE5B81E8B;
        Wed, 10 Aug 2022 19:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A304C433B5;
        Wed, 10 Aug 2022 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660160818;
        bh=j4NAmNa+NOsRyfj7CQJ6yOcaolWvSSkBRfc6r84XnU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YgEgicisxH0l5FXSnTwQTnuswp8EvQAav+2/60OXcR4lsZpN1v/adU15FqIyghSZO
         CPf84vINRwMg326sItzpL9GOZtDlfDxIDBsdBCWiskcWJuFWi4lYf6IchAeoOpoq3T
         d4gKKOMEjQr+y2jgs+NSOCjD9bAFQcbCrxMGT2yltlmHGiyMoz7PPzKSOBDsarRWYy
         ExfyA7VQfm7dEjyulVOEIDQMfRBC3rE+i8x1JnDOqeUjFo1VBMjTLzDMzttUAkzOCp
         llE42t7s5XOM9W/wEVLD41A9s3UcBLnm+NQmuHEoV33fFCUoXXVTcdaZHdo1aXtqCZ
         KUbZz7xoi5ULA==
Received: by mail-vs1-f44.google.com with SMTP id c3so16216866vsc.6;
        Wed, 10 Aug 2022 12:46:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo3WQFNdHDiaWjEpWcZ3Z9YsXXKAz2VtBkkHwyJWNMPjS0WzVR9e
        q6LPybvqaxL4p9akGE2iqlQ0PK6/K++J4rovfw==
X-Google-Smtp-Source: AA6agR6/UxLKpBSwVfdXRnbSQ9FgFSumGzqpNaCrWFI5hM93PyXjC2bVz90Bb9lUmyVxknc8RVwes/44YlW38zdXIJ0=
X-Received: by 2002:a67:d183:0:b0:388:82dc:7a9 with SMTP id
 w3-20020a67d183000000b0038882dc07a9mr11285255vsi.0.1660160817246; Wed, 10 Aug
 2022 12:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
 <20220312113853.63446-2-singh.kuldeep87k@gmail.com> <CACRpkdafQ4G=a1E=G6GK3W2zAD4Nh96GiQiYbYkn4ctVu3c04w@mail.gmail.com>
In-Reply-To: <CACRpkdafQ4G=a1E=G6GK3W2zAD4Nh96GiQiYbYkn4ctVu3c04w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Aug 2022 13:46:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2p+4R=-HcKJ=UdXFcATrZgwwpfRnJES+-bHxRohorHA@mail.gmail.com>
Message-ID: <CAL_JsqJ2p+4R=-HcKJ=UdXFcATrZgwwpfRnJES+-bHxRohorHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: integratorap: Update spi node properties
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Mar 12, 2022 at 12:39 PM Kuldeep Singh
> <singh.kuldeep87k@gmail.com> wrote:
>
> > As per spi pl022 binding, SPI clock name is "sspclk" and not "spiclk".
> > Fix it.
> >
> > Also update ssp node name to enable spi bindings check.
> >
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> > v3:
> > - Reword commit message
>
> This and patches 2, 3/4 applied to the versatile DTS branch.

What happened to this?

Rob
