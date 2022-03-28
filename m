Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80624E8E96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiC1HFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiC1HFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:05:08 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388E2AF5;
        Mon, 28 Mar 2022 00:03:26 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id u16so18943883wru.4;
        Mon, 28 Mar 2022 00:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pkiElRGcYMgqGO+15AWzkYL63nI4vFLbBIBuyFUuyGM=;
        b=AVvIeps8xZRD98ICS5dQ7gA256C+XkC06zWEgJqsY41wW6INddOJpq3kVWjWw56csG
         cbQaELz4Vhvoys7lnP2NjJjZS/8zAabldA/MdO/FV3ufpDDuLG+EqP6GgGpneRtJb3WW
         xazyNf6xSebAiH0NXI0tiLxmiWDT3a7mutOVwtS8zuKwrdCFcTOAA0T3rJhIkyX0+wLs
         S30USnF1CQXVz8Q5rISgV0fCmrcrmszIvAyfVYkuTA0P+EEqZ8MTIbYYeWUMDV1s2g4R
         VkAkEtMjpOuOsPrCnUc/5phm6XQwb1VDuMiQ4zkTwUQukdHuN2fvAJspA4FCJs9zLwF+
         ufAw==
X-Gm-Message-State: AOAM531V23x/qSIfyNBW07djIvnHGagV+sSrw5z+GwQwNLe8YIdnNGRY
        iQgIyEO2QptipIdWuCcHSAw=
X-Google-Smtp-Source: ABdhPJwy/cOClG5uWIA9JX2AxfXLLjzon9aoQtRw5DDcKvCEtvAdLnaCcFAucyDOibo1MjviWfbGPg==
X-Received: by 2002:a5d:64e7:0:b0:205:8b74:8db7 with SMTP id g7-20020a5d64e7000000b002058b748db7mr21770989wri.34.1648451005144;
        Mon, 28 Mar 2022 00:03:25 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm11097375wrv.49.2022.03.28.00.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:03:24 -0700 (PDT)
Message-ID: <95cb1ea9-a737-7d01-f81f-f94ea92c7a4d@kernel.org>
Date:   Mon, 28 Mar 2022 09:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 2/6] ASoC: dt-bindings: Add audio-graph-port
 bindings to rt5659
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-3-git-send-email-spujar@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648448050-15237-3-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 08:14, Sameer Pujar wrote:
> To use rt5658 or rt5659 audio CODEC with generic audio-graph-card machine
> driver, the CODEC requires "port" bindings. Thus add "audio-graph-port"
> reference to the rt5659 binding.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Oder Chiou <oder_chiou@realtek.com>
> ---
>  Documentation/devicetree/bindings/sound/realtek,rt5659.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

This should be squashed with your previous patch, otherwise that one is
not a complete conversion.

Best regards,
Krzysztof
