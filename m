Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB258D951
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbiHINWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbiHINW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:22:27 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DEB18B0F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:22:27 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id r69so4799744pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 06:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=B7uQTub1ahljxDOniVaW04DLGF0sT86p8KJIWqRumqI=;
        b=P/tWjiPKQiglwsFjq0880HKShXoycGYtDqhLWkZsXyZQabazPhqPCa7+uG70R/vRmZ
         GwW0+VJ2zlsKx1QXCBbW7gnwjj8Micqi9e34GmiJ52OhokHBIqpCgOo23+ONTRtgNiFo
         uGo6supJCMLufIRx1kfT0jaGtm2V9bjDHUgs08HbLKHK8ZDN9opJXNPE1ZH3rQfpFBYf
         beCyK7Kb0dMIVogW0vyywqB47+YrEILbTjo3AcSwFqKjWMnvWGr2HJFpKynZRQwWJUYU
         KsoAgKPx28olgSvB7KETPDeUnl9gI2bV3uxHWIDMZxAqbO3c6/q2/B9k/vKVJNVq80rs
         CDjQ==
X-Gm-Message-State: ACgBeo16TRyC8zr43FvW1iv4gkBd+BL/+rQCSGRBe6/YGTUXdz8+ysfq
        BjmbIvL2bF03OQ0ES554ooZKB0jgj7k=
X-Google-Smtp-Source: AA6agR4tAnjlYEo90WCcd2wTNnl6yimFsFXXxb3LxkBsGO1YIjs6GCBTnJpAWY6gaM87U16z41e3Kw==
X-Received: by 2002:a63:1502:0:b0:411:4cc0:3ec1 with SMTP id v2-20020a631502000000b004114cc03ec1mr19498300pgl.91.1660051346506;
        Tue, 09 Aug 2022 06:22:26 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b0016d1bee1519sm11020225plg.102.2022.08.09.06.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 06:22:25 -0700 (PDT)
Message-ID: <8f6abe4e-17a0-7f20-1383-a044188e0bc8@acm.org>
Date:   Tue, 9 Aug 2022 06:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [kbuild-all] Re: drivers/md/raid10.c:2647:60: sparse: sparse:
 incorrect type in argument 5 (different base types)
Content-Language: en-US
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <202208061258.jAwlaAXe-lkp@intel.com>
 <dc0dbf3d-d524-7edc-6fbf-0067c75c3d03@acm.org>
 <bd67a6dd-4d43-28f6-e2bb-a283f581a7a9@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bd67a6dd-4d43-28f6-e2bb-a283f581a7a9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 03:23, Chen, Rong A wrote:
> Only the warning prefixed by '>>' is related to this commit 4ce4c73f662b:
> 
>  >> drivers/md/raid10.c:2647:60: sparse: sparse: incorrect type in 
> argument 5 (different base types) @@     expected restricted blk_opf_t 
> [usertype] opf @@     got int rw @@

Thanks, I can reproduce this warning. I will send a fix.

Best regards,

Bart.
