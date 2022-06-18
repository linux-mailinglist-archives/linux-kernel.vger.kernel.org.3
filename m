Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD8550526
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiFRNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiFRNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663615801;
        Sat, 18 Jun 2022 06:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9513560C16;
        Sat, 18 Jun 2022 13:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B9C3411A;
        Sat, 18 Jun 2022 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655559556;
        bh=NaI1s8MV1DekMTJJBuznazPzmo9dH36Xf7i0FHuVPzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOiNSW5LpDW9Pglq9D9QYvt0Q2PVjmxgUo6ycj8fUCYpT/ScNDPmBoRes/wfTEZmU
         L7zbSPe1kR9BsvASD7ABYwB7vV0m3d26jIS4II9geCSoKO7iFi+/M3Qx1DImXS3ai8
         JyWSn0SvgzKlnCcCPheGUdPEHL9qZMCZT+Q37XipeRBWonuOR0Vrksu9v13dousWwj
         9sCAy1yOWLDSGZ0IVi4iyUdrLgnyV2T2f+ZYi5RwA2aCrWoV+UxMWw6qfMATqPx3hm
         5Bnd3c1KIN94HrP/sw1p54EsJHtZR3/nW6TB1uxoWU3HvVDNMaknHJDf70ufvf/n50
         0xS9/i7qs6vQw==
Date:   Sat, 18 Jun 2022 14:48:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220618144809.7d36908d@jic23-huawei>
In-Reply-To: <20220608091238.403897-3-cosmin.tanislav@analog.com>
References: <20220608091238.403897-1-cosmin.tanislav@analog.com>
        <20220608091238.403897-3-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jun 2022 12:12:38 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
FWIW I took another look through and didn't find anything to add to the
existing reviews of this version.

Jonathan

