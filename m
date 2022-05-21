Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA652FFAD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 23:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346882AbiEUV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiEUV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 17:57:24 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B2342A24
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:57:21 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f17f1acffeso14042174fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gAITwp43a4w30vT1uOOmJoUF5xFm7wkkasuEdQTf/Fk=;
        b=bNkZRhnXoZZ5uhXo92mBOu73mygo/R5GNLxg5obG3gOyW7/ORTAmhTscXQcbfLNEQ1
         QtgbRC9m0DSk/EXOho8u69FZK13Ea6S9b1Xmc2oHdMYWJ10lu4x+F5nCMLzEtSfJKJVi
         Dy0xuYMXQo//jUgiFURvGWJawZzN69S9XbraN9tn75SF1FB0Z7nrAEo9bkfwRpoBOD4a
         mDQYGWzKb5ERrU6YxR/cZvZMASYIYzjOH9loLCEzEzgEUSH+9XIDHx+o+MgPJPRhb74d
         EcN6hyAirMWVFhDj7s8PLXOuRuM1z7BuHO8C5lVzKCs7mWQKem6/2OayIgUeQhI69C8A
         Bo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gAITwp43a4w30vT1uOOmJoUF5xFm7wkkasuEdQTf/Fk=;
        b=KI2iPnUTturLMECv6cYVXOVLR4QUMg11fJMj7a8qKsNVEEISEYAvIAalzmezLSBzo0
         kuESHa80opqe5pqWFvu5NO8FdQL7RQRsoP2v5J/DlMcc+NXLuqLd6Zugd8CTldhIJC9h
         jtK/By6OAKBjEP7+IWo7BMVzULgwz8vR7Ck6M6OIxjlFQHXPjdaxHLvSK5MAt3osaKTQ
         mIAo5Fbo5hJY6InZOfDkVvP6n6gY+0fQLaXdZ/1B3JH/vca3pzuKptkww0onYXJVD1ww
         x6Wt6xf7+ObBGdb0eVsdnZmzqXg+AtelSi1TFMMy0dxBjpMD4ZiZkIctu5246NwIgG3y
         hGAQ==
X-Gm-Message-State: AOAM531NNiYAmFsk5qA7NmPeiNlv7m5j4NSjcsnGJgEB/eTLTcrSS6vg
        NmLLGVV4ZEu7l78hwYGkuFl88toPivs=
X-Google-Smtp-Source: ABdhPJzltjAK+2MQ+KnlkH5rxNWyy/EZlDTj21LQ1U22Fyp6iyU7Bt80iI2IPVBUOEdsF1/h8AgAzQ==
X-Received: by 2002:a05:6870:5487:b0:f1:98a6:6f79 with SMTP id f7-20020a056870548700b000f198a66f79mr8996604oan.221.1653170240847;
        Sat, 21 May 2022 14:57:20 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id m129-20020aca3f87000000b00325cda1ff99sm2617026oia.24.2022.05.21.14.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 14:57:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b922eaa2-303a-69da-03ec-e053092c8682@lwfinger.net>
Date:   Sat, 21 May 2022 16:57:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] staging: r8188eu: add check for kzalloc
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <lists@kaiser.cx>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dan.carpenter@oracle.com, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
 <20220521155017.7jjz7prdnspm2276@viti.kaiser.cx>
 <8fb49b5b-106b-3346-a75d-d54e0a065587@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <8fb49b5b-106b-3346-a75d-d54e0a065587@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/22 15:26, Pavel Skripkin wrote:
> Hi Martin,
> 
> On 5/21/22 18:50, Martin Kaiser wrote:
>>
>>>      for (i = 0; i < 4; i++)
>>> @@ -1474,7 +1479,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, 
>>> struct xmit_frame *pxmitframe)
>>
>>
>> res is still 0 here - but the caller of _rtw_init_xmit_priv compares
>> this return value with _SUCCESS (1) or _FAIL (0) and interprets it as
>> _FAIL.
>>
> 
> I think, it's time to make
> 
> s/_SUCCESS/0/
> s/_FAIL/-1
> 
> since developers from outside of staging are confused.
> The main problem will be with functions that return an int (or s32).
> 
> Will take a look.

I agree; however, this change will likely break a lot of pending patches.


@GregKH: Could you apply all pending patches in preparation for this patch? If 
so, then Pavel could make this transformation while the list is relatively idle.

Larry
