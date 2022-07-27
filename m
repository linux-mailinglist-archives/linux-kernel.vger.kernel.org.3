Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8D583285
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiG0S4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiG0Sz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:55:56 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1958127B27;
        Wed, 27 Jul 2022 10:55:56 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id bf13so16495252pgb.11;
        Wed, 27 Jul 2022 10:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7qxn+JNDvcIG+lyVki0RgRQJyk3Tl2RlS02Rp/s2JCk=;
        b=K8JHfvN1G1QdSYLrl6zoAGa+extXSsGu2FKZfLze/LAUbCYFWdrUoIp1/6Xb3BJmKk
         IJdqzVeTzE1v+S2l2DiQrqL07lZdwjnS+N7ZwPkFBsVwe+Nw40kzwowZeLiISkakyvOM
         LdHjqrJMcfDsMBJIxcHUaIM0Uto/pgHUisL5Uu47ewua4qBAhpNxq9M7puP1erpOcW+3
         pfUhc0/ZZecn2dnDckWKTJmIYifvY74LWroQjAcFSwmuFpB+qOhess1jrR4aucWxWHkF
         ZX0Of0FO3OFxAVIQ+DYQPGvfaC4tdqLuLdHcekDS1tg9NTJkLmqmPhWjFSLzGb+TQcFw
         2/Sw==
X-Gm-Message-State: AJIora8y1tefT7wgAFugzd9T5EswFf8Nrm2LfBFYCJqebIxiB35nYP4j
        gRTT2d2dgSTxmK5RPDvLcHU=
X-Google-Smtp-Source: AGRyM1tO2NHQPOkTbEkiTtiX+GPr//1Bgn2ydfjx67gqokU31MXnafLgfUyNg7YxYZECA4U2oJYiCQ==
X-Received: by 2002:a63:c5:0:b0:40d:d290:24ef with SMTP id 188-20020a6300c5000000b0040dd29024efmr16467841pga.141.1658944555427;
        Wed, 27 Jul 2022 10:55:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id mj1-20020a17090b368100b001f310564e8bsm1480908pjb.30.2022.07.27.10.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:55:54 -0700 (PDT)
Message-ID: <b8ecd9ce-35b7-276d-b028-2d8a4a900945@acm.org>
Date:   Wed, 27 Jul 2022 10:55:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] scsi: ufs: ufs-mediatek: Remove redundant header
 files
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220727034454.31892-1-stanley.chu@mediatek.com>
 <20220727034454.31892-2-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727034454.31892-2-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 20:44, Stanley Chu wrote:
> Remove redundant header files like
> <linux/sched/clock.h>
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> Change-Id: I7796a23a5fdc767a4d00475b399844ceeaded0a8

Please leave out Change-Id tags from patches that are sent upstream.

Otherwise this patch looks good to me.

Thanks,

Bart.
