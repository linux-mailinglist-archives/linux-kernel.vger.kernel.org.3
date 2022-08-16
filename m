Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304CC59581B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiHPKZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiHPKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:24:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8E792A254
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:12:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34AAED1;
        Tue, 16 Aug 2022 02:12:47 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81C5C3F70D;
        Tue, 16 Aug 2022 02:12:45 -0700 (PDT)
Date:   Tue, 16 Aug 2022 10:12:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com, gregkh@linuxfoundation.org
Cc:     palmer@dabbelt.com, catalin.marinas@arm.com, will@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, atishp@atishpatra.org,
        Brice.Goglin@inria.fr
Subject: Re: [GIT PULL] Fix RISC-V's arch-topology reporting
Message-ID: <20220816091243.apz7p2rb4wbxdh2t@bogus>
References: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:14:55PM +0000, Conor.Dooley@microchip.com wrote:
> Hey Will/Palmer/Sudeep,
> 
> Catalin suggested [0] dropping the CC: stable for the arm64 patch and
> instead making it a specific prereq of the RISC-V patch & making a PR,
> so here we are.. I was still up when -rc1 came out so pushed it last
> night to get the test coverage, but LKP seems to not have reported a
> build success since early on the 13th so not holding my horses! I built
> it again for both ARMs and RISC-V myself.
> 
> I tagged it tonight, so it's on conor/linux.git as riscv-topo-on-6.0-rc1
> with the prereq specified.
> 
> Not sure if you want to merge this too Sudeep or if that's up to Greg?

I don't have any other patch(other than a fix that I requested Greg to
pick it up directly yesterday) and since you have tagged it already, may be
Greg can pull this or patches directly based on his preference.

--
Regards,
Sudeep
