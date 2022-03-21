Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F2E4E2E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiCUQeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351289AbiCUQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:33:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A19188A0F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:32:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u22so4524262pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fjCU1MalO2ku7wS+OzZnKaTrnAbFLbT6vv2XAruGwg0=;
        b=C2Q3YotK5tlAAX/5Nt3UugiYRMm54RayeGGL2dzd/kqrUp7IMk5ZRdf0BkaAT/Jp5K
         rfa4mGAn5AgP10nRH/xkv1tdtp68ZlXcrTXrsR/MK4Qk2yigbRn6vSY5MF5s1IXO1Mok
         kPr4vJ6SmRagV0zXiBfKrOIKsEocpdvOHEOg/O5jbygovDvL65fb8/FXyu8do0JWLDhh
         IKoYMok9oyjhwV+qCuQTxA56rFeZbVe6lBft/PPk2NtKCLK2Q3no6xYlQq9GTKVoAXA5
         xC5Aikh5zJKbK2VuH7LDNqFW+OV32LFHLw8KBkGPBVsCd7kbCu7DVeF9thVJPIgi4a4c
         /zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fjCU1MalO2ku7wS+OzZnKaTrnAbFLbT6vv2XAruGwg0=;
        b=T3lkgm2C+mbZsodYFuTNUBqeVexrasouXPnap77T/OHW5kYxYljkLb1NslG5izRGNP
         PABYL34S45uaRLEgrDmukPSYZnI+XzCXguqwV93ygJn2cPbBgZgK2O8h7Wo8SZG3DoaV
         yv9kl4QSS+WP1nbesJuVI0+q3S7BRrpghbTOyC14rGnR8yM717iEQqc+1K3cilszNxxB
         +Uzj9sH+5OeRwQ0wcIIjPX2n64FsbNrCtJ+PuLcI7aEREcczrVb86+4hQQ0iyVV9T9At
         qltYH2YOlAo7dTHgsu8WmTssCwzWpEWE70gG3sOl6k1aV08OwO6uTGeGhhy5kIldwr1k
         ASzQ==
X-Gm-Message-State: AOAM533uyatP8F02rA8PqF/epFq06utd9NjVRplcPdSm9PjqUZZjKi6z
        ttIiJSY0aQfQylN+7oZe/34=
X-Google-Smtp-Source: ABdhPJxbrkQDklVFlVZKw+5uA6kihshjZbDUScq9pxuqDWO0ilYjj6LmQXNA5IJCAZoUZYSsVuDJCg==
X-Received: by 2002:a05:6a00:338e:b0:4fa:9015:af50 with SMTP id cm14-20020a056a00338e00b004fa9015af50mr9259059pfb.57.1647880346834;
        Mon, 21 Mar 2022 09:32:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id on15-20020a17090b1d0f00b001bfa3e36086sm21950187pjb.54.2022.03.21.09.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:32:22 -0700 (PDT)
Message-ID: <781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com>
Date:   Mon, 21 Mar 2022 09:32:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Question about the Broadcom Always On register panic handling
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        computersforpeace@gmail.com
Cc:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>, opendmb@gmail.com,
        gpowell@broadcom.com, justinpopo6@gmail.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
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

On 3/21/22 09:15, Guilherme G. Piccoli wrote:
> Hi Brian and Florian, I'm studying the panic notifiers and found one
> added by you in the commit 0b741b8234c ("soc: bcm: brcmstb: Add support
> for S2/S3/S5 suspend states (ARM)". Basically, the handler is very
> simple and the only thing it does is:
> 
> /* from drivers/soc/bcm/brcmstb/pm/aon_defs.h */
> #define AON_REG_PANIC		0x20
> #define BRCMSTB_PANIC_MAGIC	0x512E115E
> 
> /* from drivers/soc/bcm/brcmstb/pm/pm-arm.c*/
> brcmstb_pm_panic_notify() {
> 	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
> }
> 
> This write happens on panic time, but I couldn't find any
> information/documentation about the AON register and what effectively
> happens when this write is completed. Does the SoC reboots or anything
> like that?

The AON (standing for always-on) is a small domain in the SoC that can 
retain its state across various system wide sleep states and specific 
reset conditions. The AON DATA RAM is a small ram of a few words (< 1KB) 
which can store persistent information across such events.

The purpose of this write was initially to help with indicating to the 
boot loader that a panic occurred and so that it should try its best to 
preserve the DRAM contents holding that buffer for recovery by the Linux 
kernel as opposed to wiping out DRAM clean again. I cannot go into the 
mechanics of what happens publicly unfortunately.

> 
> Any information that helps me to document such panic event is very
> welcome, and in case you have AON documentation, it'd be also pretty great!

Why are you asking specifically about this if I may ask? If you are a 
legitimate Broadcom STB customer you can reach out to our support and I 
am sure the question will come back for me to answer.
-- 
Florian
