Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6DC5636BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiGAPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiGAPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:14:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D7D1E3E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:14:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65566113E;
        Fri,  1 Jul 2022 08:14:03 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2404F3F66F;
        Fri,  1 Jul 2022 08:14:02 -0700 (PDT)
Date:   Fri, 1 Jul 2022 16:13:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 0/2] Add SCMI full message tracing
Message-ID: <20220701151359.4vnbhroubk7kswrw@bogus>
References: <20220630173135.2086631-1-cristian.marussi@arm.com>
 <20220701135411.eeruvjuispgfuyls@bogus>
 <CA+-6iNz2rORXE2u0EZOS9cnUBAXR_pyvcNKAMQjOf_gpRYyqsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNz2rORXE2u0EZOS9cnUBAXR_pyvcNKAMQjOf_gpRYyqsw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:03:38AM -0400, Jim Quinlan wrote:
> Hi,
> LGTM, I appreciate this change. For testing, I fed  your sample output to this:
>

Thanks!

>      perl -MData::Dumper -nae  's/^.+scmi_msg_dump:// && print Dumper
> { (map { split /=/; } split" ") }' < scmi.txt
> 
> which gives this
> 
> $VAR1 = {
>           'pt' => '15',
>           'seq' => '0000',
>           'pyld' =>
> '000000000800000009daffffffffffff008268d4c075fd1611daffffffffffff008268d4c075fd1619daffffffffffff008268d4c075fd16',
>           'msg_id' => '01',
>           's' => '0',
>           't' => 'NOTI'
>         };
> which is what I wanted.   BTW, if I ever write a script that would
> take this SCMI trace text and
> decode it to nice cmd names and arguments -- where would I submit such a script?
>

I am not 100% sure. After reading this, the first thoughts were scripts/
or tools/scripts but looking at the content I am less sure about latter.
Worth posting and then check what people have to say once this lands upstream.
Or even once this is merged into -next officially.

-- 
Regards,
Sudeep
