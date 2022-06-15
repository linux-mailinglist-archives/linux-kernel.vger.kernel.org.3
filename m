Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBC54C722
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiFOLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349226AbiFOLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:04:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B711A3D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:04:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u18so10123367plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T824YRyWbY8QMwmDAOdeOrXAS4lOWMO5bv33bcKaW7M=;
        b=7k0x2XCq3c+fO57mLWxyW3hIRphZs6qRafxHeFqwN6WujzbKD2zGN3SOtovrXLKgzM
         WmD21sQigiQQXmu3CRxkLilzT39tnuFDZfFTYahh83+0Qb00MasNXGLYfbCgjBI4HLf+
         PVSVLC2n8rCGc0P1fq1xDHDyfqJ6vjrYVhtOcfHM05QUZJwGfhuixYo/cmO/inIwPKII
         WeYU64MyfllBmx53oSXWEWsBU4NbbjdyGaGVB+4XgZ0x/2i4mGQ/Cs+tbSIU3Q/SRpAV
         82pfRdxx7TxB1lWM1lZziARVfujowqge99iYdGMjGNmunykqNTr4zdyA2LE5F5ic5gH3
         MgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T824YRyWbY8QMwmDAOdeOrXAS4lOWMO5bv33bcKaW7M=;
        b=UMNTMcdUPvj7CGq/16OBg+kBJjbXpoSsrE3HMZ4nezMuY10CCY6G/QIyItj2vPV9Ym
         Xyrf4Icf8XkhJWpqo5cvOzAjM/OyS6t96PmQhXRW2k7HIIAIsreG3+M+S5wnKC06vgb9
         sR19kcBXwlaFQDMXhCVPyWvqnLk/KF2yRkMGxqsf4iVDKUz94lwwm64jn6NXdmwwlKxo
         s2uMZI3G5MRF6ef11p3RpdC+rDKCXFxRXayZFf4PnytbndNxl0PLEeVud6l/XatOKrTe
         6Sfb5AH51yiZC6eWSNsoWIul3OcU4kCJQ/IPWnDUXz34nCn8Qr9vWxDNV3ithEm0/yRQ
         3CWw==
X-Gm-Message-State: AJIora/nA99cGwdVbGOPGrbv2m+/5JeaMrrlKDkMi7FSJGbtNfiMszH2
        IrS3g27GXwwt0ovaTFyPZiqYjv8CxyH32A==
X-Google-Smtp-Source: AGRyM1t5eoWtX6J8r3c+wvPvgRu3y+yh8lij5bXtDZ8bbbUbfVBMy8KPtTccm7534wzKi0hhYKIX1Q==
X-Received: by 2002:a17:90b:4a8c:b0:1e2:f378:631d with SMTP id lp12-20020a17090b4a8c00b001e2f378631dmr9590261pjb.58.1655291074460;
        Wed, 15 Jun 2022 04:04:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b00163c6ac211fsm9009421pln.111.2022.06.15.04.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 04:04:34 -0700 (PDT)
Message-ID: <6d214e48-721d-c9b8-f900-c23d6cbe9324@kernel.dk>
Date:   Wed, 15 Jun 2022 05:04:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Erwan Velu <e.velu@criteo.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220614210902.744318-1-e.velu@criteo.com>
 <20220614210902.744318-2-e.velu@criteo.com>
 <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com>
 <20220615053729.GA21858@lst.de>
 <CAL2JzuwnZhMgaVQ0=LAYfe6pWnxGLgR_b4xdF_==F3vL_Hh=gw@mail.gmail.com>
 <20220615105316.GA7911@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220615105316.GA7911@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 4:53 AM, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 09:57:05AM +0200, Erwan Velu wrote:
>>> I would much prefer to not print it all.  The Linux boot is way to spammy
>>> to start with and this doesn't add any real value.
>>>
>>
>> I know the boot is a bit spammy but when systems crash because of nvme
>> drives, that's very handy to get a trace showing who was the culprit and
>> what drive is installed (including the fw version which is usually a major
>> source of troubles).
> 
> Well, usually they are all the same or a very small set of different
> SKUs compared to the total number of drives.

Agree that we don't want to add unnecessary spam to the boot messages,
and we don't need tons of lines like eg SCSI does. But it does seem
handy to have a single line of the basic model/fw/sn for each drive
along with the enumeration we already print.

-- 
Jens Axboe

