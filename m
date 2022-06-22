Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241AE555091
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359846AbiFVP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359817AbiFVP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:59:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22561427EF;
        Wed, 22 Jun 2022 08:56:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E385D12FC;
        Wed, 22 Jun 2022 08:56:18 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00FA3F792;
        Wed, 22 Jun 2022 08:56:15 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:55:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        cristian.marussi@arm.com, matthias.bgg@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] cpufreq: scmi: Support the power scale in
 micro-Watts in SCMI v3.1
Message-ID: <20220622155504.bcggz7spw4n2ehyj@bogus>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622145802.13032-5-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:58:02PM +0100, Lukasz Luba wrote:
> The SCMI v3.1 adds support for power values in micro-Watts. They are not
> always in milli-Watts anymore (ignoring the bogo-Watts). Thus, the power
> must be converted conditionally before sending to Energy Model. Add the
> logic which handles the needed checks and conversions.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
