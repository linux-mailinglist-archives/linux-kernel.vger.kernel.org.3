Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B40C517D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiECGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiECGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:18:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B043BCF;
        Mon,  2 May 2022 23:15:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5544180FB;
        Tue,  3 May 2022 06:12:01 +0000 (UTC)
Date:   Tue, 3 May 2022 09:15:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: enable am33xx and am43xx wkup_m3_ipc
 features
Message-ID: <YnDIc6avf+8PwAXK@atomide.com>
References: <20220502021508.1342869-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502021508.1342869-1-dfustini@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Drew Fustini <dfustini@baylibre.com> [220502 02:11]:
> Enable new wkup_m3_ipc features which includes IO isolation on the
> am437x-gp-evm and i2c voltage scaling firmware for both am33xx and
> am43xx based boards.
> 
> This dts series depends on the bindings and driver changes in:
> - [PATCH v3 0/2] soc: ti: wkup_m3_ipc: support i2c voltage scaling [1]
> - [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation [2]
> 
> Dave Gerlach (3):
>   ARM: dts: am437x-gp-evm: Enable wkup_m3 control of IO isolation
>   ARM: dts: am33xx: Add i2c voltage scaling firmware to wkup_m3_ipc
>   ARM: dts: am43xx: Add i2c voltage scaling firmware to wkup_m3_ipc

Applying these all into omap-for-v5.19/dt thanks.

Tony
