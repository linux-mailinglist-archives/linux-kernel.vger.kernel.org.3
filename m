Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2474F14BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiDDM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDDM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:28:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777E3B56D;
        Mon,  4 Apr 2022 05:26:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w21so8196402pgm.7;
        Mon, 04 Apr 2022 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fnJuoERhv8ETdvaOu3dlxEyvw1tLWFCWvEfVDiqOVwA=;
        b=mfDrhSuJdnac+yngsaGZ+Hp2hIExeUoenhoMUwzY5LXt4nybrn72WBXJR2o54ZHW6x
         LVn7J6O9An6adSvQKWDw6efWPFN6ONzz7fPs9S1qi5TJecttVD3EnP1e9qJ/G/8IGpJO
         RcEjEi1DdF3noaCLypmC9OpWDh7ETfWRwDDH6VpcY/5m8Im4Xs+baHHDdMzbzOmrO6o6
         V9TQ77aecz29Xa1NNEC4FiEUoNXgVgLJr5RKX0G/aMdNWaNmKl34d3Y62NygjznZDinF
         njbmqPWfrDOcqdqhV33ViC31nBBW2+z7NnP2SepGUYC0xJXryLamyEF0d7qhtPozjHFY
         TbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fnJuoERhv8ETdvaOu3dlxEyvw1tLWFCWvEfVDiqOVwA=;
        b=MUWpvku7bjcT8Clq7StphNZ6F6x7nUNpi/QJGnYCSqxAMY0lGid3Twg/z8kOoqfdjb
         l4ThXQXWrqyite2dHWhpHgcKUpQIuLSRHseFj90/+VU0dAy9Vmn81F23IY4Z92tvgvaQ
         7/aKaJq6GvHcuIzOOnaoAy23kkTR2BemMX9RRJCigyzhdNUxaEg8V0XuGR9SqCdZ4fxt
         2/1zfaJQnjgIFsvTnAqnhIxnrZszpFgpPFZ4Qd9tadXnJ6CICK70ZpviNC9ptb5w0ZCR
         uSC4W1FaGJK2uDow+7G3Og0+cj8z73aP6fEPSpMTfW31bqwsm658uRcQ7qxRJMxabWcz
         uhzg==
X-Gm-Message-State: AOAM531wUTkmzJd5CuXgvMSA0ZqJshEzB4ui4D6wwJ5Bv+Maf/gydzej
        XzYSqpFodv28levJXuCSrPg=
X-Google-Smtp-Source: ABdhPJyX6xOF2bGRTjJTAbyf2AybJrm7dFZdvpTwDq4+J1eMMgc95JCJX2Ta9y0JGpGWiIKud7tKnQ==
X-Received: by 2002:a63:2b0d:0:b0:386:322:f05c with SMTP id r13-20020a632b0d000000b003860322f05cmr26074315pgr.11.1649075200737;
        Mon, 04 Apr 2022 05:26:40 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id mr10-20020a17090b238a00b001caab109ff3sm1959211pjb.23.2022.04.04.05.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:26:39 -0700 (PDT)
Message-ID: <abc7cc7d-b21c-7b6e-487d-f8f8896b40e7@gmail.com>
Date:   Mon, 4 Apr 2022 19:26:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: unexpected indentation warning in
 Documentation/ABI/testing/sysfs-*
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-iio@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Chao Yu <chao@kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
 <YkreSbV4+KmW1/zV@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YkreSbV4+KmW1/zV@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/22 19.02, Greg Kroah-Hartman wrote:
>> Presumably because Sphinx mistakes these documentation files without
>> extensions for .rst files? I dunno.
>>
>> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Care to send patches to fix these up?
> 
> thanks,
> 
> greg k-h

Hi Greg,

I'm sorry I couldn't do any fixes for now. I'm just reporting.

-- 
An old man doll... just what I always wanted! - Clara
