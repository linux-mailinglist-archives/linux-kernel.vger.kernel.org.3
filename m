Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCF05223E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbiEJS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348880AbiEJS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:26:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136CAB36C6;
        Tue, 10 May 2022 11:26:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so2869389pji.3;
        Tue, 10 May 2022 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XRI/42wOvBZ/8slI1s6G+ZLQFaSjtz9xMU2JmEe+gxo=;
        b=qhd2Bkeump+a0C7whAKFe//Lz9r35AcFJL8ma0XBcX1FiVT4HUBQA8VgwCIo+b+ZMF
         09i4AmcHcrUJFVZv5uSKS3+vd9i6ufcqvRUlSemUa8LyqFd+Vd9aspNDf9w0K7a4w1ft
         jWZe9qvgj0SlYul5BPeww6u8Gen3zdhZiu76xxC8Sh05pC7+aB+2+xhBnkU1S+O2R72E
         qpue51cuGQ6iylpsIYGtFX8ozFomY4dFKKyxLiVZv+o6ifZV+vIqWS6QAF7Oy7FxJ/3M
         CkvyRGeP85ES8/cHifln6E72BuyMU5IJzPYQSNHeb8m8TmE5ZwOz8QM8DPYDmpmY+XY1
         5YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XRI/42wOvBZ/8slI1s6G+ZLQFaSjtz9xMU2JmEe+gxo=;
        b=HYkdBRiagzwt/UtqDDgMaf2xNOV5Nz/TzT05bFvCn3g4TKYUn1f4eLBEFlsc8XssEt
         LTI5ezOKCiBTYs1DApd9f/BQcLZ0LGqUU44TjMipoYlG7ZsNXEJjKQ3tZWmc/OPzM7Hf
         g0Itc2vHKy2uwgv/gjcA4ZivYdRt7p/Q0yS9cNVRY8SfiSbVCdulvLmyLAzedmZ8jnmJ
         coGQHW8LngXeV2j+JIaj80bSOiFMH2z3+pquNhcI6lF6m1xfEjqt0+mWhVdsfoGrtJML
         CPhnQO8xdpf7GcVMSeHn6xiUjweYha7HeL60mC9PuWAKDhx+AEVY0jMft7KwdsfN/Tiq
         wUng==
X-Gm-Message-State: AOAM530z1iFrKiBSho8+gWrs1YaI/K9j5nybW74akqGm+QoqQN5gxSAR
        9fSIHrJ2v8lqgl2+k3gPpDk=
X-Google-Smtp-Source: ABdhPJxzCs+nSIvWELTAlR92PRL0K8C35jw8R3nR4VmaCcznF0ET3gGDDq+EGPWwqyImBNp36f9sLw==
X-Received: by 2002:a17:90a:b78d:b0:1d9:4f4f:bc2a with SMTP id m13-20020a17090ab78d00b001d94f4fbc2amr1151292pjr.155.1652207165523;
        Tue, 10 May 2022 11:26:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o8-20020a17090a168800b001da3780bfd3sm137366pja.0.2022.05.10.11.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 11:26:04 -0700 (PDT)
Message-ID: <5b56cbaf-0482-f235-1806-60a58038c7c3@gmail.com>
Date:   Tue, 10 May 2022 11:26:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [patch 01/10] clocksource/drivers/bcm_kona: Convert to SPDX
 identifier
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
References: <20220510171003.952873904@linutronix.de>
 <20220510171254.404209482@linutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220510171254.404209482@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 10:24, Thomas Gleixner wrote:
> The license information clearly states GPL version 2 only. The extra text
> which excludes warranties is a transcript of the corresponding GPLv2 clause
> 11, which is explicitely referenced for details.
> 
> So the SPDX identifier covers it completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
> Cc: linux-spdx@vger.kernel.org

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
