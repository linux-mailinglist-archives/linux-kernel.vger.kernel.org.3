Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8935056A7FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiGGQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGGQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:25:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012ED13E84;
        Thu,  7 Jul 2022 09:25:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b24so13755886qkn.4;
        Thu, 07 Jul 2022 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0m7H0XHHpSUDPM64nINCpNYb7JELjnUa4O9E/yofjNs=;
        b=ZK1y3gP88uX2fWlJiaNNXH2pGNcg9WiwzuCiGEt06K5pQPd/pWW4r1nhfB/o+rtKU/
         wTOd0gJveC6HlFUyDRHI8DZJmBi0vrGd8d9hofSQSPdR4YpqGy1rGjbWj7I6ptzLu0qP
         o9osNswGRdyAO/o+EFAFvqSaEmbfoo7hPFYxAETbgG14+rJWN2/2aDtKCST4RCt2qi9T
         mstu+ByHl7b/y45CODj5iwx2CcszJN4arFeU/dQ/UO0nNmwno9OaeFHNtwCaT5yPg61E
         UdrrewHzYeQvz+T69EC5Gdwusgg2MpW6xut2hTu1h0RCWVzXBB8xiqpDz6ZocliRPbS7
         MydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0m7H0XHHpSUDPM64nINCpNYb7JELjnUa4O9E/yofjNs=;
        b=E9jYZkdtXdinj84YeGOkOrwBfPKIHumjFsyzQeShR4x3y/KjnSURyd49ZdRk6KGcQi
         H8UtHrlprMnj3Mjo0L7q+8M5EoYn9ArCKIGNmdhRkcziz7TkzlSiLr2qj/XkwMsrkPtL
         vwyjzmTaV+nGhKlzeIDFOy2NDbstp7dYFdm6mc0g3/Qhqu6VRSeIKQqhB+GqCOb5FXz0
         mOVWVd5jIv5xyiKZGCUMPfha+6XOHr8OKuD/odER7euuDUFUUwEAFOyVCx/WLcERwwWQ
         albDJN93IJ3VCi06k3uBMJCmxYe8R/+q3UVO/o11Nzth1n9p6I/gtFsX8X3+RkHMptkV
         WNvA==
X-Gm-Message-State: AJIora+9LWUIv0Cv99MwSGs4cjStfOJoOLrLjtUgl5loelS5BYsEw5pp
        tM7KhJmW9or81mB47fzTbTI=
X-Google-Smtp-Source: AGRyM1t3UW1nP2P0FMItdQG2yfWNYaVelzYQp3L0xteH5nZpmbZvZu7oCt6xnYNCQMXClrb4zDIOow==
X-Received: by 2002:a05:620a:12c2:b0:6af:474:99b2 with SMTP id e2-20020a05620a12c200b006af047499b2mr30823657qkl.402.1657211107035;
        Thu, 07 Jul 2022 09:25:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t19-20020a05622a01d300b00304f3e320f2sm29215323qtw.4.2022.07.07.09.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:25:06 -0700 (PDT)
Message-ID: <b4bbb34a-d00e-b612-e843-ffc956285fba@gmail.com>
Date:   Thu, 7 Jul 2022 09:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 2/8] ata: ahci_brcm: bcmbca: Replace ARCH_BCM_63XX
 with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-2-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 23:57, William Zhang wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> AHCI_BRCM depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

There is no cover letter for this 8 patch series :/ it is not clear to 
me whether each subsystem maintainer will be in a position to merge 
these patches individually, yet still have all 8 (7 of them actually, 
see comment to patch 1) land in 5.20.

Alternatively, we can merge these patches through the Broadcom ARM SoC 
pull request(s) to ensure they all land at the same time.
-- 
Florian
