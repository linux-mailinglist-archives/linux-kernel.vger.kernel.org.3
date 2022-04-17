Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5C5048E5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiDQS1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiDQS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:27:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8F13D12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:24:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso2309913otk.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z6B8K9hOSItoReJE/oEpye49sP623Gy4KHdMI2dEK/o=;
        b=XTIDgrLuHfJw+v4YqpMsiKjUGQgAsaGcY9sTeU5OMWIM8iuTHs8MaxmoqCl1dr57/5
         Z4uoCvPCTGo7w80vBVVcG9RuGJ6NBb2fjulczKsQJrjBsk6U6UCci+7yhAaDzHmYEqJD
         wup4qhQwIa2qekzdbYc0FgDr4Gu5qs16WL6hbihYgkddoVOOJthoUCpt0uL0eas7BCzn
         pwMcWzilBFMI/tMpdYz6m8uHdiMl2kYTXEYuRIVtIKNERwPMQOL6zrtednXUbD9ETGEE
         YFV5QoKZeiGSMdHWr9YmMXKuD1dvGT18wT+7JZsJEBrLa/BEbp5ryfdwH2KSJqACX0so
         6E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z6B8K9hOSItoReJE/oEpye49sP623Gy4KHdMI2dEK/o=;
        b=IUTJz1QpoNs3WmGAiC8U3uEAl9tgy2IvioNeU6oGSk5C/lhS/7klG0m6C4TpDk1dQh
         hnQTkdkwGFlb4PqPTPPtLj/PxNQb7Bv2l0SuM5cjWe+yhekQqBhvItCDEwhRfXrlpTP3
         qGw3RjcOVn2uZ8N6ndeEljNpfPLk63Moqly3rrOg4EyMH0e3rOC5kOeRMsE/LQ70jJPq
         gHayTBEHEkMadujnbOvUMAkg2bTBOPgijNkXBY+fL0X1SCrB75RKo7OiyKtKCZ1pm6hF
         /OEhSUAluZYXAnofPD2wfOLh9mOvR8TZLZs2mY/hTF2CHoUiFc+Z/OJds96xJKCC5Iu/
         UaPw==
X-Gm-Message-State: AOAM533dtAsRIFQncaphREBV/WQsRngl+OTAtAcGvHakPiLS0yJH/sHW
        ihQ9v8Ax8x6yMvqZXCFd0FLOpOTYhVBRDQ==
X-Google-Smtp-Source: ABdhPJy9acbYLr2W1JIQ8B141EOKx0BplVd5ADTQLstr61Lua/KAwX7BsKbQiHiwK95JKz9D3chPPg==
X-Received: by 2002:a9d:6303:0:b0:5e8:eef2:1963 with SMTP id q3-20020a9d6303000000b005e8eef21963mr2717735otk.169.1650219872938;
        Sun, 17 Apr 2022 11:24:32 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id w11-20020a056830144b00b006054888b7a3sm1109687otp.1.2022.04.17.11.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:24:32 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <e30cf945-61d4-acb7-757f-0ffcd3035901@lwfinger.net>
Date:   Sun, 17 Apr 2022 13:24:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/8] staging: r8188eu: fix and clean up some firmware
 code
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220417175441.13830-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220417175441.13830-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/22 12:54, Michael Straube wrote:
> This series fixes wrong size of struct rt_firmware_hdr in the first
> patch and does some cleanups in rtl8188e_firmware_download() in the
> other patches.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> v4:
> - Keep the in-line comments of struct rt_firmware_hdr.
> 
> v3:
> - Splitted the first patch into two separate patches.
> - Added back logging the firmware version only once.
> - Included the compile time check for size of rt_firmware_hdr from
>    patch 8/8 of v2 in the patch that replaces the hardcoded size.
> 
> v2:
> - Added a patch to check size of struct rt_firmware_hdr at compile time.
> 
> Michael Straube (8):
>    staging: r8188eu: fix struct rt_firmware_hdr
>    staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
>    staging: r8188eu: clean up comments in struct rt_firmware_hdr
>    staging: r8188eu: rename fields of struct rt_firmware_hdr
>    staging: r8188eu: use sizeof instead of hardcoded firmware header size
>    staging: r8188eu: remove variables from rtl8188e_firmware_download()
>    staging: r8188eu: use pr_info_once() to log the firmware version
>    staging: r8188eu: check firmware header existence before access
> 
>   drivers/staging/r8188eu/core/rtw_fw.c | 84 +++++++++++----------------
>   1 file changed, 34 insertions(+), 50 deletions(-)

It has been a bit of effort, but I have no comments on this version.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Big improvement,

Larry

