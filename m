Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF35774CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGQGqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGQGqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 02:46:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDB167F7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 23:46:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o8so5288143wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71hropnB6RNayKPZfqEby/pAC1OReaXdsuVJlnousUU=;
        b=PQj5kqZ8XZGLZ2dHSEPP7L/hgjVEcltg4LnbkMvEvv6GA2UQdmck959sAf2vRYMosu
         SEkEcZEiZe1BFbamtBZnyzYkrxMkSdm3CpeUsjKf5Yq/V1e+ge/K1IaLyTnYRdhYk9rp
         oUMP050m8i3vwkuds2+efGXQf2TnRyKluMqAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71hropnB6RNayKPZfqEby/pAC1OReaXdsuVJlnousUU=;
        b=SBt15UbD35Z6SmY5QuwGkAqnZzTB2JbmxWUcNplTIVJ7cETXqqKFQxw33iNF0Fvw1E
         tnJpebwf+YFWMapCLV1papoJro+eqR7tyZIsAw+Ia4R4XlsrnueO5T5LKy+iwk/PUJwr
         2xqWPMa27sdIrFMVi0fnPqeodVQncxDmrzBsZrI6I49TOZRp/2UjsFC8125YAn0eKd9f
         OBn+hj5EJzxQzYaSMrybCyzzGhoRPT0AVI0J7cLeNAe0ZdZTt7ysu+pll32LjueZdtVM
         BViKvQfkg5Wlera5aM1QqnGaIN5UV+/wzNFTZPCgxz5zMRLiQsmmNnyvDdRUVrCVa8t2
         R2Vw==
X-Gm-Message-State: AJIora8s+xYw3Xt2bbLFeDHVnY1CbhCv66edi0nhWoTcZTLcs8VQMWOa
        mYpVik1b5efjT+LVvv9N9vEijbTbOZwDCw==
X-Google-Smtp-Source: AGRyM1ugZ6sKDANfO5THMmzhCzMzv53CfTlC0u9698RXSYlSpoMRkU5+amRurOAXRAA8+IREG3vkTQ==
X-Received: by 2002:a05:600c:1548:b0:3a3:186b:f5f3 with SMTP id f8-20020a05600c154800b003a3186bf5f3mr2258141wmg.187.1658040375298;
        Sat, 16 Jul 2022 23:46:15 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id e9-20020adfef09000000b0021b89f8662esm7666985wro.13.2022.07.16.23.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 23:46:14 -0700 (PDT)
Date:   Sun, 17 Jul 2022 07:46:14 +0100
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <YtOwNiF1JJK544bN@chrisdown.name>
References: <202207171242.NdWlnOID-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202207171242.NdWlnOID-lkp@intel.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real issue is this:

     ../arch/parisc/math-emu/decode_exc.c: In function 'decode_fpu':
     ../arch/parisc/math-emu/decode_exc.c:49:25: error: expected identifier before numeric constant
        49 | #define fmt             11      /* bits 19 & 20 */
           |                         ^~
     ../include/linux/printk.h:391:34: note: in expansion of macro 'fmt'
       391 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \

And that's why you don't define such shortly named, ambiguous macros. The 
simplest fix is probably just to have this file and others like it use _printk.

I'll send a patch and cc linux-parisc.
