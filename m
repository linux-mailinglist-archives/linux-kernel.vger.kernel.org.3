Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E095359B107
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiHUALg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 20:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHUALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:11:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605BBC2;
        Sat, 20 Aug 2022 17:11:22 -0700 (PDT)
Received: (Authenticated sender: n@nfraprado.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8912BFF804;
        Sun, 21 Aug 2022 00:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1661040681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVc/spzvVRXvcAwGLO93tueirWsgH1TzbcCXIqS2zJg=;
        b=CSrtbKcSPKr+c/PD7wvl7QBCDvWS5Ptbe6a/G0efcVFbPQyXWAoq6ZssqmM1FIVQyMCWCi
        LEJhrT67lNJndYhhgIJH+VIPdNHEloVKtEYBFNrSNyEPgz2t31gKiNoHnTyDa8OO8kJlmV
        f6rCj4UddJmjUwXHzpoQOFuiqxIQuaMlWs0dqJlNWfCgr/0XwB5RR0h8Y6xq4vFB3DDSdU
        ZOPqb1D1O3xR8Ytc9pe9RrF7crHrt2KCyzlCc6/OJQes1WlPAXDugI5fa75pdaKn0eVgTx
        Rarc7oFRU8vHa8sXVetzcfuGqZrSlsrPs04Mw+Xuj6843Cgd0mBk3+FeNyiHfQ==
Date:   Sat, 20 Aug 2022 20:11:14 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Message-ID: <20220821001114.ahnb4f6hcykt5nrm@notapiano>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:30:04PM +1000, Tom Fitzhenry wrote:
> From: Martijn Braam <martijn@brixit.nl>
> 
> This is a basic DT containing regulators and UART, intended to be a
> base that myself and others can add additional nodes in future patches.
> 
> Tested to work: booting from eMMC, output over UART.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> This is derived from
> https://gitlab.com/pine64-org/linux/-/commit/261d3b5f8ac503f97da810986d1d6422430c8531
> with fixes from https://megous.com/git/linux.
> 
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
> [no SoB, but Kamil is happy for this patch to be submitted]
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Tested-by: Nícolas F. R. A. Prado <n@nfraprado.net>

Indeed booting from the SD card also works with this minimal DT. Also confirmed
that eMMC, thermal sensors, power button, regulators and UART are all working.

Thanks,
Nícolas
