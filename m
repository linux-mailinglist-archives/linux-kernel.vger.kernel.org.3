Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47024908CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbiAQMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:40:40 -0500
Received: from foss.arm.com ([217.140.110.172]:57746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237036AbiAQMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:40:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12086D;
        Mon, 17 Jan 2022 04:40:38 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C63473F73D;
        Mon, 17 Jan 2022 04:40:36 -0800 (PST)
Date:   Mon, 17 Jan 2022 12:40:30 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 11/11] clk: scmi: Support atomic clock enable/disable
 API
Message-ID: <20220117124029.GD6113@e120937-lin>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
 <20211220195646.44498-12-cristian.marussi@arm.com>
 <20220114230839.ABD63C36AE9@smtp.kernel.org>
 <20220117103100.c6ltxnz4iqmbc4b5@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117103100.c6ltxnz4iqmbc4b5@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:31:00AM +0000, Sudeep Holla wrote:
> On Fri, Jan 14, 2022 at 03:08:37PM -0800, Stephen Boyd wrote:
> > Quoting Cristian Marussi (2021-12-20 11:56:46)
> > > Support also atomic enable/disable clk_ops beside the bare non-atomic one
> > > (prepare/unprepare) when the underlying SCMI transport is configured to
> > > support atomic transactions for synchronous commands.
> > > 

Hi,

> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > NOTE THAT STILL THERE'S NO FINE GRAIN CONTROL OVER SELECTION
> > > OF WHICH CLOCK DEVICES CAN SUPPORT ATOMIC AND WHICH SHOULD NOT
> > > BASED ON CLOCK DEVICES ENABLE LATENCY.
> > > THIS HAS STILL TO BE ADDED IN SCMI PROTOCOL SPEC.
> > 
> > Why are you yelling on the internet? :-) I guess I need to ack this.
> >
> 

Sorry I did not mean to yell really, just to warn partners using this.

> It is for the partners who request such changes. We are trying to prototype
> and share the code and ask for feedback before we finalise the specification.
> 
> In fact it is other way around for you 😁. Not to ack as it is not yet final
> 😉. At least I need to wait until the spec contents are finalised before I
> can merge with your ack 😁. But I agree RFC would have indicated that along
> with the above background instead of *yelling*. Cristian assumed everyone
> is aware of the content as quite a few are involved in offline discussions.
> 
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> Thanks anyways, will use it if nothing changes.
> 

As Sudeep said, V8 it is indeed not the final version which is going to
be posted soon after the merge-windows (without yelling :D) and which it
will be indeed still marked as RFC since it does include a new protocol
feature which is still under review and not published.

Sorry for the noise.

Thanks,
Cristian
