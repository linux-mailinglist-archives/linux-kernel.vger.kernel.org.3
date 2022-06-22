Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9247655507F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359736AbiFVP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359858AbiFVP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:56:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9EC73F899;
        Wed, 22 Jun 2022 08:54:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2888712FC;
        Wed, 22 Jun 2022 08:54:37 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15B53F792;
        Wed, 22 Jun 2022 08:54:33 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:53:22 +0100
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
Subject: Re: [PATCH 3/4] firmware: arm_scmi: Get detailed power scale from
 perf
Message-ID: <20220622155322.g2idz2623nxi6mu3@bogus>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622145802.13032-4-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:58:01PM +0100, Lukasz Luba wrote:
> In SCMI v3.1 the power scale can be in micro-Watts. The upper layers, e.g.
> cpufreq and EM should handle received power values properly (upscale when
> needed). Thus, provide an interface which allows to check what is the
> scale for power values. The old interface allowed to distinguish between
> bogo-Watts and milli-Watts only (which was good for older SCMI spec).
>

Assuming you will take this as a series,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
