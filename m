Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E325686A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiGFLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiGFLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D927CE9;
        Wed,  6 Jul 2022 04:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACDE61EA1;
        Wed,  6 Jul 2022 11:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B9BC3411C;
        Wed,  6 Jul 2022 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657106355;
        bh=pH+7zRRRrVd449IaGLCpYB+pLDOwoJSHJOCedwPzYo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giamls3R4KjBgVh9Zt8u69smmkESsiV146Px6bUNYh9yyI6cOwxABDzjpdCkfqasE
         IA6vhsNdXeI5v/lGl5KVrshXmngzp911Exn+3o62TOVqnB1nQ5+i2D8ZRUK5n2f1gW
         rCqKi3nZ5uX1e26iYiR/FeyJcx4lSx7fE8cpkYW/nKyI84rUoSZy9WHWXS230BRLFG
         3CT0YHKpowYafOrQy663UoiXm5221KByWNr6oWlZ8yL6IaIpXeYciGvTtrvHnPXrAH
         fSx3ac/a0rORYVYhn8Jhyp7mfDviy9Hze4xvBrh3XkzkEsGRRdgNg6hCO7aEotAjYD
         qIVg7at3pakCA==
Received: by pali.im (Postfix)
        id A01BB7BA; Wed,  6 Jul 2022 13:19:12 +0200 (CEST)
Date:   Wed, 6 Jul 2022 13:19:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Message-ID: <20220706111912.hz2mx4dc35lgq6l5@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org>
 <20220706131507.353f0bed@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706131507.353f0bed@thinkpad>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2022 13:15:07 Marek Behún wrote:
> On Tue,  5 Jul 2022 17:59:28 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/common.h>
> > +
> > +    cpld@3,0 {
> 
> The generic node name should be just "bus". That it is a CPLD
> implementation should come from compatible string.

Sorry, I do not understand why "bus". Why other memory chips are named
e.g. "nand" or "nor" and not "bus" too? By this logic should not be
_every_ node called just "bus"? Hm... and are names needed at all then?
