Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237C51BCDC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiEEKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354904AbiEEKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:14:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EECC24A3EE
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:10:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FDF106F;
        Thu,  5 May 2022 03:10:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5F73FA27;
        Thu,  5 May 2022 03:10:35 -0700 (PDT)
Date:   Thu, 5 May 2022 11:10:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to
 boot due to firmware bug
Message-ID: <20220505101032.icqb2hau4dhj3afr@bogus>
References: <1698297.NAKyZzlH2u@archbook>
 <20220504132130.wmmmge6qjc675jw6@bogus>
 <3764923.NsmnsBrXv5@archbook>
 <YnOEwuuyO2/h7c1G@e120937-lin>
 <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > On Wed, May 04, 2022 at 02:49:07PM +0200, Nicolas Frattaroli wrote:
> > > > > Good day,
> > > > >
> > > > > a user on the #linux-rockchip channel on the Libera.chat IRC network
> > > > > reported that their RK3568 was no longer getting a CPU and GPU clock
> > > > > from scmi and consequently not booting when using linux-next. This
> > > > > was bisected down to the following commit:

OK I missed to read the above properly earlier. If scmi probe failure is
resulting in Linux boot failure, then that is another bug that needs fixing.
Why does not getting CPU clock block the boot. I would like to see the boot
logs. I considered this issue to be non-fatal and must be just ending up
disabling all SCMI communication. But the reported issue is boot failure
which sounds like another/different bug and I would like that to be fixed
first before we push the workaround for the reported issue so that it is
not ignored.

Has anyone analysed why the absence of CPU clock results in boot failure ?
Are you running the upstream kernel itself ?

-- 
Regards,
Sudeep
