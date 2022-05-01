Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3C51643E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346655AbiEALlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346586AbiEALlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:41:20 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCD1D0C2;
        Sun,  1 May 2022 04:37:55 -0700 (PDT)
Date:   Sun, 1 May 2022 06:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651405073;
        bh=XaQB/bDfL05mxHX/W7B5FozwTL67msdQW3AyRnhRTCI=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=IMM2ZHxxw8//ifayT/L6KtpTjjYFJ/Mb3WGrwaqYA2r1SVZvNlFk6mpsK0Y0oW7VX
         gS//o+5LAjo/P82fkXl1FmQZ4SFChs6jjOh3xeD2NOq0xL/TqH85jCcgOG6Kf1LeUa
         Cl8CpjbnQ6ahHm79JBVfDaiDEN0EpfsVLIn6e/puaJxgp/YPYs8P5urkoRxwvHO7pe
         YWlNBtBzcsgYXRjTHTAJNNP3taoeuKrQIEd6CBV1awTe/59+cQcK5v7lLT6NtB7RRs
         jwVk4c7Jn1eniOvXZVqgYF+wEWrB0Oto4yusbNr6jpqEkn2UioghRm6kli8tZyU8g4
         3QucZwlKVEzaA==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm: hisi: enable Hi3521a soc
Message-ID: <20220501113749.vcwimgv3vzbl45qp@proprietary-killer>
References: <20220501051020.2432338-1-hanetzer@startmail.com>
 <20220501051020.2432338-3-hanetzer@startmail.com>
 <e68f9371-e111-d357-c224-a0067774db73@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68f9371-e111-d357-c224-a0067774db73@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 10:36:17AM +0200, Krzysztof Kozlowski wrote:
> On 01/05/2022 07:10, Marty E. Plummer wrote:
> > Enable Hisilicon Hi3521A/Hi3520DCV300 SoC. This SoC series includes
> > hardware mutlimedia codec cores, commonly used in consumer cctv/dvr
> > security systems and ipcameras. The arm core is a Cortex A7.
> > 
> > Add hi3521a.dtsi and hi3521a-rs-dm290e.dts for RaySharp CCTV systems,
> > marketed under the name Samsung SDR-B74301N.
> 
> Where?
> 
> > 
> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > ---
> >  arch/arm/boot/dts/Makefile | 2 ++
> >  arch/arm/mach-hisi/Kconfig | 9 +++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7c16f8a2b738..535cef3b14ab 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -242,6 +242,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
> >  	gemini-ssi1328.dtb \
> >  	gemini-wbd111.dtb \
> >  	gemini-wbd222.dtb
> > +dtb-$(CONFIG_ARCH_HI3521A) += \
> > +	hi3521a-rs-dm290e.dtb
> 
> There is no such DTS.
> 
Ugh. Sorry, I've been fighting this for a while and must have missed it
out of exaustion. will resend.
> 
> Best regards,
> Krzysztof
