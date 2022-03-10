Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5804D4339
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiCJJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbiCJJPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:15:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E309A137740;
        Thu, 10 Mar 2022 01:14:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D1F1650;
        Thu, 10 Mar 2022 01:14:43 -0800 (PST)
Received: from lpieralisi (unknown [10.57.43.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5363FA20;
        Thu, 10 Mar 2022 01:14:40 -0800 (PST)
Date:   Thu, 10 Mar 2022 09:14:40 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        James Morse <james.morse@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: [PATCH v6 1/2] ACPI: tables: Add AGDI to the list of known table
 signatures
Message-ID: <YinBgHvZT8T1EGtm@lpieralisi>
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
 <20220309020750.65399-2-ilkka@os.amperecomputing.com>
 <CAJZ5v0iY-pV-N7JhuAM4JM99tHVBVnCHj+JyJYpShS4cKA+q_w@mail.gmail.com>
 <alpine.DEB.2.22.394.2203091234060.4508@ubuntu200401>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203091234060.4508@ubuntu200401>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:41:27PM -0800, Ilkka Koskinen wrote:
> 
> Hi Rafael,
> 
> On Wed, 9 Mar 2022, Rafael J. Wysocki wrote:
> > On Wed, Mar 9, 2022 at 3:08 AM Ilkka Koskinen
> > <ilkka@os.amperecomputing.com> wrote:
> > > 
> > > Add AGDI to the list of known ACPI table signatures to allow the
> > > kernel to recognize it when upgrading tables via initrd.
> > > 
> > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/acpi/tables.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > > index 369eb998c3d1..ceee808f7f2a 100644
> > > --- a/drivers/acpi/tables.c
> > > +++ b/drivers/acpi/tables.c
> > > @@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
> > >         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> > >         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> > >         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> > > -       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
> > > +       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
> > > 
> > >  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
> > 
> > I'm noticing that this depends on the linux-next-only commit
> > 783dedf41b79ac7a3a68b51cf6f88cbfd6dc3292, so it is probably better if
> > I apply it and the other patch in the series can be routed via ARM64.
> 
> Sounds good to me, thanks. The other patch needs commit dc4e8c07e9e2 ("ACPI:
> APEI: explicit init of HEST and GHES in apci_init()") in your bleeding edge
> branch to work but it hasn't been acked yet anyway.

It is best for both patches to go via Rafael's tree, given the
dependency above. I acked patch (2).

Thanks,
Lorenzo
