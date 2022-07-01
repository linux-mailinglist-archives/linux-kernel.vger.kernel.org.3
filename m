Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234B55634C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiGANyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGANyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:54:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B1E11929A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:54:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59875113E;
        Fri,  1 Jul 2022 06:54:16 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8795A3F792;
        Fri,  1 Jul 2022 06:54:14 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:54:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        james.quinlan@broadcom.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/2] Add SCMI full message tracing
Message-ID: <20220701135411.eeruvjuispgfuyls@bogus>
References: <20220630173135.2086631-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630173135.2086631-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:31:33PM +0100, Cristian Marussi wrote:
> Hi,
> 
> after a few recent troubles handling too strictly out-of-spec replies from
> SCMI servers deployed in the wild, I though it could have been useful to
> have a basic way to dump at will the effective full payloads of
> successfully transmitted/received SCMI messages.
> 
> The existing SCMI traces already collect a bunch of information about SCMI
> message exchanges but they do NOT keep any payload information: this is
> certainly preferable most of the time since dumping full SCMI messages to
> the trace buffer involves a full copy of the payload.
> 
> For this reason I added a new distinct trace_scmi_msg_dump with this series
> in order to be able to selectively enable at will message dumping only when
> required.
> 
> Only successfully transmitted and received (valid) xfers are dumped.

Looks good to me. I would like to hear from Jim if possible. I plan to
merge this ASAP.

-- 
Regards,
Sudeep
