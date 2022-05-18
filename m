Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4D52C421
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiERUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiERUIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:08:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E65523F3AA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:08:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c22so3125805pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XaJIvHbo+jlpzInpn2fbengyAliiuq/keur1HWe07wA=;
        b=DwAF1ZYn3vS/365bW9taVd7+33OIAEGWeik3SXc8jbn6Heo2Gf9v9RLFfzUFYCBaz4
         0TrV9xCPH/PdmMV4t0ZqaPJdt8/8JcH0go1CT0qI1WOYys9cZmeTmF3gToTSGtAkUXJo
         epoG/vKpJHn8pPaJZJo748h8gtHNscCVYWqaV1K+RTjTNOVEvJIehqPpMnfjkign5Tfu
         mq9/HxjINmNhwfyLMGpRsBLH8CramQUnkiNXtRIHk4ukiG0aCQyefRlN7s8K0tzAdZAQ
         Hk7XG5vlwDEGd3MAKMZhiROInkJ3HyAwAJNbmYssBryYZwxhjo7rsbcSuTdCEo/R++jR
         m9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XaJIvHbo+jlpzInpn2fbengyAliiuq/keur1HWe07wA=;
        b=OdydyAbT6T3dMHDR6FWAvGDK9RE05JsfipNveaVfWjIWep831svRiBbUtZG2bDIFDP
         KKZRNolStn0S3lL3OlZGbt0sJyJDtFBaMwS0hNfO5lLDABL/JsdEThTtiNvCxxUCzyZT
         nWgOsJlkg2MlDgbXs0Jy8Fjxox9nX/92kpYYOJ+aJXrjllLhmSzwWlkP9AOABkhru4VX
         ZXquddsJX9Vq0geu+o32h1wuc3etMoCdCgUpz+UPhLSl91S4qap9a4roMziFs+VFvTzn
         v93t+DI+EXBmPdc9r2m0k5Z0jk+LXIjmn96vw3IaCQE83SwJe++gEYKnmJBpmVkku1G0
         lOSg==
X-Gm-Message-State: AOAM533mbU9h05nkwR1k41GpvzLI0q2bPmq34F2wd3uSlPw/5eEkkBep
        7PpUlIa8VSl+VICiE7trjYU=
X-Google-Smtp-Source: ABdhPJxQj2GCZ2R/0DYA44LwwZ/SvhEdrgpr+u4vh4s7Jqthw//frI7TB51bx7cWeELu3f9uwrkdbQ==
X-Received: by 2002:a63:2a0d:0:b0:3ab:392c:f45c with SMTP id q13-20020a632a0d000000b003ab392cf45cmr918112pgq.575.1652904502756;
        Wed, 18 May 2022 13:08:22 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b0015e8d4eb2c3sm2050126plg.269.2022.05.18.13.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 13:08:22 -0700 (PDT)
Message-ID: <8337fdf9-6176-5b44-4999-594d41049ca9@gmail.com>
Date:   Wed, 18 May 2022 13:08:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/5] MAINTAINERS: add bcm63158 to bcmbca arch entry
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        tomer.yacoby@broadcom.com, samyon.furman@broadcom.com,
        philippe.reynes@softathome.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, linux-kernel@vger.kernel.org
References: <20220514232800.24653-1-william.zhang@broadcom.com>
 <20220514232800.24653-5-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220514232800.24653-5-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2022 4:27 PM, William Zhang wrote:
> Add bcm63158 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to 
https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
-- 
Florian
