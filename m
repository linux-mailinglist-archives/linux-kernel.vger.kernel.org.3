Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7450553E97A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbiFFOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiFFOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:43:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 406F84E3B2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:43:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198711595;
        Mon,  6 Jun 2022 07:43:54 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38C0F3F73B;
        Mon,  6 Jun 2022 07:43:52 -0700 (PDT)
Date:   Mon, 6 Jun 2022 15:43:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on
 protocol list
Message-ID: <20220606144305.agzzyf7c4kp2nwlw@bogus>
References: <20220523171559.472112-1-cristian.marussi@arm.com>
 <45bf11a8-47eb-e088-ba99-30c8788c7143@wolfvision.net>
 <Yp4Br5d0jMnlF5yy@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp4Br5d0jMnlF5yy@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 02:31:48PM +0100, Cristian Marussi wrote:
> On Mon, Jun 06, 2022 at 02:59:10PM +0200, Michael Riesch wrote:
> > Hi Cristian,
> >
> Hi Michael,
>
> > On 5/23/22 19:15, Cristian Marussi wrote:
> > > Even though malformed replies from firmware must be treated carefully to
> > > avoid memory corruption Kernel side, some out-of-spec SCMI replies can
> > > be tolerated to avoid breaking existing deployed system, as long as they
> > > won't cause memory issues.
> > >
> > > Reported-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > Cc: Etienne Carriere <etienne.carriere@linaro.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >
> > Thanks a lot, without this fix the Mali G52 GPU won't probe on my RK3568
> > EVB1 in vanilla v5.19-rc1.
> >
>
> Yes, the break was reported on -next and today it appeared in 5.19-rc1.
> A proper FW fix is also up for review by Etienne but in the meantime
> this tries to limit damages relaxing a bit the checks.
>
> > I guess this patch should have a Fixes: tag, right?
> >
>
> It has not a Fixes tag because the issue was introduced in 5.19-rc1 and the
> fix will go in with the next round of v5.19 fixes by Sudeep (AFAIU) so it
> will be solved within the v5.19 cycle and I thought the Fixes tag was
> not needed in this case (I could be wrong...)

Correct, if for some reason, we can't push this before v5.19, then fixes
tag needs to added. I will add that then, but for now let us target getting
it in before v5.19

--
Regards,
Sudeep
