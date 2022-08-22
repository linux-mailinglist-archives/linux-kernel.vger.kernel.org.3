Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F059C3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiHVQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiHVQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:06:15 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5652ED4C;
        Mon, 22 Aug 2022 09:06:14 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so11818226pjl.0;
        Mon, 22 Aug 2022 09:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A1lAI+RysD9M2zZlMWCFJOu0yk3MiDlnKNAKjdWT4/4=;
        b=z7VQcv/UEoBmFishnYrC/kHLzNdN/FBHvZ2i9HP/NhzdxV9rJ3ttSz7f0LIC84DArW
         7jGiy8w5/MAUPubTr30e5rv/lCj/X9kNmKPK5Mb5kn5UiJFCto4sfpyu4MhpAL7gXh64
         tyO9dEeWxDmY1DxGaXHLIqe399ye2iN4x5F90CvTX6cMgNUVhBA4libnV352pXeATvcw
         j+X7EF0L2W0ChMnSDalWs9h/pRQkLvTbJsEdVKj2AjR28aIhyQ3bTtSpL9f6g6PfM3oo
         sFeoDWsKiQaMQEsVRB2QevDdPeBlIS8nZzl2hrYgXZyoaW+2YD8otClaXLsv8Mc57Opz
         Vl3w==
X-Gm-Message-State: ACgBeo12PpUtjEq3c0iOx45PKw1JNIV4iEMGJALmRgY4N5nI93xIj9XA
        7P/hBIFfpq6EPC8J9u+UvM6OGT3Wyls=
X-Google-Smtp-Source: AA6agR613ZfPjUp9dXPEQAopwB5EREFuHQSD4atXkG57WKcBXRiGpZciDRnH7bx13zFFxlGC6FeVIA==
X-Received: by 2002:a17:90a:64c1:b0:1fa:d891:adc0 with SMTP id i1-20020a17090a64c100b001fad891adc0mr21896638pjm.147.1661184374056;
        Mon, 22 Aug 2022 09:06:14 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001641b2d61d4sm8654704pla.30.2022.08.22.09.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:06:13 -0700 (PDT)
Message-ID: <5b659baa-8451-b4a1-2ad4-0423faac4642@acm.org>
Date:   Mon, 22 Aug 2022 09:06:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220822144613.6e6ce950@canb.auug.org.au>
 <911717ae-3955-08dd-ad53-a6488ef8127b@kernel.dk>
 <3848cd00-b4e8-17f6-32d6-011170f293da@acm.org>
 <4a9d2d6f-2b07-7331-6507-e19cd8e4f2ff@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4a9d2d6f-2b07-7331-6507-e19cd8e4f2ff@kernel.dk>
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

On 8/22/22 08:40, Jens Axboe wrote:
> Done - please check the end result, both yours and Stephen's had to be
> manually applied.

Hi Jens,

There is a difference between the qlogicpti source code in your tree and in
the master branch. Is this change intentional?

Thanks,

Bart.

$ PAGER= git diff origin/master..axboe-block/for-next drivers/scsi/qlogicpti*
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 57f2f4135a06..87b60bf9ad3b 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1339,7 +1339,7 @@ static int qpti_sbus_probe(struct platform_device *op)
         /* Clear out scsi_cmnd array. */
         memset(qpti->cmd_slots, 0, sizeof(qpti->cmd_slots));

-       if (qpti_map_queues(qpti) < 0)
+       if (qpti_map_queues(qpti))
                 goto fail_free_irq;

         /* Load the firmware. */

