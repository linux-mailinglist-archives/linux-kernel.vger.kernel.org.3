Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD933596E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiHQM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHQM25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:28:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944674D26C;
        Wed, 17 Aug 2022 05:28:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q16so11850851pgq.6;
        Wed, 17 Aug 2022 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=z3KPVMJ/zbBV6Xu6pGeHORE5i4JgT+Cz6Ssw7JrD6GY=;
        b=k4tvbUiIFuXz2zhECgDTAIEVBO8ErHpLVDIPn7Giv525jcUzfzb+U94civYPpqlCSO
         RFRTxwVKxX1R1LG+dj2uYo+WPESjJNoRneOWzyLiGg93NxzxyMjkOsvxG5Xj0M2jomNP
         w0kEoeXQgNhVOGEzUfITeGOAM2ZbZIM9i9hI5YKC905Nq2yqVCRc/mcYtBPGal48hgnF
         6wonXbDzKtEzutgLo5KRxWLLbE8GTFvH8Dvl5mgMmS2EspHZUX7MZ7/kSaqHG7eFZJtv
         ucqot3yEtMrmp0KeU7WRbF7C3BbeH59SaMSK1lk5qemauC94KTfkbObrI79ODrMqCfld
         JNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=z3KPVMJ/zbBV6Xu6pGeHORE5i4JgT+Cz6Ssw7JrD6GY=;
        b=MVSVahbRiqMH3qgvovCyVQSZz6aqG3o8UY7bsxeKgr4p6MdmfvUn9Ag+EDAI5QnlHV
         fpeohidRGlF7qjHhD/89qaqRbA8gHxfPHJuu3gOInRmqkMFgWpbyTfbd+R0YQC7W/n6+
         7+ZIDefpcxHV3MdVEXhOq5VWP3y6MX9/pE51cG7PlSqLyAxUR97CDLcBjBjU/rpYmN7h
         2ukn2LABm+p4kwW13nNdcWojZdDStST1o4E/GQ6TW83x3d0FCk+v39FSt9paXkFHYG2O
         fRkUC9qRSSWsiinCEWGldqLSpwzZ4pl2wxpSLM9m5IrbGmbnusBfWZP1PswF7h9uK1IX
         TnSQ==
X-Gm-Message-State: ACgBeo2Wu++1RRBRUewnGvY6mKHlFrQeL1UgFfzWxG3yOvm4exEqh5eV
        Nxp2eZTQwFPDm2PU1lGKcHY=
X-Google-Smtp-Source: AA6agR7b/UkFuGBIRIFrHOSbE3E8FbiAfWzIbvRSxivm04qgq69cnWezNL4GfoyM90RtdIMsDK+nAQ==
X-Received: by 2002:a63:18d:0:b0:41b:20bc:3139 with SMTP id 135-20020a63018d000000b0041b20bc3139mr21167467pgb.521.1660739336085;
        Wed, 17 Aug 2022 05:28:56 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-37.three.co.id. [116.206.28.37])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b0016c46ff9741sm1420704plh.67.2022.08.17.05.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:28:55 -0700 (PDT)
Message-ID: <e9b97ea3-0867-d09f-ca59-362931073c9c@gmail.com>
Date:   Wed, 17 Aug 2022 19:28:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] hwmon: Add the pmbus driver for the TEXAS TPS546D24
 Buck Converter.
Content-Language: en-US
To:     Duke Du <dukedu83@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     fran.hsu@quantatw.com, charles.hsu@quantatw.com,
        george.hung@quantatw.com, duke.du@quantatw.com
References: <1660718497-7315-1-git-send-email-Duke.Du@quantatw.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1660718497-7315-1-git-send-email-Duke.Du@quantatw.com>
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

On 8/17/22 13:41, Duke Du wrote:
> make the PMBUS_VOUT_MODE return value 0x17,
> VOUT returned value is linear11.
> 
> V2: Correct the tps546d24.rst format.
> 
> v1: Initial patchset.
> 

Seems like the patch description is just the changelog, which
should have been put between the dashes and diffstat. I would
like to see the proper description.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
