Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5F50FF06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350972AbiDZNay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbiDZNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:30:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A275118D6A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:27:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70818ED1;
        Tue, 26 Apr 2022 06:27:44 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4F5D3F774;
        Tue, 26 Apr 2022 06:27:42 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:27:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH V2 0/2] Add complex scheduler level for arm64
Message-ID: <20220426132740.yhthgoazoolvlven@bogus>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <20220425141926.00004d2e@Huawei.com>
 <SL2PR06MB3082D393ADEC823426DEE7DFBDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <SL2PR06MB30828131C046AB979BE75BD6BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB30828131C046AB979BE75BD6BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:05:15AM +0000, 王擎 wrote:
> 
> Hi Sudeep:
> 
> I am thinking if it is possible to add a complex level cpu topology
> between cluster and SMT?
> 
> We can describe it directly in “cpu-map”, instead of parsing it through
> the cache info.
> 

I don't know or understand what you mean by that. Do you have a proposal
for DT bindings ? Please post the patch with details on the motivation for
the change to help us understand your proposal. I can't comment much without
seeing or understanding your proposal at this moment.

-- 
Regards,
Sudeep
