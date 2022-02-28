Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD34C6A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiB1Lgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiB1Lg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:36:28 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2870F51
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:35:49 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21S957cO026481;
        Mon, 28 Feb 2022 05:35:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=WDzG42ornLCilMA2TL/Y74VvskOgpiUGxdW+SjGSD8M=;
 b=HWzhPgBiBInwFd3a4VjWAJGhGaS9BYbrnEQZH2Da+I3XlI4xAZrXsdvabE3/Kz22kje5
 IWJclW6bQBK1VSi7lP3tvq9k8bHya4vd8/Vejg60+ivJVim49LPKZllVh+SA6i+jfsLo
 tfjEsjjNMcw02kY/7vrEabls7R0mxWjCTQp8R6TRCBvMc/7p9Ato5XZeVSNOsS96N/Mm
 ts1wr6PxDh48a1DxXhUTgfCQ7c2LImgVar7vFHsU+7LHCj0j0rdeFPfhUPEYwv3jl42t
 rNZFFlFNj7x2PgICIOnAJkBr9JhPL7DZe61lpq49neC+byyOZC53yBqYge3gak6J1wKX wQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3efhgsa59c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Feb 2022 05:35:47 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 11:35:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 28 Feb 2022 11:35:46 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3DDD3B06;
        Mon, 28 Feb 2022 11:35:46 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:35:46 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: arizona-spi: Add Android board ACPI table
 handling
Message-ID: <20220228113546.GJ38351@ediswmail.ad.cirrus.com>
References: <20220223134222.730886-1-hdegoede@redhat.com>
 <20220223134222.730886-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220223134222.730886-2-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Ropa4160oTmt8_n2I8YJSdT52QuSAk0t
X-Proofpoint-ORIG-GUID: Ropa4160oTmt8_n2I8YJSdT52QuSAk0t
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:42:22PM +0100, Hans de Goede wrote:
> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> Android as factory installed OS.
> 
> The ACPI fwnode for the codec on Android boards misses 2 things compared
> to the Windows boards (this is hardcoded in the Android board kernels):
> 
> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
>    for jack-detection.
> 
> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
> 
> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
> module contains DMI based per model handling to compensate for this.
> 
> This module will enable the 32KHz clock through the pinctrl framework
> to fix 1. and it will also register a gpio-lookup table for all GPIOs
> needed by the codec + machine driver, including the GPIOs coming from
> the codec itself.
> 
> Add an arizona_spi_acpi_android_probe() function which waits for the
> x86-android-tablets to have set things up before continue with probing
> the arizona WM5102 codec.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
