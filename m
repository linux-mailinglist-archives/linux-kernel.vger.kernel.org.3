Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2458A4E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiHEDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiHEDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:07:24 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842231054B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 20:07:23 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id f30so776783pfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 20:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nrJp3vudFTu47iN2kppYhxEnbGVtQ/lyisC1RF0DUQQ=;
        b=ZnR0ECYhDdxyk0MUwzRaH75wh4ER21oa8C3y7A6Br/P3sDHVw5gVZqZbtN+lfmgGJ+
         +4yH9dfVGVXs9JOu4fOTbjZHI9FOr4X3Zzo9Mu4vSn1A5XZxqgWfKCs4xxQn7obnjcNj
         MxBgFiX0BG4/ISkm/Tv5LYEkUav+5iwEgSVuhQmrpb3tJ8vqnSnQWsb9wyeK4piIOPHc
         dGqk5+8++bnFNBh7CJxlUx/kEg8JKSrPLEIG5Ifqq/vtssNLLgjiSUamXbmcmCS5LQgi
         EDvZaMGol2rKRz51fOp4g6fm/1QSr6b+4b1H1476JPheYe5lFRNnm/zj9Uvp6eWUW7cY
         6okw==
X-Gm-Message-State: ACgBeo08BmvO+feqI6s/Y0vc9MnhPFiJuu/B0Q6bc0JAofDlf9UP8Or6
        Br4JMnfjFECt2LDXQ46Db8YxGe3DYfQ=
X-Google-Smtp-Source: AA6agR5CsW2UEtrPEI5xm1dsJS55qRMjv/DqEIvEnrAyf20o70RDZvucqoRFHsYMvkD1nDFr5LFp3Q==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr4080338pgs.280.1659668842795;
        Thu, 04 Aug 2022 20:07:22 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g130-20020a625288000000b0052dc77fa40esm1644504pfb.215.2022.08.04.20.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 20:07:22 -0700 (PDT)
Message-ID: <18f28bb5-d8ac-20a5-fd6a-932cda454209@acm.org>
Date:   Thu, 4 Aug 2022 20:07:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to
 restricted blk_opf_t
Content-Language: en-US
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
References: <202208051050.mUx9O9G8-lkp@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202208051050.mUx9O9G8-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 19:03, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
>     fs/nilfs2/segment.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/nilfs2.h):
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer
> 
> vim +191 include/trace/events/nilfs2.h

Hi Luc and Linus,

I think the above sparse warnings refer to the following macro:

#define is_signed_type(type)	(((type)(-1)) < (type)1)

Is the current plan still to modify sparse such that it stops 
complaining about the above macro?

See also 
https://lore.kernel.org/linux-sparse/20220626095814.7wtma47w4sph7dha@mail/

Thanks,

Bart.
