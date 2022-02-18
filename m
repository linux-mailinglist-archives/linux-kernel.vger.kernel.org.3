Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F674BBE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiBRRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:45:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiBRRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:45:51 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B69251E47
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:45:34 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id e19-20020a4ab993000000b0031a98fe3a9dso4353318oop.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=afcM4DQupixAxH0kc1FcSrJ62dkTTraEAu7alpgcE5k=;
        b=T2FTHtJlw2tz58RdWq5RP/pXsvqUojg0GbRxPQDEAZsbI5S3XxD3nc+uWjVc5kMo46
         EVoPJlz3ZiGLQ97OD+P8Mz+CPb/quyO5wYs8zjn8cO9huLAmun9brZQb+K5PdUJfwhCa
         Gv9KcPoWfBCHCe4jeVU+iqa+belCW2JP35GX2LQzk0synQTcnKE22hM41CFe7yGJl15T
         PQJMoJYfZ5ITi3OuEmNpqyyc9avf4BlkQ8ie5Q0S506dpdzkwIoW2fYHQsaedQJLMS6U
         s3nb0vmjJ31wQMNN0x6J2Vc46Bw6y0DPLb03A/vYhscgM8HKBZKA/weNIbTO9DIHkyQi
         dT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=afcM4DQupixAxH0kc1FcSrJ62dkTTraEAu7alpgcE5k=;
        b=S5vCBD6gVmubxX/rgIJopfQjjDR47OQgMTIrc6Pxu4Ix1ly1Hw2+75kYgIOSkqoo1/
         2yxKRik+mOe6mlJO9b3guibgdQskI+eyQc0F0P8Ci1Ue4tcFg6jIuPQjydVnNmaOCGH8
         wfB2o4bwhx/VZH7aRyURJGrmtyj/8HmBIXFzHL88ufXIAvIOJ0pxKvLQSjIuRvPEBGXr
         Fj4BI8DepDdJZCe3+UTXqoAj64Nx8aMtD1B4cnrscy3KajvJUu8YXNJF0+wNqZhzy9Sc
         o66o7F8kyoVQioInHzLIOmtPh3ocd+lbxRjXzyTbPX0psGID1UyLaiX18ro8wEHMJ79R
         qDOQ==
X-Gm-Message-State: AOAM531Yff8/p2FZW3jd81UT1jX3eecptGn4N9jYXpKISxZbd9IXe9Uq
        MZWrTnmviIstvd74+UVAgNg=
X-Google-Smtp-Source: ABdhPJyId5/JaldGbob8T9AXgeuwzjHaMaeS4RXNFfR3wDk9nqVeHI5Geg7g8vUf9Ox7DP8Cs8Hm1w==
X-Received: by 2002:a05:6870:75c6:b0:d3:5241:d4c0 with SMTP id de6-20020a05687075c600b000d35241d4c0mr3168966oab.19.1645206334092;
        Fri, 18 Feb 2022 09:45:34 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id p22sm22691187oae.33.2022.02.18.09.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 09:45:33 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <fb51e801-d1b9-a436-8fd2-e05a69f0c24b@lwfinger.net>
Date:   Fri, 18 Feb 2022 11:45:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH RFC] staging: r8188eu: comment about the chip's packet
 format
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220218092252.853807-1-martin@kaiser.cx>
 <20220218102227.GE2407@kadam>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220218102227.GE2407@kadam>
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

On 2/18/22 04:22, Dan Carpenter wrote:
> On Fri, Feb 18, 2022 at 10:22:53AM +0100, Martin Kaiser wrote:
>> The structs phy_rx_agc_info and phy_status_rpt define parts of the
>> header data that the r8188eu chipset sends to this driver via usb.
>>
>> Add a comment to clarify that we cannot modify the content of these
>> structures and remove seemingly unused fields.
>>
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>> ---
>>
>> Dear all,
>>
>> I experimented with "cleaning up" these structures and related code before
>> discovering that their content comes from usb packets we receive from the
>> r8188eu chipset.
>>
>> Would it make sense to add a word of warning to prevent others from
>> repeating this exercise?
> 
> Just the fact that these structs are endian means they're from the
> firmware or the network.
> 
> If a struct has a pointer in it, then it's rarely part of the UAPI but
> if it has endian data then it probably is.

Additionally, do not change any struct with the __packed attribute. Most will 
have endian variables as well, but not all will.

Testing after modifying any struct is a necessity.

Larry

