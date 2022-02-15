Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5684B789C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbiBORh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:37:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiBORh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:37:58 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525A4EF52;
        Tue, 15 Feb 2022 09:37:48 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id i21so34581502pfd.13;
        Tue, 15 Feb 2022 09:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oXWX0jaQNHFvwdQVtFP6krv3RJnur7U+S/3/43SPpDg=;
        b=JMAFbJvvRk7zoL9ZZCkE1ZMLufEu7TGRMHlyn2TnW6Vj3ST1qstsemOFQ5Ad21BbG4
         Z+8omORo/ergcZ2bDfRq4dy/50abIVMV9I1gEshmy19ce6ddeQbJFI+h3Mh9m/dzwgtV
         WraXoUEIT3hwkQgxfDbmoIFsGOWQuUQ4gucuu29NDO8W3qzbJqrcZTU9fhB8iL0VPXkl
         c3sKMLbfS/Y+qx6Ejvpn9WGv2AZcLK8du5Z8GjR7g59fzLL2323mmKEb4vDPGAjqw5Jf
         aVGF66Gg8K53VgQCgCsO5oHaz3SE2rugz1lI7xHGazBuO3mye4LYLV8SgNiSQtpXguXN
         DnRA==
X-Gm-Message-State: AOAM530bqbjAO9CIU8twmD6oHkAU7o0EIQxFm1fEXNk7e7Vxzmdu3yDb
        eB/zt4Y5dOn/NGZ8MDjYk/I=
X-Google-Smtp-Source: ABdhPJxlCrWNZuGjUj8mtG+WZTgrCvZWeUA6qZVWeZbra0yvA2xyyvFTN6r8ezQWAhBHJO6h+4YM7Q==
X-Received: by 2002:a05:6a00:1c6e:: with SMTP id s46mr5546027pfw.56.1644946667649;
        Tue, 15 Feb 2022 09:37:47 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id d15sm41466850pfu.72.2022.02.15.09.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:37:47 -0800 (PST)
Message-ID: <739e4ca0-ec2d-d39a-4c80-2b2e16435f49@acm.org>
Date:   Tue, 15 Feb 2022 09:37:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] [hpsa] Fix the wrong chars in comment section
Content-Language: en-US
To:     James Wang <jnwang@linux.alibaba.com>, don.brace@microsemi.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <974edf4d-37fa-b25a-d0ac-33ac502381d8@acm.org>
 <1644889961-61470-1-git-send-email-jnwang@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1644889961-61470-1-git-send-email-jnwang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 17:52, James Wang wrote:
> These '+' should be redundant.
> 
> Signed-off-by: James Wang <jnwang@linux.alibaba.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Please do NOT add a Reviewed-by tag if a reviewer has not posted that 
tag himself.

I have the following additional comments on this patch:
- I am not convinced that this patch is useful since it does not help
   users of the hpsa driver.
- The comment still does not conform to the Linux kernel coding style.
   From coding-style.rst:

The preferred style for long (multi-line) comments is:

.. code-block:: c

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

Bart.
