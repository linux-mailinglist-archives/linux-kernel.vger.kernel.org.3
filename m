Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC88D567848
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiGEUYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGEUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:24:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F9B3183B7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:24:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45061152B;
        Tue,  5 Jul 2022 13:24:10 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193F23F70D;
        Tue,  5 Jul 2022 13:24:06 -0700 (PDT)
Date:   Tue, 5 Jul 2022 21:22:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     Brice.Goglin@inria.fr, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Valentina.FernandezAlanis@microchip.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-riscv@lists.infradead.org, kernel@esmil.dk
Subject: Re: [PATCH v6 00/21] arch_topology: Updates to add socket support
 and fix cluster ids
Message-ID: <20220705202255.lfev2jjtl3e46qa7@bogus>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <6a647b6b-c913-b9d7-a23e-b17a8034c5c8@microchip.com>
 <507c6b64-fc23-3eea-e4c1-4d426025d658@inria.fr>
 <da1cf1aa-7291-92cd-4b62-0af0d0d12277@microchip.com>
 <20220705200737.unxj2hdcowdjdkt2@bogus>
 <d4b7bfbe-c6a5-c0a9-8aae-7d04682a5271@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b7bfbe-c6a5-c0a9-8aae-7d04682a5271@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:14:38PM +0000, Conor.Dooley@microchip.com wrote:
> 
> On 05/07/2022 21:07, Sudeep Holla wrote:

[...]

> > 
> > I would have preferred you to add me to the original thread and referred
> > this thread from there. I don't want to derail the discussion in this
> > thread as nothing much can be done here.
> 
> This is the original thread! It was just one off-list email that was a
> to me only response to this arch_topologu thread that you can see here
>

Ah OK, private mail. I missed to see that and assumed it was another
thread, sorry for that.

> But yeah - should have CCed you on the cpu-map stuff too.

No worries I spotted that and responded.

-- 
Regards,
Sudeep
