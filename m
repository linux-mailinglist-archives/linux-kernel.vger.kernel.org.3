Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15CC4F6C12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiDFVFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiDFVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:04:38 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BA2EF140
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:38:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z6so4327232iot.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vGHNAGNQJ+jili+nDe/Ec5j5ASwqbtr085CgGssJUDU=;
        b=I0xeLq/G4IGv2sgI720zwJl21NVzHNM0zXEmIIoNpVWVvAuiDk++aM58zqwTTspPp/
         nx+uQRw6RU+ZMJaEglvXfzu7kMuQEurl1j67Rb2Q1T5MyE0s5r15Zt6XyN672AWgpnCb
         MwNjLn8PPJY1qY9bP3MJ56sF3OPkym0v8KiGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vGHNAGNQJ+jili+nDe/Ec5j5ASwqbtr085CgGssJUDU=;
        b=mgbOpLIe3tqYsl4X9lDdRWQqYIO5ddk7Yxjpy5jO6X8k5Rq0hgp/97Cr6j2N/Qi0rD
         Orugw4G+8AUIOGLHcBxNWecX6UNfP60rLJpWENhqmcLKtW950t3S3XP+8XBIjyV322sm
         nBv5N0CyZEhY0SZjA3I/1zYxgmTiVLNbxBN7UVaAos7SewcELv6X49S+bcGq+AIGbTHU
         4urf+Nn4zMgg6OEXQHRYqSQTf2RTpY5gGtUW2e2egBYjSWXID7jYTDYk3wIkH677f+GA
         KmvEhhPIRQUFtpbPylP94f3haLuxENCQ8FQmVK/MenpCuGI97/jypi9u0qgyZp1CMJg0
         5Ryg==
X-Gm-Message-State: AOAM533bx7k1rl4RAXZWtA8TvsdK9EQRj64z0MuJJ4wnmqOVxDnwzGir
        sEFKH/c+ktp+nuyfkA9ispRQGQ==
X-Google-Smtp-Source: ABdhPJysv2MloHTozqtk5nZiHOCb1+hWcKHSHjfhz5NKnhYsEEK3VKL1DiiZ7tK4C6bXa/5onGGRfA==
X-Received: by 2002:a5d:83d2:0:b0:64c:fbd3:e792 with SMTP id u18-20020a5d83d2000000b0064cfbd3e792mr4841279ior.59.1649273914715;
        Wed, 06 Apr 2022 12:38:34 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k3-20020a0566022a4300b0064ca623b65esm11875297iov.4.2022.04.06.12.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:38:34 -0700 (PDT)
Subject: Re: [PATCH v2] selftest/vm clarify error statement in gup_test
To:     Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220405214809.3351223-1-sidhartha.kumar@oracle.com>
 <YkzDoBUAhydtvnR0@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bc04ce83-eed8-f35e-9816-bdd9d0ac1470@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 13:38:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YkzDoBUAhydtvnR0@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 4:33 PM, Matthew Wilcox wrote:
> On Tue, Apr 05, 2022 at 09:48:09PM +0000, Sidhartha Kumar wrote:
>> -		perror("open");
>> -		exit(1);
>> +		switch (errno) {
>> +		case EACCES:
>> +			if (getuid())
>> +				printf("Please run this test as root\n");
> 
> Shouldn't all these be fprintf(stderr, ...); ?
> 
> 

printf() is consistent with the other messages in this file. Either
works.

thanks,
-- Shuah
