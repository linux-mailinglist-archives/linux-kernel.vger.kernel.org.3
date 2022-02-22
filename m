Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED64BF930
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiBVNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiBVNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:25:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4D6E556;
        Tue, 22 Feb 2022 05:24:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30C74CE13E1;
        Tue, 22 Feb 2022 13:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BCEC340E8;
        Tue, 22 Feb 2022 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645536278;
        bh=Ljwz0VSQXW5190Zgm0T2BP+0b1W/O+Ow7Aa2IBiiJxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDs7eL3GAGNXfHjTTA3hutWqTtkIDxMri5oGhDixQyLH/3rkzd+v/9MCkff3TqteF
         Oo4GzhAtMAbonNR3KLa1h4DRUe4qjpCHyS0zlSIcl0ysltKsmrKvVMgD2v1oK6wii8
         bampMKNu9HDz4zfsEbwDrPm9/3OXm32u6UDkj09bG7Gel3xxOyiaj3E8OxUgJr7s4m
         WYM4+r5egIPUaxeV7+r9kCEI1DM8bvOwijdoYCJ/gBfoB9SyrEw7xoCSvbh6WDwyGI
         1D/wwfZBi2qcggWNFVJ1LY4mzwQANydrKlggdDwicb0adz3uAQ4B8Uy6JefsWOKTNP
         rK+Vrtu87TDtA==
Date:   Tue, 22 Feb 2022 18:54:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: phy: samsung: drop old Eynos5440 PCIe
 phy
Message-ID: <YhTkEvnSbomEMuTF@matsya>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-22, 20:36, Krzysztof Kozlowski wrote:
> The Exynos5440 PCIe phy support was removed in commit 496db029142f
> ("phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
> PCIe PHY") (with its own bindings), so drop the old bindings.

Applied 2-8, thanks

-- 
~Vinod
