Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599C45A16C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiHYQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHYQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:38:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA3B9F96;
        Thu, 25 Aug 2022 09:38:13 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d6so9479180ilg.4;
        Thu, 25 Aug 2022 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cg4DKuqZRXI8XygUcYOSntZBB49Z7XOxAN4MDp/rKMw=;
        b=KiqFMG0trws4p7kItu23a0fBvq++91aZ80QsPUnlOD9g6nUwgaF/RmfrTrK8fJJXr8
         iUue/c52TU7d4ZglonAvDypXzOl/O4iNXjZdoNAk2gXZWUAjGOPG8nrP9gmNRR4nruKG
         R+kRm/FV/Vkc6rX9Wvbdh4MMMvVT0wmeehPZA9i7jcsb5G2oTWCh5zMNoCsWGT6M/Ray
         WmaJi3pi8D6f53Cg0K9jS/W7aEFnclWZ1SEi0YVJpHQSF2KeqG3SS08n83XjENeQVxPP
         P3K5LgzpynqMybjfdLpuv5QwoRRGUXQVgN3sOiXoaNbgvHNQdKCFVu2PDiNalDU5i7YV
         tgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cg4DKuqZRXI8XygUcYOSntZBB49Z7XOxAN4MDp/rKMw=;
        b=chdHC7UAlhZjKXIN1jghc12CzCmhPpOm32DwYq+8xbU+NYhVtdmf+w/RgZDclvYSkL
         H5ulP/n593I3yWmOAWQaRqVYva7gMJclrPnngn6DumYM+A4QQoQYZnU/EMxOsYdeebD5
         85EzdmdVZ90fTUAkITAj+E+W3V9tL4p4UPcDDvfaZndQ+Onnoufopo9ycml2v9yhRhDu
         Me4BNkgen93stp/58ch51GYoMmdUKAfr167r7vVCzkqtkcNwO2zwxLcGzvxjj+TdoYY9
         XlbXYNsOm7bVWtR+W1LuSzIzTa0CzlNw1DfSlW6+PNrayO9ReG0cM/RMtx2pCxIwsVOP
         lXZg==
X-Gm-Message-State: ACgBeo1iKs2SGJYyLE+35XcEzA0/xgpwaZ8L5uZtKbUNcQs1DY6LKtHq
        onQWKzTlJ/PiN3zUv4RokTY=
X-Google-Smtp-Source: AA6agR6x34SkG5dp3T5Li7CZq6no4k62eMJxDTDbSDL7DC1g4ZhKftOOvN1IvNHx7ghLp1vK9PfxYA==
X-Received: by 2002:a05:6e02:18cd:b0:2de:73e8:3f0 with SMTP id s13-20020a056e0218cd00b002de73e803f0mr2348747ilu.69.1661445492977;
        Thu, 25 Aug 2022 09:38:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:1906:ee71:4d12:9d74? ([2600:1700:2442:6db0:1906:ee71:4d12:9d74])
        by smtp.gmail.com with ESMTPSA id y10-20020a056e02118a00b002e9818bc2dfsm2370346ili.8.2022.08.25.09.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 09:38:12 -0700 (PDT)
Message-ID: <1ecf05ab-b1f7-d0be-fac4-7941a306aa42@gmail.com>
Date:   Thu, 25 Aug 2022 11:38:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] of/device: Fix up of_dma_configure_id() stub
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824153256.1437483-1-thierry.reding@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220824153256.1437483-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 10:32, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Since the stub version of of_dma_configure_id() was added in commit
> a081bd4af4ce ("of/device: Add input id to of_dma_configure()"), it has
> not matched the signature of the full function, leading to build failure
> reports when code using this function is built on !OF configurations.
> 
> Fixes: a081bd4af4ce ("of/device: Add input id to of_dma_configure()")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/of_device.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 1d7992a02e36..1a803e4335d3 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -101,8 +101,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  }
>  
>  static inline int of_dma_configure_id(struct device *dev,
> -				   struct device_node *np,
> -				   bool force_dma)
> +				      struct device_node *np,
> +				      bool force_dma,
> +				      const u32 *id)
>  {
>  	return 0;
>  }


Reviewed-by: Frank Rowand <frank.rowand@sony.com>
