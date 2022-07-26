Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9255815CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiGZO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGZO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:58:21 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1132BB01;
        Tue, 26 Jul 2022 07:58:20 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D6513240006;
        Tue, 26 Jul 2022 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658847495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2QVtMJBXp5WDh6xKtWCU7TcIfQMEpW5O9W1Yj5TkIo=;
        b=h+cXxrgGGbuG4Dmmz+lZ6+At3aUaQW3mFXMWHb3y52//1SYolIDLFYSDC47/ii6Abtps1m
        njMOoUp2Q2BO1QN5eX0GTkfTUMdgAbJJPDSwNf0LnWL+EMckYtIUi1MbIxFFQabLjIunHl
        VrN/VHIyvXrh+m27OdOMOsX/qC2Y4mdyqTzvhNyw9DmF8fUYbzmAEaCyYi1pME4R66aBEv
        X0iVELtpb2MTLjOVZf1jPJ/yxrP+EkW1XT+ccsrMeNdfH8mw04oMhdXTJj05mIfZmh9Wrr
        wQtZ9AIcXLbgbg14+9JbN1PmsVyPEO9cBzYxxv2JKmU6V2mGq4RtlVOk5Bdzcw==
Date:   Tue, 26 Jul 2022 16:58:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: microcrystal,rv3032: Add missing type
 to 'trickle-voltage-millivolt'
Message-ID: <165884747543.3162435.10649453266544407027.b4-ty@bootlin.com>
References: <20220719215143.1877566-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719215143.1877566-1-robh@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:51:42 -0600, Rob Herring wrote:
> 'trickle-voltage-millivolt' is missing a type definition. '-millivolt' is
> not a standard unit (should be '-microvolt'). As the property is already
> in use, add a type reference.
> 
> 

Applied, thanks!

[1/1] dt-bindings: rtc: microcrystal,rv3032: Add missing type to 'trickle-voltage-millivolt'
      commit: 2830320122d87fb65632f09cdffe129046915d51

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
