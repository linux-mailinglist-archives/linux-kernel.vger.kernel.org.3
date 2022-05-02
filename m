Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33750517301
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385886AbiEBPn3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 May 2022 11:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385924AbiEBPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:43:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D2B13DC7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:39:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nlY9G-0001BN-4Q; Mon, 02 May 2022 17:39:42 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nlY9G-006Yn5-9t; Mon, 02 May 2022 17:39:40 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nlY9D-000Bq1-Us; Mon, 02 May 2022 17:39:39 +0200
Message-ID: <c4405033251f154ba7dd00cb2d37986be8d8bb16.camel@pengutronix.de>
Subject: Re: [PATCH 05/14] dt-bindings: reset: lantiq,reset: Convert to yaml
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 17:39:39 +0200
In-Reply-To: <CAFBinCBiypQYfJ6ZMoNnHXFCviOzpHs4WvCrSfPZAy7Q7GTVHA@mail.gmail.com>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
         <20220407154338.4190674-5-p.zabel@pengutronix.de>
         <CAFBinCBiypQYfJ6ZMoNnHXFCviOzpHs4WvCrSfPZAy7Q7GTVHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2022-04-18 at 18:34 +0200, Martin Blumenstingl wrote:
> On Thu, Apr 7, 2022 at 5:44 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > Convert the device tree bindings for the Lantiq XWAY SoC RCU reset
> > controller to YAML schema to allow participating in DT validation.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> I am not sure who can take this patch (through which tree).
> Maybe Rob can simply take it through his devicetree tree?

Thank you, I have just picked up all reviewed patches into the reset
tree.

regards
Philipp
