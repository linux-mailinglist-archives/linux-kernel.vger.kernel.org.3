Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99A5A7C27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiHaL1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHaL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:27:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA53825E3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:27:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FD92ED1;
        Wed, 31 Aug 2022 04:27:25 -0700 (PDT)
Received: from bogus (unknown [10.57.44.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCF73F766;
        Wed, 31 Aug 2022 04:27:17 -0700 (PDT)
Date:   Wed, 31 Aug 2022 12:26:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH 8/9] tee: optee: Drop ffa_ops in optee_ffa structure
Message-ID: <20220831112652.brjnuygzkvcteadx@bogus>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
 <20220830100700.344594-9-sudeep.holla@arm.com>
 <CAFA6WYPXsLt692eW3_tqy+=aLz7W-Ymh-RqZuqATeHpzGp8Tkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPXsLt692eW3_tqy+=aLz7W-Ymh-RqZuqATeHpzGp8Tkw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:28:01PM +0530, Sumit Garg wrote:
> On Tue, 30 Aug 2022 at 15:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Since the ffa_device itself carries ffa_dev_ops now, there is no need
> > to keep a copy in optee_ffa structure.
> >
> > Drop ffa_ops in the optee_ffa structure as it is not needed anymore.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/tee/optee/ffa_abi.c       | 9 ++++-----
> >  drivers/tee/optee/optee_private.h | 1 -
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> 
> Is this patch doing anything different from patch #2? If not then I
> think both should be squashed.
>

Indeed, I thought about squashing them and forgot before getting there.
Does the review tag still apply for 2/9 after I squash this into it.

Thanks for the review.

-- 
Regards,
Sudeep
