Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA95776CE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiGQOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiGQOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:50:49 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63048A44C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:50:49 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id 5so7003564plk.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/1vkZ9JABW2K7ica4Ajy0tyKCPUYY75FNBemI4lsUBg=;
        b=kWi+r5745tzQQc5JHzCbss+e6CeYuz5wu7fmAqf2TEScYvTxf6PfpVhFT/m1EE2kY/
         9r8+OjcL1u01mrjn3MXHfdU0zLi8OVJAXfm4wNSBO55xTc6UqFDlBiWyGW7zuRJDzD2P
         KpsBzZd8cMqFjJHNsPF1W4D8aKvAIR9+LOy/BoXAnvF5SiFF+b+nmaye4zgEmKVorBM1
         qVrJlVwwzGxa25J/1EsTBLaYZdpExOM2/AQVfg4W8FAGLzMusBx6yo0bTB5+iJwzSTJo
         QTqgfJmaD3RKGdqnlG8XsaULKD0yCPQ+vRPZqgeRxAfAePi5eLXM9e+huTNOG1QEOrnX
         kHLg==
X-Gm-Message-State: AJIora8CS5aLOI8RqnkIQoXEvgBtz3LhxqNLwpcEZohh4reV7weTDICG
        WmOm57Qp7qzPmJ8tvvC/MAg=
X-Google-Smtp-Source: AGRyM1sDh/unRqWobDUPacv2jQl5xlct+ynv29q8MAGFRuaKNvf+drhrZse3wRx5B3UCFSRgmbxj1Q==
X-Received: by 2002:a17:90b:33c4:b0:1f0:3d9d:39ac with SMTP id lk4-20020a17090b33c400b001f03d9d39acmr26700881pjb.56.1658069448793;
        Sun, 17 Jul 2022 07:50:48 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a0f8b00b001efc839ac97sm9532346pjz.3.2022.07.17.07.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 07:50:47 -0700 (PDT)
Message-ID: <4dc9a4eb-403f-951e-16e3-6fae5ed322be@acm.org>
Date:   Sun, 17 Jul 2022 07:50:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [ammarfaizi2-block:axboe/linux-block/for-next 91/112]
 include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
References: <202207162314.Jz305X9h-lkp@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202207162314.Jz305X9h-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/22 08:40, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
>     fs/nilfs2/segment.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/nilfs2.h):
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer
>>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer

I think the root cause of this and similar reports is in the tracing 
core core. I will post a patch.

Thanks,

Bart.
