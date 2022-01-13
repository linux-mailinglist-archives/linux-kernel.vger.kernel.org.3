Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DAA48D4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiAMJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:16:34 -0500
Received: from comms.puri.sm ([159.203.221.185]:47166 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbiAMJQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:16:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8CACFE04DF;
        Thu, 13 Jan 2022 01:16:02 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0h8TyHm8kzhB; Thu, 13 Jan 2022 01:16:02 -0800 (PST)
Message-ID: <ab560610d70a4e3499255284b3170b0b16572bb8.camel@puri.sm>
Subject: Re: [PATCH v1] usb: typec: tipd: keep default interrupts enabled
 during probe()
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Hector Martin <marcan@marcan.st>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, sven@svenpeter.dev, hdegoede@redhat.com
Cc:     kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Jan 2022 10:15:56 +0100
In-Reply-To: <f8b4606a-e3ec-e452-f291-7ac36c69f8cd@marcan.st>
References: <20220110163559.711404-1-martin.kepplinger@puri.sm>
         <f8b4606a-e3ec-e452-f291-7ac36c69f8cd@marcan.st>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 11.01.2022 um 20:10 +0900 schrieb Hector Martin:
> On 2022/01/11 1:35, Martin Kepplinger wrote:
> > Commit 9990f2f6264c ("usb: typec: tipd: Enable event interrupts by
> > default")
> > writes a fixed set of interrupts to TPS_REG_INT_MASK1. In case
> > interrupts
> > had been enabled by the firmware by default, these get disabled now
> > which can break use cases. Only append to what is already enabled
> > instead.
> > 
> 
> I'm confused. The kernel drives the hardware, it needs to enable only
> the interrupts it can handle. Do you have some kind of firmware
> trying
> to share access to the same I2C port that needs other interrupts?
> That
> sounds like a recipe for trouble... or am I misunderstanding things?
> 
> If the *kernel* needs other interrupts enabled to make something
> work,
> then they should also be enabled unconditionally, and you'd have to
> check the IRQ handler to make sure it actually handles it.
> 

true. sorry for the confusion. we need to submit the patches for the
interrupt handler to handle what we need and then we'll extend the mask
accordingly. please ignore this patch.

thank you,
                               martin


