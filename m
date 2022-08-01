Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2891A586793
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiHAKiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHAKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:38:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D7A7371AC;
        Mon,  1 Aug 2022 03:38:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0ED139F;
        Mon,  1 Aug 2022 03:38:09 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A5BC3F67D;
        Mon,  1 Aug 2022 03:38:06 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:38:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     jassisinghbrar@gmail.com
Cc:     robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] arm64: dts: juno: Add missing MHU secure-irq
Message-ID: <20220801103803.5fyftr4jbgfvim7l@bogus>
References: <20220730142336.484564-1-jassisinghbrar@gmail.com>
 <20220801103308.yehh7l6k4fmrxlqh@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801103308.yehh7l6k4fmrxlqh@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:33:08AM +0100, Sudeep Holla wrote:
> On Sat, Jul 30, 2022 at 09:23:36AM -0500, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> > 
> > The MHU secure interrupt exists physically but is missing in the DT node.
> > 
> > Specify the interrupt in DT node to fix a warning on Arm Juno board:
> >    mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
> >
> 
> It fails to apply on v5.18-rc1 or v5.19. Can you please rebase and resend ?
> 

Sorry I meant v5.19-rc1 or v5.19 as my -next branch is based on the former.
IIUC the interrupt-names are dropped couple of release back as it was not
in the binding.

-- 
Regards,
Sudeep
