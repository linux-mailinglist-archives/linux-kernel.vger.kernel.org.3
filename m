Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E94F0544
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 19:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiDBRqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiDBRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:46:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC77642A37
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 10:44:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n9so303431plc.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8s/BHQnenI/dQuo9Bx4DjxsKw1aS1YEGBIC6gaAHQig=;
        b=2YbxB5bh+ymmDvqyygbpui3ePOClpWpHpAhDgaVZ4b+x21ZIRXxNXizYRabmSFdHdw
         rsMeU9MGdjqzJKUM7oq7ES6fyl5l1iS2JX9UkDuY5nfUxnjqAqKMHUw/ZHqCzA3Duhyx
         c5deLeG8d6ToSZ5naiKzigUqUhyYhq2w7eS0nBqGjxyaktHEJuXcsZ4mwQfRZaF7mhZ0
         2nLU7awvlzzUy5dNMFwfr9wACNhcpmSKQpVEkrywMIyy6QuKAh7Cq4YzyPtX4mivyjXz
         F7JIH74PZR7kbJwN3f1xfd3SHNr5uPsDT2aF8dwVorczqOFzHQraAS/YjoPM/UM4h8vb
         OZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8s/BHQnenI/dQuo9Bx4DjxsKw1aS1YEGBIC6gaAHQig=;
        b=0ktr/4BdOH280M6X0//WX8HRDcRSQ2H5TAbNivSD9wdBFoHQq2JTOOxg+wPKVKGokB
         KIoq+VRZLPkqhRLP73vYwU+9arr7thjkNAjSazldBlEBsonVS2PudR4hkTZkJU9wvE52
         Tz9KCUzDup3/9tA3gNyvYY/kG34VmOjtKrGIz+iyX59YS8YjXUf6SrvRZba8LzXgGptA
         1/5L3H8Ayn8JKiWDkwZvh7s8UjpUbDu7b03VovtYZOAtnO8At+Bp0tzWQNgcSrh1O27j
         RX3/beFWniDEV+bWAvxf+9zbz322oxd32F0UDnHfOg91j2qLFnA1xD9i56FUdRRsis6Q
         fQoQ==
X-Gm-Message-State: AOAM531lRmdBjkxwOcuhPCZhtu4nydw3zxR03B+nhE6GmtvlsSatSAir
        iTcRrMglqUjCLPE8s4CYWzRlUg==
X-Google-Smtp-Source: ABdhPJy7B1CwAYnjdOE/0354VIXtcxQQyASRB+QgG3NJzVmtQMei/fO7JcyT4M7r8rC1Jddu+8CZ/w==
X-Received: by 2002:a17:902:d64e:b0:154:bc8f:b6c5 with SMTP id y14-20020a170902d64e00b00154bc8fb6c5mr15908197plh.157.1648921457201;
        Sat, 02 Apr 2022 10:44:17 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b004fafdb88076sm6943869pfl.117.2022.04.02.10.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 10:44:16 -0700 (PDT)
Message-ID: <9b61c3b4-ee68-856d-65ad-0e95e4d12f11@kernel.dk>
Date:   Sat, 2 Apr 2022 11:44:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: nbd, sysfs: cannot create duplicate filename '/dev/block/43:0'
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        lkml <linux-kernel@vger.kernel.org>
References: <YkiJTnFOt9bTv6A2@zn.tnic>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkiJTnFOt9bTv6A2@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 11:35 AM, Borislav Petkov wrote:
> Hi,
> 
> so I enabled CONFIG_BLK_DEV_NBD=y on a test box here and I'm getting the
> below.
> 
> Kernel is Linus' branch from today + a couple of unrelated arch/x86/ patches.
> 
> .config is attached.
> 
> Thx.
> 
> ...
> [    4.501239] sysfs: cannot create duplicate filename '/dev/block/43:0'

This is the second report on this this morning. I'm going to revert it
for 5.18-rc1. Thanks for your report!

-- 
Jens Axboe

