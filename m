Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC5522824
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiEKAGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbiEKAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:06:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DD39692
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:06:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v11so530321pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QoRYyZFYqOCYeEPoaKoS4IMRtm0mxY9WhxzlW1K9FLc=;
        b=VkYVMjzV+TPFdj749OMz9tAsMC9F7OhhKUI0/CMtRoMYSVPKVul3/+ISEV21Mt5BCC
         pwC+DUHIKQ27hcE7kQQpzRU+wGjn4TURxgbNXhRNzncYnXPesuBtmAKnpeCv0fGPTxS7
         lAtWhW4FzNw86082+A8zazgWG+eB6EW5FMlhXFzbBqwntYtE8uSpHqCu4FJV4ykEJzDx
         iQid2t3QiuflehZ084uHNE9gelqudoj59Et/hWywVm2B9IPCd6Pxp2RhvhtA5AKUAyjB
         ycqjppbk9los2XHgpwkhET4QfUR4Qg3w/Em6LJ/msZWqjJnAJxD3xuXWa74VjjDhqrGE
         42bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QoRYyZFYqOCYeEPoaKoS4IMRtm0mxY9WhxzlW1K9FLc=;
        b=cLlc76jtzQMAg4u1C0jfj2mJXEwjhaRPJKOKhHFFdNcO2URHPvm6JSdUceqAayIEBl
         WV5FKmSHPokKvpBAmcpzwuHW8ZCT1xiyM0BdpRJEqzfT7JH40hje6Pt94JCSRFvra03g
         LzGKluGX/pip971N+bDgWE6BYEgWwhR8+uGXcshH9Ar1G/brxg7P7Tn73p5nSs6W0fiA
         aEUYO2e1GJusLcDBvDVbuVvQVZbPhP0TLw+Q6H9tFu7V34LqFlIYobqswsKH3knk/2aG
         U878fnNLJkQSOytqD5R5/ggCaF3L0BItpbC+vetNapFfv99nNgtdCEzv3Th7zkCPDqTK
         vLGQ==
X-Gm-Message-State: AOAM5301XaDaG97JLja3Nzn84dVYrkESUPySPOCx9sXpqwMl6ctole2e
        Wyju8JNiJJUHX/nF87OlFqUr8Q==
X-Google-Smtp-Source: ABdhPJymSIxMmHAzXsVLUOe9z+7vsY1KbCrEE3tZ9MEhiemiYYcHvtEYR6p0zSkPWjjgpUUtD3e4ag==
X-Received: by 2002:a65:6451:0:b0:3c1:cb83:8e4 with SMTP id s17-20020a656451000000b003c1cb8308e4mr18668161pgv.339.1652227566423;
        Tue, 10 May 2022 17:06:06 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b0050dc76281e8sm116517pfm.194.2022.05.10.17.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 17:06:05 -0700 (PDT)
Message-ID: <21bb1776-6ee9-c32d-0049-cd52b14fd133@bytedance.com>
Date:   Wed, 11 May 2022 08:02:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] nvme: enable smart AEN
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     axboe@fb.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
        hch@lst.de, linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
 <3c233d71-af16-d230-c207-b9c2ae38afbb@grimberg.me>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <3c233d71-af16-d230-c207-b9c2ae38afbb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/22 03:13, Sagi Grimberg wrote:
> 
>> Hi,
>>
>> There are several changes in this series:
>> - Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
>> - Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
>> - Enable smart AEN.
> 
> Is there another side to this patchset? meaning some userland agent
> that listens to these events and does something with these?

I tried to test SMART AEN end to end by QEMU NVMe emulation. I did not 
realize that the SMART AEN CFG is not optional.

Also sent this to QEMU(Klaus corrected me):
https://patchwork.kernel.org/project/qemu-devel/cover/20220507072644.263105-1-pizhenwei@bytedance.com/

-- 
zhenwei pi
