Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0F51492C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359021AbiD2M0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiD2M0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:26:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA5C1C81
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=+F+t14h7dCMqtUvgMcQLvebwaz98xMAMgfVgVM5gZxg=; b=DH
        fc0fp2suOod35jaezHtQzI/GeWnMOnPNtvy2ZZ3zkoTI2xVJkpzpoOGrQlNOqVEb/u+BZELggxi1n
        ZH80PsT32uFBiQY+kmsdbPkWUCG64t69VLluRPwU1ckgVR+me+XvikcRVHLOGUOBMaGTXSzqmWqDU
        bftFOR3zqswBLEM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nkPeO-000TdN-Ev; Fri, 29 Apr 2022 14:23:08 +0200
Date:   Fri, 29 Apr 2022 14:23:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip/armada-370-xp: Do not touch Performance
 Counter Overflow on A375, A38x, A39x
Message-ID: <YmvYrFUfIUvfjrmY@lunn.ch>
References: <20220425113706.29310-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425113706.29310-1-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:37:05PM +0200, Pali Rohár wrote:
> Register ARMADA_370_XP_INT_FABRIC_MASK_OFFS is Armada 370 and XP specific
> and on new Armada platforms it has different meaning. It does not configure
> Performance Counter Overflow interrupt masking. So do not touch this
> register on non-A370/XP platforms (A375, A38x and A39x).

Hi Pali

Do the Armada 375, 38x and 39x have an over flow interrupt? I assume
not.

Does this need a fixes tag? Should it be back ported in stable?

     Andrew
