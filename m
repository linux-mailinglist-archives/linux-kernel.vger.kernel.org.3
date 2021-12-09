Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2246E36A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhLIHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:46:45 -0500
Received: from muru.com ([72.249.23.125]:36390 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhLIHqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:46:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C5F8780A3;
        Thu,  9 Dec 2021 07:43:52 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:43:09 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     bcousson@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND v6 0/3] ARM: dts: TI AM437X ADC1
Message-ID: <YbGzjTnYlmO8g63G@atomide.com>
References: <20211126142413.354770-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126142413.354770-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Miquel Raynal <miquel.raynal@bootlin.com> [211126 16:24]:
> Hello, as part of a very big series, support for the AM437X ADC1 has
> been merged in v5.16-rc1. It involved quite a few changes in the MFD and
> IIO subsystems, as well as the acknowledgment of new bindings:
> https://lkml.org/lkml/2021/10/15/217
> 
> Now that everything is upstream, it's time to merge the device tree
> changes which I am resending today (already Acked-by Tony but not taken
> by anybody yet).

Thanks applying all three into omap-for-v5.17/dt.

Tony
