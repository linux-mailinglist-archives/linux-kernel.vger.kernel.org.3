Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6F576E89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGPO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:26:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA761EAE9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:26:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso8616846pjj.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vAhxXzlwc0d/w/M6f1DCLNnaAhsawHdFInLCFqusdAU=;
        b=3YeUX20hZeUltQxwI4xQg05CZQgo5wK6MGeswzNMDOfobg4pkVheVPngI4hX40CiyE
         LcUvaIc2M2uxFVTDdujB3rHj0BTId5OeL1ilDk6PjnPNwVQCNMfklL+DdIePb6hcDhxN
         nZaRzNH3i2ljUhJGYags7olKOjwxgK3xQQ+ePhEoPeA2+9athQmABg3OZFoWfYWUNwQY
         i9bO4dq0GNfy4TgJIgDtNIZGO744bwcU7H93Hm19vjMQGqHbG03scgj3s6FCpBu3SEyc
         1JLhSVa96z43uMFlQsOMTRHGF3P+gK/LjDsRfGbyc43qxFlfTeG//ItqCTE1/Bm6i60n
         Hv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vAhxXzlwc0d/w/M6f1DCLNnaAhsawHdFInLCFqusdAU=;
        b=5v0k4OLSW5UGMSqNmTt1GfifnPxRbXtFxG/OuwiLCYb2qeF0++XJ68VloXUZvA81rv
         dT8tphzhUbkHv1nLTYrFJGhwVaqEK0nLTKXEaDqwTEVsz8ffPgu0AXfqnZpaCTehJXz4
         orRKDM7DMkGPesIMQHqxLje00AmYTm5AgXksffME2yMvydzc8am3z1UMjYV6QLfDK23Z
         DbqZEOAfPv3n1wRs7eOFtNVTh3cE0H3WECFj2by7ZAkHYucXPKzmwccvjjbbaES2jjxt
         2hvzZu+/vHT0gdrPJiX5sspCxCrYbgx5pN22Sav0FvTxdhG3NcvfRtf8GqRqZ39GbENQ
         XdDg==
X-Gm-Message-State: AJIora/T6/XAoJ5ZoAc9O2O+0kGI2aDc5ZZH3M+LC+I+ZXK8ayEjMGue
        syzOv1e+HsBm9W5044d4womzTg==
X-Google-Smtp-Source: AGRyM1uDqyFLDoYwDAAmT5wVcDPFuPmb2tl9y8zTliTryA3LepSzTMsdbZLnQY5ugSET0TqRQC1DUg==
X-Received: by 2002:a17:90a:c906:b0:1f0:47ed:59bd with SMTP id v6-20020a17090ac90600b001f047ed59bdmr28269640pjt.40.1657981588100;
        Sat, 16 Jul 2022 07:26:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a394500b001f1694dafb1sm1928423pjf.44.2022.07.16.07.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 07:26:27 -0700 (PDT)
Message-ID: <f7f30927-9f36-ec92-cfdc-cb216115a39f@kernel.dk>
Date:   Sat, 16 Jul 2022 08:26:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [net] 65a1e5c409: canonical_address#:#[##]
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Dylan Yudaken <dylany@fb.com>
Cc:     0day robot <lkp@intel.com>, Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        lkp@lists.01.org, Pavel Begunkov <asml.silence@gmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        io-uring@vger.kernel.org, Kernel-team@fb.com
References: <YtLGmrJEJy2pnLaO@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtLGmrJEJy2pnLaO@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/22 8:09 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 65a1e5c409f2b56b025f913b9cfbc8ae3a717c9a ("[PATCH v3 for-next 2/3] net: copy from user before calling __get_compat_msghdr")
> url: https://github.com/intel-lab-lkp/linux/commits/Dylan-Yudaken/io_uring-multishot-recvmsg/20220714-190504
> patch link: https://lore.kernel.org/io-uring/20220714110258.1336200-3-dylany@fb.com
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

This is the same as the issue reported by Marek, should be fixed by:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/io_uring&id=e544477ca928416bf3897b8461672752eb6581fe

-- 
Jens Axboe

