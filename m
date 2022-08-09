Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FF58DAA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiHIO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244671AbiHIO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:58:51 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643A1D323;
        Tue,  9 Aug 2022 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=JRyd0USx0pAjaDjWtRY6YJGa08LFJASFCAJlB960sTw=; b=Ib
        1iUpuLHo7K4v0EYPMfORFnZWBbySKthJvN7xPmqmsqiny2soEZmRMUpKdBBr7OsUEN8e+l/O/rmfB
        s9zbhvo3DJOInNlP3Zl3xzp+p0UYrtFVUY6l2dIv1eSDRLsOuOYk6y9VcbjRiAQdkRPJVgZKL7Xf/
        MvAGFHCj4QZU2Jw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oLQgm-00Cq24-Vp; Tue, 09 Aug 2022 16:58:36 +0200
Date:   Tue, 9 Aug 2022 16:58:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <YvJ2HKqMTTyWiNth@lunn.ch>
References: <20220713200123.22612-1-pali@kernel.org>
 <20220809131252.z3mbmiz4duxwlauw@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220809131252.z3mbmiz4duxwlauw@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 03:12:52PM +0200, Pali Rohár wrote:
> + Andrew, Gregory, Sebastian
> 
> please comment on this

Krzysztof said:

> The change is an ABI break, which looks reasonable, but still
> platform maintainer should comment on it. Especially on the aspect
> why the marvell,armada3710 fallback was chosen at the first place.

I was not involved in the armada37xx enablement. I have no idea why
marvell,armada3710 fallback was chosen.

Gregory might know, he is the author of this file.

It does however seem reasonable. And a grep does suggest this
compatible is purely cosmetic, it is not matched on anywhere.

	   Andrew
