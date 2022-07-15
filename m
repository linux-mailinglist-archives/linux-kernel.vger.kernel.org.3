Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76901575D17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiGOILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:11:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA1A7E820;
        Fri, 15 Jul 2022 01:11:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so5287482edd.13;
        Fri, 15 Jul 2022 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/WT3O/iaEN8ZI+k9sQWWRlrclbEh4N1aPfEXOoHcef0=;
        b=QZavUBjxaC4/hGgbODR950XscjvP9bmaeH2lRJBzmMSReOjB9VvfUrmY4K8QWmUn9g
         LkiEbaJh7T6ph0sMxmpfm0jlTEJ1wpV4UpzO1WTa99klN6zrFEU3TChReJqnXyRj5ifp
         Cl6mg7/rXqOFUdMa+XmMECQtR4Fx4POGaW0UI9qpxoJTfgJPfDZ0SzzkQYPNcRZt7B2A
         2MYxNP3NYwQXUik34Nw5ZhXZ6a8eZYY2LbX6U0EuFD1hXjpMRoRYteY4BGLv8aDRJfNn
         5PggjQawr/XuKWyjvfqbOhfxof2BTqBKezTrJjGmj8eQ+gxLc0r9t/YPjTT/37l4XfoT
         dFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/WT3O/iaEN8ZI+k9sQWWRlrclbEh4N1aPfEXOoHcef0=;
        b=BtjaIr3b1sazmpD1/9j4jJkOMTEct4BvDMTElSOCgv/anm3hgrp+Z8f/vUcmXZmXL8
         1CbkkM1HDYfu78cbMQAstmfNq62dI+8xfehruI6dDY7VNM7LOgPa7QTvs8UxxIuRuO9q
         vPbVUlyuIUZya6YOYI34Lj54SNbbY323Uvm8UiJouoLk46MQTlfa+HfQs59ifoJOh1Di
         NBLmcgP6z2LQrzuJT46nHHnJHWZ2LK7KOImN8om8US3QzIFIhf3Wh2fTJ32xUvSkMF7x
         CcANwhWw7tizNNidC3gNiuqJagu2I9zHV6kIF1zqNRwC1yEtimcg2ZBztfpEf5k5Xsai
         FKfw==
X-Gm-Message-State: AJIora+X+Zn6zBTR5WiSfajLPxvtpj92TGpvnnbRkNyqzCuwBfO03L85
        H9e6HIW8ri8udWm6qea2Hwo=
X-Google-Smtp-Source: AGRyM1srrvHd0wd+c0mqmiFtnTU7PpeHR6s6xc/yzdHG2oy+kWoRM9LA5K3cHcZ2ExozHwQ2fXyF8Q==
X-Received: by 2002:aa7:ce8a:0:b0:43a:7b0e:9950 with SMTP id y10-20020aa7ce8a000000b0043a7b0e9950mr17559858edv.58.1657872690017;
        Fri, 15 Jul 2022 01:11:30 -0700 (PDT)
Received: from [192.168.178.23] (h081217087223.dyn.cm.kabsi.at. [81.217.87.223])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709061dca00b0072b32de7794sm1719447ejh.70.2022.07.15.01.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 01:11:29 -0700 (PDT)
Message-ID: <efca1b16-2492-fa68-119b-8c3cfa05cadb@gmail.com>
Date:   Fri, 15 Jul 2022 10:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] Documentation: process: Update email client
 instructions for Thunderbird
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
References: <20220714131152.12709-1-sndanailov@gmail.com>
 <ae06388f-a062-132b-ee61-8ad68f227970@infradead.org>
From:   Sotir Danailov <sndanailov@gmail.com>
In-Reply-To: <ae06388f-a062-132b-ee61-8ad68f227970@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for taking the time!
I didn't expect the original author to participate. :D
I probably should've sent a cc to you and others as well, sorry about that!
Didn't do my research good enough I guess.

On Fri 15 07 2022 01:18, Randy Dunlap wrote:
> 
> Does thunderbird v91.11.0 qualify as newer or older?
> 
> I tried to use the external-editor-revived yesterday with v1 of the patch..
> no success.

Do you think that the whole section about the
old "External Editor" extension should be removed?

> v2 of the patch has more useful info (about native-messaging), so I installed
> that and still not happy.
> After pressing "External Editor" in a tbird reply window, nothing happens.
> 
> Wait -- hold everything!  Exiting tbird and reloading it
> fixed all problems. :)

I probably should add in the document that the user should
restart Thunderbird after all modifications, just to be sure.
