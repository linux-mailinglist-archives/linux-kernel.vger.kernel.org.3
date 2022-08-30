Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124075A5A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiH3DhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH3DhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:37:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD780B68;
        Mon, 29 Aug 2022 20:37:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so9859037plr.8;
        Mon, 29 Aug 2022 20:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cP18/M+EyPxw7T9Zgu8KcrAe0OP5LLjvkZI4wzfWBio=;
        b=M8CRVnI97CnsiDSOxUnvB8BZE2sgRitkJQS7KraBTYwoj0Cr5UodBBeQ/tstHZaMDP
         C09qWSWxOj36OfJTBrPWi494nCothF2nYxPbztpFp7Y7wz5CIpmGdDQM+N2h3Tjx75oc
         wG2Dk8bSUeXHC3F6sAZyS7Hpx5ysSsiaCFP3lQhUGNBJFIeEQOTINOPzkboW6aIAVMTN
         qYP1fBvF3z/8QJ2yF1QVMLiNXjjDog9BQwOnJSNJA2pbnHeXXnCy26VIkOiXDgffceVS
         y+VU560sZ8VSpOnQJi0HoiSZ0ttQSPwJnfJh/EUFGiUJzj8yjRr5dh3j1pIzTm+dVRAs
         Ce0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cP18/M+EyPxw7T9Zgu8KcrAe0OP5LLjvkZI4wzfWBio=;
        b=Sw/xWHg80LMxmd+NZzD9ZVVbdvmUBfEt5qoCim8Nq07snKksD/3xSuKsXEeYTnWR9h
         oPzig3N4WW6ohNiupvp1HTZNseNV1ullQbj4pxvkRKRdnQ7F1NrfmQPrOCWUG91S0ROf
         F9XZ46ls9CHizYYtVjoe0rA5sz4omHRCSeoJpJ/rFj/QjyHGM+tchdMsUrF06UyIoQ14
         heNWsT5HMsGn2V3/hLzJDSK+Sd5A45UF7hnOfdYR/vh3bO3oOR+Bhry0+Qw71WgfxyiH
         IIkAmZ7Q9hYU5BVavgzUEwFq6C6GaB/yyziY0XHR8FnpgRZGYOkCScxqQTh8Ara2r7Fg
         8T0w==
X-Gm-Message-State: ACgBeo0GJLIoLtFdMF3FKzmMyZNkRZpAF3tn1x4R8yEyZb3XIEEAXZP7
        YFBrmHVzDMGXLiaPumU7nfpDVy9ZHzY=
X-Google-Smtp-Source: AA6agR7MqkZjBR+Uf2VT90X9je+mc78Gtjq1L/rq3cjngv/PJOVEhE4zQnc4AT6YKU87YVnbbWuFwg==
X-Received: by 2002:a17:90b:1e0f:b0:1f5:37f5:159c with SMTP id pg15-20020a17090b1e0f00b001f537f5159cmr21574601pjb.189.1661830636506;
        Mon, 29 Aug 2022 20:37:16 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-15.three.co.id. [116.206.28.15])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a858900b001faf7a88138sm7396957pjn.42.2022.08.29.20.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 20:37:16 -0700 (PDT)
Message-ID: <e79ebc62-7e44-3ec8-fdaf-42572c8ac75c@gmail.com>
Date:   Tue, 30 Aug 2022 10:37:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] checkpatch: warn for non-standard fixes tag style
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
References: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 22:53, Niklas Söderlund wrote:
> +  **BAD_FIXES_TAG**
> +    The fixes line does not fall in line with the standards specified by the
> +    community.
> +
> +    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> +
>  

Did you mean "The Fixes: tag is malformed"?

Also, mention that this message can occur when the tag is split
into multiple lines (e.g., when pasted in email program with word
wrapping enabled).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
