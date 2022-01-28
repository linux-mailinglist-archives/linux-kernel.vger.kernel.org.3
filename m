Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E449FFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiA1RmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:42:07 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:36488 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiA1RmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:42:05 -0500
Received: by mail-pg1-f170.google.com with SMTP id e9so5814067pgb.3;
        Fri, 28 Jan 2022 09:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PesQloUaxvEmTVPfJQcjOIXm9PVWBcnSQjPoitUS3nY=;
        b=SSU6ixxs6a8oyjrnFWCP6N5zUp7Y2OfcX07onFSmI/kpfSxDZCu2sZBXiXQdhciEEI
         pHCPHLpjZzS8GvaB4EO3kBUh5W2372Apzucg5w6E1cIPmtrt+vVIlZfZHEqedQ7mc2Kw
         NPRKWQkVTBPA3QKcBHHxU4WHOgTh6Eh9I5S0UCdTaU+9etSj9E9Ni5IurA/7jWwwdjwv
         j9zCtvDKcU/Dw6T5vSs1aB0spbnOfWkpo7KM+wfR1Fxe9n8RYihp9e0PviqYisvNkCIp
         kVPpZQW+MT8HHkiSd7iWdHseQAMr1BZJfx0HQ6vCI/YOT0wHJafemG/acAkLHiSenRSy
         u9bg==
X-Gm-Message-State: AOAM533whrxnZg4wgrGTJyCflOOGQphaQbyM5Y4qatJs+ipTsUt6ZMr2
        Dr0p8A2mmZ+1UJgvYsVz0tE=
X-Google-Smtp-Source: ABdhPJzMLWm8Yz2uo2wdeHC5HjiecMlFM4aw3Bp/FY8+WB3loHfG+lRatSAgH3e6dnaxBBDKBabbxw==
X-Received: by 2002:a63:e94e:: with SMTP id q14mr7390897pgj.376.1643391725033;
        Fri, 28 Jan 2022 09:42:05 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id h18sm10275011pfh.51.2022.01.28.09.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:42:04 -0800 (PST)
Message-ID: <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
Date:   Fri, 28 Jan 2022 09:42:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
Content-Language: en-US
To:     trix@redhat.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220127151945.1244439-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 07:19, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> checkpatch reports several hundred formatting errors.
> Run these files through clang-format and knock off
> some of them.

Isn't this the kind of patches that carries more risk than value? 
Additionally, this patch conflicts with a patch series that I plan to 
post soon.

Thanks,

Bart.
