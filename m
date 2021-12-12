Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB14718FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhLLHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:05:55 -0500
Received: from marcansoft.com ([212.63.210.85]:60066 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhLLHFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:05:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 426E042598;
        Sun, 12 Dec 2021 07:05:51 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] (mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM
 platforms)
To:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <99496d50-bbf0-ec73-a97e-7c1be59e21cd@marcan.st>
Date:   Sun, 12 Dec 2021 16:05:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211212070210.141664-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 16.02, Hector Martin wrote:
> Hi folks,
> 
> This short series adds a few quirks needed to make the card readers in
> Apple M1 Pro/Max MacBook laptops work properly.
> 
> The first patch should be straightforward; it just allows configuring
> the CD/WP polarity based on device tree settings. There is already a
> standard DT binding for this.
> 
> The second patch works around an issue with 8/16-bit MMIO reads that
> only affects these platforms, for some reason.
> 
> Changes since v1:
> 
> - Also applied workaround to GL9750
> - Fixed checkpatch warnings
> 
> Hector Martin (2):
>    mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
>      platforms
>    mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit
>      reads.
> 
>   drivers/mmc/host/sdhci-pci-gli.c | 42 ++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 

Argh, sorry about the bad subject. Copy&paste mishap while editing the
cover letter. Not doing great on the emailing for this one... :(

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
