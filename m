Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5014576E28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGPNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGPNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:22:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4A1EC6A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:22:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so14003156pjm.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+HNtxGQD7e4/sLkvDJa6jpv7jycfk922+wnC+RQcTIU=;
        b=lhLES4fyFR+FYNpd2+gkPC1xS8YjVsmI18JvmW1b4NK9N2QULLu/XV9WmjYaRxewjZ
         QLJ7fTK69VFbQpsEkQRUi9ClHMliLAYAb6Ww8oQzjGEsT7lo7yL9MpshT0upgJK6roYT
         yy4kbpalmj7mV69hMxwtHw/OZow1kKV7lw6edrGuedmbuYWbpj8f1bwh66+E4PrvTIa/
         CMImqd7zDHqhqXWvNFx5oWubqBh03ea3iXZnmy+YSmyvymxi7f7yE75HOo7HA6dkCHiB
         im8dw3gYWVZk0M79ympBsaBmJm+lO/mkb52N5E6diCmb/5bfjw1XbT1vlK5PWXXXsyZ4
         b0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+HNtxGQD7e4/sLkvDJa6jpv7jycfk922+wnC+RQcTIU=;
        b=cWRuJypV1CeynZsMuhLuTRDockRCtQpNsQrFqTZadNY5HHrX0SSScJuFJe4YjZlgUV
         jmVFihUJEUXWPq7oOPyk83Hczhw9Mb5ZD+KhiB8Ne81qBpLQtyZ37Oa7OnWtFjbAAjDy
         hNICqwPvAr+R13vPCrr652a7DIycUqmEO95pcKkXwqxV0rQz4Ywgyz22gzxRbOh5TrsX
         gPmpBq7UiU8T9qp8+xKNQfL8vdpjXxbsdhd+V5CwjI3Zr9G1EQrTwvqYM8Qq/g+EJFVT
         kRw7oFijvTZQZjSmxa9LwCihHMdCN56RIFjJ3RHK02NaBbNAykBXAkpi9MtD//bpse8T
         4BRA==
X-Gm-Message-State: AJIora+yvhFGOqZ3FhQK2+AEWm6kFrq0KPnm2wuMf/+Q+I13IbsTbkeU
        hMFd7oAR2S2SZqsHAHrXBbXX2g==
X-Google-Smtp-Source: AGRyM1s5JiMQgQ6sRddokryRkWqTvb6c6yGQC+X2S0YHRA6yMKI5sOvmxpfsUIbDpdGMP9OcSelNvw==
X-Received: by 2002:a17:90b:1e04:b0:1f0:61a4:d747 with SMTP id pg4-20020a17090b1e0400b001f061a4d747mr26953849pjb.58.1657977745202;
        Sat, 16 Jul 2022 06:22:25 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g21-20020aa796b5000000b005289cade5b0sm5807094pfk.124.2022.07.16.06.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 06:22:24 -0700 (PDT)
Message-ID: <d12332ff-dbe6-6753-f327-588623edda73@kernel.dk>
Date:   Sat, 16 Jul 2022 07:22:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ublk_drv: initialize ret variable
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, nathan@kernel.org,
        ndesaulniers@google.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220716131555.2014270-1-trix@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220716131555.2014270-1-trix@redhat.com>
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

On 7/16/22 7:15 AM, Tom Rix wrote:
> clang build fails with
> drivers/block/ublk_drv.c:1304:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> 
> When the call to ublk_get_device_from_id() fails, ret is used without being
> initized.  So initialize.

Should already be fixed:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/block&id=f2450f8a2c1ec3e88d6674f747b913aa5f21fa59

-- 
Jens Axboe

