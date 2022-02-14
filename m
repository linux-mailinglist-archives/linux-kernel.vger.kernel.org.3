Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20274B5763
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiBNQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:51:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiBNQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:51:17 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF164705A;
        Mon, 14 Feb 2022 08:51:09 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id l8so4987741pls.7;
        Mon, 14 Feb 2022 08:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3yPbiawnoTewdDNHiKDHgRuYxsSFY5JgTKHU0YNYk+4=;
        b=4ToBIDeI5/xdIALMjKOuXaPD+SkC8KPT4zzXBhm+Q8CF79JyUHA9r8A/C1iDs/fo+C
         /I+DImQeNpUkWsubaECABbfPrzBG6Xzgah+Emy2sTbIXmxvK138ST+0DUSigBnfhU0uh
         Y67StdVzyxfKSMCUdhidszgUYJk4TEl+Sub9RRZDzQej2ldMp95Ebh+XLprxs5Yxbn3g
         Fy02caxtWNl+WXUNDqtNDCXSzbdnwqI0F5GJvrRpt5hS+uBzTeUovg0UL2e6KNKLJ5Cs
         MzljSmjuov1lLjRKsDspqsts06AzGhgr6Q5u8Awvy2AzSRDo2JNuGNVYRaSRs5EgZ+mN
         mTMw==
X-Gm-Message-State: AOAM533PzbB0wJyd+cOApc3R2BoOuikaTgg+ziLZsAfbBD/MuPGWOkUM
        ERwZ9Rw+trEdNyNInin53ko=
X-Google-Smtp-Source: ABdhPJwsrKAwDeIspFDEGq40H19o8morxFVhKT7pdp2J4OJhnqcHHcCZhMHedkitoajGiPQ5m2bX2g==
X-Received: by 2002:a17:90b:295:: with SMTP id az21mr15646456pjb.145.1644857468936;
        Mon, 14 Feb 2022 08:51:08 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c12sm39145563pfl.130.2022.02.14.08.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:51:08 -0800 (PST)
Message-ID: <974edf4d-37fa-b25a-d0ac-33ac502381d8@acm.org>
Date:   Mon, 14 Feb 2022 08:51:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] [hpsa] Fix the wrong chars in comment section
Content-Language: en-US
To:     James Wang <jnwang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, don.brace@microchip.com
References: <1644742790-87210-1-git-send-email-jnwang@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1644742790-87210-1-git-send-email-jnwang@linux.alibaba.com>
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

On 2/13/22 00:59, James Wang wrote:
>   /* Find and map CISS config table and transfer table
> -+ * several items must be unmapped (freed) later
> -+ * */
> + * several items must be unmapped (freed) later
> + * */
>   static int hpsa_find_cfgtables(struct ctlr_info *h)
>   {
>   	u64 cfg_offset;

Has this patch been verified with checkpatch? The style of the above 
comment does not conform to the Linux kernel coding style. Please fix.

Thanks,

Bart.
