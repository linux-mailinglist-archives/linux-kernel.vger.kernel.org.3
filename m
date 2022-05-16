Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA42528280
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbiEPKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiEPKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:45:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1451147D;
        Mon, 16 May 2022 03:45:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k30so7225519wrd.5;
        Mon, 16 May 2022 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=punFsSWooaR/zkqiRvfCk7P2Q5fE22P5g6FkfwQb1y4=;
        b=DqwzfO7hORJHGLUvl2vG9u2d8HM7PpJt2LdUrkKPwviPxq/M/Mn/0LZyWEsuCfEnwK
         esQ9B3LlmA8xBAW1Nx45fJ6EUXd1L0SAYOCuIqfCXOwTutnHdLPXSrXWyuAd+mCIrL47
         VGzC+GHdx2llI5Ab5I58r78dbA9V6O1ZKcTMOz+rzanynXzvmV9C8TpSuCqoFgsPdKiB
         0iEVGedqnR9qVo7+ioj6xaafdb9iut0tiH83sMK9KtV/wZnZrNftCmYK2Dk990id0itF
         Avl9cmHG44MZpUhXtxkp/L4Qrou3nUMyU1uieAnT8uX5rzw16uKEPyVtUdiag8UxORQt
         Ix4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=punFsSWooaR/zkqiRvfCk7P2Q5fE22P5g6FkfwQb1y4=;
        b=3PZ7QfOUCJOxPx3IVFlVYutVRM+YU7+2YmrC1LnXJoizSUWA2Ymr48qBrmYZrMn327
         h4GjHpoa0pMjVaGF9GQp8vJmt8Uk1HRRqGiRLh6oBaEoj1Y4xTw8i4a4MIuCReml8kd5
         8S5RH1aHr9kc3wUSvvva99LTDNFLaksgNRuGuhxGqqEG66w64fIJ5PH0gpCzUlqEKKZ4
         WygsBy9nO/Vq8DUwGjh7n6WzgNwY2uHImykw1ZCzhJ3omn7dvwNDcrQDBaxvR7jjFvtl
         9d3fuuFSdWKRz76ZNl9ZMwFX5ALZeRaXxnWJdnCNDNabItPPmhEn3WwpoOHAbCbWJoCC
         aDYg==
X-Gm-Message-State: AOAM532xEbyAC4PLkgZgXQ4gT2BUQaa7tUHZh1JiDblrdckXt4rKdvb7
        1iKXqYz9c58oGxmJyep7G+U=
X-Google-Smtp-Source: ABdhPJyMwU2zdo7BT7eoGn+hO0VI3lIF0I9GELIneRef+MrwbXkoT/UpWzO54SIm26FF7q7w55DzFg==
X-Received: by 2002:adf:e310:0:b0:20c:7894:99ad with SMTP id b16-20020adfe310000000b0020c789499admr14039171wrj.73.1652697951311;
        Mon, 16 May 2022 03:45:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d40:29d:ba85:78f8:3d80:548? ([2a02:810d:6d40:29d:ba85:78f8:3d80:548])
        by smtp.gmail.com with ESMTPSA id v2-20020a05600c15c200b00395f15d993fsm4484148wmf.5.2022.05.16.03.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 03:45:50 -0700 (PDT)
Message-ID: <140fe69a-c37a-cce4-c7c1-0344de6f1bf1@gmail.com>
Date:   Mon, 16 May 2022 12:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Status on hid xppen patch
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
 <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
 <20220424093239.GA4380@elementary> <20220512205952.GA8936@elementary>
 <ebb6d627-4974-beed-1dc6-60634ab2f034@gmail.com>
 <20220516090829.GA20623@elementary>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <20220516090829.GA20623@elementary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yo José,

>>> I had to introduce new functionalities to the templating system of the
>>> driver, that's the reason for the KUnit tests.
>>> The last patch is work in progress (hopefully I'll have time to finish
>>> it this weekend), only the HID descriptors are missing.
>>
>> I hope you make it, but otherwise you can always use mine, as it's quite
>> the same as yours. Only the logical minimum and maximum are -60 and 60.
> 
> You are right, 60 and not 127 is the right value. Actually, I think
> that -61 - 60 is the correct range, because of the 0.
> Running "libinput-debug-tablet" makes it easier to debug.
> 
> I also had to fix the descriptor to avoid an issue with the pressure
> causing issues with the Deco L, but other than that, it should be
> correct now.

I don't think the two's complement thing has any bearing here, because
there are still several numbers left in both directions. Also I couldn't
get the mini 7 to produce tilt values either >60 or <-60,
but I'm sure you'll get behind it.

> Also, I don't know if you have seen this error after connecting the
> tablet:
> 
>   xhci_hcd 0000:2a:00.3: WARN urb submitted to disabled ep
>   usb 3-2: reset full-speed USB device number 6 using xhci_hcd
>   usb 3-2: reset full-speed USB device number 6 using xhci_hcd
>   [...]
> 
> It happens with the Deco Mini 4, even when using the hid-generic
> driver. I need to rebase my patches on 5.19 and test again, just to
> make sure the problem is not somewhere else.

Can't say I have seen it. The only thing I can think of is that I was
using the async urb functions and that delay did something about it.

Kind regards

Stefan Berzl
