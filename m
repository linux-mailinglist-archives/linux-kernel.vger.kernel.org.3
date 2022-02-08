Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0654ADBD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbiBHO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBHO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A276C061576;
        Tue,  8 Feb 2022 06:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9861961366;
        Tue,  8 Feb 2022 14:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE62EC004E1;
        Tue,  8 Feb 2022 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644332359;
        bh=Iim13+wcx981IoY7NRzgqa8/7u5WZQqNYlLSJorSXks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMXP7aUBlb95gFYFfHb/yPk7LWsddKdFfODPOlQA0cMK0msU6buVrRCiZm0UXb5Yn
         2u8Lw6pSQRS64JVeRlVQG2JKN3QAENR0vJcYgarZeNQsrctbjwfg/EC4Vt1XJCYBSX
         4+ukfX6wwlitI92eCzYUcPflueFr2I2gaAuw73ZcjKIPXgfT55U3f5S9cLZKtomNLj
         AMzk942YK6jytoYT0BYUVTWEbfPu2vjNUe0SUyNxUJZ3ysZppfe/XpbBEpTvjLRFUm
         WzJMlwsmeY5zgul5ir19GmKDkGNLHKKuthpq8NBGBc65MTGYsBZ3CdNwngJfOBMV1k
         a6AnGTtd8PxOg==
Date:   Tue, 8 Feb 2022 14:59:13 +0000
From:   Will Deacon <will@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: Replace acpi_bus_get_device()
Message-ID: <20220208145913.GA1802@willie-the-truck>
References: <10025610.nUPlyArG6x@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10025610.nUPlyArG6x@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Feb 01, 2022 at 08:10:01PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/perf/thunderx2_pmu.c |    6 ++----
>  drivers/perf/xgene_pmu.c     |    6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Please let me know if you'd like me to take this for 5.18.

Will
