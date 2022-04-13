Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E34FF951
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiDMOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDMOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:50:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D61644C8;
        Wed, 13 Apr 2022 07:47:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E2C1424;
        Wed, 13 Apr 2022 07:47:41 -0700 (PDT)
Received: from [10.57.8.248] (unknown [10.57.8.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88383F5A1;
        Wed, 13 Apr 2022 07:47:38 -0700 (PDT)
Message-ID: <bcbcdc45-c857-129e-814d-6f5a7b0f0259@arm.com>
Date:   Wed, 13 Apr 2022 15:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND][PATCH 0/8] Introduce support for artificial Energy Model
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <76230a1c-73b8-c471-c62e-3ec9b33461a6@arm.com>
 <55d4a19d-15d4-4d15-8430-8a8ed8149497@arm.com>
 <CAJZ5v0g5vcC7aS4KS-uN+fHmbrKCmA-MVbJEKOnPgEyDDfqSRw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g5vcC7aS4KS-uN+fHmbrKCmA-MVbJEKOnPgEyDDfqSRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 15:29, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tue, Apr 12, 2022 at 8:53 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> gentle ping. If you need some help with this maintenance,
>> we can help.
> 
> Sorry for the delay.
> 
> Given the lack of objections or concerns, I've applied the whole
> series as 5.19 material.

Thank you Rafael!

> 
> Thanks!
