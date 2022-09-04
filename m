Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33E55AC1F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 03:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiIDBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 21:03:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98D4F67F;
        Sat,  3 Sep 2022 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ATZI2fowS/AxNbsIyQzG4QYaMmr60ObaKExsdpSgzzM=; b=ZG5uY2CawXp8WZ17SgfqwPmxnT
        DwbUmf6KngHXLwGvOHgfAD6NRtTRCXgElbWKF1PL/km3GaOQLvahBGD9kYBI7ar8JY4pEppA/S50K
        C4RlWab0Lb5CtCJ286X64mS1bqK+gi4VRc/N6jllxtM80TV7cozuzG3HxLcmwoX5/cps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oUe2K-00FXdb-PA; Sun, 04 Sep 2022 03:02:56 +0200
Date:   Sun, 4 Sep 2022 03:02:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <YxP5QD6v4HmBUVGp@lunn.ch>
References: <20220819131152.6513-1-pali@kernel.org>
 <20220831142809.lcmnv3l4rnulo522@pali>
 <YxE2JqJutZ0ilghH@lunn.ch>
 <20220903152735.2ga3iwrivh6zhibf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903152735.2ga3iwrivh6zhibf@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm also not sure what the DT people will say about the node name mcu.
> > I don't see any examples of that in the binding documentation. They
> > might request you rename it to gpio-controller, unless it does more
> > than GPIO? And if it does do more than GPIO we are then into mfd
> > territory, and the binding then becomes much more interesting. Then we
> > start the questions, are you defining a ABI now, before there is even
> > a driver for it?
> > 
> >        Andrew
> 
> Yes, there is already driver. See my previous email, I mentioned it and
> also I wrote link for this driver. Moreover now driver is merged in
> upstream u-boot.

I'm not comfortable accepting a DT binding for a driver which does not
exist in Linux. As i said, there are interesting ABI issues here, and
it could be the MFD, GPIO or reset Maintainers don't accept a binding
until a Linux driver exists.

At minimum, you need an Acked-by from the GPIO Maintainer, of the
binding before this DT change is merged via MVEBU.

	Andrew
