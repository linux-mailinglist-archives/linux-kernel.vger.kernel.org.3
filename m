Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2074FDCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358181AbiDLKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351859AbiDLKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:43:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A6B476E06;
        Tue, 12 Apr 2022 02:39:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 326AB8061;
        Tue, 12 Apr 2022 09:37:13 +0000 (UTC)
Date:   Tue, 12 Apr 2022 12:39:44 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am3517-evm: Fix misc pinmuxing
Message-ID: <YlVI4EAX5is25bqh@atomide.com>
References: <20220226214820.747847-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226214820.747847-1-aford173@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [220226 23:47]:
> The bootloader for the AM3517 has previously done much of the pin
> muxing, but as the bootloader is moving more and more to a model
> based on the device tree, it may no longer automatically pux the
> pins, so it is necessary to add the pinmuxing to the Linux device
> trees so the respective peripherals can remain functional.
> 
> Fixes: 6ed1d7997561 ("ARM: dts: am3517-evm: Add support for UI board and Audio")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> I put the fixes tag here, because I feel that the pinmuxing should not
> have depended on the bootloader, but if it's not appropriate, feel free
> to drop the fixes tag when applying or I can submit a subsequent patch
> with the fixes tag dropped.

Makes sense as a fix as confusing issues like this are annoying. So
applying into fixes fixes with s/pux/mux/ typo correction.

Regards,

Tony
