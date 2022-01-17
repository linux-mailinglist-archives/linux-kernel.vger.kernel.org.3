Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1C4905F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiAQKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:31:22 -0500
Received: from foss.arm.com ([217.140.110.172]:56348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238606AbiAQKbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:31:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D1A96D;
        Mon, 17 Jan 2022 02:31:20 -0800 (PST)
Received: from bogus (unknown [10.57.38.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7C0D3F73D;
        Mon, 17 Jan 2022 02:31:17 -0800 (PST)
Date:   Mon, 17 Jan 2022 10:31:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 11/11] clk: scmi: Support atomic clock enable/disable
 API
Message-ID: <20220117103100.c6ltxnz4iqmbc4b5@bogus>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
 <20211220195646.44498-12-cristian.marussi@arm.com>
 <20220114230839.ABD63C36AE9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114230839.ABD63C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:08:37PM -0800, Stephen Boyd wrote:
> Quoting Cristian Marussi (2021-12-20 11:56:46)
> > Support also atomic enable/disable clk_ops beside the bare non-atomic one
> > (prepare/unprepare) when the underlying SCMI transport is configured to
> > support atomic transactions for synchronous commands.
> > 
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > NOTE THAT STILL THERE'S NO FINE GRAIN CONTROL OVER SELECTION
> > OF WHICH CLOCK DEVICES CAN SUPPORT ATOMIC AND WHICH SHOULD NOT
> > BASED ON CLOCK DEVICES ENABLE LATENCY.
> > THIS HAS STILL TO BE ADDED IN SCMI PROTOCOL SPEC.
> 
> Why are you yelling on the internet? :-) I guess I need to ack this.
>

It is for the partners who request such changes. We are trying to prototype
and share the code and ask for feedback before we finalise the specification.

In fact it is other way around for you 😁. Not to ack as it is not yet final
😉. At least I need to wait until the spec contents are finalised before I
can merge with your ack 😁. But I agree RFC would have indicated that along
with the above background instead of *yelling*. Cristian assumed everyone
is aware of the content as quite a few are involved in offline discussions.

> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks anyways, will use it if nothing changes.

-- 
Regards,
Sudeep
