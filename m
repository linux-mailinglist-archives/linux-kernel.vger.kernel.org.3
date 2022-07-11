Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D557082B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiGKQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiGKQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:18:10 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55B7AC20;
        Mon, 11 Jul 2022 09:18:09 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so8831795pjm.2;
        Mon, 11 Jul 2022 09:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vlCWnpuHBiBhE7oDhpYPIvbDLmOAPgNxuESwMXrAYiU=;
        b=eqSvVOAIxucBDLsFDxmeW/qXuUk44seYQ6I3IY4SK68SN9Iad3tDh+rEKl0wqoRWcX
         Mfq3filoGWHgMyeH/MnUIM26MsTzEbPaJDpKoTBhsKYR1M18hUkitsGZ9knW6go4CELl
         KeC2VNNAKfmQHNu/rHRNIQWuAW9mhNUvnBqWExD/C+wz8Ec3KIpOynWszIcBpAB+OF/D
         OFHBxS3BVcQlkggDLl2uldNbKRBwIob5O+M8Fi2I11PgRqTSt1mklYjuemqJVzm4aUI/
         KpvLVvLNXceJh2Mkcyk+ch9pDjJdIMmQBVloXr7DtTzMtt/3ERhioqis4zTRBbuS3hKu
         yVFg==
X-Gm-Message-State: AJIora8/FWNGKUVc5g5greKqugKami4KauNRtxr5v9NsX4PDee7pcsw2
        XzJwKH428oi9AevuuT0Vh73zCr6vyek=
X-Google-Smtp-Source: AGRyM1tLWkkZqwtTqS/hVhuJzABmpZbeOei2hzW3KRFV8Fvzeep3j8QAn/1PgXUbTXlvSgsDCVpQ2w==
X-Received: by 2002:a17:903:228c:b0:16c:2f61:9158 with SMTP id b12-20020a170903228c00b0016c2f619158mr14413129plh.140.1657556289325;
        Mon, 11 Jul 2022 09:18:09 -0700 (PDT)
Received: from [192.168.50.14] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a348100b001ef7bcb7e61sm7160094pjb.47.2022.07.11.09.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:18:08 -0700 (PDT)
Message-ID: <4c63d554-80fb-99bc-68aa-245bdbe4e1a0@acm.org>
Date:   Mon, 11 Jul 2022 09:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
Content-Language: en-US
To:     Ren Zhijie <renzhijie2@huawei.com>, stanley.chu@mediatek.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220704025632.235968-1-renzhijie2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220704025632.235968-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/22 19:56, Ren Zhijie wrote:
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
