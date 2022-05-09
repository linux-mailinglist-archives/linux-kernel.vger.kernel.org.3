Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216FA51FBA2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiEILsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiEILsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:48:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187711C15D8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:44:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v12so19014767wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EtleC+nTX7D5i2/ZTNJy5jdg5LLdu4nTUmNHgMyAnh8=;
        b=rUxiG7Es1bfnB0Bdvs0RQIJf6UBghpuBTRwvVm9ge8zn8gIwrsycFZo0G36xYW2Vpe
         oHAWUoqgtIfnIVwTTslGxHZFmgBhYAxtFGUyrp/yBBdEXclV/HKQmXQ9ACOSiansJm1s
         mr94Qg+nGgej/FwclwjNBkUdU5nVqA5wANLrh+mQM+8OxshEn4+6mdnwLG2wR/LBwdkn
         r9ZeB9Zv8jdlpg/+LOQhY54klrmVghm6v53DUlbffsUSC2fIeeJzrpQ3rRJNI4MJBfE+
         jEHS8QyuLMn1ZPa+I1AugFrZ7kNOYSgTlWBIgrWiB+lI4faXeHv0eYdWPU1ceeyqV9ue
         +MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EtleC+nTX7D5i2/ZTNJy5jdg5LLdu4nTUmNHgMyAnh8=;
        b=CB90Tp04lNAxOZZdefqML8xIrnbrLjHJViwXxvS1NG5JJy37go/s6duCT1ViyvYUxW
         UfswqUkRGFXHppU4qGIWT28HOS0OJEVDczAoO80jgG5+qCfLao8oYI5gDdhqH6CCQS0k
         dleWYekmCm1Vpu4XVGxk2qMCyLHudFvNJEMMxEXWABWOvRQbH7/McU/MZ1l9yRPZ9WUM
         XkgYuIqpvw7f0mBkhIaQOZxTp7Zz1p8mk4DMfYRmwhYV4HParHGRfBTK2Y8n6Kt0altn
         Vmok+zkjH+s9b1fZZqXcf05U0Vf05AQ0neKbj8w2Nh+x3KsHy+OEwlBZxpGIE7FxzoAh
         uyLw==
X-Gm-Message-State: AOAM531qPMpb+ydbk2E3dpm6kTUJy48EZmcmfR5gwkN3vUy5P9cgzroJ
        8r5BWj+B4ScEp1CXnC5XH8iHERyOEdZZlw==
X-Google-Smtp-Source: ABdhPJxM3VqJ9VyXlYRaqD4wz+LfzF6Us+nF6AOJU9wyLSe+j6MOjfuR8iN1sCnIx5Ppw7JWlD8RDQ==
X-Received: by 2002:a5d:6489:0:b0:20c:6c3b:d49e with SMTP id o9-20020a5d6489000000b0020c6c3bd49emr13773050wri.75.1652096647657;
        Mon, 09 May 2022 04:44:07 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id z11-20020a5d654b000000b0020c6b78eb5asm10934000wrv.68.2022.05.09.04.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:44:06 -0700 (PDT)
Message-ID: <32af96b3-5b87-6db1-ad23-8bc66d5530ff@linaro.org>
Date:   Mon, 9 May 2022 13:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU
 suspend
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220509012121.40031-1-samuel@sholland.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220509012121.40031-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 03:21, Samuel Holland wrote:
> Some implementations of the SBI time extension depend on hart-local
> state (for example, CSRs) that are lost or hardware that is powered
> down when a CPU is suspended. To be safe, the clockevents driver
> cannot assume that timer IRQs will be received during CPU suspend.
> 
> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
