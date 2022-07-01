Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497FE56363A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGAOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGAOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:55:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE8627FF4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:55:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8863D113E;
        Fri,  1 Jul 2022 07:55:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 630C33F66F;
        Fri,  1 Jul 2022 07:55:11 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:55:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Subject: Re: [PATCH v3 5/9] firmware: arm_scmi: Make use of FastChannels
 configurable
Message-ID: <20220701145508.xw3zbhldi7lvcwgd@bogus>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
 <20220627123038.1427067-6-cristian.marussi@arm.com>
 <20220701140307.upgfn4qpxhl63syg@bogus>
 <Yr8GsvW+cnf3PkSG@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8GsvW+cnf3PkSG@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:47:20PM +0100, Cristian Marussi wrote:

[...]

> ... regarding why, I am using personally this indeed for testing with or
> without FCs without having to change the installed FW blob, BUT the reason
> for upstreaming such an option is that FC support is indeed optional by the
> spec so I thought it would have been acceptabel that you could want to
> configure a platform NOT to use them even though the FW implementation you
> are using, maybe across multiple platforms, supports it.

Yes it is optional. But we use only if F/W advertises that it is available,
so no harm if it is not implemented right ? I don't believe it will save
space in the way config is used and I don't want to push all the code
under the config too.

-- 
Regards,
Sudeep
