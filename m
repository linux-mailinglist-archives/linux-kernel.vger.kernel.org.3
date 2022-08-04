Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CEB5898DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiHDH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiHDH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:57:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0C6335;
        Thu,  4 Aug 2022 00:57:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so4737352pjk.1;
        Thu, 04 Aug 2022 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=B5ShB1FMDcSOC6vlt1FTAf9Cnw9dE9FUOP5cnHnXKSM=;
        b=dF7Gh8AP5VyjFSoJdF1MJbwvdrvHEMNkvPD/rUMzqukFyNPcn1/uOevoOE4U12cg7W
         5iY3/nrYqcWvf/MliZj9CRAUA8aP2ajxz6AyVD+MHSv+D+QR09mEnEl6yUmqC5qSCvzQ
         K80g5WdczDXsi2JnA/f0Kq4CM3LFIUfXL4KjnSRO2PJlfqus7ZXiaSKtz9XGgsS6hEki
         nnSAF1HyoMxKGSDKI7RuXyOA0LNQUZvaj0Aco+rlOSMbAJf3aYTziRsRqeXBjSs4clEf
         t2foOiQkj/93mM9McEEmRgkV+mMxSqgpehDzt6MLjU/4G+fSKSoFF+iDGE0r3vMPwt/Z
         uWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=B5ShB1FMDcSOC6vlt1FTAf9Cnw9dE9FUOP5cnHnXKSM=;
        b=H0ompg0SZt1t+lYY7U2dDnX2hVycXKkD/MRRmv7NUcmQZ6Zz6DMXJFqzIYmoQn2u1N
         LeIexmEwUVxIF7M+xtlL2Av7khEoJJojigB0POxf6/67d1dWGr/69OgUM/ysEU+VNdNV
         LLFqnvAK4XMfDoczb98e6elDJVblCqVNN5/OqpyEsbFJeHDGFDAzVnHbRHf3paD5K3F+
         QlXDkuF2YZikmWYf1IAKe4gvo84bZkqE+H6f+Z5WA/uze5QaeOTX1S6y5X+7j3HrOYBu
         vivdKBvqYkbgyass0Jl3TAQWlhXzqa2phcycH55Pu7rgXbo8QhVA7DR1Td0U1iIb/4my
         0Ssg==
X-Gm-Message-State: ACgBeo1kKlZa9Qelbdsc2RIFqJW76Sk+Mif0Q147BGPglFnOZqHfrrCx
        qfhqGSACnKH0la5ZSrQWcng=
X-Google-Smtp-Source: AA6agR4K9kXEsbApykItiq/orOgQ5vrCLFndla99LPDrlpkl5KA7WpFIQqoV2qRJ9IwsmkO08uSrTg==
X-Received: by 2002:a17:90b:3b85:b0:1f4:f595:b0fe with SMTP id pc5-20020a17090b3b8500b001f4f595b0femr9025186pjb.61.1659599847121;
        Thu, 04 Aug 2022 00:57:27 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f54700b0016db1b67fb9sm147421plf.224.2022.08.04.00.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 00:57:26 -0700 (PDT)
Message-ID: <ed2de577-416d-24a7-a780-846a0ccac87a@gmail.com>
Date:   Thu, 4 Aug 2022 14:57:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/10] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     babu.moger@amd.com
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
 <165938740360.724959.7059659465268246182.stgit@bmoger-ubuntu>
 <YunwoDwcy7GZoKXA@debian.me> <0c3721ba-b564-733a-16d5-5150d2b7a885@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <0c3721ba-b564-733a-16d5-5150d2b7a885@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 22:59, Moger, Babu wrote:
>> When building this documentation, I get new warnings:
> Is there a command I can use to build? That would be helpful next time.

Use `make htmldocs`.

-- 
An old man doll... just what I always wanted! - Clara
