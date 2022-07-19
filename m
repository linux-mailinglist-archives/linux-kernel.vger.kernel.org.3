Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2F5797B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiGSKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiGSKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:31:25 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 03:31:23 PDT
Received: from smtp-out-06.comm2000.it (smtp-out-06.comm2000.it [212.97.32.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2D13FA21;
        Tue, 19 Jul 2022 03:31:23 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-06.comm2000.it (Postfix) with ESMTPSA id 35AE156129F;
        Tue, 19 Jul 2022 12:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1658225747;
        bh=GhcCPb2jQrUtMMbBjqAyvfS7kPvpUNdi6KFbBvqTx94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lkrOwjs5BHSTNoqlvVHR3XqIR0QeWw2+CRi2TbtiwxuGz/JChH2s56znQiOXowTO1
         Pj6Um7SH1JXwXfrax1P0i/eC3cPj4I2lEUA5+mqjKqTpP/jOzoo+urN1nbKGDojzV8
         ZZqN3cuEOAzTjkueg62rq9B9KkLDkeyEbxtr/I0xRvKwb45HMvmWXpHEg/vaq+01po
         388nPX5PXP1hp6FI80Xis2OYwGtLkR9ygQRfhPL51lDDRTBI4aantMYMr0Cqyuq3dL
         DVFIn1cZ+CrEpkG+cB3ACP7QOgIYO+VS2NYn6L8XCHed2wi0jxlyyidqutIWPPR7gy
         bUHC4w4HgsPKA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
        id E0A3E7F888; Tue, 19 Jul 2022 12:15:46 +0200 (CEST)
Date:   Tue, 19 Jul 2022 12:15:46 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: Add device trees for MSC SM2S-IMX8PLUS SoM
 and carrier board
Message-ID: <YtaEUvP4jpO5Dggg@gaggiata.pivistrello.it>
References: <20220718152310.1937899-1-martyn.welch@collabora.com>
 <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Tue, Jul 19, 2022 at 12:01:34PM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2022 17:23, Martyn Welch wrote:
> > +	tca6424: gpio@22 {
> > +		compatible = "ti,tca6424";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tca6424>;
> > +		reg = <0x22>;
> 
> compatible, then reg, then all other properties. This applies everywhere.

Is this documented somewhere? It would be easier to enable new people to
contribute, if it was.

Anyway, I would add to this list status as last, when present, and I do
try to order alphabetically all the other properties.

Francesco
