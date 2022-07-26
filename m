Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB35816E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiGZP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiGZP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:59:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61E392F64D;
        Tue, 26 Jul 2022 08:59:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830001FB;
        Tue, 26 Jul 2022 08:59:54 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.72.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABC93F73B;
        Tue, 26 Jul 2022 08:59:52 -0700 (PDT)
Date:   Tue, 26 Jul 2022 16:59:30 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, kajetan.puchalski@arm.com
Subject: Re: [PATCH] cpuidle: Add cpu_idle_miss trace event
Message-ID: <YuAPYrAH7jRroZLn@e126311.manchester.arm.com>
References: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
 <20220726100816.3e37ed97@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726100816.3e37ed97@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:08:16AM -0400, Steven Rostedt wrote:
> On Tue, 26 Jul 2022 11:24:04 +0100
> Kajetan Puchalski <kajetan.puchalski@arm.com> wrote:
 
> For the tracing POV,
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks a lot for taking a look!

> -- Steve
