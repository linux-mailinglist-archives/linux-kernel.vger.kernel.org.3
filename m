Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD564EA802
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiC2GkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiC2GkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:40:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3B1DA8F5;
        Mon, 28 Mar 2022 23:38:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z128so14013912pgz.2;
        Mon, 28 Mar 2022 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=cih9eRaSIxbxmILbyn2YR4alicmKyfBJFHiUkf3CDZk=;
        b=mcH+8nMY6FAMeK9TDj5Og3uT7XJOfTq2a+8r/uAmhySpfieb2bx+P3UjRNU/mGrHss
         43KZkCTLh7Iovpi3+enSGNqZwJHmTniXBUGyOU+7swz9qxfCS950DYfTj+5jmQcLBMHM
         gG1Ju6nCyOUlLfeWpTUJ7iH2xc0wzlAd+0tsptRGA46pgcMONpp3iPYO19WbfEMHPX3u
         T25XLls5oIG6KtLY5EN0obzi24MtfEqgx+dJFIg/SO2m+bs4NmxpFFq2hwUvRGIa5lrN
         WRNDkmNFpgt05anwQfbcVHsbWBMJv5U3TjNuGDm0Dj2VEcapcdknVuaaiJRaRAWMxzGV
         dCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cih9eRaSIxbxmILbyn2YR4alicmKyfBJFHiUkf3CDZk=;
        b=ggfJ/9VLAyjpYs4qpxfKb4d70EiSdEVCMxMx/EI6rWmSlscpxNcHeLpgEqruDBkXq4
         Vy/C7/wxz/79VkId0uiUMkM8oe4GT6lFwLKM2ccIaTQO/RkqzRInt8kZHR7kUVAUqf//
         WmbuUFfkEb2wWYg23dK9NSbN5SJ5MDnGy8kC8ljOzNJzFjriiN3qNitIfiNc6vvs2QJk
         3Rc47chMkFpo0ukvkWT5+zQpLiy9AFDXfcPVrxpHVJ3ilXo6nP+XqtxN5Q+XDTyQyyaq
         s8++uY5mZ5Tx7lqNpejmyBdvc5suBErAgBBa/XstHa2al6uIn1okNmKdsQfr40k6jdl6
         lXaw==
X-Gm-Message-State: AOAM531sXrNfsL2P/UaehwUSOX7+CoIV9aWaJtzwJoq508YnRyb9672L
        7WvyaG0H4fEnwV6jE104m1k=
X-Google-Smtp-Source: ABdhPJwW8ERIPKusBttDrjsrixouKMZeP5JnAJ4YeR9XngS5sp2SqudKSmkChfNpARzLmo8eQFWzSA==
X-Received: by 2002:a63:214c:0:b0:381:1a27:fe1 with SMTP id s12-20020a63214c000000b003811a270fe1mr918595pgm.328.1648535915132;
        Mon, 28 Mar 2022 23:38:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id 96-20020a17090a09e900b001c6dc775159sm1504349pjo.46.2022.03.28.23.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 23:38:34 -0700 (PDT)
Message-ID: <57f74780-6520-f2a4-8551-74c4b0986ac6@gmail.com>
Date:   Tue, 29 Mar 2022 13:38:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 2/2] Documentation: x86: Clarify Intel IOMMU
 documentation
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, vasant.hegde@amd.com
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-3-alexander.deucher@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220328172829.718235-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/03/22 00.28, Alex Deucher wrote:
> Based on feedback from Robin on the initial AMD IOMMU
> documentation, fix up the Intel documentation to
> clarify IOMMU vs device and modern DMA API.
> 

Maybe we can squash into [1/2]?

-- 
An old man doll... just what I always wanted! - Clara
