Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA16515E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382901AbiD3PBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiD3PBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:01:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E0546BD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:58:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so9407404pjt.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QjWgryp+Uq4wMZ8bK3bQuLAdw1FnUL2BZ0+56NKx/tk=;
        b=dupnZ9aaLD1KoTinG3RLm+LkaHIN8bjLEhyg2UdHQbbHV1ISY54gUyLiWVCmXJ712x
         UcBLQEVRO0UxBFrlDnr8NLaJaWS0kScisspNHLdqzs1nNNjG1oUUOVKCv8E+T7Y2vlL8
         2hMwhduFE0yMm1WmB4i7YqPf5V4MNb3fFIci/7v55f27potNdX1w6IbP6skYHbr3ILZW
         vhDpYsNruAOTiLQ8xEEi5fsDIlXux2MLah2FSBGZN8Uv5Mj9GcvSTdkLuhbcEyutIGn9
         ONkC6u6wXGaBfmUqp4bc+g21/h57rklexyQECSb2ViYQuNqDTz6k32P4qKE35L0W0p6d
         9ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QjWgryp+Uq4wMZ8bK3bQuLAdw1FnUL2BZ0+56NKx/tk=;
        b=2AM5QvF1Spa8UZzMuUeI03HHQ4LBgEW2ErXffslnE4sIcEiLY4M11hqtaoGpDPcPe6
         QZeRcbm7lf8+tscnVjP6QdEDHwqZqRcryrSAaSs5vPfVPBEsc9y7E5D7sSIKpFm3kn41
         YUI59vs2zuwd2di54URtrDc6BJ6vxkqjpwTe18nhdRxpZOtBl2CPHwXTRWz1Xyf5nOTx
         qB1zK+bkzRuLpFMJ9BTcHBE6gfj4yVaRhf7eqDG86rsAOxhCxQCVmocPPTrEX5dteV/o
         YixykAoHmuPp7r8cQhGhV/Cs4mURnv8P5LI/8tBy03vwbtvWFkOTTbJB6fD22ykRvVBa
         3blg==
X-Gm-Message-State: AOAM531oGcMbPRi4B9NrvTWlwQ0K3hqaIJ9S9W5Qu3qJVHjvTaCFQ1zz
        zZFhck2S2GwPVxncEzaXFbl6FC3BdgjQ44hN
X-Google-Smtp-Source: ABdhPJxudQ5GgL3okMdFRE+OV6hiq+JT7EmiSFGjhH4nbx+CKqQq0aWaqgqbTNZxVgNvcQVTRN2Okw==
X-Received: by 2002:a17:90a:cf89:b0:1d7:7055:f49c with SMTP id i9-20020a17090acf8900b001d77055f49cmr4585714pju.12.1651330702628;
        Sat, 30 Apr 2022 07:58:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b0015e8d4eb1f7sm1589867plq.65.2022.04.30.07.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:58:22 -0700 (PDT)
Message-ID: <f8de18da-e6ae-e82c-c6eb-6f4de6ce8e98@kernel.dk>
Date:   Sat, 30 Apr 2022 08:58:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [net] 02dcea6024: INFO:task_blocked_for_more_than#seconds
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>
References: <20220430144902.GB27004@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220430144902.GB27004@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/22 8:49 AM, kernel test robot wrote:
> 
> (please be noted we reported
> "[net]  02dcea6024:  netperf.Throughput_tps -9.1% regression"
> on https://lore.kernel.org/all/20220429062049.GA8992@xsang-OptiPlex-9020/
> yesterday, but now we found a func issue on fsmark tests.
> FYI)

Please just stop testing that branch, it's been abandoned.

-- 
Jens Axboe

