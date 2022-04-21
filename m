Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD850A3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiDUPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389869AbiDUPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:07:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E55192AB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:05:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r19so3394156wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E15M9Ws9rPTsezqPUu5FPX35Ipux/TcBsX6BpW7X7Mc=;
        b=AITr5RnwDxY5IpwPra9w2ksKNUuSqTH7IVfpHD8VTH5aL8oRt0tlPRC795QKxcXho3
         V48Ael5YBf8nTu1aM5DmbsbaErIHF1Lr5hU/0xREThm2sTjVsUU3d+eyRZM+dGyQoLTA
         enZLQStav9Xck7aYA0FWtfA1thm+CiQosv5sUFs94xqHUhcEKt+Fa3kFzXK7dK+TrGhj
         uQsRTqi50G5R6nycUOXBt2Td94u0HY9znZLbl4JeUO7MMXxdVxmILh3ezdVP+BMGio+A
         hY7Cke1BuzrJtGi5QvE1SM+PjB4/afX1pf9LnxB2euCwEyu2Z5KGjCgfWTRFUp9KT7qD
         9amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E15M9Ws9rPTsezqPUu5FPX35Ipux/TcBsX6BpW7X7Mc=;
        b=ReqjlabKADGpOCo/tDblEvoI2/o7VF/uLWVxCqiphzm9rlryaujiac/XF0je86dgFQ
         SMtLSDuZtDNLf0STboIM1FQxGwAhqeG0QbCqNpt/Jc7DVrieHvdgfKmGOv9uh7T2rLNJ
         pCZxnB2bKfXdTENsnLwMLC3Sa+m94wMp9/xdGJTZexhwCpHNPgf1plnIhrMNj9MvvzLt
         yB5flQnJQcNCYcPMauT45GdrTgDDkTgPEllprAUklRSfz7vEo6jarcAXE+X1fz+7y/2n
         OKjRSwtOSOBknmnI9kGmZVOjGtmhLOqDQ2n/taoVmDVE3+FBf0GL4ugkocnp3WiVMrsl
         3fbA==
X-Gm-Message-State: AOAM531+ct6ftKbZzM6Us69omF7s0i/Igq3YgUzw65ZBkUw5lxAXs87M
        h1ocSCbKp3bcxULfXIImR13S0rS8xBFaRg==
X-Google-Smtp-Source: ABdhPJwTQ+9A9qQhbowMT6ITAZESTr+JAZ57+aJU0Gok1/P01kUj2CpfBFcvhWOpWAV3HNG+gO3qaw==
X-Received: by 2002:a05:600c:19c9:b0:391:d98d:2cf3 with SMTP id u9-20020a05600c19c900b00391d98d2cf3mr9137192wmq.136.1650553504458;
        Thu, 21 Apr 2022 08:05:04 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id a4-20020a056000188400b0020a9ec6e8e3sm2875350wri.55.2022.04.21.08.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 08:05:03 -0700 (PDT)
Message-ID: <e10b3f13-75b6-c19b-9a27-d75e2e80054a@linaro.org>
Date:   Thu, 21 Apr 2022 17:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/4] tools/thermal: thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220420160933.347088-1-daniel.lezcano@linaro.org>
 <8610206dac7bf538eaf8fa81569741a91e4b8dc7.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8610206dac7bf538eaf8fa81569741a91e4b8dc7.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 05:59, srinivas pandruvada wrote:
> On Wed, 2022-04-20 at 18:09 +0200, Daniel Lezcano wrote:

[ ... ]

> But I still see these errors in applying patches:
> 
> Applying: tools/lib/thermal: Add a thermal library
> Applying: tools/thermal: Add util library
> Applying: tools/thermal: Add a temperature capture tool
> .git/rebase-apply/patch:809: space before tab in indent.
> 	      	polling = 100; }
> .git/rebase-apply/patch:90: new blank line at EOF.
> +
> .git/rebase-apply/patch:221: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> Applying: tools/thermal: Add thermal daemon skeleton
> .git/rebase-apply/patch:86: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

Ok, I'll apply it with --whitespace=fix

I did a try and it fixes the trailing whitespace

Is ok for you Rafael ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
