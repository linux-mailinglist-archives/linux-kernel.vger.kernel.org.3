Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226A44D5530
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbiCJXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiCJXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:20:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF7C12C4;
        Thu, 10 Mar 2022 15:19:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B75D3B82958;
        Thu, 10 Mar 2022 23:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DBDC340E8;
        Thu, 10 Mar 2022 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646954344;
        bh=V4wnjvY4L2Bz4KbOd372AkNLQFQqJB/gYFyf2CbrAPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V7OfqB2HgEAfy/XIE/6MNNrzxwNkKKdMG1if4kqM8Xb3YcYe9BTNq7v1cKkcAw+37
         nL8azRKEeaV8W/ImP7+jAdPAktJg0QELfw312GWfajTimQ3S8h8s4j4520cSmmsnPR
         ZioKvp4ioZ8tM7KerdVAcqpBuU5PXvtCyLLWEWXORZ0VCP+LelslbUoiI2k7LwYPqC
         prep9kbc87SthFLJxs5ilYSBH15vLgLazsnI9UnW//brk1wgrwrWeiqd1DmXBAHuGW
         nEUQU1KpEsvygKmFWTYpcr7AnsI83dOlmwBcbAlJVGmlUQLJTK7AOgn8GoRGUjfRNv
         YyvAX+NbLhBkw==
Received: by mail-ed1-f46.google.com with SMTP id b24so8886278edu.10;
        Thu, 10 Mar 2022 15:19:04 -0800 (PST)
X-Gm-Message-State: AOAM532PooI/8eQfKRMF1EcqdmlzVmn5ItitJnYWSKhNvXndGIvENOVG
        VtdmvJg071J7RchfRKpz7mPvwFnULGb0XehB2A==
X-Google-Smtp-Source: ABdhPJxp5bzTn1l2vSAMzoBAlG+a+dzRRbgefEAQj1lm2OxzmVsKHXuPiu56tHVQ2UwYQ4D6aHBqV8vPXCoNGMDSloU=
X-Received: by 2002:aa7:d355:0:b0:415:f703:569 with SMTP id
 m21-20020aa7d355000000b00415f7030569mr6593519edr.215.1646954342540; Thu, 10
 Mar 2022 15:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
In-Reply-To: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Mar 2022 17:18:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+k+ridWTkdy4xwTC7VxUTU8tu+Q2BA9kbQVA222PWvZw@mail.gmail.com>
Message-ID: <CAL_Jsq+k+ridWTkdy4xwTC7VxUTU8tu+Q2BA9kbQVA222PWvZw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make DTs compliant with bindings
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Chanho Min <chanho.min@lge.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 12:24 PM Kuldeep Singh
<singh.kuldeep87k@gmail.com> wrote:
>
> These patches are an attempt to fix DTs which are not in compliant with
> pl022 binding.
> LG1312, LG1313 and amd seattle platforms require fix in clock
> properties.
> https://lore.kernel.org/linux-spi/20220309171847.5345-1-singh.kuldeep87k@gmail.com/T/#u
>
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git,
> master.
> Rob, could you please help in picking these patches as git tree is not
> specified in MAINTAINERS.

I don't take dts files. Resend to soc@kernel.org asking them to apply.

>
> Kuldeep Singh (2):
>   arm64: dts: lg131x: Update spi clock properties
>   arm64: dts: seattle: Update spi node properties

Acked-by: Rob Herring <robh@kernel.org>

>
>  arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
>  arch/arm64/boot/dts/lg/lg1312.dtsi           | 8 ++++----
>  arch/arm64/boot/dts/lg/lg1313.dtsi           | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> --
> 2.25.1
>
