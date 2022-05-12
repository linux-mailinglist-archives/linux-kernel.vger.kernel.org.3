Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298352502C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355369AbiELOeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355044AbiELOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:34:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D834F9C2E8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:34:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC4C9106F;
        Thu, 12 May 2022 07:34:34 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B4B3F73D;
        Thu, 12 May 2022 07:34:33 -0700 (PDT)
Date:   Thu, 12 May 2022 15:34:30 +0100
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
Message-ID: <Yn0a9nSD7Yu6aOkt@bogus>
References: <1698297.NAKyZzlH2u@archbook>
 <YnOEwuuyO2/h7c1G@e120937-lin>
 <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
 <6587375.6lpfYT6tjA@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6587375.6lpfYT6tjA@archbook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:11:22PM +0200, Nicolas Frattaroli wrote:
> Hello,
> 
> sorry for the late reply, completely missed that there was a question
> for me in this mail.
> 
> On Donnerstag, 5. Mai 2022 11:40:09 CEST Etienne Carriere wrote:
> > Hello Nicolas, Cristian,
> > [...]
> > 
> > Indeed the firmware implementation is wrong in TF-A.
> > And also in OP-TEE by the way:
> > https://github.com/OP-TEE/optee_os/blob/3.17.0/core/drivers/scmi-msg/base.c#L163-L166
> > 
> > @Nicoals, do you want to send a patch to TF-A, or do you want me to do it?
> 
> I have no experience with TF-A, so I'd prefer if you could do it.
> 
> In good news, Rockchip has confirmed they're preparing to release RK356x
> TF-A sources, so I'll be able to port the patch over to their sources once
> they are released, if they don't already apply it themselves.
> 

So, there is no way to get a blob release with the patch applied ?
We know it is a bug in TF-A and if Rockchip is using that codebase, it
will be the same bug there too causing this issue. Waiting until the
code is released and the proper TF-A port is done may not be acceptable
for many developers. So someone from the rockchip doing these tf-a blob
release must get involved here, understand the situation and get the fixed.

We can workaround, but I want to hear that it will be fixed instead of
getting ignored until proper port is available.

Etienne, are you not the author for the related TF-A code ? How can we
get that fixed in the TF-A code base. If you are not, then I will try to
get my repo login credentials sorted so that I can only push TF-A change.

-- 
Regards,
Sudeep
