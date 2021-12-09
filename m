Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1B46E2FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhLIHOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:14:36 -0500
Received: from muru.com ([72.249.23.125]:36326 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhLIHOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:14:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BE29C80A3;
        Thu,  9 Dec 2021 07:11:42 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:10:59 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: elpida_ecb240abacn: Change Elpida compatible
Message-ID: <YbGsAxOOHHJfDUCT@atomide.com>
References: <20211019234059.29877-1-digetx@gmail.com>
 <a584428e-99f7-986e-90d5-7e81ca213158@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a584428e-99f7-986e-90d5-7e81ca213158@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Dmitry Osipenko <digetx@gmail.com> [211027 12:19]:
> 20.10.2021 02:40, Dmitry Osipenko пишет:
> > Vendor prefix shouldn't start with capital letter. The Elpida Memory
> > compatible was never used in practice, hence just correct the compatible.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  arch/arm/boot/dts/elpida_ecb240abacn.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
> > index d87ee4794f83..9698801cbcfb 100644
> > --- a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
> > +++ b/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
> > @@ -5,7 +5,7 @@
> >  
> >  / {
> >  	elpida_ECB240ABACN: lpddr2 {
> > -		compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
> > +		compatible	= "elpida,ECB240ABACN","jedec,lpddr2-s4";
> >  		density		= <2048>;
> >  		io-width	= <32>;
> >  
> > 
> 
> This patch should go via OMAP tree since there is only OMAP board which
> uses this dtsi. To make it more clear, "elpida" variant is now
> documented in the bindings [1][2].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9e17f71e9c334f14ad6a8ec3edc09c7a4244e12f
> 
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=001b8b2594db4ea24fbea4c161e665f858917fce
> 
> If there is no interest in taking the patch via OMAP tree, then it may
> go via the DT git tree. Rob, you should pick it up then.

Applying into omap-for-v5.17/dt thanks.

Regards,

Tony
