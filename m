Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26C51359F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347645AbiD1NuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346806AbiD1NuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:50:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97EB3B368C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:46:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1061474;
        Thu, 28 Apr 2022 06:46:48 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67ED33F5A1;
        Thu, 28 Apr 2022 06:46:46 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:46:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 00/22] SCMIv3.1 Miscellaneous changes
Message-ID: <20220428134642.zkxfs64i3wfsfhlk@bogus>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:05:29PM +0100, Cristian Marussi wrote:
> Hi all,
> 
> this series introduces a bunch of SCMIv3.1 miscellaneous changes to support
> basically all the SCMIv3.1 specification [1] addition with the exclusion of
> the Powercap protocol and driver which will be introduced later on in
> another series.
> 
> Most notably the series adds:
> 
>  - supports across all protocols for long resources naming using *_NAME_GET
>    dedicated new commands
>  - Clock protocol Rate change pre and post notifications
>  - Voltage protocol asynchronous voltage level set command
>    (VOLTAGE_LEVEL_SET_COMPLETE delayed response)
>  - Perf protocol power-cost in micro-watts (only internal support)
>  - Perf protocol PERFORMANCE_LIMITS_SET	new checks
> 

Apart from minor comments I have, this looks good and I have queued it
provisionally with the changes I have mentioned in the thread.

-- 
Regards,
Sudeep
