Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7494E511A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiCWLSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbiCWLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:18:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A83A57891B;
        Wed, 23 Mar 2022 04:16:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467FFED1;
        Wed, 23 Mar 2022 04:16:38 -0700 (PDT)
Received: from bogus (unknown [10.57.41.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C74303F73B;
        Wed, 23 Mar 2022 04:16:34 -0700 (PDT)
Date:   Wed, 23 Mar 2022 11:15:05 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v11 0/9] Add Sunplus SP7021 SoC Support
Message-ID: <20220323111505.caioueiqdj75kw6b@bogus>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <YjmrdlQqoqUNcs7R@bogus>
 <be7f6ea70a5146a190c750695aead7f5@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be7f6ea70a5146a190c750695aead7f5@cqplus1.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:40:51AM +0000, qinjian[覃健] wrote:
> > 
> > Not related to this series, but to the platform in general. You still
> > need to resolved the boot/cpu-method for this platform before you add
> > support for all the 4 cpus on this platform. I remember discussing about
> > CPUIdle on a separate thread. I thought this is best thread to remind that
> > so that it is addressed before we see either cpuidle or cpuhotplug support
> > on this platform.
> > 
> Thanks for your comments.
> Currently,  we boot all 4 cores via psci successfully.
> 

That's great. Sounds like Edwin Chiu may not be fully aware of the situation
based on the discussion we had here[1]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com/
