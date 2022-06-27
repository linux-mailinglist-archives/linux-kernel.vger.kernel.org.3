Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1055E062
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiF0RfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiF0RfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:35:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60FD114;
        Mon, 27 Jun 2022 10:35:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k9so432114pfg.5;
        Mon, 27 Jun 2022 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9CsM32t4Z5wOlsd6CfHVHJCzLBpNtvXv2dbWYHZaXLU=;
        b=RK4Ufv1btDwvSThAEWtsmECgPZQsYJ8Q+g/0z45hnkXo1YSOm/3RK0fC8enuDFwdi9
         HRmTRmJ9XNIZeawPvns8+lzFKC+rXq11VKQBtoesSsc7NUozujFZOmMRVKKoFlKFUj9D
         i4pT8sOCkbn/kxvyxsFoRT/TaTV73NRfywWmEzaK7oBqGnn5tXf79xSGejTnSx+c3WBS
         +w67wB47EoboF8fFgyJoE4yK7WfFW8O8tPIi1SpuHVzmDOuBdv1NygpSx9ZWOUeq8K4e
         DXEgPnrXq+xYbL+2/k1mm8qO6tkSYmnr1iKB7BkGMKlVSjVB+Ar/JPaxR0HtBGrkDzrg
         n3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9CsM32t4Z5wOlsd6CfHVHJCzLBpNtvXv2dbWYHZaXLU=;
        b=yqkF1ynEgqA6MevAw0gNbwRXVy2ebMD+/SzTQx+mSIFmDdciYtBMc29OmSxOq7gNeV
         z/lNBP9tnzJhrNJrtLlIF3GMcfpa1e97UiQ8NYALrHTlQpQqEJ9P92oWG3uBN4hxMx1E
         BDqBPEer9LfaBtlGRlAk7yypmvkAQA0lE48FkkBYixHjP4U6cVRs8feLzEC9oS2VvqNI
         9SWNbmGi0Ql/3Hf1LvxHs8g+Q78vEv4AhbRDr1fRWSehh7nZnHwIKPFyAuB0BCzNS0Rm
         011ROCvQReVPHMF8Wn6gdSPPYmqnZCi+CmshUeuHzrk+wJz3vjkpBB0dgz1URRH/wXLf
         mGaw==
X-Gm-Message-State: AJIora9zvfNi0R9O0nChug9irSLtoajJ8wNgopetpNNba74fTnLcO5de
        eBHV5b+6boKyiHLK4PWvpCF9qxFfXB7RyA==
X-Google-Smtp-Source: AGRyM1upCKTPMsUWpygoe5VlMqEFj+0nvXAo6yP/f57cp5lQIlM99+6uwPDDgGOxC0t0zuTT8/BNXA==
X-Received: by 2002:a63:6d4a:0:b0:40c:f5db:f08a with SMTP id i71-20020a636d4a000000b0040cf5dbf08amr13369355pgc.124.1656351305354;
        Mon, 27 Jun 2022 10:35:05 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c0f:ec3f:8053:b39e:a633:cf03? ([2401:4900:1c0f:ec3f:8053:b39e:a633:cf03])
        by smtp.gmail.com with ESMTPSA id rt22-20020a17090b509600b001ec98cc43e4sm7555707pjb.49.2022.06.27.10.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:35:05 -0700 (PDT)
Message-ID: <f08574e9-3e1e-0bc4-c95c-83fb955d2869@gmail.com>
Date:   Mon, 27 Jun 2022 23:05:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] platform: x86: Remove duplicated include in
 barco-p50-gpio.c
Content-Language: en-GB
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YriUMDJoip0Mknh3@Sauravs-MacBook-Air.local>
 <8735fr1bqh.fsf@dell.be.48ers.dk>
 <924eb8a2-a040-0632-872b-e1951c71c169@gmail.com>
 <87y1xizj06.fsf@dell.be.48ers.dk>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <87y1xizj06.fsf@dell.be.48ers.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/22 12:32 pm, Peter Korsgaard wrote:
>>>>>> "Saurav" == Saurav Girepunje <saurav.girepunje@gmail.com> writes:
> 
>  > On 27/06/22 12:41 am, Peter Korsgaard wrote:
>  >>>>>>> "Saurav" == Saurav Girepunje <saurav.girepunje@gmail.com> writes:
>  >> 
>  >> > Remove the duplicate include of linux/io.h in barco-p50-gpio.c
>  >> > file.
>  >> 
>  >> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>  >> 
>  >> What tree is this against? The io.h include in the line just above
>  >> delay.h was already removed by:
>  >> 
> 
>  > I am using git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git .
> 
> staging? That seems an odd tree to make platform/x86 changes
> from. Just using the mainline tree would be a better choice.
Ok, Sure
> 
>  > if it fix on another tree . Please ignore this patch.
> 
> git describe --contains 011881b80ebe773914b59905bce0f5e0ef93e7ba
> v5.19-rc2~1^2~5
> 
> So it is in 5.19-rc2, released 2 weeks ago.
> 
Yes
