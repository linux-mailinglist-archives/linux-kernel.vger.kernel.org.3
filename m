Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7577B482351
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhLaK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLaK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:26:15 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82085C061574;
        Fri, 31 Dec 2021 02:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rg9rGwZgGR4ykMu25hQPlqku2ztjnWuF82soOKGpW3k=; b=nl1DAtkaErGPmlGNZgIzCZ3aq0
        qRf8iS5UM3v0zagSWEXLlrCQUagZ2Cy8pB9vkkYpEMOk8GUOFZNmxu4IEoyHMRNG6LWbn1mNkKvAC
        6tXqtdrt5I6Y3KfrO4GnhDqM6wRJNvcZ6pYDmwxfgWuZ1tlXAkZIkiUArYsJSvDaB2Ds8xU4bQzHk
        nWjyXTniKEqGS/X6CtHSYoLjbJyNbvEciNhciOGHx7hGgy4mi3FlQ7DLbjwj0sIJO6AZK8jj4i8a/
        nw+/Hq41kwMRw8BR+j+ZnGudav6WCmNkU7t5Atfm9JypUchH1i0QGa6fzH+SvkRYtMQdXAMmXVVUr
        4hvclzTA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56500)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1n3F6o-0003jN-Rv; Fri, 31 Dec 2021 10:26:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1n3F6k-0003QA-Vg; Fri, 31 Dec 2021 10:25:58 +0000
Date:   Fri, 31 Dec 2021 10:25:58 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v3 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Message-ID: <Yc7attAhxzhWfuBn@shell.armlinux.org.uk>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 07:37:23PM -0800, Ilkka Koskinen wrote:
> Arm Generic Diagnostic Dump and Reset device enables a maintainer to
> request OS to perform a diagnostic dump and reset a system via SDEI
> event or an interrupt. This patchset adds support for the SDEI path.
> 
> I do have a patch to enable the interrupt path as well but I'm holding
> it back since AGDI table is missing interrupt configuration fields
> (trigger type etc.).
> 
> The recently published specification is available at
> https://developer.arm.com/documentation/den0093/latest
> 
> The patchset was tested on Ampere Altra/Mt. Jade.
> 
> The patchset applies on top of
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (642439a44411)

LGTM, thanks!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
