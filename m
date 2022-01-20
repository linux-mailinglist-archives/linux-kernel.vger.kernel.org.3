Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B50494C45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiATKys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:54:48 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60411 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiATKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:54:46 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AD8E640002;
        Thu, 20 Jan 2022 10:54:43 +0000 (UTC)
Date:   Thu, 20 Jan 2022 11:54:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel@lists.infradead.org,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH] dt-bindings: rtc: st,stm32-rtc: Make each example a
 separate entry
Message-ID: <Yek/c2hPGID0neTc@piout.net>
References: <20220106182518.1435497-7-robh@kernel.org>
 <Yeg4Sba3eye24+LG@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yeg4Sba3eye24+LG@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 19/01/2022 10:11:53-0600, Rob Herring wrote:
> On Thu, 06 Jan 2022 12:25:15 -0600, Rob Herring wrote:
> > Each independent example should be a separate entry. This allows for
> > 'interrupts' to have different cell sizes.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Applied, thanks!

Just for the record, I didn't reply but I trust you completely on this
one ;) I'm usually letting you apply dt-bindings only patches, let me
know if you prefer they go through my tree.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
