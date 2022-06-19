Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EB5508BC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 07:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiFSFS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSFS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 01:18:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE011C01;
        Sat, 18 Jun 2022 22:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F31B8B80B1B;
        Sun, 19 Jun 2022 05:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36ADC341C4;
        Sun, 19 Jun 2022 05:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655615932;
        bh=62G/054S0TgUBwgFzMUpfznmu/hhrrxiiqBp08t4wcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcdCp5/tEkdQIxhJ4maT+1DpAbyQasGoyoHfaMHBsSESYyERHOB90JlciZczEqMzu
         VVOQn+J+kfegnAh1pfJz6dzZcgH1ZNtS+8D7NBvmohfPGewlcBnDYHsMwFjCyhXLqL
         i81rk4QkrO4kHbh1RtzIpnMNIJnlekUJp6zRkvQ0FMVFHDFRpsegHJZXd8qON0tfPF
         SW+jX2OgdwO4xFppgWa/1d4AwRjfKo18l7jquuQhIC27zKsJ8R8wC0VkU1HpDW9NsP
         N0UM0cVLVfGvMV/Sav/xcWVdsQYWY71lWuHXSIObPbGeICKcnCpZrw1HzMqXoWZFsb
         zGuYzSlDp0RkQ==
Date:   Sun, 19 Jun 2022 13:18:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sl-tolino-shine2hd: fix led node name.
Message-ID: <20220619051846.GB254723@dragon>
References: <20220604155705.574071-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604155705.574071-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 05:57:05PM +0200, Andreas Kemnade wrote:
> Node name is supposed to be led or led-x
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!
