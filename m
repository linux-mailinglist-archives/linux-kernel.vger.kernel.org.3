Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8F852D239
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiESMOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbiESMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:14:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23CD7A833
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:14:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 10so1186197plj.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=;
        b=p27yU6tdtyX4ZiycgPNJ1iNvzRs1b87/Voz0GLihHtppsn0VQ3J005iotBD+d8vcfc
         pSl70SwV2zgj2wW1XGGR3wzVPV7Ted5GdEV4zVKBunzNd7u8sjyc1eF/FWWXPgUxIwIf
         rp0p9c8opyZr+BSNShaf8iK1fu1Cbe4GNVcGr4uk4VJx3YUoRhpv0RT1/T/lPz5S7v4J
         A75Bhgl5CyQT7JAgoVP2i1Z78/9hWaX9YUb5WeKxD0xv9+85PAj0cNWCP3s0G31qjmJ6
         8diBYNnWVIkLmLoJXFzKa8Ez8S2M3Cog4RKVqWXlcK5ghGu7VAX+O5HJqzjgeyXisdvo
         GKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=;
        b=lld8zeO7KvcLjImpcdYjdatntC8gXV0gP7D+RG08sNyNZeOgimopWCMYTWJ3LUe9Jd
         cSTcT4LQVM8lFHr7WtvZzO/6kRMhG6MKkzvPg4ZKWytT0THdtwQwOVOPyQrNaeDfKZKs
         QhXpyVPqTK9wnIS1xfRORUGqn9yjwhaBE2ktohYis/jLwykVNZ/rzv6xN4v2Z4WlX8Yx
         qQ9JN0As/7+6i+vgAxn3Op/GBo22FsIYZOFkp7/WzeJSgvjUXBNq+v08nDspiyHhsMQ2
         /LkNTJhnp/P549eHd/0zg9PNtWbOp0Mb5rd4HfWxE5q8KqSzCVwRdPHSQrtGCG1N0pJB
         f5+g==
X-Gm-Message-State: AOAM530hXGuRoKDwBsW54FTNoCxwOA6Ct9dlCvcesrp/YD4ZbX7QDJ53
        GOk0maOPaW2suWdrzb3p6V07UZFZvBVnzA==
X-Google-Smtp-Source: ABdhPJw2DRKb0mxn4KqbWP/jQzIrlt0CfwCkmk5n6p40P9UnKG1Hxulsj0NJK/Dq6iFqITKjk7qNMQ==
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id m2-20020a17090ade0200b001df3f94811cmr5442544pjv.112.1652962460260;
        Thu, 19 May 2022 05:14:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v10-20020a62a50a000000b00518285976cdsm3671518pfm.9.2022.05.19.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:14:19 -0700 (PDT)
Message-ID: <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
Date:   Thu, 19 May 2022 06:14:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
> Greetings,
> 
> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> 
> Console Logs :
> 
> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
> make -j 17 -s && make modules && make modules_install && make install
> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
> make: *** [Makefile:1914: modules] Error 2
> make: *** Waiting for unfinished jobs....

Christoph, can you fix this up?

-- 
Jens Axboe

