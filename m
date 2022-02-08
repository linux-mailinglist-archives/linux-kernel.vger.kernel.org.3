Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CE4ADE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383160AbiBHQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383127AbiBHQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:22:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333AC0613CB;
        Tue,  8 Feb 2022 08:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FDC9B81BDC;
        Tue,  8 Feb 2022 16:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B413EC340F2;
        Tue,  8 Feb 2022 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337329;
        bh=ZV70IUeh32GHdGG2/5iy3KDBRhJ1xne/qFAM7rrDojI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYr3B2T+9JtifRZk/42CU15cKfnnSxW54IN3NNiDJK8TsVzgueswux58D2U4hOgPg
         /OdbYRDKs4iV3+WrCn6fUxpvfy6zwYdjwTkKyMbnR/Sz45cLlrTO8CkS43oKzQkDsA
         f7IZcGHxQ6pmSdBa9sVTviWt+Cit/jDO3JLEbtV6cwR+5m/w3qklPGbAixZJ7+dgUn
         xjFJ7t5Dy7BDnHt6wLtIzbjomDaewTNInNAAB8WeqlSGI4a39pF3vwm6WLFHYnCnah
         FNrBxQpvBqrD+HAr7BKR8MbaSBnkcqT8ZUIic2X52ac2RGClkXJO0FqednIfEeVHtw
         vTZ5t0PPnf8DQ==
From:   Will Deacon <will@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] perf: Replace acpi_bus_get_device()
Date:   Tue,  8 Feb 2022 16:21:54 +0000
Message-Id: <164433329407.3773412.15776450422000493467.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <10025610.nUPlyArG6x@kreacher>
References: <10025610.nUPlyArG6x@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2022 20:10:01 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: Replace acpi_bus_get_device()
      https://git.kernel.org/will/c/602c873eb52e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
