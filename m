Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB556A805
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiGGQ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiGGQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:26:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC734D4EB;
        Thu,  7 Jul 2022 09:26:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x184so7035610pfx.2;
        Thu, 07 Jul 2022 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jt1e/2ScFzvzJ8enZxDzBhOWnG33XZMiqPivyj1EZrQ=;
        b=mwwssqW7cpb/n2kz9xsR4FuOlMGONRHF+b3KvU+HdbFmOpO6xKpXP8GKSQmkqCCIWS
         zC655llfWn7GRKmdFdReGl5t5Lcs2vaknTlqcJntCEYxsx9aGZxLaXWzBGTY/ETcaU97
         cx0BBt7C2/JbtsmcDmUwW6+okNJ7T+LB/IhbY4FVhcyxchrtMGeTtaPBi15gV6ZfV20w
         atX8UdInZ6DSxT1m6/J81U9jhTr9bcdC0L0fD+BmWPmjGiU4tDZnznPu/3NfVICq6D+n
         QwFdtN3uOYu/9NLGLI4+/p0MXz4aWZRTnvlkN9evP5+s+MVMFOwk+/U4ylSdxyAC10Fd
         78mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jt1e/2ScFzvzJ8enZxDzBhOWnG33XZMiqPivyj1EZrQ=;
        b=Avw29ykNRJsiNnBiyUlRsyzF7y/xJoUIzBQWZnGuKNKaeI7icdODd2CaKgjRXz0we1
         dce497R9r62ZN/lvX8+ezQ0nrYKdVdPklekf2AI1TmmfE9O6N9mCBAJLfuQ+Sj540IW6
         eBLHmZMiJAkl3GiF7cXnc6sM8dnzUg2n/8r5eNA+NSrIJHxh68+CY+YzSxgxxrM53vLX
         AUUGG0IoWFabfqVHQx/bsUze7oaI0Ct50ZktQQ+FGtlKJ4hrXX2fiLhXNbCNzahzpOz7
         6NRRM5Yy0vB9qEbr9MHktQk5Rd58qu9/cA+IR1zoPrEgmy3UXrVeXsbkZKXW+1EOgXdP
         xELA==
X-Gm-Message-State: AJIora9jl3B2sBrObPWIlS+4v207NvT+iS7hndkIB/C0xE/02jgDnLg2
        fh0Pt5u94HrV25pY+aofLGqI9twqtg4=
X-Google-Smtp-Source: AGRyM1s+f+eh94bcWmcy6FCYO+4mrJG4bxZUDnb7al0tRzuDlPOdafJsZxdZivfXgJYFccT1adYi7g==
X-Received: by 2002:a17:90b:1284:b0:1ef:877b:2f06 with SMTP id fw4-20020a17090b128400b001ef877b2f06mr6051287pjb.37.1657211194250;
        Thu, 07 Jul 2022 09:26:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i4-20020a17090332c400b0016a4db13435sm28352148plr.191.2022.07.07.09.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:26:33 -0700 (PDT)
Message-ID: <2716ee5c-9339-3bcb-f435-c39d6c3b9b0c@gmail.com>
Date:   Thu, 7 Jul 2022 09:26:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 8/8] tty: serial: bcm63xx: bcmbca: Replace
 ARCH_BCM_63XX with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-8-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-8-william.zhang@broadcom.com>
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
> SERIAL_BCM63XX depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

There is no cover letter for this 8 patch series :/ it is not clear to 
me whether each subsystem maintainer will be in a position to merge 
these patches individually, yet still have all 8 (7 of them actually, 
see comment to patch 1) land in 5.20.

Alternatively, we can merge these patches through the Broadcom ARM SoC 
pull request(s) to ensure they all land at the same time.
-- 
Florian
