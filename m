Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630D94AF6A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiBIQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiBIQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:28:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9CC05CB9B;
        Wed,  9 Feb 2022 08:28:18 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHpp8-0002r1-Gg; Wed, 09 Feb 2022 17:28:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, Liang Chen <cl@rock-chips.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Alex Bee <knaerzche@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: gpu: mali-bifrost: describe clocks for the rk356x gpu
Date:   Wed, 09 Feb 2022 17:28:05 +0100
Message-ID: <3297396.uCXnvZdJcx@diego>
In-Reply-To: <01b78d95-fdf3-060a-831d-dae2abbc7109@wolfvision.net>
References: <20220209085110.3588035-1-michael.riesch@wolfvision.net> <1644420908.380944.391811.nullmailer@robh.at.kernel.org> <01b78d95-fdf3-060a-831d-dae2abbc7109@wolfvision.net>
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

Hi Michael,

Am Mittwoch, 9. Februar 2022, 16:46:28 CET schrieb Michael Riesch:
> Hi Rob,
> 
> On 2/9/22 16:35, Rob Herring wrote:
> > On Wed, 09 Feb 2022 09:51:06 +0100, Michael Riesch wrote:
> >> From: Alex Bee <knaerzche@gmail.com>
> >>
> >> The Bifrost GPU in Rockchip RK356x SoCs has a core and a bus clock.
> >> Reflect this in the SoC specific part of the binding.
> >>
> >> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> >> [move the changes to the SoC section]
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml:173:12: [warning] wrong indentation: expected 12 but found 11 (indentation)
> 
> D'oh! Sorry for the stupid mistake, I found that yamllint was indeed
> missing.
> 
> Lines 173 and 174 need an extra space. In the case that a v6 is required
> I'll fix this. But of course I wouldn't say no if this could be fixed
> when the patch is applied :-)

My guess is, Rob's bot filters out the easy wrongs, so I'm not sure if he
actually looks at these in person.

So doing a v6 might actually be better for a Review :-)


Heiko


> > 
> > dtschema/dtc warnings/errors:
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/1590238
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 




