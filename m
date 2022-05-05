Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E151B85C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiEEHEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbiEEHEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:04:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDE41313;
        Thu,  5 May 2022 00:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 830DCB829A1;
        Thu,  5 May 2022 07:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD76C385A4;
        Thu,  5 May 2022 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651734064;
        bh=RulggmURxy/bgRQzjRpAUTqqCwOOUaZLn1ElIm5Tdfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fm9/lQ71IxtV7BW4/czpysKhiaMBIlnIfJx2QQ7WyP4Enyky/tcu3rappH2zQpi99
         +ZrMa7sAwfDsnhDAbjFRurOr/D8D8PmdPf6jWlJaxIJsuHObo0aVVJZ2QCCDfx3vN8
         B673M9AL8rDVRm6a+vHE42XWp65hWrzsomO/avTrKhAZ41oxF1Mym2k58VrYM4PnEO
         soBjavjrXVPTWLCsuskQ4ACuBj1PrqpjtS1X1HDZCs87GiG5V6fbuN4cJf6c6GAiCY
         Sfe5iTEq9MBhmFf1N7XR/2Opo9Vr9wzf3WwS/bfH0XCn2j3xZAPSkLFCQ09oFwqx9F
         ooRSqcI8DRQ1A==
Date:   Thu, 5 May 2022 15:00:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-venice-gw7902: fix pcie bindings
Message-ID: <20220505070050.GZ14615@dragon>
References: <20220429161347.7947-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429161347.7947-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:13:47AM -0700, Tim Harvey wrote:
> Update the pcie bindings to the correct dt bindings:
>  pcie_phy:
>   - use pcie0_refclk
>   - add required clock-names
>  pcie:
>   - remove pcie_phy clock as it comes from phy driver
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
