Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF71500014
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiDMUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiDMUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:41:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710383207B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:39:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so5628313lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fYQwf1MFEi2p+ImntMeAp4Bvczx3GAneP4+zjXqea58=;
        b=FNNt24W5RmK9/Smtd9HW3bxBLmVkJAW6x/7G0FEH0V/I0wWl9NG9yMKTtCC5X9qy7t
         8zpOaOHX+nxIpVNUCF5wAc8kmk1bIrEYIlqzxHh67BXcUTyazwsPtyERm0WSq3SskngE
         1scb/Ds4okAkGm9iTNRiVB5Mn8+0V9Bt/DDpG5jYGcAaOHpExQRZhyyVzXQfmg4QW44T
         czy5q5/XNbLZx1JiQbqeudvIPcUfbkVIdQfpC/QiplVh18yqjPZUlwVNRD342OxF7OT0
         eWHFAJxvcDs7Fj2Q4ny4EJmVKtVsvAwqnlctzRdfmYQsRwRdnSBg1LRsue/KmTv7xvsd
         N+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYQwf1MFEi2p+ImntMeAp4Bvczx3GAneP4+zjXqea58=;
        b=qyLzJI6b1TkcMNtqLdU1t+TPlKaqYz3aA1hB1xA7W5raDbKY4d8BdqWkrUitbU5CG1
         30Hfr+ZkNJfO1GpRbLibZTVLrfZhdin3DdYG77/qBfCz1odyhjQ5EHd37vJGRGr45y0y
         OoHshULXOiQ6dsASxkhqC8guYoDqVEOZmn5kcXjGoDZLg0RTnfDgx1qLsqCLbQCk13LR
         fLlurVBPNpO92oFaWtGF+AWhpDVYjKlHhhQpF1GwDZyHSGNnfp4q1t2Et9ypIWspoGz1
         jcCPEALp31ruECCXpHln1PssJ8Q+wnpOshwGGSL0Tb1bee/sh8KSwyKB4hp8ahUY+z1L
         axiw==
X-Gm-Message-State: AOAM530afKWSE70U+6GDXZ7JblWJ3/JIYs8x9kcQshFXmT0pDw19ARpj
        1AdVkcvCSIorR3bxBjIMhf4=
X-Google-Smtp-Source: ABdhPJyY+QSeEyckG9WkEcu2jeIkFmNEQtFmAql1ifALgjaJjdhsi26Z3XCpdC8WieZJoX2/PFi1qw==
X-Received: by 2002:a05:6512:c18:b0:44a:9992:28bc with SMTP id z24-20020a0565120c1800b0044a999228bcmr30100438lfu.641.1649882346657;
        Wed, 13 Apr 2022 13:39:06 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id p20-20020a056512329400b0046ba6832cf6sm2861lfe.155.2022.04.13.13.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:39:06 -0700 (PDT)
Message-ID: <b028d269-4dd8-7165-6220-d42c1e0e588c@gmail.com>
Date:   Wed, 13 Apr 2022 23:39:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] staging: r8188eu: merge _mgt_dispatcher into
 mgt_dispatcher
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220413200742.276806-1-martin@kaiser.cx>
 <20220413200742.276806-3-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220413200742.276806-3-martin@kaiser.cx>
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

Hi Martin,

On 4/13/22 23:07, Martin Kaiser wrote:
> All that the _mgt_dispatcher function does is to call a function from
> a function pointer. It's not worth having a separate function for this.
> 
> Merge _mgt_dispatcher into mgt_dispatcher.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---

[code snip]

> +
> +	if (ptable->func) {
> +	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
> +		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
> +		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
> +			return;
> +		ptable->func(padapter, precv_frame);
> +	}
>   }

Looks like each `mlme_sta_tbl` element has `func` member initialized. I 
think, we can remove this check.




With regards,
Pavel Skripkin
