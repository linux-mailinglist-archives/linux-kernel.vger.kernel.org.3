Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA40B46CE7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbhLHHsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLHHss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:48:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5011EC061574;
        Tue,  7 Dec 2021 23:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90E21CE2037;
        Wed,  8 Dec 2021 07:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853CCC341C3;
        Wed,  8 Dec 2021 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638949513;
        bh=wW9RIet2nCD3niwV3rcV7PvV9BC7tdBsrg1L8F8DdmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FNkTtqglWMumOqKlVH+Oztoj3XnhZjMI47pI/4mALFUcnU0KHATz622LZK0km7XF8
         cdc2z+Zusc2nYQVgWsXskm/5ppYcHMpYRTyheS/WbgJg8vU/k+f9lxvQeLsqHcEmtP
         qhekOYqMDzrxkW+q4JyGxlKnDQGdsiQVKbR9S66KLUv32rjO1on0aAMe3nN0pfGqbL
         oeuWS86YzrRKDOxlmbIpURLySBhgu95PWahr185TSCWpwbsKhjXjXR/0Y5CjST/tBj
         DtAnRBLw6ka5WQOJGDN9gq7M7Y4OmjVQ5s5qkbHLeASoRjEuMWAQq4mYmnB9rNJhFg
         Jr6pu2PG2SgPQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1murdX-00Ai3a-D7; Wed, 08 Dec 2021 07:45:11 +0000
MIME-Version: 1.0
Date:   Wed, 08 Dec 2021 07:45:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?qinjian=5B=E8=A6=83=E5=81=A5=5D?= <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        =?UTF-8?Q?Wells_Lu_=E5=91=82=E8=8A=B3?= =?UTF-8?Q?=E9=A8=B0?= 
        <wells.lu@sunplus.com>
Subject: Re: [PATCH v5 08/10] irqchip: Add Sunplus SP7021 interrupt controller
 driver
In-Reply-To: <39f9b853af7c44cb94421354744512a8@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
 <e88ea4cf28ba69a41f6d1b4dd4128b82a6095c29.1638515726.git.qinjian@cqplus1.com>
 <87r1ao23fp.wl-maz@kernel.org>
 <39f9b853af7c44cb94421354744512a8@cqplus1.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ce867937861df454823eb703bfd29256@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qinjian@cqplus1.com, robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de, p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, wells.lu@sunplus.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 07:15, qinjian[覃健] wrote:
>> > +void sp_intc_set_ext(u32 hwirq, int ext_num)
>> > +{
>> > +	sp_intc_assign_bit(hwirq, REG_INTR_PRIORITY, !ext_num);
>> > +}
>> > +EXPORT_SYMBOL_GPL(sp_intc_set_ext);
>> 
>> No way. We don't export random symbols without a good justification,
>> and you didn't give any.
>> 
> 
> This function called by SP7021 display driver to decide DISPLAY_IRQ
> routing to which parent irq (EXT_INT0 or EXT_INT1).

Based on what? How can a display driver decide which parent is
appropriate? What improvement does this bring?

> In previous patches, which defined in DT, parsed & processed @
> sp_intc_xlate_of()
> From your comment, this is a SW decision. So I removed it from DT &
> intc driver, only
> export this function to access the related intc reg.

If a decision has to be made, it has to be done in the interrupt
controller driver, or rely on the standard API. Exporting random
low level functions to other random drivers is not acceptable.

         M.
-- 
Jazz is not dead. It just smells funny...
