Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E3850649B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348910AbiDSGif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348884AbiDSGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:38:32 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DDF275F8;
        Mon, 18 Apr 2022 23:35:51 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id y10so13414562ejw.8;
        Mon, 18 Apr 2022 23:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3NJg4g7B+4l3tGmcxZNjI96XS6NNFYQpd3kk23A2Fvs=;
        b=PPK3mQ+tXmM79egQ8764vfJVEOhpmUYizBQiucrmP1drK5GTZ8Ou4eynHbv5OmcaO3
         YUhjG7KA1+H95LF4pt+lbTzV95J/FZ76lAmUjCaK5ydiEyCf0hzjHXKzeyvAt+PujL3Z
         1C5gNu9XN68ab8xmDo3iXw3+EJdZdWkFMxWbJjdBqZGjVzJAuJglcPTQBGHaagYd5hU9
         Nb4b2cnHwkZ83wwLOI0UaDn/yQN6Bfue/wMGVDIXKqT746bkZjKIY9AUQX6PNBEm+U6S
         ppmWg8Juj5iZXs/Kfg/3abeKLOtBUua8y1QZynMqUZ2W3pTM4nRoGTUbEGT/VMsYmDRi
         Hdyg==
X-Gm-Message-State: AOAM530B3LEU4rY1DN/lmTqLpidCoLDBbDbowdNLyivPo4IAwRwcGb7W
        1lpk+zWNS5lbeurvH9h1uJ4=
X-Google-Smtp-Source: ABdhPJzcqJ5y6/OAAJwzl0marXpMfSOJLNuFguaMRmeIDPmf7QgwswY/Gzi9osNRFqxN1tIU40tWyg==
X-Received: by 2002:a17:907:86a6:b0:6e8:d649:5e05 with SMTP id qa38-20020a17090786a600b006e8d6495e05mr11884934ejc.705.1650350149876;
        Mon, 18 Apr 2022 23:35:49 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id qb10-20020a1709077e8a00b006e892cf471asm5237830ejc.84.2022.04.18.23.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:35:49 -0700 (PDT)
Message-ID: <8c1012af-38b6-8037-43b1-230ba1651fb7@kernel.org>
Date:   Tue, 19 Apr 2022 08:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build warning after merge of the tty tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220419163318.0682ffb8@canb.auug.org.au>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220419163318.0682ffb8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 04. 22, 8:33, Stephen Rothwell wrote:
> After merging the tty tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/driver-api/index.rst:14: WARNING: toctree contains reference to nonexisting document 'driver-api/tty'

Uh, it should be only "tty" after the move, apparently. I will look into 
it closely and will send a fix later today.

> Introduced by commit
> 
>    b96cd8b05ead ("Documentation: move tty to driver-api")

thanks,
-- 
js
suse labs
