Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA546F430
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhLITrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:47:47 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:47079 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLITrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:47:45 -0500
Received: by mail-pg1-f170.google.com with SMTP id r138so5974636pgr.13;
        Thu, 09 Dec 2021 11:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VlKj6DMExfzicQ3MgAc+lGSRrWeAFRS2WV0yuzGqAE0=;
        b=oHWr3FbWc2Jw0rGB+V1tuGCrVUguz9rz0DQTehFLGatwGEiPtjiLZ+ah6T5O/cKYKE
         Xf5N/SWW7ptxv1AGAHCcPE8oF9uCJ4j3EjnJRIL2cb5qO5JuBsZQzZ+Q6I9xplX5YAo9
         cjrGonCdE2qanZ7PTzP6AGnumaxu97X+7hON/DbYXGYzr696QHtbtbGIV82MJnxuGjwI
         v5FVDA6rqBlU/+M9kkSmz0pX+R/nONUp8305SIAacdD3ReLyCHHjq1x+lRqXbvvl+ATA
         5i/JQi0o2PPsOSHSCDZjyVQqULb8QrrNBgknXbaKfNQwerdCK13+yvkOh9yG/DdSATRf
         ARHg==
X-Gm-Message-State: AOAM532UeLZUN5si7MaL3V8aoisZuh5iNtUkev0zrW6cM6+k7TMM56rA
        n1FfMKfQSJjEJsEg1PVP2ZlI8gAw1vY=
X-Google-Smtp-Source: ABdhPJyNgXeLlKUNnuJxTFyyEwWGKWORgJneEZ9l6TDb5yYWOSo1QR+SDqZAS6k35bQtQVV9i+qAPQ==
X-Received: by 2002:a63:6c8a:: with SMTP id h132mr36390886pgc.85.1639079051890;
        Thu, 09 Dec 2021 11:44:11 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:4f5b:f494:7264:b4d4? ([2620:0:1000:2514:4f5b:f494:7264:b4d4])
        by smtp.gmail.com with ESMTPSA id f5sm429422pju.15.2021.12.09.11.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:44:11 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] scsi: docs: update notes about scsi_times_out
To:     Khazhismel Kumykov <khazhy@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20211208225637.1054164-1-khazhy@google.com>
Message-ID: <6c50efd9-2987-067a-bc05-0a68ad908a5f@acm.org>
Date:   Thu, 9 Dec 2021 11:44:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208225637.1054164-1-khazhy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 2:56 PM, Khazhismel Kumykov wrote:
> + 2. scsi_abort_command() is invoked to schedule an asynchrous abort. which may
                                                                       ^^^^^^^
                                                            Should the dot perhaps be removed?
> +    issue a retry scmd->allowed + 1 times.  Asynchronous abort are not invoked
                                                             ^^^^
                                                        abort -> aborts?
> +    for commands which the SCSI_EH_ABORT_SCHEDULED flag is set (this indicates
                     ^^^^^
                 which -> for which?
> +    that the command already had been aborted once, and this is a retry which
> +    failed), when retries are exceeded, or when the EH deadline is expired. In
> +    these case Step #3 is taken.
>   
>    3. scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD) is invoked for the
>       command.  See [1-4] for more information.

Thanks,

Bart.


