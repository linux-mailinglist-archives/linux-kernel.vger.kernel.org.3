Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE128598442
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244935AbiHRNi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbiHRNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:38:27 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992D927CDB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:38:24 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 10so1095871iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=8JryTZJNmVWftlwTMNbthawYc3h5N+iWyPdLImn/rhU=;
        b=ANqNZEUHI7+wP4NYhu071IcgKY/pbUo0Jc7YUGZDe5EjyYYFFTq19ZfItZNiOi9yHT
         qYWwsIg6ApohVdq8GbdRMeaejcgBpmPhbt/w45CsEK+VfDz1cRHvFQRGKqmRGsVuRFAE
         l/EnFWvqHHV/kQ3w9mdlbOBIml+B4NYIXwMQOSdffkdKSdbbWkS63wtPcP7plpOk3T/T
         gxiiRmhSd5VyoEFkG8gL7BQWRurl41qAEuHOhE8ttv11oPJGXBPiWap7k0TX1FoBhTq5
         Z7+uqHY1Pc8BTVJWlLR/ygv29g9WsJYm29GaAJgpuWoNS8kidRgCTCHza/dC/GNXYUd5
         KTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8JryTZJNmVWftlwTMNbthawYc3h5N+iWyPdLImn/rhU=;
        b=Z/rPUiKcpZHP3KJHIDxx09Sj/+dEJVczZS3v+ev7CqGdRPjS62nwNmA2FmGpuFIgVp
         R8qMD585XfGsjidMhhQXOwAO17vUdnShjDQtfT06tmMwklMagh9uAH5w1SvjEw92F1Uv
         eqZjuWk9Z6+tABYTvbzM2ScaS9cjJ0Jls/eApAVLHeoy3OUPojXven2UantWL9aaE/El
         fxzo79ZzXbRO7VeS8blS51UTUg9qnOtZ/TVtbr8f676G975ffKQUmSFyi2Lwf8HWs/di
         ck4XB4NXHNY+qp+XwShg8i+PeYncKOoZgwJDxvG709gSs6NHcPqwclemZMhXFoZz/G5/
         BPtg==
X-Gm-Message-State: ACgBeo0PFnPlc2WWDQRg6VV5ILiTeu/AElNrI0G61VMCJCuKmdSWGkVO
        I5fbtxaaXyOnyvXihJ1x+QljoK/Y3DivFg==
X-Google-Smtp-Source: AA6agR5GO6dK3qh5UFIJI0QSIsZKPHlzjRYAMGhwn/k21OENaC9qZYx7DI7DYUIuf04jS3IvLjKoGw==
X-Received: by 2002:a05:6638:2708:b0:346:8b3d:c18e with SMTP id m8-20020a056638270800b003468b3dc18emr1448630jav.272.1660829903737;
        Thu, 18 Aug 2022 06:38:23 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b16-20020a05663801b000b0034602e741f0sm629071jaq.67.2022.08.18.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:38:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai1@huaweicloud.com
Cc:     yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, linux-block@vger.kernel.org
In-Reply-To: <20220818063555.3741222-1-yukuai1@huaweicloud.com>
References: <20220818063555.3741222-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] blk-mq: remove unused function blk_mq_queue_stopped()
Message-Id: <166082990303.8966.13019066479952675350.b4-ty@kernel.dk>
Date:   Thu, 18 Aug 2022 07:38:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 14:35:55 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> blk_mq_queue_stopped() doesn't have any caller, which was found by
> code coverage test, thus remove it.
> 
> 

Applied, thanks!

[1/1] blk-mq: remove unused function blk_mq_queue_stopped()
      commit: a8239f0342bae5a51acca967ba95b9a8ad56dd62

Best regards,
-- 
Jens Axboe


