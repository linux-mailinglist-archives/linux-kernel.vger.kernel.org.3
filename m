Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6054C015C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiBVSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiBVSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:33:02 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF531070B9;
        Tue, 22 Feb 2022 10:32:35 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id bd1so446346plb.13;
        Tue, 22 Feb 2022 10:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uk23sL6XdP5uOodAkzhoIbLjps/F/rWwEdSM/N8Negs=;
        b=c2ZJD8zXpgJEexurTDwZEVx21db/u+YbRsvk2Wdo80zdLZlyWyU751aI+Hhq+0zuSC
         O16UBBwJyeJhsH6xekjmaw9SHIpfHCdjyn3/XHel0FEoJ8kxA318nFLoQ1ziOYSDhQJF
         VGSCkWWEVTmKRBBiqMeIvnJu4u1Pc7z03KvRf+ibb8Ernr5EaOcnYE5LSNbmxWvoDHVW
         RXTQfXQuX9cp6BjzlNNBnGw2Cnhi7BlQzlKpIk9kjmMIEuXcFwUXuOOZwMWX71A1oqdf
         xM/yaQjBgLJBoqjgyaHXRX3yZ6fy+3tiyaE4hvOdM06MVR9qoLcp44kvBzCW16GS2glC
         aPMQ==
X-Gm-Message-State: AOAM5320Cxe8LxRbtvqg3y6kDD3O3s2jfLMg4dCoYoxB0NdIIhM8VtpH
        ISTiXgVRkWSf0QFPIvo2NYqg5GGSYwFN/w==
X-Google-Smtp-Source: ABdhPJxxy+FMhUzeRzoAW4fLU4Jyu+DAtMa5g9Cau5r9xporSq/MSEwX327uKdn+yq0HKFw2aVg9Dg==
X-Received: by 2002:a17:902:7d83:b0:14e:f2f4:743 with SMTP id a3-20020a1709027d8300b0014ef2f40743mr24328453plm.107.1645554755212;
        Tue, 22 Feb 2022 10:32:35 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 16sm21889656pgz.76.2022.02.22.10.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:32:34 -0800 (PST)
Message-ID: <beb5eea9-5294-92a3-3dda-a50be71810ec@acm.org>
Date:   Tue, 22 Feb 2022 10:32:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] scsi: docs: update notes about scsi_times_out
Content-Language: en-US
To:     Khazhismel Kumykov <khazhy@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20220219001601.3534043-1-khazhy@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220219001601.3534043-1-khazhy@google.com>
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

On 2/18/22 16:16, Khazhismel Kumykov wrote:
> Most importantly: eh_timed_out() is not limited by scmd->allowed,
> and can reset timer forever.
> 
> Fixes: c829c394165f ("[SCSI] FC transport : Avoid device offline cases by stalling aborts until device unblocked")
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

No blank line between a "Fixes:" tag and a "Signed-off-by:" tag please. 
Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
