Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D034FF2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiDMIzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiDMIzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:55:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACF3E0CC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:53:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so2367057lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=REX/z+n7YWBBJDlzF+Aw7IHHABYWnYTA+zJDNU+tu7Q=;
        b=oEV3gX7Rvbzp2KVJLJ69CrNyKqmwoP9ryrMSU7KFeaMcacoPE/HZ0whfjtAsHzQpH2
         Zyyzmlg29f0yESAZ5wwvxMM8xVAi39rYWqNVEQP1sRzsxAmxm+D8Lf3aLmABPl9xMatv
         WSdeMrWqfdu+vEBxsFXFyG8krQqi5IO3Aj+0fVZhLxB6QWlLDG6X7989fbz/hcOjzM8V
         WFosbj7EhA7qJW5HwhySVemvTAgMvVXR5tKIKriPawNP0X9kLJa9pjHA5Cm71cL2xX81
         qEU5YTeKYWiUJPKBQ2s99TqJaQwewk1WtynSoE1p+Jq5YKWlWyf/BTZOpyIDs5RfRgZB
         WweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=REX/z+n7YWBBJDlzF+Aw7IHHABYWnYTA+zJDNU+tu7Q=;
        b=oBEAX55FAFy/NG5oBkpOMkfLKJkyFLDlanwow67XcN56pFRagzE98l2TxaukcLoa4X
         nd1kqqdsze6HEPRUs+o5N64A7h3quXYmKytjk9bD2Ln6IDvEunTdt4kI9Dl/t5TKF8jf
         qjN3BO1hIv5peW2xZFpodqWwY3f4097mqC/MH6RsRasaTV2atqhJUXNDQOCmCMNLldAI
         ZjT8/sMa7ORm5msOv3dUoKp+gBMTS7Fj/ELxkGB4zKCUhWj43K7bLnlg8cB3/Ad6KBdF
         XXD8XLdw71NAUB96Fvu35+AdBd0lRZeOdp27oI553DBr+nJ4dEoRzUsWEsa3nL9AfRRn
         RgTQ==
X-Gm-Message-State: AOAM533CTxXvwHKoZh5KytvyOTgcF1jHWa7CprC8t5/+nwAcyrVgOmOQ
        OKmZJ1MVVaxA1xg3yjPshqcB0wYmH6w06A==
X-Google-Smtp-Source: ABdhPJxr5eXW2iLcB++u3dsXLo8Bp0ENFxT3tQssPkZ7+Fl2HgeHHYKub6XLGAH++AsjbnjZnMU4ig==
X-Received: by 2002:a05:6512:b08:b0:46b:a876:3009 with SMTP id w8-20020a0565120b0800b0046ba8763009mr8839300lfu.378.1649839980642;
        Wed, 13 Apr 2022 01:53:00 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e7d14000000b0024b44fb9a9esm1930623ljc.51.2022.04.13.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:53:00 -0700 (PDT)
Message-ID: <4946ce95-8692-b765-b5ea-ab4b521182fc@gmail.com>
Date:   Wed, 13 Apr 2022 11:52:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: remove else after return and break
 statements
Content-Language: en-US
To:     Mahak Gupta <mahak_g@cs.iitr.ac.in>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <20220413052759.4859-1-mahak_g@cs.iitr.ac.in>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220413052759.4859-1-mahak_g@cs.iitr.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mahak,

On 4/13/22 08:27, Mahak Gupta wrote:
> Else is not necessary after return and break statements, hence remove
> it.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>

[snip]

> -	}
> +	/*  could be pure B, pure G, or B/G */
> +	if (rtw_is_cckratesonly_included(rate))
> +		return WIRELESS_11B;
> +	else if (rtw_is_cckrates_included(rate))
> +		return	WIRELESS_11BG;
> +	else
> +		return WIRELESS_11G;

This 'else' is after 'return' as well, isn't it? Just wondering what's 
the difference between this one and others in this patch




With regards,
Pavel Skripkin
