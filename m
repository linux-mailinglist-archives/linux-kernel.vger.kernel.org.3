Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04B4A7F92
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348683AbiBCHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:04:58 -0500
Received: from muru.com ([72.249.23.125]:45710 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbiBCHE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:04:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 436F580EE;
        Thu,  3 Feb 2022 07:04:42 +0000 (UTC)
Date:   Thu, 3 Feb 2022 09:04:55 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH 01/12] genirq: Allow the PM device to originate from irq
 domain
Message-ID: <Yft+l6/JQlZM88rs@atomide.com>
References: <20220201120310.878267-1-maz@kernel.org>
 <20220201120310.878267-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201120310.878267-2-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Zyngier <maz@kernel.org> [220201 12:03]:
> As a preparation to moving the reference to the device used for
> runtime power management, add a new 'dev' field to the irqdomain
> structure for that exact purpose.
> 
> The irq_chip_pm_{get,put}() helpers are made aware of the dual
> location via a new private helper.
> 
> No functional change intended.

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
