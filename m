Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECECE5AEFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiIFP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiIFPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77E78E457;
        Tue,  6 Sep 2022 08:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AACF6B81915;
        Tue,  6 Sep 2022 15:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F006DC43470;
        Tue,  6 Sep 2022 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662477213;
        bh=6ixbFK5dgdMaMZNuwVyiFXnCv9UWW2o+MX03FBO4Qsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJtuD/4inzykbohpjLekuGttk04rVbGcZHY3Tyw6Y16SsUF3FSPVjS/Q8FcKoBIHC
         ZXlYUwiemE5wPjpAXY0/5yEw8FWoRtu6S3VJ1oC8of2BO/QXkQejU58ArloQjPUCQs
         ggGPcakrSem1zh0n7fODo2aieFhCo+agA3mwWkDz6yABqbuL0xzZwSn79F5U8cGtdl
         gTdz0OH563dgBeClebTp0g6aVYImdSo0mNYl+buuVLOwFtbH5bhJhjczJlhK/jLDy+
         p4uR2wHuUXF40+naQ68NTLLcZTvVd3d6LoCYiXLyKtrZ5AUTncilm0hYWMGYoKoS6m
         JSwgV1lQjEf3g==
Date:   Tue, 6 Sep 2022 16:13:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, contact@paulk.fr
Subject: Re: [PATCH 01/10] power: reset: Move TWL4030 power driver from mfd
Message-ID: <Yxdjg/MKlc5Tc/3Z@google.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-2-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220820071659.1215-2-bavishimithil@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022, Mithil Bavishi wrote:

> The power/reset folder seems like a more appropriate place for
> twl4030-power.c
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  drivers/mfd/Kconfig                          | 13 -------------
>  drivers/mfd/Makefile                         |  1 -
>  drivers/power/reset/Kconfig                  | 12 ++++++++++++
>  drivers/power/reset/Makefile                 |  1 +
>  drivers/{mfd => power/reset}/twl4030-power.c |  0
>  5 files changed, 13 insertions(+), 14 deletions(-)
>  rename drivers/{mfd => power/reset}/twl4030-power.c (100%)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
