Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05384504D94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiDRIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiDRIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529A11C32;
        Mon, 18 Apr 2022 01:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD346104C;
        Mon, 18 Apr 2022 08:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D834C385A8;
        Mon, 18 Apr 2022 08:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650269329;
        bh=NvQzA8r3CpfN3EEOE+dzR+OC5JOdLMsVh5Lvn23crhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHHaw/xnv0FhFCoI7OBu5iGoO8G/dtyKx6A4psBQjjaufFL4ylKUsTcZB29bKhcbs
         PlbQwXbKp15iJk4zI1b00CKnMocs8aFpEZlRbcc+kbPoZWrriYjURPtgotnorrHob1
         fCkz5HYZv0OUUw221TDerNviDZOHfWtM74q3PlMSmsr6F49dG+Wg21BYsvvKo0v2RK
         KdDj/XmhvDgGc4sGjzDLTrT+YJjTbiIR6LgfLeBcPATwenYN1lDncs0ylKZGvs+6uu
         GHlJD4KLuxYZY5YN64YvtrLtiDsoV2YS90mDxC6oBnsa+43HKEkV6amWxbTBlIhTTe
         K5CxM6WS5mmxw==
Date:   Mon, 18 Apr 2022 16:08:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc@vger.kernel.org, aford@beaconembedded.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/3] arm64: dts: imx8mn: Enable HS400-ES
Message-ID: <20220418080842.GC391514@dragon>
References: <20220410193544.1745684-1-aford173@gmail.com>
 <20220410193544.1745684-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410193544.1745684-2-aford173@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 02:35:42PM -0500, Adam Ford wrote:
> The SDHC controller in the imx8mn has the same controller
> as the imx8mm which supports HS400-ES. Change the compatible
> fallback to imx8mm to enable it, but keep the imx7d-usdhc
> to prevent breaking backwards compatibility.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied #2 and #3, thanks!
