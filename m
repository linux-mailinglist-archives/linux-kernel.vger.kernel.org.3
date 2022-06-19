Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE795508BE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 07:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiFSFTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 01:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 01:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A3A11C18;
        Sat, 18 Jun 2022 22:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07C6DB80BA2;
        Sun, 19 Jun 2022 05:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE217C34114;
        Sun, 19 Jun 2022 05:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655615952;
        bh=+P5DblInmn73e3AEh8Ls1G28tkoHlL8QeaIm7OcrEps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5j5KKLBiCkABn1jIu4i2B2U2Xv65kZwxldDjcyaLKZgWc/1G8aOtLRVt2HM1q61m
         lB9zOVhY/T69bAYiB0K2VeTsLuFPJOeiQwmCuUydjvuhfc/VJ1D66AUR4lSiRiTBRb
         k9FcmQMN2AGDFcN3DBH3tgsqW5k842hY6RTvDx9nps9ceP9KlPfHIYCc1jBYTYTLm9
         YTwUTNygymI9AzLpE5XBY/0xnyj4CCCl8QpISBq88XXH9TSMlwkLC4N43tcDVvzGPw
         LFN1M0D51S+Td5LJUNmQFYM0/nljdiRQFNP8fEW1s2Da23GRlCLF0RPH9bVQPfrknp
         Pr7ru3MUB6YBg==
Date:   Sun, 19 Jun 2022 13:19:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6: fix node names for ebook reader keys
Message-ID: <20220619051906.GC254723@dragon>
References: <20220604155748.574153-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604155748.574153-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 05:57:48PM +0200, Andreas Kemnade wrote:
> Node names are supposed to start with key-
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!
