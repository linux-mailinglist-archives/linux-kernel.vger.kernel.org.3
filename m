Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D059C0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiHVNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiHVNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:47:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131031EE9;
        Mon, 22 Aug 2022 06:47:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f17so4231871pfk.11;
        Mon, 22 Aug 2022 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=raZfW5qhGa1lAPdxzrXy4rgI2GHOmhIqElWAhsqmaYM=;
        b=E49XVIu/QRqTPx7ur4nBHuPqsCmDavAQDxUXEOJXPnNrW+7ItuwzSgjFkfIXJyiJy2
         AiLTbj6CCuwuQ2DWPhN6WF4VwCLCPOf9XS1Uo2J66RmVIBiOGG0FTqjVG6EJc6g1R1rl
         ErmwyhkYlLSrhJByiRW48NeotecFp4RJmdASvJzetoZVH1YNiGU1yudHX+evyB9Fr984
         oiEI/xr4+7GYEDb4AFvh2WgilFGOnlZsODQW4iUriXexjZOkqho7q4T46ZObc25Tseh5
         roD8sVfoOg8VRAmcybzWj+n1oen+DXr/URMGaLlFqvg94O3akXbYLCcuj6YOKbyeKJwF
         peOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=raZfW5qhGa1lAPdxzrXy4rgI2GHOmhIqElWAhsqmaYM=;
        b=euivuX7TL91oFKCbRttqQ9vdpLRmyTNh030LfQTTEFNSP7sYo8Tncg50mnipF25/9y
         Yp+Ef8fcDqGeYqilnlvifZXT7eHdbfHAl+aRIZFJyxuUOsrrB2cXEZbqxT8S3tIzweDn
         cdfTL5QmTn4f8pXjAzv1Tv0jezmgvSEw5pxglkSSaQq6LjiQelkTZnKXAUZGJVUU57c6
         1n4ZPK6VP0e3XKtJTfS2VMYdFBCJPerLk3FIt6JFq8RyZ4fSPcsvrzRxOsjZW60vn/fu
         ghyUanCzxm5AIUwf9VwfG0iVvtNAYwAnJTc4TjaHSobuO2icKBjv46I7/Jvp1zPA5evK
         vDvA==
X-Gm-Message-State: ACgBeo2V6zUy7opND8qrJ/laZbL3uq9Fkz1MG/XZT+rReWATgGxvdW3n
        J4xNnRL1Z8RhvnEL6qJ9olM=
X-Google-Smtp-Source: AA6agR4Djl6tx2sG5mrKWlAWQYBFugCmg8G2UiMkStURWNravSm5XtqrcScee3tsznilgZW5flRCNw==
X-Received: by 2002:a05:6a00:228c:b0:536:b82b:e427 with SMTP id f12-20020a056a00228c00b00536b82be427mr3841996pfe.17.1661176037192;
        Mon, 22 Aug 2022 06:47:17 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-77.three.co.id. [180.214.232.77])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a150700b001eee8998f2esm8008988pja.17.2022.08.22.06.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 06:47:16 -0700 (PDT)
Message-ID: <d75aa75d-92e5-f946-8b41-fd63a6169eb5@gmail.com>
Date:   Mon, 22 Aug 2022 20:47:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
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

On 8/22/22 20:44, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading
> the sysfs configuration file.
> 
> Following are the types of events supported.
> ====================================================================
> Bits    Description
> 6       Dirty Victims from the QOS domain to all types of memory
> 5       Reads to slow memory in the non-local NUMA domain
> 4       Reads to slow memory in the local NUMA domain
> 3       Non-temporal writes to non-local NUMA domain
> 2       Non-temporal writes to local NUMA domain
> 1       Reads to memory in the non-local NUMA domain
> 0       Reads to memory in the local NUMA domain
> 

If the table above was in Documentation/, Sphinx would flag it as
malformed table. Regardless (because it is in the patch description),
I'd like to see it properly formatted.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
