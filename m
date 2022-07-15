Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F83B575D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiGOIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGOIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:22:12 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556DF74780;
        Fri, 15 Jul 2022 01:22:11 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oCGZm-000nQg-Ab; Fri, 15 Jul 2022 18:21:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Jul 2022 16:21:30 +0800
Date:   Fri, 15 Jul 2022 16:21:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] Add Aspeed crypto driver for hardware acceleration
Message-ID: <YtEjivBuw5MMpXJi@gondor.apana.org.au>
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <HK0PR06MB3202AE39EF5F43E62F19337880879@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB3202AE39EF5F43E62F19337880879@HK0PR06MB3202.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 03:23:00AM +0000, Neal Liu wrote:
> > -----Original Message-----
> > From: Neal Liu <neal_liu@aspeedtech.com>
> > Sent: Tuesday, July 5, 2022 10:10 AM
> > To: Corentin Labbe <clabbe.montjoie@gmail.com>; Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
> > Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> > <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
> > Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> > <dhphadke@microsoft.com>; Johnny Huang
> > <johnny_huang@aspeedtech.com>
> > Cc: linux-aspeed@lists.ozlabs.org; linux-crypto@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> > Subject: [PATCH v7 0/5] Add Aspeed crypto driver for hardware acceleration
> 
> Gentle ping on these patch series, thanks.

Please address the comments that you've received first.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
