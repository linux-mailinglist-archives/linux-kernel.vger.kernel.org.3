Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0C59F822
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiHXKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiHXKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:47:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B876742
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rTm5itbKiSggiZhC57sLbFwshHgkWsM/GK2tpy85Hhg=; b=tZ283tF6Qioq3UAnjyduhp9nnn
        vB5kQlRsYeG19DWkL1T8va0C0CN9I3PxkIREsIeciemRFViweck9YdEV2k++TSNVg5ZhfQl+yw8wa
        rFUrQ2NpUY9iF0ErtJLcdawjcJ4FCww4XzYajVMNcw9GXUHmmlk31YyKvLKP61OR1aK9eNomYK3dw
        r8yjlMsJzoxUKUYQZLThmrn8bzJK8ur2kPZ/aXLGANGjCTvd144hSwKoK/7kEaI0tucNShLGugw90
        xgAcP4SJkXTHBzLYEFjI54w6QLnhXIV2kd9B/lohtb+LDWAOw1mn+FDjxbJIAZjmuDbM1njHxBj74
        KUIIxq8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33910)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oQnv3-000475-T2; Wed, 24 Aug 2022 11:47:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oQnv1-00043V-SO; Wed, 24 Aug 2022 11:47:31 +0100
Date:   Wed, 24 Aug 2022 11:47:31 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/4] ARM: footbridge: remove leftover from personal-server
Message-ID: <YwYBw/77TiZjuCub@shell.armlinux.org.uk>
References: <20220818211550.3272321-1-arnd@kernel.org>
 <20220818211550.3272321-3-arnd@kernel.org>
 <20220821055537.GB25950@lst.de>
 <CAK8P3a3x5qvEdJJXTMzgu0jXjzXh6LqQRESpGM2XPHiYHm7scg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3x5qvEdJJXTMzgu0jXjzXh6LqQRESpGM2XPHiYHm7scg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:37:15PM +0200, Arnd Bergmann wrote:
> On Sun, Aug 21, 2022 at 7:55 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Aug 18, 2022 at 11:15:48PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The machine was removed a while ago, and the checks are
> > > now useless.
> >
> > Curious, should entries for removed machines be kept in the mach-types
> > file?  Because that makes it really easy to leave dead code like this
> > around.
> 
> A long time ago it was common to add the entries in mach-types before
> the Kconfig symbol got merged, an  Russell just updated the list
> periodically to drop stale entries. As we remove most board files in
> a coming release, we should probably do this as part of the bigger
> cleanup then.

The scripting I have for it doesn't understand "board was removed from
the kernel" so if I ever run the script in the future (unlikely) it'll
get re-added.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
