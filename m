Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430EF557CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiFWNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiFWNPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:15:13 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624513BBED;
        Thu, 23 Jun 2022 06:15:12 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id k14so6645997plh.4;
        Thu, 23 Jun 2022 06:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FnlFrTjZa6sSKCZYE+9FTM9rVSZJN4L1TESRVFSoBPM=;
        b=3vfU4ZMycmgJmHYK7oZhGJfouGgSxxeQUWOQBOMK8yLofjoiUT5ox0VVS0SleSKl1y
         7G0vm5eLnomyvIzR19XjqUXqYc+ID268erzmxMtrXUeqUtz7G1AU+9UNTAumwogAL3ap
         1ejnNpQKZqLc9zEbdfdAOAe3Jrr+7HtYmqgPN2zsa/4qi+ScSgii1aiLkk0g1ZWUlzL2
         pMnkRF+shDExmPghSZe1lbsYQCddaLk9oP2Ns4vfpTSjxopdWlW8n7e8MJyeDqhZqlQf
         zsBAKVjv6mNjrivaKn81Leib0KKGG7MGvbh8e3r0oavgQl5Ef5wYudwQ8M8p3rCMe2t1
         VLiQ==
X-Gm-Message-State: AJIora888mx9pNTpDGnbOydoJJrfoIQDfnfgUcNvOpkwQGs0h6sRsAtw
        +N1nQLyPZo3AbhplndDzuHc=
X-Google-Smtp-Source: AGRyM1v66il5XeRjY2a520cnS5/1pE4oykmyRvOGPYtPOIvzHjnjmYDigbcvpWOt0Ug7aq7XtWB3fg==
X-Received: by 2002:a17:902:ba90:b0:16a:2863:fb85 with SMTP id k16-20020a170902ba9000b0016a2863fb85mr19355563pls.15.1655990111757;
        Thu, 23 Jun 2022 06:15:11 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id w91-20020a17090a6be400b001e667f932cdsm1819069pjj.53.2022.06.23.06.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:15:10 -0700 (PDT)
Message-ID: <03329565-a405-eefd-88b3-992c1663d703@acm.org>
Date:   Thu, 23 Jun 2022 06:15:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/8] Provide features and fixes in MediaTek UFS
 platform
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
References: <20220623035052.18802-1-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220623035052.18802-1-stanley.chu@mediatek.com>
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

On 6/22/22 20:50, Stanley Chu wrote:
> This series provides some fixes and features in MediaTek UFS platform.
> Please consider this patch series for kernel v5.20.

For the entire series, please add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

