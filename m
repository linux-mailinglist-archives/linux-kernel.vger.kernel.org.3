Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB47473B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhLNDie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhLNDic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:38:32 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:38:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so11656072pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2qHShe7MY+8PE2qolLnbnuDu55sdtZRID6G1qJA4piY=;
        b=VucomVBX1aC4jUA/wGyYl8S0pG6ueKwh59eieLdb89BDd+VlR6PLwzK0GIQaATZpST
         xUCcYNZly3lNc8GUNc1y3Moeov1iHQvXaOofRB1WrjSvHxtnbBOW6BDUcGhBbF/HAtHT
         Bq2OfX1xq1ixSKf8nfnFXxeklWfSO32HHcaARRLSlgukIIcjX6QomGFX3Wzxx+WpcIhk
         a9CtlPLbpz2g6clf0IzLf82pSEme3bQncM734hRDdzfwHny9GV+M+KUY5UwgLEOvkD7A
         XCXQsaIEE/4+wmxAEt4Rd2oL3ccnekVWTHszZwb/ZG772ZSgAjhINPrSYWbwuwvcExUz
         +tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2qHShe7MY+8PE2qolLnbnuDu55sdtZRID6G1qJA4piY=;
        b=hZjxpgyJ/94J9vA6SP/P84eot2PKiAbXnHu5HcHpcP5slPvrC3J4XBdJGIsbIzc/6Q
         w8YUVvRWXUpgNW68oCQyi2BJydXVAkNkW9tq75DVP4cGqX8CWPy4tEf2fhpEAOftu5GE
         nu1Sqx7KFX3KhLJ3y6M66eu5/ReMoAby8DPSX81XNqESEJIRbXw9cZ2sOZZbgs2uHjEn
         cZ3ZSFUAixXsQgsLXcmq0IiGaYdz/KNN/TsBOgslVq15HZ9G/yIebmBMxeI37dCFC4QF
         4tM25IgGNBzZ1Ay99VFEIhOpQ4E46rWcVbAVgaCwM8aig5RbqG7WDGjJbhSsJtHPfAbF
         cR2Q==
X-Gm-Message-State: AOAM532LFlF7WCHt6708ozPbzITO0CooJlxIO6Oy5Hcf7MB0TVlYIu2K
        ioeKvbR9hZaH5e1j4Wf+E5M=
X-Google-Smtp-Source: ABdhPJw9bh3Mf5C0pW/xayi4e61SkxUApHmT50j/831wRK2l99VMT58NOJ2mmaOiLlyAAUMErfhx5Q==
X-Received: by 2002:a63:5906:: with SMTP id n6mr1839549pgb.563.1639453112192;
        Mon, 13 Dec 2021 19:38:32 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id j7sm14285294pfu.164.2021.12.13.19.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 19:38:31 -0800 (PST)
Message-ID: <134050ec-c156-8361-7fe6-c4191f8c9873@gmail.com>
Date:   Mon, 13 Dec 2021 19:38:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2021-12-13
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211213123040.184359-1-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211213123040.184359-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2021 4:30 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-12-13
> 
> for you to fetch changes up to 5e8c1bf1a0a5c728cee2b6c2162348a9dfddf1bf:
> 
>    ARM: dts: bcm2711-rpi-4-b: Add gpio offsets to line name array (2021-12-13 13:08:04 +0100)
> 
> ----------------------------------------------------------------
> Uwe Kleine-König adds offsets to GPIO line names array for better
> readability.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks!

PS: please remove your older @suse.de email address from the CC list 
otherwise people get bounces when replying to this mail, thanks!
-- 
Florian
