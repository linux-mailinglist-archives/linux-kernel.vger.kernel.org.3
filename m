Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF2562022
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiF3QT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiF3QT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:19:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4FC62A974
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:19:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC2331042;
        Thu, 30 Jun 2022 09:19:55 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E93263F66F;
        Thu, 30 Jun 2022 09:19:53 -0700 (PDT)
Date:   Thu, 30 Jun 2022 17:18:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 0/2] Add SCMI full message tracing
Message-ID: <20220630161842.n57xwxbhon4hq4ln@bogus>
References: <20220623145533.2882688-1-cristian.marussi@arm.com>
 <CA+-6iNx_EW_L5Ffn-L+xyg8VVGVPyBonvBFVV6dq69HpTHdqrQ@mail.gmail.com>
 <YryXp5ieC+dz8CSy@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YryXp5ieC+dz8CSy@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:19:32PM +0100, Cristian Marussi wrote:
> On Mon, Jun 27, 2022 at 03:05:57PM -0400, Jim Quinlan wrote:

[...]

> > This format is also easy to parse with a script:  strip the preamble,
> > split on whitespace, and then split on '=' to get the  [key, value]
> > pairs.
> 
> In fact having a grep-friendly format is better.
> 
> Thanks for your feedback, I'll wait to see if someone else wants to
> chime in and repost.
> 

I agree with Jim's proposal, please update and send the patch.

-- 
Regards,
Sudeep
