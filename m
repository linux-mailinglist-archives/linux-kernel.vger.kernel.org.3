Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47444E6681
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351554AbiCXQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351640AbiCXQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:00:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665BB0A4F;
        Thu, 24 Mar 2022 08:58:25 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q189so5288156oia.9;
        Thu, 24 Mar 2022 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5/1n/yQL0PaM9gpjD8BL74vTTmyMhMnVzexUmrmhuJo=;
        b=Xd02s76ifoRZYHgxVZVoGj7o32xaP8PYrWtiLUWFsLaid3Xe+Zg4MvqlbbeUF3XWJy
         H1YsQvMOBj8Nqb1t0dXT4JKGp8mOaBbGUBbn1YBDIOaIQxb56dP1OCQvqz/Uj6VkdDIH
         2uTUcFwYNXNlH1ggTs2KnooZD7ZK2k1TtK93J5u4zT2LWYdA+3eL9KCA4XYjf6JRS1BB
         1kYs3JjyQu3kiibLECkxEGK/oTg/5uydV0Pd9EsUMj4NDr7S/Mi6Zrr04wEwL125Gfd8
         3NERsTPTYs9Xl09XzBeDK3pLH8lZ/FQ/Zq/zAb7fq+otxeovbtX8wd5CPDBDWF3ozAhK
         8fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5/1n/yQL0PaM9gpjD8BL74vTTmyMhMnVzexUmrmhuJo=;
        b=8GKLsREIorNVIWNebH0th747OL9TXgpOGXBIwy4CbKezwsIK5hts9R6cr1aeckKf9y
         7QfXpGAcnNn2m0C+wvdqxqFoqNT0AZJuBm7uofk6v0mT6kI0waFWZkFd614KDeV9rFS/
         MRz8UMMt9T37v7Vhy2alO3TxKpP4ktfQMyfEgdrymmJ8B7mkkshFAejl11ubrQlf/np1
         wjS36aN3RfS6mQ11/r9WiW3Kl9AR166+dsUbgo2kJKqtKafPWqyfJgkbJnPwXIfBy+/6
         Y1JD+2W4ecAv1SVmR6+2fLx2K4cQ+Wync0jON8aDepjGvULP/SA/eYCHr2fY4F5m6UD0
         8AiA==
X-Gm-Message-State: AOAM531hagjKdF7+9+8lnRTjnzDdBXhvgpzocJtW/JcrnHklcik5za61
        dv5+gUPApCVHiUqCS8Lc5euXxAziktc=
X-Google-Smtp-Source: ABdhPJx9Wki8uy2EDKrx8/rZ1eDeCsTF58VIL/O8LGICSDDrdUITcqbIF4jleblqxMIHXjrqPiNqYA==
X-Received: by 2002:aca:e102:0:b0:2d9:bdc6:b2e7 with SMTP id y2-20020acae102000000b002d9bdc6b2e7mr3108149oig.128.1648137504681;
        Thu, 24 Mar 2022 08:58:24 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1084? (2603-8090-2005-39b3-0000-0000-0000-1084.res6.spectrum.com. [2603:8090:2005:39b3::1084])
        by smtp.gmail.com with ESMTPSA id m3-20020a4ae3c3000000b00320d7c78b01sm1403252oov.20.2022.03.24.08.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 08:58:23 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d7e3752e-0aad-e247-3708-41f7aba8248c@lwfinger.net>
Date:   Thu, 24 Mar 2022 10:58:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] wireless: broadcom: b43legacy: Fix assigning negative
 value to unsigned variable
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1648109173-28403-1-git-send-email-baihaowen@meizu.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <1648109173-28403-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 03:06, Haowen Bai wrote:
> fix warning reported by smatch:
> drivers/net/wireless/broadcom/b43legacy/phy.c:1181 b43legacy_phy_lo_b_measure()
> warn: assigning (-772) to unsigned variable 'fval'
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

This change makes no change to the executable code, but as long as it makes 
smatch happy -

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

> ---
> V1->V2: modify title of this patch
>   drivers/net/wireless/broadcom/b43legacy/phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43legacy/phy.c b/drivers/net/wireless/broadcom/b43legacy/phy.c
> index 05404fb..c1395e6 100644
> --- a/drivers/net/wireless/broadcom/b43legacy/phy.c
> +++ b/drivers/net/wireless/broadcom/b43legacy/phy.c
> @@ -1123,7 +1123,7 @@ void b43legacy_phy_lo_b_measure(struct b43legacy_wldev *dev)
>   	struct b43legacy_phy *phy = &dev->phy;
>   	u16 regstack[12] = { 0 };
>   	u16 mls;
> -	u16 fval;
> +	s16 fval;
>   	int i;
>   	int j;
>   

