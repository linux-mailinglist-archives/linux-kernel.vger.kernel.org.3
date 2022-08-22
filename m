Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617E59C117
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiHVN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiHVN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:56:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DC39B8C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:56:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x64so8336580iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jYizavyTgywCgwQKlhKWtAmK5JRzYKWfldfefWnHvqQ=;
        b=BcHg7Ilvx8dMtVT2ok7ZjdCsPkYPQLubtEg/E5wKsN83qxas71SnESKJUFb8IkOPTP
         YKJhnN5obj9pJBVbQcPusRL5SutptSq+YU0Fe9n7GFZiCJlI7s3pdfcvqiVQrz0/rUEf
         xQcaSMGs7EEY1E9AR7cesdhyhcORUgWaGxfWL+IUZA1euaP/gYRuMTYftJ+qryGGZotD
         LY7/NCN4SykzINS/p/IUS+Up6LEI84krRDkd5u021Pkano6cj0jPr/fXFbofqX/U/qZh
         sBPhcXGesD3cXUg7XkAWP5c4WpT7U0U6D3z+gUfH+gpnAPuVV6qCSqybDKnISo2ybN9c
         WbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jYizavyTgywCgwQKlhKWtAmK5JRzYKWfldfefWnHvqQ=;
        b=x5mHbMdjKsMPbhTF87yWRZLDpaKwDN9ugDvzwcrefeXjpzabgN4ltwvV9cBVGqPVHd
         D0MOS7kI37KG50UMwylvgdb2/5jUa/AEyCnzTlMjVzAe/JU/+W4qZg9LzK9lAwed1NKF
         SB+E3giVg5xstVZijlL/uI3a5NMjx1uSP4ESofp0tSCojYQZEfto4Va8ywekB667QDJz
         Mg8kw7rjOpos50+PXfIergYycSU3EZgAdvNxD6LoDWw1FY74wzFz18cN10sm5QdatYu6
         N/zJqLIT8CGQ4iRRBBUDcrg28MKt4knJCEYq6cAK9kqFtB49k0TiSUAGafxOmcRuA79H
         FEqw==
X-Gm-Message-State: ACgBeo1E3Oq62Mgmfc3auQDXTh9UmQv5BZG9/aF4EoKs2chV5FQFcE2G
        nRdv5Zjlv7hDt4OshBwh7z1XnUFAgDoYIw==
X-Google-Smtp-Source: AA6agR6LrKlLmFHdBy8a12lUVu6COjHRqGOr+6F0NKq18fTUyWItG5SkTgwVznKY1hOFhjYuhVr5mA==
X-Received: by 2002:a05:6638:1485:b0:348:b986:6e62 with SMTP id j5-20020a056638148500b00348b9866e62mr7602798jak.236.1661176561281;
        Mon, 22 Aug 2022 06:56:01 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l6-20020a0566022dc600b0067bcc80ac23sm5823763iow.1.2022.08.22.06.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 06:56:00 -0700 (PDT)
Message-ID: <911717ae-3955-08dd-ad53-a6488ef8127b@kernel.dk>
Date:   Mon, 22 Aug 2022 07:55:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220822144613.6e6ce950@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220822144613.6e6ce950@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 4:46 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (sparc defconfig)
> failed like this:
> 
> drivers/scsi/qlogicpti.c: In function 'qpti_map_queues':
> drivers/scsi/qlogicpti.c:828:24: error: 'return' with a value, in function returning void [-Werror=return-type]
>   828 |                 return -1;
>       |                        ^
> drivers/scsi/qlogicpti.c:817:13: note: declared here
>   817 | static void qpti_map_queues(struct qlogicpti *qpti)
>       |             ^~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:839:24: error: 'return' with a value, in function returning void [-Werror=return-type]
>   839 |                 return -1;
>       |                        ^
> drivers/scsi/qlogicpti.c:817:13: note: declared here
>   817 | static void qpti_map_queues(struct qlogicpti *qpti)
>       |             ^~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c: In function 'qpti_sbus_probe':
> drivers/scsi/qlogicpti.c:1394:1: warning: label 'fail_free_irq' defined but not used [-Wunused-label]
>  1394 | fail_free_irq:
>       | ^~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>   f19f2c966b2f ("block: Change the return type of blk_mq_map_queues() into void")
> 
> I have applied the following fix up patch for today.

Folded in, thanks Stephen.

-- 
Jens Axboe
