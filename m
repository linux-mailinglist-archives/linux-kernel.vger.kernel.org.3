Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538955B290B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIHWI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIHWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:08:56 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFD7E7F94;
        Thu,  8 Sep 2022 15:08:50 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D73781BF206;
        Thu,  8 Sep 2022 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662674929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIa0kJIH1H21k3QYUQ2Pv9F9fKXRgutlu049FmwPNjA=;
        b=fX9cBFpnDDPUnUDtfJFyWi9kDibG98O8ZO0BUayIdH2WamXN+ItD7thavyrBNwRc8Hw9Tm
        FmK0ANUR6+Oiry/xI8Gc2+4SndGMYvjZ5OboMrnuTGt5PVWuJ4Uj90EIOBwuou/m3ktG40
        eBbe9RKPJAjO7o9PzaWqbc4dSFuq9xfCB+AX0DiswX4aRWmupVypoWxnAO3P46cmScy/2p
        HVU6Os2qe2xtwH8mZfTzQTu4p0rYqjUz+Utns1JxC4VlYPoO/6EhqdZjLO7enOZOun912l
        5zQujekpwad5c7nTmOGO6Cv3H2Pr6Ll5XTEI45wWJjnPmdjR2CYbm53DnVyG9Q==
Date:   Fri, 9 Sep 2022 00:08:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jerry.Ray@microchip.com
Cc:     robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] ARM: dts: at91: Adding documentation for
 SAMA5D3-EDS
Message-ID: <Yxpn8OnHdmlSwqFQ@mail.local>
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220908211048.GA3344136-robh@kernel.org>
 <MWHPR11MB16936F4F2FE278CAFAC6E7AFEF409@MWHPR11MB1693.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB16936F4F2FE278CAFAC6E7AFEF409@MWHPR11MB1693.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 21:38:48+0000, Jerry.Ray@microchip.com wrote:
> >> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board 
> >> description yaml file.
> >>
> >> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> >> ---
> >> v5->v6:
> >>  - No code change - patch prefix naming modified to match with others.
> >
> >You did 'git log --oneline Documentation/devicetree/bindings/arm/' for inspiration?
> >
> >'ARM: dts' would be an arm32 .dts file which this is not.
> >
> >Rob
> 
> Yes.  I'm trying to get it into the right bucket, but I guess I'm clueless as to how things get broken down.
> I tried "dts: arm: at91:" but was asked to change it.  I can keep guessing, but would prefer if someone could
> help me understand and get it right.

dt-bindings: arm: at91: is the right prefix

> 
> Regards,
> Jerry.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
