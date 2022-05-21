Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2525C52FF7D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbiEUUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245130AbiEUUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:46:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AC63CA77
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:46:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z11so931677pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jwrHtlvoewbRftN79d2AI6EqYNBZAOLiqwA2wLK3D6Q=;
        b=yo8vdBEEiaXPv5TVCm0uGTi08S+UDkH4S3uyX9hcU/H+SJpdwMgG9PHXxNMH935f8p
         i6WWIGk0SNGhSfs9+xDFfvLPpCyMsN7BJOMKx+NydgVIrFWYPAl/cJq8TvoHYVSyenAV
         3Sr5r9+2K9vLEva0N0rYD3b6SRPvMnmnYdvR6giHbX0V9JkXCEks1Tk992WQb3kHQuhq
         SHWeBGgkpxSuwi+4l6G2aU8i7VPrsS+kAkZerHVF2EIB3wqnUPvxvoA2Hhp4wW+C+Jhq
         WnJdklRqz1jR3uWC3DnY9EVCjhSdTtn3iMvzaTwu3cHwa7Ynpk2dzzILWv1JaPqHLeWv
         /MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jwrHtlvoewbRftN79d2AI6EqYNBZAOLiqwA2wLK3D6Q=;
        b=6ePFGvBguSgGWwCfkcdCfGZFUKcsAapHyVT2AcJ/QXb7Hp2A/SYyE221UI4DpEoQPz
         4LLObgAiFi0tHLcup0a8cNXBMhsgEySs7h30ASW6Frbj0lLQ+zJdlwNlTZRkvg3UMsaX
         GtOXvQNRSnuVi1tAY/IbiGtL9ADYZGqL/0SCT0OhExPCNxBgajRIrif+zdO/Kj4GmMVG
         6mmfQ9n7QAE1HOcTbLrqAXdjaIn6mtBCgyxhhQM+xYm6wQrieQR8KS9YI4F9PIQli+/o
         8ZYTkVq8b9nLp8z/K/2kh9331k5u3hfU77NqNbZixCBkZZ77iuW+a/udyflTaBqWRltF
         S+jw==
X-Gm-Message-State: AOAM5339miQ5ZqaaefNZwKdKJu1hKv0Gdoo8ERUDYRFTTrxttqldA4EU
        Ij3T3bsQgq9Lx58cAfXePl1nXQ==
X-Google-Smtp-Source: ABdhPJyRUhZLqKij6roy84fqUWFg5odT9HuZcCTJ9XBMKxnsSy3XKYFHF6vGp9GIlcchCijVMYJctg==
X-Received: by 2002:a17:90b:4ac9:b0:1df:af66:1f3 with SMTP id mh9-20020a17090b4ac900b001dfaf6601f3mr18398951pjb.106.1653166001503;
        Sat, 21 May 2022 13:46:41 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id t13-20020a63b24d000000b003fa321e9463sm9039pgo.58.2022.05.21.13.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:46:41 -0700 (PDT)
Date:   Sat, 21 May 2022 13:46:41 -0700 (PDT)
X-Google-Original-Date: Sat, 21 May 2022 11:33:11 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Add CONFIG_{NON,}PORTABLE
In-Reply-To: <YlgX5Jy1pjPPI+/u@x1-carbon>
CC:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Niklas.Cassel@wdc.com
Message-ID: <mhng-0cc9ae4c-55ee-425b-9e83-41d3f3d4ad5f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 05:47:33 PDT (-0700), Niklas.Cassel@wdc.com wrote:
> On Wed, Apr 13, 2022 at 06:40:10PM -0700, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> The RISC-V port has collected a handful of options that are
>> fundamentally non-portable.  To prevent users from shooting themselves
>> in the foot, hide them all behind a config entry that explicitly calls
>> out that non-portable binaries may be produced.
>> 
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> ---
>> 
>> Changes since v1:
>> 
>> * Fix a bunch of spelling mistakes.
>> * Move NONPORTABLE under the "Platform type" sub-heading.
>> * Fix the rv32i dependency.
>> ---
>>  arch/riscv/Kconfig | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 5adcbd9b5e88..3d8eb44eb889 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -213,6 +213,21 @@ source "arch/riscv/Kconfig.erratas"
>>  
>>  menu "Platform type"
>>  
>> +config NONPORTABLE
>> +	bool "Allow configurations that result in non-portable kernels"
>> +	help
>> +	  RISC-V kernel binaries are compatible between all known systems
>> +	  whenever possible, but there are some use cases that can only be
>> +	  satisfied by configurations that result in kernel binaries that are
>> +	  not portable between systems.
>> +
>> +	  Selecting N does not guarantee kernels will be portable to all knows
>
> nit: s/knows/known ?

Thanks.  Turns out I've got a bit of an issue here and this results in the
defconfigs breaking, so I've got ahead and sent a v3 that includes the
necessary bits to make those work along with this fixed up.

> Kind regards,
> Niklas
