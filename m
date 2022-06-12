Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E85547808
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiFLAcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFLAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CF0A18E;
        Sat, 11 Jun 2022 17:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E2C612E6;
        Sun, 12 Jun 2022 00:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148A0C34116;
        Sun, 12 Jun 2022 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654993956;
        bh=SbaZao137SQ+bA002Q19kZBk98FaoMb6B+SK3mHqPQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0Aw7bmtG+rYjVLWOrI9ujvEiijVY+p6Pa2WUQlN1rbcQL7SmAzIlJLnOzKQ0kpcH
         GQRkTxidsa/Uv/+Y19tzHgnF0lR8uRHU23j7tsNEyV07PaATDdnZEElDs9Lu59hDAf
         AdqBMFi4ZGJIEBFyHM570DGKAvVDkJcBJlPTBUrCgw3g6FseYS+2jrWjyhd+OmsHdz
         2D9nzolwGcYkBOC9nKhxZzz4KvNALxnS92fKqDJj+CJ5B9pvbMgfL3kfSmfwEVATxk
         arqMltNBnPD8HFMM7UiMxkC4l4ZS4m+NnvQ0dO6yIaXIzEAgms/ztFe+bKcePEnDVQ
         fjsNztr9w84Ag==
Date:   Sun, 12 Jun 2022 08:32:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: fsl: ls1012a: fix Micron SPI NOR compatible
Message-ID: <20220612003230.GL254723@dragon>
References: <20220521164638.91410-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164638.91410-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 06:46:38PM +0200, Krzysztof Kozlowski wrote:
> The proper compatible for Micron n25q128a11 SPI NOR flash should include
> vendor-prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
