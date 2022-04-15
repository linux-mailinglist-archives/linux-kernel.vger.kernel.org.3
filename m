Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947725028EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352711AbiDOLtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiDOLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:49:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DA673D6;
        Fri, 15 Apr 2022 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kxc9T+YmUkntjESaace9DUZMT9xh/VGpJbsX4b1xNhA=; b=QpNZanhdbt2h22Yyn3PDrPmN/W
        c7i9nWyKnjhldyXFgjcMUAVkRyHBxFUa5+6XhPO75fQ44w7VdNPw6uSGv6c8nUyv8Z/BJBctencM2
        8b6mut/J7qmugrxIq1QbP8JyRy6i63GBLs+B6HPm3cT70PW3HjQNERTcjSZPQBMfmwlk=;
Received: from p200300ccff0ff7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0f:f700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nfKOf-0001qL-Om; Fri, 15 Apr 2022 13:45:54 +0200
Date:   Fri, 15 Apr 2022 13:45:52 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        =?UTF-8?B?T25kxZllag==?= Jirman <x@xff.cz>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/16] dt-bindings: display: rockchip: Add EBC
 binding
Message-ID: <20220415134552.182b49a9@aktux>
In-Reply-To: <d5bb060e-5964-db0d-ca93-5f73ee9277a3@sholland.org>
References: <20220413221916.50995-1-samuel@sholland.org>
        <20220413221916.50995-3-samuel@sholland.org>
        <20220414101548.2b9c3dad@aktux>
        <d5bb060e-5964-db0d-ca93-5f73ee9277a3@sholland.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 22:00:09 -0500
Samuel Holland <samuel@sholland.org> wrote:

> Hi Andreas,
> 
> Thanks for the comments.
> 
> On 4/14/22 3:15 AM, Andreas Kemnade wrote:
> > Hi Samuel,
> > 
> > for comparison, here is my submission for the IMX EPDC bindings:
> > 
> > https://lore.kernel.org/linux-devicetree/20220206080016.796556-2-andreas@kemnade.info/
> > 
> > On Wed, 13 Apr 2022 17:19:02 -0500
> > Samuel Holland <samuel@sholland.org> wrote:
> > 
> > [...]
> > we have sy7636a driver in kernel which should be suitable for powering a EPD
> > and temperature measurement. So I would expect that to be   
> >> +  io-channels:
> >> +    maxItems: 1
> >> +    description: I/O channel for panel temperature measurement
> >> +  
> > so how would I reference the hwmon/thermal(-zone) of the sy7636a here?  
> 
> It seems the consensus is to use a thermal zone for panel temperature, so I will
> need to change this.
> 
I am open to anything here as long as it fits together.

> I think it's best to reference the thermal zone by phandle, not by name, even if
> it requires extending the thermal zone API to support this.
> 
maybe referencing the hwmon might be interesting, or we add a hwmon_iio
adaptor. The other way round it is there. The thermal zone stuff is
only needed because hwmon cannot referenced directly.

Regards,
Andreas
