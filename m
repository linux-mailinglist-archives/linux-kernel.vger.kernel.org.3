Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A946E366
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhLIHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:44:30 -0500
Received: from muru.com ([72.249.23.125]:36378 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhLIHoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:44:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 207B580A3;
        Thu,  9 Dec 2021 07:41:38 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:40:55 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: am335x: add rtc system-power-controller
Message-ID: <YbGzBzGlbWQdZnmr@atomide.com>
References: <20211018220018.1514652-1-dfustini@baylibre.com>
 <YW7ArLpGwKz2Fc/b@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7ArLpGwKz2Fc/b@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [211019 12:57]:
> On Mon, Oct 18, 2021 at 03:00:18PM -0700, Drew Fustini wrote:
> > Johan pointed out when I submitted "ARM: dts: am335x: Add rtc node as
> > system-power-controller" [1] that mentioning am335x-evm and boneblack
> > in the commit message was incorrect. system-power-controller is already
> > present in am335x-boneblack-common.dtsi and am335x-evm would need the
> > property added directly to the dts file.
...
> > Drew Fustini (2):
> >   ARM: dts: am335x-boneblack-common: move system-power-controller
> >   ARM: dts: am335x-icev2: Add system-power-controller to RTC node
> 
> Nice work. I trust your review of the schematics, and only
> double-checked sancloud-bbe. The patches look good.
> 
> For the series:
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks applying both into omap-for-v5.17/dt.

Regards,

Tony
