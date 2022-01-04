Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B1483E84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiADI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiADI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:56:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741BDC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZXnWJCxtXHkbWgtojI2Bd6qfv8asOpj9X4IENawtoYQ=;
        t=1641286571; x=1642496171; b=rH5cdZsroTommNWPnncP/9xvbOwX7rxSyEj3hlsYXPElVlF
        AKp6aUS+jRY6tFAPqigQWFymiUMovySi0huNSfPnGDBiRDcFZ/W7T3k3CGhgBURy+i8wKdPTB5QuL
        CmQCJbErt6CE48lCGJpka3p7B6vqxaCN07lY4uq7bKw0LVH/cylWQPHHKHnu/dRArj1V3CqNJc/48
        /kV1VTP5UlQeeRqOvOlrAdkpeWoJK+TPRDaGRfFc8C/E4Jo2pb+qfMuUJAbq07wy2yUdoeLRnsJhf
        FjMYKxIh6hsTkTSTJb7BesktHzBC/MvcetBX15SUq94rQeeSU0FvTFXwpFp6113g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4fc0-001hXZ-Rr;
        Tue, 04 Jan 2022 09:56:08 +0100
Message-ID: <6fad9c06ac08b60d9bfea703552712daf150a4f7.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: Run console exit code also upon kernel panic
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com
Date:   Tue, 04 Jan 2022 09:56:07 +0100
In-Reply-To: <20220101215810.13260-2-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
         <20220101215810.13260-2-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> 
> diff --git a/arch/um/include/shared/uml_console.h b/arch/um/include/shared/uml_console.h
> new file mode 100644
> index 000000000000..aa8d02fe5e90
> --- /dev/null
> +++ b/arch/um/include/shared/uml_console.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Richard Weinberger <richard@nod.at>
> + */
> +
> +#ifndef UML_CONSOLE_H
> +#define UML_CONSOLE_H
> +
> +extern void uml_console_exit(void);
> 

Not sure it's worth adding a whole new file just for this, but also
doesn't really matter :)

johannes
