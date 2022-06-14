Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B554AC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355729AbiFNIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354765AbiFNIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:41:00 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF6427C4;
        Tue, 14 Jun 2022 01:40:42 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so3480281wml.2;
        Tue, 14 Jun 2022 01:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=egrbdk2IabQIuuxLf1d/OXrpwvtBMyPeKMUwkWUojjA=;
        b=IHaUyypNNkRpPaC1PS1rjfqgIghSbsLxIPTs8oFg92tOEG0//W1HzkTwS/xGiIJQCT
         3jXRQXlK8M1UgsCB1xuA7AVxrYV52TqLvRfB3C1IoYVCLEqxM2nej/4V9ReRvxihXkSw
         PiJCgE6tbp+2GNc/YsvXSQFNpiUhheqZJA2zKLpxjxtoT3+IH8OAsdjbRq+Vp0svu62a
         jmgQppxa8t3/1L/+T311JRKhmXkCl39sN0YXQcZkyE/ueMmbHAwdvzKde4Pd4IkFiKyB
         v47Q5PtVBhtgVWmMcoUGynNzsq2+65cc6YH099gEqfznkjmU3yVjny5qe7YoLzFFJxXr
         LztA==
X-Gm-Message-State: AOAM5321sKqNkrIO5c/o+Ff3YqX+goZ6ckZWPTfAUgkJnuPMMl0G9wzn
        5646fhbiAWawzl4Qj31WYRA=
X-Google-Smtp-Source: ABdhPJyGYD48YyiiCOeYK5bqdQNCr1LIpgO77tHGaFTqWs//zdbb2nBIN3T39WUtVPx41JgYfygqVw==
X-Received: by 2002:a05:600c:b51:b0:39d:b58f:67bf with SMTP id k17-20020a05600c0b5100b0039db58f67bfmr340044wmr.195.1655196040839;
        Tue, 14 Jun 2022 01:40:40 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b0039c975aa553sm5006591wmb.25.2022.06.14.01.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 01:40:39 -0700 (PDT)
Message-ID: <bb349247-1f2b-1c2e-decb-77f4008a7563@kernel.org>
Date:   Tue, 14 Jun 2022 10:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/7] tty/vt: consolemap: saner variable names in
 set_inverse_transl()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220614075713.32767-1-jslaby@suse.cz>
 <20220614075713.32767-4-jslaby@suse.cz>
 <74fc76bf-a7f-be34-10cd-412234990f1@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <74fc76bf-a7f-be34-10cd-412234990f1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 06. 22, 10:35, Ilpo Järvinen wrote:
>> +	for (unsigned int ch = 0; ch < ARRAY_SIZE(translations[m]); ch++) {
> 
> This removes the compile error you introduced earlier. Other than that:

Bah, let me fix that up. It's an error coming from a rebase -- I rebased 
this on the current tty-next as this was part of v2 of the previous 
series which Greg already applied 8-).

thanks,
-- 
js
suse labs
