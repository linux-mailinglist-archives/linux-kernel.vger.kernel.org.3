Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770204B75F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiBORxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:53:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiBORxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:53:46 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A1FA23F;
        Tue, 15 Feb 2022 09:53:36 -0800 (PST)
Date:   Tue, 15 Feb 2022 18:53:32 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: ps2-gpio: convert binding to json-schema
Message-ID: <YgvonImK7lqBDcYO@pollux>
References: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
 <20220215165113.52659-2-danilokrummrich@dk-develop.de>
 <b6003ead-e3b4-a803-b92d-c08fc731a654@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6003ead-e3b4-a803-b92d-c08fc731a654@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:59:36PM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2022 17:51, Danilo Krummrich wrote:
> > Convert the ps2-gpio dt-binding documentation to DT schema format using
> > the json-schema.
> > 
> > Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> > ---
> >  .../devicetree/bindings/serio/ps2-gpio.txt    | 23 --------
> >  .../devicetree/bindings/serio/ps2-gpio.yaml   | 58 +++++++++++++++++++
> >  2 files changed, 58 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
> >  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> > 
> 
> Please version your patches in the subject. You can achieve it manually
> or with `git format-patch -v2`. I think lack of v2 confuses b4 diff
> ("ERROR: Could not auto-find previous revision
> ").
Yes, I accidentally missed the `-v2` parameter.
> 
> > +
> > +additionalProperties: true
> > +
> 
> I missed this part (lack of) in your v1. This has to be false.
I'll send a v3.
> 
> Best regards,
> Krzysztof

Thanks.

- Danilo
