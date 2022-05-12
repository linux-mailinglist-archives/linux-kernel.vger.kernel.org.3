Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE25241AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiELAqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbiELApv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:45:51 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5711AD82;
        Wed, 11 May 2022 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P3j6JNTPki/LW6Lx+K5sl1l625zeCFl9dehtVEycpws=; b=piM4VjBx/IAEu2/eYZ6g+T+qHT
        N0eed6UnxXniHjZ8UQol6BGPhCg+C571Ka74nRLhzOzyL6xLngCwU0uvwndGF0T/Ou1gHPzcvhkko
        9HPJqtAwJTqyusDFoUHn1QyJ7yXw//NqqZDluAkt/QHeIYGES7tWqiR4pZlozQwKiMn0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nowxY-002NEV-GU; Thu, 12 May 2022 02:45:40 +0200
Date:   Thu, 12 May 2022 02:45:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Message-ID: <YnxYtE9dGn6BwF/8@lunn.ch>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <YnvsInrh03BVh7lN@lunn.ch>
 <608a7d9d-9238-281a-8770-aa20feb7e6be@alliedtelesis.co.nz>
 <YnxUcB2e+Y9gtwI7@lunn.ch>
 <d9663aa1-e574-f12f-a330-79d984af107e@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9663aa1-e574-f12f-a330-79d984af107e@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes there are registers that you can read to identify the specific chip.
> 
> It still might be useful to have a expected vs actual check as those ID 
> values are determined by pin strapping resistors.

That i don't get? Can i turn a 

* 98DX2538: 24x1G + 2x10G + 2x10G Stack

into a

* 98DX2535: 24x1G + 4x1G Stack

by strapping its pin differently?

> It could also be used 
> to validate the dts (e.g. port 20 would be invalid on a 98DX3501). But 
> those are considerations for further down the track.

Yes, that would be up to the switchdev driver to validate the DT based
on the ID register.

   Andrew
