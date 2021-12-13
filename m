Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D666471F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhLMDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:35:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48594
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231503AbhLMDfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:35:19 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF0FA3F206
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639366512;
        bh=WxXM4jyaAfim4In51kFlNAC+ZCUZPdZC2EcFP94mchw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mwrvchtDFZxa71zRKnG9EQbKn/2QFrOwg2Mn5A7fbIzMtuckEboZr/ILOjISdY4nE
         cz4k858A6NuxxOWEpg8csAgNj1JGNVfcIXvabUA5IbtnUdSeBl5oswCLUDcRVhAszS
         QVegqDUAQIh5qziXeqnDJ9/8mTT127XdDLScPj+CBlSZYTx6VTbZkJTiY9dD8rcr5Q
         OeKqaUNgDn4GPbkbJgcvhrq2wkgXzONP6J0inXMVO6/QeXW8zf4niZXB9WMBa+qpT/
         TIVfBj5LVIekG6SPvdl7H7J+A+I7Si0sIxjT2g8ztrVeHSOUmdU4yxMoX8qOn0AD7v
         wZNKzQMzKWYXg==
Received: by mail-oi1-f198.google.com with SMTP id k124-20020acaba82000000b002a7401b177cso10193754oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxXM4jyaAfim4In51kFlNAC+ZCUZPdZC2EcFP94mchw=;
        b=QyJHge4JGxD/4ZeKJ9kQc1xtLDEwXXDUEQ4BEuJT+7TCvThnxyGEJrZQzbtcMo15yJ
         XhUE9zZNgg+Zd98pCgNt+nEVFIc9lQ2MqrP51muqAIwwgUEooRlW+0e52UoAGHgQuiae
         LpelUqlweTdkNgOSaC8xFpdnxwGPtYCIxwCj10a4ytugG/ZgqpYP3N1b0J0wv2zjcgY3
         7yprELrGylRwZ5UygL+xKMviW9VBNWleVSdmsXrYjWLFyamOJEJd6lQqztNJLlhpFKU7
         UVQBRpaCcVAybxQg6hCIWm4bA53+4tjd3h4XO0dzifKiwCHH4bdfHXwil4//hK0cwk6h
         zbfA==
X-Gm-Message-State: AOAM530w59wDKazDjIQ2OBdG8kXtbcdNM+BRIkJNukfUwXA6+v3j1eq3
        GyKPJtjOnmkqQmX3WIoKmAB6oYocS1GFjIG/oDzFlM8nhKquoNV8CLiAANby6tLylqOkvIAL12P
        xA8pfjfRx1tDeLkBUQCeA+DTk+wNjCOPzbR0aY3w+kqPXEXJcEcxT6cH1ag==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr26139376oib.98.1639366511551;
        Sun, 12 Dec 2021 19:35:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2Jy7YvzKyAwTVwOJsnFzMt1E8Lv8cfRVZtR3ZcuTEDyo+hZ/52vVzx+j4rK67PXijH9rfcTzGJ2rLJTw2v+c=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr26139358oib.98.1639366511305;
 Sun, 12 Dec 2021 19:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20211203020931.1419572-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211203020931.1419572-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 13 Dec 2021 11:34:59 +0800
Message-ID: <CAAd53p4v6BWSmd-4jNBs95y2Tf8TY1iedvgN=P_3nC3oa1_oTA@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Increase microcodes loading timeout
To:     luciano.coelho@intel.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dror Moshe <drorx.moshe@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Abhishek Naik <abhishek.naik@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Ayala Barazani <ayala.barazani@intel.com>,
        Harish Mitty <harish.mitty@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 10:10 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Intel AX201/AX211 device may not work at boot:
> [    8.875307] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x7267, CPU2 Status: 0xb03
> [    8.875418] iwlwifi 0000:00:14.3: UMAC PC: 0x80481126
> [    8.875426] iwlwifi 0000:00:14.3: LMAC PC: 0x1541c
> [    8.875430] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 13 fired (delay=0ms).
> [    8.877906] iwlwifi 0000:00:14.3: Loaded firmware version: 64.97bbee0a.0 so-a0-gf-a0-64.ucode
> ...
> [    8.878997] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> [    8.878999] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
>
> Increase MVM_UCODE_ALIVE_TIMEOUT to 2 seconds can solve the issue.
>
> The PNVM loading can also fail:
> [    5.159949] iwlwifi 0000:00:14.3: loaded PNVM version 4b50f925
> [    5.414211] iwlwifi 0000:00:14.3: Timeout waiting for PNVM load!
> [    5.414219] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> [    5.414224] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 13 fired (delay=0ms).
> [    5.416618] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> [    5.416619] iwlwifi 0000:00:14.3: Transport status: 0x00000042, valid: 6
> [    5.416620] iwlwifi 0000:00:14.3: Loaded firmware version: 64.97bbee0a.0 so-a0-gf-a0-64.ucode
> ...
> [    5.914276] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
>
> Trial and error shows that the MVM_UCODE_PNVM_TIMEOUT also needs to be
> bumped to 2 seconds to fully eliminate the issue.
>
> The timeout values are verified by rebooting over 10k times.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/net/wireless/intel/iwlwifi/fw/pnvm.h | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
> index 203c367dd4dee..b730330d8feac 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
> @@ -10,7 +10,7 @@
>
>  #include "fw/notif-wait.h"
>
> -#define MVM_UCODE_PNVM_TIMEOUT (HZ / 4)
> +#define MVM_UCODE_PNVM_TIMEOUT (2 * HZ)
>
>  #define MAX_PNVM_NAME  64
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 6ce78c03e51f7..0c5375f7baecf 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -24,7 +24,7 @@
>  #include "iwl-modparams.h"
>  #include "iwl-nvm-parse.h"
>
> -#define MVM_UCODE_ALIVE_TIMEOUT        (HZ)
> +#define MVM_UCODE_ALIVE_TIMEOUT        (2 * HZ)
>  #define MVM_UCODE_CALIB_TIMEOUT        (2 * HZ)
>
>  #define UCODE_VALID_OK cpu_to_le32(0x1)
> --
> 2.32.0
>
