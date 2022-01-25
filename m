Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9007E49BD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiAYUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiAYUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:52:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B68C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:52:07 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id h23so25130544iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OCJUq5jHgfkgVNsby7KQbTGRdgGOLVS/mZVDvuvbVQM=;
        b=XDtRUAzCdycPSIlpf0grik4f8dPgS2/nusSo3wILEaRv793kD9AXzo4pKaWOqWar/f
         uxh7UJmUzs4kR724KcwWUgC0Y+wcTV9abtTgnE3RxAl/iMre3I89ECkvpFucq7R65eRi
         oUrt6KoJedPddvKQOmpMOTFPz6TYCTmsgInrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCJUq5jHgfkgVNsby7KQbTGRdgGOLVS/mZVDvuvbVQM=;
        b=wcQa6BVQ97/f+84rH3XkPFQnBOzQ6GcZblTPEaGG3gY5PTGXZfh2XtgJhw0CTjj3Im
         LJXWS+YdxLoYVqVkKXVOARCmf0tio+GzxZq0KXyxCd1K/CUglWxYlHtGk9XB5iLyNiKh
         a8kpU1e+kIj9nNaKnglRX4fOzD4IlZdsA44/lDS22HWXpNe2X8GlbUNIBK+gzp3iIeP0
         q+X2vyEnQKZNVYa6el+toCBznGh9YKKve8kkoVST1GX4lz6eg2C3Izd/3r6rqWHmzdVY
         cyNm2Tgo3TBvOYFzadsu6v4tfEYDDsNfBNUr/cCiQObERwQ4w9LLEju7guJeDRaKlgdo
         uYVg==
X-Gm-Message-State: AOAM530fpV7iMM3LZY3v8O6ptivqbaeoKbbtI5OpPywFxXCeDs/r9fX9
        tZ62ICS0xauRkt6GPnZNLKaiMA==
X-Google-Smtp-Source: ABdhPJyjdSeD5XUu2Mr1BnYKELR7qedOQe1LHbs1/7dxduM5uthKYktGexZ5EoGuH31VcQ5SL4t/JA==
X-Received: by 2002:a05:6638:3009:: with SMTP id r9mr10016866jak.262.1643143926581;
        Tue, 25 Jan 2022 12:52:06 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id q16sm8238668ion.27.2022.01.25.12.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:52:06 -0800 (PST)
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Petr Vorel <pvorel@suse.cz>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <61DFC646.7060707@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2055a76c-f50a-467f-e1ae-e8b8496a4911@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:52:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <61DFC646.7060707@fujitsu.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 11:26 PM, xuyang2018.jy@fujitsu.com wrote:
> Hi Ping
> 
> Best Regards
> Yang Xu
>> Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram has
>> switched to per-cpu streams. Even kernel still keep this interface for some reasons, but
>> writing to max_comp_stream doesn't take any effect. So remove it.
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>

Reviewed and changes requested.

thanks,
-- Shuah
