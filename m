Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A935046BD51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhLGOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:14:27 -0500
Received: from marcansoft.com ([212.63.210.85]:50838 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232369AbhLGOOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:14:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AD4B641EF0;
        Tue,  7 Dec 2021 14:10:46 +0000 (UTC)
Subject: Re: [PATCH 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM
 platforms
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211207064019.61444-1-marcan@marcan.st>
 <5723f5bc-f721-9976-d63d-2738233f62bd@marcan.st>
 <CACT4zj9Oy_Le8KzPS9WfH+Zx9Re7h0SOwkWFN+G5X1pCF3s3ZA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <04d8b420-d957-edea-bdae-7f939b108b60@marcan.st>
Date:   Tue, 7 Dec 2021 23:10:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACT4zj9Oy_Le8KzPS9WfH+Zx9Re7h0SOwkWFN+G5X1pCF3s3ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On 07/12/2021 21.25, Ben Chuang wrote:
> Hi Hector,
> 
> I got your two patches so you don't need to resend them.
> About the 8/16-bits MMIO read patch as the second patch, it is necessary.
> I don't know some vendor-specific knobs, sorry.

Is this only required on these Apple platforms? I'm very curious about 
what's different about them. I assume these chips don't need the 
workaround on x86 laptops, right?

> ps. Do you make Asahi Linux now?  It's a cool project. :)

Along with a lot of other talented folks, yes :)

-Hector

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
