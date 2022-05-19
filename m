Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87252CD31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiESHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiESHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:34:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF98D939E0;
        Thu, 19 May 2022 00:34:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p12so4453637pfn.0;
        Thu, 19 May 2022 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+YvGchU2DWnacdHZ8YXfbhTutS2B3ifrEudePvwfb/A=;
        b=F105/nO//lUKNQdbEVPPJtf4UiN0Dpe4AhFvrF2atwPhUJRjs9cIbNZS7JmWT7bHIC
         WH5VUE/wi4XlgzpqCuAFlNiEESKO5L6y2oAutIgqqo20VBEAI6ZQPAKHy9P9zRHoqAi5
         esp+iJMGIRcpsije9YwIjnm/7i4ETyAM3N8mVDn2nt/Zk2yPpsssvjWdV4oKF4v8Pn3j
         7qv8/x6dVuo3mJlfYiw005V+zUTtz8rDNGJ7V/wNojrQFqsMrsn1u5ph9NhmnorddmxR
         ncan1LOhxq6nDfVhESnqC2vlFdceJLI9asmvavqWPV/wOBofZWNIH82QwVkAE6a59SuC
         MAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+YvGchU2DWnacdHZ8YXfbhTutS2B3ifrEudePvwfb/A=;
        b=lkC0vdXwMTzZUVIaA1D76MT2UPozS8BPYTwMEbI0/7hZ85GZLZRKkOcz6q/HlhxhGi
         i73bUKblyT5G5MBWxery6eanDcdTdb8EjAx+sQN2V+BpktbVGMkKxBSwUUd+q3JDiQUw
         9qyiXYcaU8HwouUzrrdMN+S7zu2vmnkTihV+6H332WPCg8GxMxHj8rar6YH18f89bXJX
         oSP5HC7FALaO2olTD+orjbJmtGLacERcvI6/Smnad2imxNoqGGjTLj8hfngKuHrI/XeS
         PJik0sbiL39DNCUweIwmIBCRhYVdNpwrojUGyHDI0ylZRmfqGKa68/6b3Kom2NxPJhLy
         jKuQ==
X-Gm-Message-State: AOAM533KCs5ASrIH0i1Qqs6lcDF5MFwdckMdgHNvgj9634sTn58ORpGx
        yZ3KU9FOcAe3dYlp9JYQHnc=
X-Google-Smtp-Source: ABdhPJyqsw1Lepw7anG+yYgDCfEZWYUotjEUoqobDngdtwvvKu2CEO6uDhZzL5/MeI9LM5czrC6kDg==
X-Received: by 2002:a63:1c4e:0:b0:3f2:6da7:5d90 with SMTP id c14-20020a631c4e000000b003f26da75d90mr2922991pgm.429.1652945694272;
        Thu, 19 May 2022 00:34:54 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id l30-20020a635b5e000000b003c5e836eddasm2746463pgm.94.2022.05.19.00.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 00:34:53 -0700 (PDT)
Message-ID: <08117fbe-e547-733f-89d5-802c4f2e2816@gmail.com>
Date:   Thu, 19 May 2022 14:34:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Fixed 'make htmldocs' warning:
 Documentation/admin-guide/perf/hisi-pcie-pmu.rst: WARNING: document isn't
 included in any toctree
Content-Language: en-US
To:     Praghadeesh T K S <praghadeeshthevendria@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org, praghadeeshtks@zohomail.in
References: <20220518082627.9144-1-praghadeeshthevendria@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220518082627.9144-1-praghadeeshthevendria@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 15:26, Praghadeesh T K S wrote:
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Praghadeesh T K S <praghadeeshthevendria@gmail.com>
> ---
>  Documentation/admin-guide/perf/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 5a8f252..69b23f0 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -8,6 +8,7 @@ Performance monitor support
>     :maxdepth: 1
>  
>     hisi-pmu
> +   hisi-pcie-pmu
>     imx-ddr
>     qcom_l2_pmu
>     qcom_l3_pmu

Hi,

This has been fixed in [1] and applied. Thanks anyway.

[1]: https://lore.kernel.org/linux-doc/20220228031700.1669086-1-wanjiabing@vivo.com/

-- 
An old man doll... just what I always wanted! - Clara
