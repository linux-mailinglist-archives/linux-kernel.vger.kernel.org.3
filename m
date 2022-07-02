Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22D563EC0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiGBGIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGBGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:08:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE226E7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:08:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n8so5358382eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SIPe2QQOYVv5nAVZFivPLxNrDO6JoR46VxCJNiekNps=;
        b=YnzgPKB/Ukeo0GRSswl9VzBr9aK07zBarTnK/4x7/YUKXouJiQw4Ik1AI5rnOkWm+P
         vf6lNcitqTd71wwgdrZzHGKwQ7bAdg87Xve5TIC67OZieNOBxQOlg5Ft+HjYJ1UiI4XP
         J1TiQ9Yz16OH03xyP9PSclOP83OLfuBSLpR65wWMeRP8psG6qKz4e9/LhQbU3WKLtYt0
         1atq/A14gUVDjaxI8OsJH+kzyaTav5SUWzQoIb83ZgWnq2NMVkOcCiDpZymr0e9uQWvw
         XpnUsOfPB+jhLeQqbkgAbzzTAuG8k873nbTd3OPyMV4eHvfna+5tKdo36kKhAu4vhXpR
         DqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SIPe2QQOYVv5nAVZFivPLxNrDO6JoR46VxCJNiekNps=;
        b=LJCgGrSQNxYUOYX+/acLNAlGNiaxPCNlpTLgGCUQz6oLwvvn0x9K6JO7cSPnGQSc+h
         93Po62HyEl44giwtUR+px1RkSKiIVSsCzKoIqcSuc6+R+Is/RWNuL6EU6rhNrUE6m8Dh
         po32OU3r0im1Cm48kex/pRFnsOgaVmzk+9pAzlZ4DhpHmyI+tLpFy5ea/tKjUJRmIbEw
         cXHYcOTwuP+YLRnU+bAmIKHF5SfWeLrag3tNLZJmxuRds3jbqotvO3eBQbB5zDS+aSyd
         lLI3A7f0jRAVQpx1JSuyjTTx8oKzKjgjzqpAnGicHeuP6qdyp7KO370DNNNCSbaqp84d
         G0yg==
X-Gm-Message-State: AJIora98dIabc6aexiOSTIlPgsRNxdWzJlaZp5/k//wEKTKZqPVEy3/M
        rkhj5KtmDqJIZICQfK+KytkOuJtgDfE=
X-Google-Smtp-Source: AGRyM1tKa8/txO/iEciqI7SKwhDfeoLS35M7LWLwVgQlXfAb3AXiywLpZvHeZf3+kyDbzztwS3BN+w==
X-Received: by 2002:aa7:c2cf:0:b0:435:6576:b7c0 with SMTP id m15-20020aa7c2cf000000b004356576b7c0mr24043364edp.18.1656742106894;
        Fri, 01 Jul 2022 23:08:26 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6912:39ab:4063:59d3:a7cd? (p200300c78f2e691239ab406359d3a7cd.dip0.t-ipconnect.de. [2003:c7:8f2e:6912:39ab:4063:59d3:a7cd])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm11149417ejj.112.2022.07.01.23.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 23:08:26 -0700 (PDT)
Message-ID: <7232163c-f573-c1f8-5cd1-da5b70e76091@gmail.com>
Date:   Sat, 2 Jul 2022 08:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/6] Staging: rtl8192e: Avoid multiple assignments
Content-Language: en-US
To:     Felix Schlepper <f3sch.git@outlook.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com
References: <cover.1656667089.git.f3sch.git@outlook.com>
 <899a1010643a05668465069951518e5dcab9c77e.1656667089.git.f3sch.git@outlook.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <899a1010643a05668465069951518e5dcab9c77e.1656667089.git.f3sch.git@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/1/22 11:24, Felix Schlepper wrote:
> This addresses an issue raised by checkpatch.pl:
> 
>       $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>       CHECK: multiple assignments should be avoided
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>   drivers/staging/rtl8192e/rtllib_wx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index b7f19b38b0e1..121bf939c6a4 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -149,7 +149,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>   			max_rate = rate;
>   	}
>   	iwe.cmd = SIOCGIWRATE;
> -	iwe.u.bitrate.fixed = iwe.u.bitrate.disabled = 0;
> +	iwe.u.bitrate.disabled = 0;
> +	iwe.u.bitrate.fixed = 0;
>   	iwe.u.bitrate.value = max_rate * 500000;
>   	start = iwe_stream_add_event_rsl(info, start, stop, &iwe, IW_EV_PARAM_LEN);
>   	iwe.cmd = IWEVCUSTOM;


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
