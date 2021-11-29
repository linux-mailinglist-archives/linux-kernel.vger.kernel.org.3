Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF346164C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhK2N3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:29:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34568 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhK2N1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:27:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E612614E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CEAC004E1;
        Mon, 29 Nov 2021 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638192275;
        bh=kbj4zD3tyLHarOKc4vVPU1nsXBzeUqdx9P5bzBwWV0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VVAD6E9Avuf4hgqQcNZvCMVMBXRbCfRYR9MmAbX6zcf/0im1V9YsbwcbhZhtHoH0g
         OY9KdfKLoGSkvYUejgEsROCHfjAcmhFDGY2akJTSk9GSMUD/P0fA+ssYYuOIDpgh/K
         Pi6ji60B5htgz/Ok8JDJtaHUz5g4jmSBXtUSxTbJqQknzbrGC7zElP97jpzgTzvbEV
         i5f9oT9E8J4C1belokJTLArMCbe6gTXkus6cSL4+IRUIBxLSDKcLDZuHik7Bxpouyv
         6nCvCQKIL8Hq1NWainXbcOd9t2Se2wWQG/7G13S6+Oae/6UR5Yklst0V0N6rgn6qYn
         LwKI6kIUef85Q==
Date:   Mon, 29 Nov 2021 14:24:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Message-ID: <20211129142431.16ffb019@coco.lan>
In-Reply-To: <YZ5c0LO5Ocaq+B7c@google.com>
References: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
        <YZ5c0LO5Ocaq+B7c@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 24 Nov 2021 15:40:00 +0000
Lee Jones <lee.jones@linaro.org> escreveu:

> > @@ -632,7 +632,7 @@ config INTEL_SOC_PMIC_CHTWC
> >  config INTEL_SOC_PMIC_CHTDC_TI
> >  	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
> >  	depends on GPIOLIB
> > -	depends on I2C
> > +	depends on I2C = y && I2C_DESIGNWARE_PLATFORM=y  
> 
> The lack of formatting consistency here is eating me up inside!

Just sent a v2 removing the extra spaces.

Thanks,
Mauro
