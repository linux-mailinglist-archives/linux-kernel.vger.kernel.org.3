Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9045E5080DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359470AbiDTGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358093AbiDTGKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:10:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46372387B8;
        Tue, 19 Apr 2022 23:07:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5so1022600pjr.0;
        Tue, 19 Apr 2022 23:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PXXhsO1cc1k6eZQ5kkAXBV1Y4UG2/t7OyhqoqVFc0/0=;
        b=hjM6lhGGix++5j1Y/+1HN1ghogA1Y4nC19JC71fazQEZUloVUcgJNT8YNm9hy3Yx6u
         7/UDemR1x5lCD/VpqPymNHOijLaYOTmTKyhrhmHzyqwTUS+C2EyFBvrxI8yfJvInGwvB
         vy1f7P9503qmEgZ59NMZt2GOjjJ5a410fuYlg/XN4fNAkHIozn/OulIyKXWCqhKagWut
         xKnsa5RtBEpwz0VFMD+KSnXj1P6HeUc3RVprgrj+48fCPDpGC20AxrwLf3BTZTqV/y5/
         GR0cdDqg/HMgFUMOhUOdMub9MQPQQbp56TffYIZiqVyAIOZ8r4QVgb1HsA963cR9/+ZC
         22ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PXXhsO1cc1k6eZQ5kkAXBV1Y4UG2/t7OyhqoqVFc0/0=;
        b=y7sgcVkWcMHtL+5vrfm1D1NTpGwNgftEzM47difUo4ktUr53QSfC32Lb7yZ58B7V+f
         nMowi320OQBDmjrPPUOTKNtsR+uqEZb0mkErBnkw0LXSzSvfoMSQDoJg3orhwODyVk90
         iRm04L9kKhqgmXSWP5V+TILquZHClXgMWOGWb16srtutizJ2+jBuYTxB2IBkjWT5SQ+k
         l1YaLCXT896bx2XSCSgZjNWlkhC3qSPzoo+VqgaTTXH/lt0Eu2mNaCJN0M5VK/KcXkwr
         0HJRRWvFISfyeIirohXoqgDwOgfzCrZDxM7KAjftOBHFi37BA4TCtjptINnnYElet/CS
         xQOg==
X-Gm-Message-State: AOAM530cxexfVEUNmCRp1m42PvxAbsfl/6JcLfl8+aaPYNRlR++B3D1y
        jlCIDGC2RD4wllp0+zxaYnM=
X-Google-Smtp-Source: ABdhPJw67KSTWTy6zq1YDwYpHlmWRiDx+KPSRNuwV/9DFLL7ufUyIcqLEjJRXTiZRPsX8alr7tepqA==
X-Received: by 2002:a17:90b:388f:b0:1d2:7381:3b41 with SMTP id mu15-20020a17090b388f00b001d273813b41mr2612722pjb.72.1650434851734;
        Tue, 19 Apr 2022 23:07:31 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id b184-20020a62cfc1000000b0050600ab6e26sm18346135pfg.187.2022.04.19.23.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 23:07:30 -0700 (PDT)
Message-ID: <ed6cd79c-6a1d-8299-c90a-5f00064f18e5@gmail.com>
Date:   Wed, 20 Apr 2022 13:07:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/2] Docs: Add cpio requirement to changes.rst
Content-Language: en-US
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
References: <cover.1650376049.git.codeagain@codeagain.dev>
 <16abd8eb6a5c8398a030ae5d8919d5c8e92e2af1.1650376049.git.codeagain@codeagain.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <16abd8eb6a5c8398a030ae5d8919d5c8e92e2af1.1650376049.git.codeagain@codeagain.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 21:48, Bruno Moreira-Guedes wrote:
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index a337e8eabfe1..41a44e5f47e6 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -56,6 +56,7 @@ iptables               1.4.2            iptables -V
>  openssl & libcrypto    1.0.0            openssl version
>  bc                     1.06.95          bc --version
>  Sphinx\ [#f1]_         1.7              sphinx-build --version
> +cpio                   any              cpio --version
>  ====================== ===============  ========================================
>  

You mentioned that **any** version of cpio will work, right?
Or is there a specific minimum version?

-- 
An old man doll... just what I always wanted! - Clara
