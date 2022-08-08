Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7458CDA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiHHSdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiHHSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:33:17 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4CDE82
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:33:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k19so2786803qkj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mTBuc/YjazV4B5Z0SpCpYJndKM/Ze/7Cyi3qZ0S4go8=;
        b=Pi+b0kaTVMtfmQyTHjEBd0l8rkdZi1Dzn+0thxdX26i5LPWE+hasFIf2E9btJdOoMW
         gH+OrzhjYIBIhUOxOQl30Vh5SlKy+VZHUi91zHNXARgWd4P1I9wY0NhVIQEp3+zieupN
         cI/d/AOJiH/fCrsjeZilqmQvI3YshF0jCvqZr+gbc+TTepRl3qWM2ueEylKyAvm3Io94
         JnBmgp+t0EOCfzmYPP4CCh5c7CNoHbqfTjHAPib21U77wdhY+WpqpErgL8kYD5ZaERrg
         wy2Z4g3y3zflWbwXCk7P9TSOhd6o2rr4epCNUQqKmM6tvTJO2DGvfMasuegFTlMEd684
         jl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mTBuc/YjazV4B5Z0SpCpYJndKM/Ze/7Cyi3qZ0S4go8=;
        b=cqeSmsxreBkou5aViaGy6UGmf5VtSpodAyDmX0sJgCVwl+SvJjCOFHsws1QvEq6sIu
         UuCSwVHrWmY7cRx7qFADjcVZgATPbiq8Y3SRfoUEM0y4TpYxR53e2JZWs/+GmlPRmJ8F
         jLY6ZSFI0pB1dTF4IIcHjXHh0aMu6mtKjFEEugmdiYlJuZ8IOSzZ/aH2vMd1opcWsvj1
         q8bDxWUvrUF6oy8hvXvN9bRgegMkAFgBXXK3X2O54nSaBf2L78UmI4XQPiL4vt2p0Vo5
         XKtPQhhcLm841+11MCIX9D+e02KOG3k/FoO8P+HQSjOBZMve92iiGXdruxgt3NPXx9m8
         7djg==
X-Gm-Message-State: ACgBeo1F7t2I90tuF+Ipwr6V351moPst3y66XTsQzUz1tNnfHC2nTlSB
        3IXe1cTcL4uWzFYVt/4ayA==
X-Google-Smtp-Source: AA6agR4tU3frXaUe8iEjHlozZ6W6Fur6lEL16E+6LxRukASSHH9myyVNCp1kuhu1AaWcJ6cJQjDHDQ==
X-Received: by 2002:a05:620a:25d4:b0:6ab:8b17:3724 with SMTP id y20-20020a05620a25d400b006ab8b173724mr15059326qko.395.1659983595966;
        Mon, 08 Aug 2022 11:33:15 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w19-20020a05620a445300b006b9264191b5sm7231016qkp.32.2022.08.08.11.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 11:33:15 -0700 (PDT)
Message-ID: <8c8f61e5-2c24-de89-1c7d-532c319a3b70@gmail.com>
Date:   Mon, 8 Aug 2022 14:33:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 24/32] tools/testing/nvdimm: Convert to printbuf
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, pmladek@suse.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, nvdimm@lists.linux.dev
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-25-willy@infradead.org>
 <62f15649dbce8_1b3c294d4@dwillia2-xfh.jf.intel.com.notmuch>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <62f15649dbce8_1b3c294d4@dwillia2-xfh.jf.intel.com.notmuch>
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

On 8/8/22 14:30, Dan Williams wrote:
> Matthew Wilcox (Oracle) wrote:
>> From: Kent Overstreet <kent.overstreet@gmail.com>
>>
>> This converts from seq_buf to printbuf. Here we're using printbuf with
>> an external buffer, meaning it's a direct conversion.
>>
>> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: nvdimm@lists.linux.dev
> 
> My Acked-by still applies:
> 
> https://lore.kernel.org/all/62b61165348f4_a7a2f294d0@dwillia2-xfh.notmuch/
> 
> ...and Shivaprasad's Tested-by should still apply:
> 
> https://lore.kernel.org/all/b299ebe2-88e5-c2bd-bad0-bef62d4acdfe@linux.ibm.com/

Whoops - got them now, thanks!
