Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982AC58CDC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiHHSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:38:35 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C08EE1C;
        Mon,  8 Aug 2022 11:38:33 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B6D2240005;
        Mon,  8 Aug 2022 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1659983912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tm3EpuS9pDYqqZBTNmVKBmb1DmjbCqV31hX/CMoLAVc=;
        b=jy7Fe9LhMQ2zm2vkg/wS/7L1gCDHmz1eNFZ/rmyNcYJvNvwRl20TsOPvUFwMipmApn4WsZ
        r1DWaPz9dwknph+ZHshcfsmufOMXjZONR13Bom2rtW0iUIqmbeNhYS+2Sk7uUBmwnO1lFc
        vg0CLzG+Xvnmy0Cx3eCm76wOVT7OH1aq+vhoRoP7MZlWDQVHvt49B8xxLOHXbFPPDevvzP
        DsS7Bslm43JmY3u9pCQZBo0g8d3c8RrkxNoVniOdym2el+piHcJ+VXvDCDP7/OsNv/UHne
        IXUvawEqAPjGGvBo2n3rnTauNfqc02pWudkrRTdEuw21/SmxnsauVqFoLHyDYw==
Date:   Mon, 8 Aug 2022 20:38:31 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     a.zummo@towertech.it, mario.limonciello@amd.com,
        linux-rtc@vger.kernel.org, rui.zhang@intel.com,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0
Message-ID: <165998389112.717573.2543861915100061902.b4-ty@bootlin.com>
References: <12054246.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12054246.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022 20:23:59 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> use low-power S0 idle on the given platform than S3 (provided that
> the latter is supported) and it doesn't preclude using either of
> them (which of them will be used depends on the choices made by user
> space).
> 
> [...]

Applied, thanks!

[1/1] rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0
      commit: 6492fed7d8c95f53b0b804ef541324d924d95d41

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
