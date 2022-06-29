Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DF2560AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiF2T4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiF2T4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:56:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161062BB1F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:56:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 168CF1480;
        Wed, 29 Jun 2022 12:56:09 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFAE3F792;
        Wed, 29 Jun 2022 12:56:05 -0700 (PDT)
Date:   Wed, 29 Jun 2022 20:54:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atishp@atishpatra.org, atishp@rivosinc.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, gshan@redhat.com,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220629195454.vbsjvcadmukiunt7@bogus>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:39:43PM +0000, Conor.Dooley@microchip.com wrote:
> On 29/06/2022 19:42, Sudeep Holla wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, Jun 29, 2022 at 06:18:25PM +0000, Conor.Dooley@microchip.com wrote:
> >>
> >> No, no it doesn't. Not sure what I was thinking there.
> >> Prob tested that on the the last commit that bisect tested
> >> rather than the one it pointed out the problem was with.
> >>
> >> Either way, boot is broken in -next.
> >>
> > 
> > Can you check if the below fixes the issue?
> 
> Unfortunately, no joy.
> Applied to a HEAD of 3b23bb2573e6 ("arch_topology: Use the
> last level cache information from the cacheinfo").

That's bad. Does the system boot with
Commit 2f7b757eb69d ("arch_topology: Add support to parse and detect cache
attributes") ?

-- 
Regards,
Sudeep
