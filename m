Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913135A39A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiH0S4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiH0Sz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:55:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BFA61102;
        Sat, 27 Aug 2022 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=iFkhQqsh5oQ+p1yr1Vuq7PdfTVzT7ogeNe4imAlHggU=; b=X6Is811b71S/eMdPEpxDcwFVEI
        ZsAmWlh32v5R0U11xRnaDFbYkFTaUIQJcxvBGZPqa2K1RG1mw99Gr+CQTsp0+YGHgA1kdmtS7zoTI
        ePd7RqJHefAzPN1xNGL7A7eM7AvtlebqdbO785PR8T0iuJzqislUfc5yXbs3svMy3rvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oS0yJ-00EnV8-5k; Sat, 27 Aug 2022 20:55:55 +0200
Date:   Sat, 27 Aug 2022 20:55:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
Message-ID: <Ywpou3shloC9mvgI@lunn.ch>
References: <20220825122102.18634-1-pali@kernel.org>
 <YwpldyOI5x1xgMoM@lunn.ch>
 <20220827184529.x6f7vacuhypaq7bb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827184529.x6f7vacuhypaq7bb@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Pali
> > 
> > I've not been following Vladimirs work on multiple CPU ports. Is it
> > clearly defined, both for old and new kernels, what happens where
> > there are multiple CPU ports defined?
> > 
> >       Andrew
> 
> Hello!
> 
> On older kernel kernel versions just the first one cpu port works.

O.K, i was worried it might use the last "cpu" port found, and so
change things.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
