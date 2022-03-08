Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72254D213D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349273AbiCHTTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbiCHTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:19:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 652FB4B867;
        Tue,  8 Mar 2022 11:18:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C89D1655;
        Tue,  8 Mar 2022 11:18:49 -0800 (PST)
Received: from lpieralisi (unknown [10.57.38.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CEFF3FA45;
        Tue,  8 Mar 2022 11:18:46 -0800 (PST)
Date:   Tue, 8 Mar 2022 19:18:39 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v5 RESEND 0/2] ACPI: Arm Generic Diagnostic Dump and
 Reset device
Message-ID: <YiesD0vwbAOQGaGK@lpieralisi>
References: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
 <YiIsYzGeeYWPQKsp@lpieralisi>
 <alpine.DEB.2.22.394.2203071424290.3354@ubuntu200401>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203071424290.3354@ubuntu200401>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:29:10PM -0800, Ilkka Koskinen wrote:

[...]

> > > Would you prefer this version, which doesn't have platform
> > > device/driver any more?
> > 
> > I thought about that and in order to keep consistency it is better to
> > keep the platform device model, so please resend the latest version
> > platform device based and I will ACK it (hopefully it is not too late
> > for v5.18).
> 
> Sure, I can do that. Just one question, do you still prefer agdi_init()
> getting called from acpi_init() or via device_initcall()?

In acpi_init(), thanks.

Lorenzo
