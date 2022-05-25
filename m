Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3F5336D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiEYGmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiEYGmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:42:31 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0645D5E3;
        Tue, 24 May 2022 23:42:30 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id t6so28693667wra.4;
        Tue, 24 May 2022 23:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xzXxE/nIG94fZDAx8kfaG+i6DsPPnFHAZGzGMp67EkM=;
        b=pztPGd5ByyQ+ZPd7SplYwlnV8QAlSM2q2Psx19/bL5Fnel087GW/RHm3JSZTsh76Kw
         v0duNkl+O+2VWT5D+BRgAN75FHbq4F9va1b/E0bcgSF8nCspp+2R07+Q2SVl5kbXkEcF
         dDNEuJ9HOWRrntN+cKXWFd6scQueOW+7GMzodvWctj+rcxydfqEHVJj//yLgf5p9Ph3J
         1rcIFg/rxd4xqpzsnc/UNpyzNpmfGJt93WACdg2wFrrxWD8BreJAQzuMgVP1yW0qE80Q
         +DxoZQrf+7C0FH8JBa4vFR+mwDEJBSQhHAJ0YjbszE+5XNAEHEjdQzDrMM5ucit2yCqf
         VOqA==
X-Gm-Message-State: AOAM533KdHUetbC7knFPuEVtLeqzsiVYjPQ503XuQzq3zeNLa5CQsyf8
        VqY1rqkz15IMqcMThBV6nV2BiUQ74kagdA==
X-Google-Smtp-Source: ABdhPJym68uKqI8/tFMPBZVxhfI+3wgz9iBVPGOPE3DbsNrCpXDXGhWzcVzZLtJgKqLzixGM7/shzQ==
X-Received: by 2002:a5d:574a:0:b0:20d:70c:3aa8 with SMTP id q10-20020a5d574a000000b0020d070c3aa8mr25569960wrw.255.1653460948533;
        Tue, 24 May 2022 23:42:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d43c7000000b0020c5253d8f7sm1154279wrr.67.2022.05.24.23.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 23:42:28 -0700 (PDT)
Message-ID: <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
Date:   Wed, 25 May 2022 08:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL for v5.18-rc1] media updates
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Young <sean@mess.org>
References: <20220322101406.459e2950@coco.lan>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220322101406.459e2950@coco.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 03. 22, 10:14, Mauro Carvalho Chehab wrote:
> Hi Linus,
> 
> Please pull from:
>    git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-1
...
> Sean Young (10):
...
>        media: lirc: remove unused lirc features

Hi,

this breaks lirc build:
> [   59s] lircd.cpp:489:49: error: 'LIRC_CAN_SET_REC_FILTER' was not declared in this scope; did you mean 'LIRC_CAN_SET_REC_CARRIER'?
> [   59s]   489 |                     || (curr_driver->features & LIRC_CAN_SET_REC_FILTER)) {
> [   59s]       |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
> [   59s]       |                                                 LIRC_CAN_SET_REC_CARRIER
> [   59s] lircd.cpp: In function 'void loop()':
> [   59s] lircd.cpp:2069:82: error: 'LIRC_CAN_NOTIFY_DECODE' was not declared in this scope; did you mean 'DRVCTL_NOTIFY_DECODE'?
> [   59s]  2069 |                         if (curr_driver->drvctl_func && (curr_driver->features & LIRC_CAN_NOTIFY_DECODE))
> [   59s]       |                                                                                  ^~~~~~~~~~~~~~~~~~~~~~
> [   59s]       |                                                                                  DRVCTL_NOTIFY_DECODE

So the uapi header defines should be brought back, IMO.

thanks,
-- 
js
suse labs
