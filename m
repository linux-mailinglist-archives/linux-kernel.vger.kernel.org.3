Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51904E9696
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiC1Mal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiC1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:30:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6477F3F32C;
        Mon, 28 Mar 2022 05:28:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j8so4455618pll.11;
        Mon, 28 Mar 2022 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UN/c7heCX4G+HDlDy0x1Dxd2U1JFyiXh5dPqJmGWYYs=;
        b=c2Bp5/OZHVFxTeufOZjGiOn/KeIdo/jlct+jN5ahnW0LIIKBZKh0TPm00+4xYUGsCi
         F2HjoTQc6brIoUvRMERPiP2P8y559PqIseBru2gc4meKz1BXLBb2UwFCRWVI9gJrCSX8
         gONUNQ08D5uxuOQ9Bv1HQRTed0iEl1U+bx5GsgB3onVWASKVL/vgQ4KdtABZl83ek9A5
         EHPaKGW62vo+pRovrs733nWfVgCpcZk42Sm/YOi8cQ2HpHfiHMWpInpj/u2XVOlK8ARt
         QXMt2WmWmiB0ZXauFJhpix+frq8Hxn0yWAHz42XsY6P7skDbGrC6/qT9t99i+fopsNSq
         rgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UN/c7heCX4G+HDlDy0x1Dxd2U1JFyiXh5dPqJmGWYYs=;
        b=lejlhvo5PUp5RUIZqCWPnKHLfELss9dwxiks2p4LPvQNINP9usqLrwj2qtEyfX29mq
         BtFKqmYGsTvx65LOjWyq3MaROjKyWp3TPQGd3N/ijaem66wZ6sVk4qkLVJqPyq6pwH2K
         fmwWyZGfagNnqpAgAFVPd76MKuP247M5IN8++/X1b+i8JvDD7/EtGhYFWbFMzRBr9eNW
         yHtnfeK3aAeQuw8NT4uhpzJ4IdJIoGcQSryiys4EJ9LDJ+ERtcnjrdouPKdHAcli2c/E
         czRNi1bWsFChWZyVseaf0mZGZfAGkMmrT7SzqNOr/dRImSdLTkib4jZv8n8mgR/MahVl
         gdgw==
X-Gm-Message-State: AOAM530mgJZ2GPf4hdR72OX05sdqAiAz1NivMqUZGF8AOegSnTNiAa2l
        LJhGZ2dv2zQzBmsaAKnKtgg=
X-Google-Smtp-Source: ABdhPJzZEahGfsJQjcanSeJERGTpHIaRWLIzcoqAJvR8tOW60Rmtwq3efE6CXQAlYkI0yAnV9kkfNw==
X-Received: by 2002:a17:90b:4c44:b0:1c7:109c:b419 with SMTP id np4-20020a17090b4c4400b001c7109cb419mr28603706pjb.113.1648470538965;
        Mon, 28 Mar 2022 05:28:58 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm14514331pjd.15.2022.03.28.05.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:28:58 -0700 (PDT)
Message-ID: <b92e00a1-04e4-c1e2-42a8-16d87d3d0183@gmail.com>
Date:   Mon, 28 Mar 2022 19:28:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] Documentation: kernel-doc: Promote two chapter
 headings to page title
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220328065030.24936-1-bagasdotme@gmail.com>
 <20220328065030.24936-2-bagasdotme@gmail.com>
 <6a5ce717-cc0a-9b7c-ba08-88e3b9f760bb@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6a5ce717-cc0a-9b7c-ba08-88e3b9f760bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/22 14.46, Akira Yokosawa wrote:
> On Mon, 28 Mar 2022 13:50:30 +0700,
> Bagas Sanjaya wrote:
>> Promote two chapter headings, named "Writing kernel-doc comments" and
>> "Including kernel-doc comments" to page title. These titles deserve
>> their own chapters in PDF output, although these will also appear as two
>> separate titles in table of contents in HTML output.
> 
> As Mauro and I have pointed out, this change won't have any effect
> in the resulting HTML and PDF docs.  No difference *at all*.
> 
> Why do you think this change is worthwhile.
> 
> Please convince us!
> 

My intention is to give page title for kernel-doc.rst, according to
documentation guideline at [1].

>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Cc: Akira Yokosawa <akiyks@gmail.com>
>> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Please don't put this Suggested-by: at the moment.
> 
>          Thanks, Akira
> 

OK, will drop the trailer.

-- 
An old man doll... just what I always wanted! - Clara
