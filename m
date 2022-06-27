Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A15D55DD83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiF0GDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiF0GDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:03:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738162ADC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:03:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so3540068edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2JA6OF5giONCzBIvAT6R4r7IVTuA+8tJsxC7EPk7bcA=;
        b=fhfgG34MO+IT6NWt8rwf3YE41k8vuO5mOskGjJ6dAL7wQ4FbbDzTOP8uucNbhn7M2H
         ont0e25yRULr51tOCvV8JWebfaPM9hXuTwmKtSnq4aWv/5f6iwiGX+y5YK1u+mX9OCKX
         9al9eIu7vmVMKYwXaHTc1+IxC4RM1DxBZsbqunBOdqNnpYXQHYU+3kLEg3Ir3mrOoBg7
         +iLp3Vxj1xodQcJKk6XJHgT147kTOSEV2AH/12Oj4BHn607qv9F8H97vtrbu3QiXA84V
         cBdJYfUx/zE9RwdwCzbg/by7eaSrSLLcwJAxBEk13gaMaoblSm7bKwJHvuqCNcYNwC1u
         eXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2JA6OF5giONCzBIvAT6R4r7IVTuA+8tJsxC7EPk7bcA=;
        b=W7B81EziT7Hk8cnlXxO0WRXwzVK2AWWvM5dFjOlNfe0Gm84hWpvYBi5NnocdnxF2Bo
         XKWBPwlrQu5PkLyN7z5t0GNj4EmyKAk2ZCjW98StcgqZczOePhJtU9OiuhkMDAzsBkSm
         b5i/1KRp6m5v+sp412/82N4btGVypxFdzUhAAIRknO37A5kUGe7y2Zj587P/IwRgNJQJ
         UeJeQFC3pBUV7veVwin5cxflAK0qhwL9GIN+bnGoWBI1UxSsVVyGUQHvLYJ/UJf5f8IH
         s0F7OoWx/dTqRswvsr82GH4RbZCkOYR7u1HlaVokq9UGxLs9bETRrtpfKob8oEemqkj6
         w0gg==
X-Gm-Message-State: AJIora/5ni8N3lvhpoenuStOVGO/O/Kdm1lXvSRAm1SF2czdRj+pYL5F
        xxbB8nxOBucafGJtKVFvksmh+sTnp8A8jTWJfmA=
X-Google-Smtp-Source: AGRyM1vzg4Dqa7ba+5JyzVEwAMkquSiLnQj553D+y4oTUcfF+355EaqfbduIYfzvVP8oBM47nGAXPg==
X-Received: by 2002:a05:6402:329a:b0:435:8935:e95d with SMTP id f26-20020a056402329a00b004358935e95dmr14596774eda.257.1656309784872;
        Sun, 26 Jun 2022 23:03:04 -0700 (PDT)
Received: from [192.168.178.86] (clnet-p04-043.ikbnet.co.at. [83.175.81.43])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm4612450ejr.158.2022.06.26.23.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:03:04 -0700 (PDT)
Message-ID: <96171ceb-4125-87b5-f029-9beaaa1d1057@sigma-star.at>
Date:   Mon, 27 Jun 2022 08:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mtd-utils] nandflipbits: fix corrupted oob
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220616073943.669332-1-christophe.kerello@foss.st.com>
From:   David Oberhollenzer <david.oberhollenzer@sigma-star.at>
In-Reply-To: <20220616073943.669332-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to mtd-utils.git master

Thanks,

David
