Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427659CE20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiHWBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiHWBzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:55:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB445A8B4;
        Mon, 22 Aug 2022 18:55:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13056255pjh.5;
        Mon, 22 Aug 2022 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0EIzSvniEU8Di6h9z2X0aRQ8+RtMeXbYmqbE9+Vumnc=;
        b=o4X4LXPNSkjvTbPIB7yxc1tkDbDZeQ03qvqvqbyDapXa7JEUzDw7ef2koEg9fHe+l4
         MKrk9CYDewk/3kbf3d9ffqWnDUFrFoXD4l0plfJ7KC6dvurVARidXNFWqrHcbmfJaj9s
         +7hsvxWMx5vPguIoc3hDxUhLusD+Zwg0aJvsWkMu7dDAqFrcbZPR6SbTYxVeEOcipMRZ
         FpI94LEJ/PgHqKUORPmzCtghmnDKVgh26v0elI/irez65MlsJ99prHBqLp5dDnQYWtKl
         PSztblWD8Kb0rJTT3Eom6dtFIog8MyHKRDugFVJRSgnzeehyzw66CywFcGK39SWRvHPU
         bhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0EIzSvniEU8Di6h9z2X0aRQ8+RtMeXbYmqbE9+Vumnc=;
        b=J1haCADDJEJ7xp7NIfOvl849PEGfAQbTajkgDbpV02TbnHUjqdcVhmLi4NPekr1PZs
         KHXwwHX/sFDowwBg5D/2y3VIyW4NZz9iKDp7+agC3eFsEuDWdv0UNNHVn5/OFo6tiCio
         jybGPI3lgQyDIbzCZNCL3TgQKaTNc24LU5wcrJ99FYBn1uAlQzwxIjTlzhqyghbtj8wV
         TZfQlfkHmGzKZ7Za2ioiVvEuukFRTNmrf5TpieNaxUNrOLPxYp1y1MVKjp6gsl7DIfmJ
         b8QLlAH5TJ4PtZYNChu3U+bMxQ1J9xwCKVjsoRsOgtKqArl8u/4xZAnTfg1xR8tJf8a1
         bObw==
X-Gm-Message-State: ACgBeo1L0uQxVEa+0EpKkKSXJ9JNk0XjPibzzFe/kjJV/Rr6QyVAkiuc
        7Z5ELEXeX0MadzI5wfKaULU=
X-Google-Smtp-Source: AA6agR6MSWizYm99GZWo8NaJDMWMME8XtDKLq/5QNYW1LBPiOspGSYzLMdIoEZbPc26eHUkFRyCGZg==
X-Received: by 2002:a17:90b:3e8b:b0:1f5:8706:18a1 with SMTP id rj11-20020a17090b3e8b00b001f5870618a1mr1114711pjb.112.1661219752979;
        Mon, 22 Aug 2022 18:55:52 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b001709e3c750dsm9102012plg.194.2022.08.22.18.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 18:55:52 -0700 (PDT)
Message-ID: <6e0a5b51-06a0-b84c-3bd5-048be028f1e1@gmail.com>
Date:   Tue, 23 Aug 2022 08:55:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     babu.moger@amd.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
 <d75aa75d-92e5-f946-8b41-fd63a6169eb5@gmail.com>
 <9888d756-4bb1-a48f-3301-5dbd00bf6530@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9888d756-4bb1-a48f-3301-5dbd00bf6530@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 20:55, Moger, Babu wrote:
>> If the table above was in Documentation/, Sphinx would flag it as
>> malformed table. Regardless (because it is in the patch description),
>> I'd like to see it properly formatted.
> 
> Actually, I ran "make htmldocs" and didn't see any warnings. I will try to
> fix this though. 
> 

That's because the table is in patch description, not in the diff.

-- 
An old man doll... just what I always wanted! - Clara
