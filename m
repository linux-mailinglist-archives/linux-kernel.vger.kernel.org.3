Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2359C2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiHVPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiHVPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:34:40 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8FD193D8;
        Mon, 22 Aug 2022 08:34:39 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso6050883pjb.0;
        Mon, 22 Aug 2022 08:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WvGCX5RcgGpvmpad8RF+/lCyvenp0spczq3lhcwfI2s=;
        b=M9PKeJYdZNlJB3ab/U7dw4DDzyE8Mq3Xr7Uq4cWX7k8fiZ7roAKpN4k3G3WVwmCDF9
         lOM+NZ48rVtojCi3BTNtMGuMxbuxtjM05qlVDtM/C4RsMOhT95jryXFDRD2xbNs7TSeN
         AJ+b3jXCxRj2cY5FliC7ieX4Zi4syRquLwcFMYyTnIxQaMBkZSq7vTVW5iTOemoPVcgI
         Xz5g1hoVllX58DqTEFgmBCx/I1xm7SlijxOJAZOgsCOdt9rtlN1XprBeSWsIwiWvwQEk
         EXS1TBULCo+yTQURr7i5Q12L04K4lxEeyRUVXDjKWXa5JBgxTAxF0dy1x2VonwewgcEA
         E00g==
X-Gm-Message-State: ACgBeo1b/ddd8AW0LmkvCdtkO/OVkEstDWdLTrlcF/CAFpocUYYYM4a9
        6jnteWgu7xuRRYWhmLpxpwF3Z1RZlp4=
X-Google-Smtp-Source: AA6agR5KQgniXwJQr00kJ7wmtahMVVrn5DoX89VVD0EbgC39h1dVuYvydgEh2kyKVcZEpusPWH2Leg==
X-Received: by 2002:a17:90a:4d8d:b0:1fa:9cc6:3408 with SMTP id m13-20020a17090a4d8d00b001fa9cc63408mr22869816pjh.245.1661182478686;
        Mon, 22 Aug 2022 08:34:38 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i68-20020a628747000000b0053659f296a0sm4640685pfe.8.2022.08.22.08.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 08:34:37 -0700 (PDT)
Message-ID: <3848cd00-b4e8-17f6-32d6-011170f293da@acm.org>
Date:   Mon, 22 Aug 2022 08:34:35 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <911717ae-3955-08dd-ad53-a6488ef8127b@kernel.dk>
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

On 8/22/22 06:55, Jens Axboe wrote:
> On 8/21/22 4:46 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (sparc defconfig)
>> failed like this:
>>
>> drivers/scsi/qlogicpti.c: In function 'qpti_map_queues':
>> drivers/scsi/qlogicpti.c:828:24: error: 'return' with a value, in function returning void [-Werror=return-type]
>>    828 |                 return -1;
>>        |                        ^
>> drivers/scsi/qlogicpti.c:817:13: note: declared here
>>    817 | static void qpti_map_queues(struct qlogicpti *qpti)
>>        |             ^~~~~~~~~~~~~~~
>> drivers/scsi/qlogicpti.c:839:24: error: 'return' with a value, in function returning void [-Werror=return-type]
>>    839 |                 return -1;
>>        |                        ^
>> drivers/scsi/qlogicpti.c:817:13: note: declared here
>>    817 | static void qpti_map_queues(struct qlogicpti *qpti)
>>        |             ^~~~~~~~~~~~~~~
>> drivers/scsi/qlogicpti.c: In function 'qpti_sbus_probe':
>> drivers/scsi/qlogicpti.c:1394:1: warning: label 'fail_free_irq' defined but not used [-Wunused-label]
>>   1394 | fail_free_irq:
>>        | ^~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>>
>> Caused by commit
>>
>>    f19f2c966b2f ("block: Change the return type of blk_mq_map_queues() into void")
>>
>> I have applied the following fix up patch for today.
> 
> Folded in, thanks Stephen.

Hi Jens,

Please drop Stephen's patch and fold in this patch instead:

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index a5aa716e9086..57f2f4135a06 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -814,7 +814,7 @@ static void qpti_get_clock(struct qlogicpti *qpti)
  /* The request and response queues must each be aligned
   * on a page boundary.
   */
-static void qpti_map_queues(struct qlogicpti *qpti)
+static int qpti_map_queues(struct qlogicpti *qpti)
  {
  	struct platform_device *op = qpti->op;

@@ -840,6 +840,7 @@ static void qpti_map_queues(struct qlogicpti *qpti)
  	}
  	memset(qpti->res_cpu, 0, QSIZE(RES_QUEUE_LEN));
  	memset(qpti->req_cpu, 0, QSIZE(QLOGICPTI_REQ_QUEUE_LEN));
+	return 0;
  }

  const char *qlogicpti_info(struct Scsi_Host *host)
@@ -1338,7 +1339,8 @@ static int qpti_sbus_probe(struct platform_device *op)
  	/* Clear out scsi_cmnd array. */
  	memset(qpti->cmd_slots, 0, sizeof(qpti->cmd_slots));

-	qpti_map_queues(qpti);
+	if (qpti_map_queues(qpti) < 0)
+		goto fail_free_irq;

  	/* Load the firmware. */
  	if (qlogicpti_load_firmware(qpti))

Thanks,

Bart.
