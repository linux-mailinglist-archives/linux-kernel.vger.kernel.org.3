Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCCD58757C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiHBCQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiHBCQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:16:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20043E65;
        Mon,  1 Aug 2022 19:16:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so12302835pjn.3;
        Mon, 01 Aug 2022 19:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9OpRRAm2VivNAktqX4mCRmrMtJTMn6OhCTjKcHXJQg8=;
        b=h8+Tkg6D3mp7fbyGZWdFiFlt1jdSCZBdGY+0NXJOBzQ4sj9pHPwvD4yS100IS/F9bQ
         G63dCZ60SWzIN6cWeYjbnQqh6NUrwhC6yezhbpFXWRLXPtO0hnYlQ7ZnXj/jpyHlYftt
         W5lJT7vPPrx3ZSzanB/ZxIikHzEBzrxWPzVTbnaKnkWYaXvG0TBRpt0H1US1UwamdI9/
         UBmoj+YKTF0q6obESMatqjCcQQvkTky+q8+dj0WVtd3Gv+efKKvMpJSKcReHfeLhTWh/
         R9RHozpWkwKTtwDIPTKmw1cLjZVs3JPwVE0nBPSkGff0PV2z5g8+XL2ioc0Gx/Ptv2g0
         yidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9OpRRAm2VivNAktqX4mCRmrMtJTMn6OhCTjKcHXJQg8=;
        b=B4cs2MM6qIEOID6qJGgyas8a8Ula/dEmXbHZV0tqj58HWO9b5PPhUKDTsqIdo9udPU
         M81p/wPAPWz8n8pGE7qbOykYRwrBKuyl2jwms6m44n44aOvmFM+xM6HzTx36i9/mHGBj
         rzcaM2v6Sgke1kusWIA0Z9iqIE7qBqBPXgLxIrE91qWBt4mpoKzFX8X2l6Nm/iBjENH/
         S9RBc0o4OJM6d++nQaNzpNsLfBOHS1gKq8ojrA9Li7nFUV7CmnmEJdnmBgRtwVA972QP
         6q/J49yPE65zl9c8HEGtsNsto0EkqMM1JG54BoCqMYBfYR6OPcCNgXj+KM356UUPeISU
         PjTQ==
X-Gm-Message-State: ACgBeo3gRoM8YGBWRxN4FrMlott6UahgaRgLhe2FPsIfJFQKiGr4AO7f
        L6fvIsxuCkPVf4+Owls8ZAw=
X-Google-Smtp-Source: AA6agR7TBQDpIDOyP7CZ4kSSsYx3nWQEKMP5O5WIbNr7xuDy1HFbL4BKP/gLgC7ix1/YJR7tOulMKA==
X-Received: by 2002:a17:90b:3b85:b0:1f5:1df2:1fed with SMTP id pc5-20020a17090b3b8500b001f51df21fedmr2486558pjb.135.1659406570898;
        Mon, 01 Aug 2022 19:16:10 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-12.three.co.id. [116.206.28.12])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d9b94ddfasm10294633pln.145.2022.08.01.19.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 19:16:10 -0700 (PDT)
Message-ID: <13d16a59-0b13-8484-380c-21deb864f0f2@gmail.com>
Date:   Tue, 2 Aug 2022 09:16:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/10] x86/resctrl: Support for AMD QoS new features
 and bug fix
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
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

On 8/2/22 03:55, Babu Moger wrote:
> v2:
>   a. Rebased the patches to latest stable tree (v5.18.15). Resolved some conflicts.
>   b. Added the patch to fix CBM issue on AMD. This was originally discussed
>      https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
> 

Shouldn't this series be rebased on tip tree? I think it's odd to base
new feature series on stable tree, since patches on the latter are mostly
bugfixes backported from mainline.

-- 
An old man doll... just what I always wanted! - Clara
