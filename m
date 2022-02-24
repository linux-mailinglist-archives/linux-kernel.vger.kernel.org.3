Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD84C28DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiBXKHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiBXKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:07:15 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF0F2252F;
        Thu, 24 Feb 2022 02:06:42 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nNB17-0008WC-GT; Thu, 24 Feb 2022 11:06:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic pwm schema
Date:   Thu, 24 Feb 2022 11:06:30 +0100
Message-ID: <1817486.VeUe9BSz9F@phil>
In-Reply-To: <YhdXyBvAbdHzc4gH@google.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com> <3248917.W5uN0jUHDo@phil> <YhdXyBvAbdHzc4gH@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Februar 2022, 11:02:48 CET schrieb Lee Jones:
> On Wed, 23 Feb 2022, Heiko Stuebner wrote:
> 
> > Hi Lee,
> > 
> > Am Mittwoch, 23. Februar 2022, 10:16:01 CET schrieb Lee Jones:
> > > On Mon, 14 Feb 2022, Krzysztof Kozlowski wrote:
> > > 
> > > > Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> > > > the old name in bindings as deprecated.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
> > > 
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> > what is your expectation regarding this patch?
> > 
> > Are you planning to merge it or are you expecting this to go through
> > some other tree?
> > 
> > The binding-change here is backward-comaptible in that the old
> > node-name is still in it, only marked as deprecated, so in theory
> > this patch should be able to be applied on its own without
> > causing defects.
> 
> In an ideal world, it would be broken up and I would take the MFD
> part.   Is that possible or are there dependencies?

That is also what Krzysztof had in mind - see his reply to patch4.
Binding going through the MFD tree and soc maintainers applying
the individual dts patches.

As written the binding change is backward compatible, so no harm.

I was just confused by the "Acked-by" and wanted to clarify how you
see it ;-)


Heiko





