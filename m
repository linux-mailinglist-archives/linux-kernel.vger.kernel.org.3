Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679B560924
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiF2SaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2SaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:30:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 770262A94D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:30:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7668F14BF;
        Wed, 29 Jun 2022 11:30:17 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7B43F5A1;
        Wed, 29 Jun 2022 11:30:14 -0700 (PDT)
Date:   Wed, 29 Jun 2022 19:29:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atishp@atishpatra.org, atishp@rivosinc.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, gshan@redhat.com,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220629182903.fku772ka2kdjj6yr@bogus>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 05:49:20PM +0000, Conor.Dooley@microchip.com wrote:
> > 
> > Link: https://lore.kernel.org/r/20220621192034.3332546-10-sudeep.holla@arm.com
> 
> btw, why is this link in the patch? Why is a link to v4 relevant?
> Links to both v4 and v5 exist in your for-linux-next branch.
> 
Yes I noticed that and fixed it today.

-- 
Regards,
Sudeep
