Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0244D077E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiCGTU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiCGTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:20:22 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DADD201AC;
        Mon,  7 Mar 2022 11:19:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z15so15097012pfe.7;
        Mon, 07 Mar 2022 11:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lOZW5pkqy2TV2ethaCBn0EQ6/ovM+WxW5CYEaBMXdvA=;
        b=dPzrZqcx4umQIHSndsddGoYcCqRqZDmD+BMg0InGyj8am3DJc+hxvfiI+qEJOKmZ+J
         lhJR2Ed5tvKPjh9Ko2nmwUF+cosJ/QP3OsKdmXc96gVyMq9j0D7gnl68oNobz7gFQV8B
         op6Z6BkFyV1qXgDFvbVR8bscHumChTHf1DkYEUYAKAKDSICZ5XK4StZn98VQPPOJX9UA
         vrT4ABhc7mf39oBisadxmb0/Il+EqPdQAelGa0qKrRbHZLQD/sOH4O7d2+mzzCAOaO32
         z3VbhTWMmZfUNXKHiW/YmHlQTqi21AZd/dHmKkedd0AviqL9eKeq/ZcLWXvCNnyh3yMa
         c2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lOZW5pkqy2TV2ethaCBn0EQ6/ovM+WxW5CYEaBMXdvA=;
        b=ZooPy11FhnzgFrT9C86Ys4w/bxXOXCLde7/iVf7oB5FHBBE+Hnky0BPNjOs0VNklI1
         YhW8Cgixx4g41La+TeDcrYSKtP4rONGaaQ288Dfn5tHg2uHSKMx2JC2ZaK1gRoKasRAr
         Mbl9EcnJ7rPKFtDwGfQBgz1jOM8F6/JcsI5FpzlGQlAeRGtpmaHmffhs5mJ4WtNQcsIK
         Nldb/SwvSgrySYtzHMPCaWVMx3trIPFrdbOjHU8Z9zoR5udGT/wnUWNtgvNWzVHoSa+q
         IT5O1ofA64uas0BBYfxn9ytjhVyU05NtNwKyZMM6p9NuBlbFcE+AjbDAW5xT5iKkBWI3
         uIEQ==
X-Gm-Message-State: AOAM533d+Mr0mVGrcZrnCRDATOQkKCBQrCPmxL94PgbAO1Tgg0MRhOoZ
        7yecBZEd1yrSViVTd8s5A/g=
X-Google-Smtp-Source: ABdhPJzFyICYLnK7OsGVnyCmU9ajih0U1JjUNoh8Rn7niSj9uFgU/qycMEVbPuZmgxYbb613ypUTKg==
X-Received: by 2002:a05:6a00:1acb:b0:4f7:7c8:8818 with SMTP id f11-20020a056a001acb00b004f707c88818mr5506527pfv.42.1646680767944;
        Mon, 07 Mar 2022 11:19:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm16664421pfu.56.2022.03.07.11.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:19:27 -0800 (PST)
Subject: Re: [PATCH 1/3] MAINTAINERS: Update git tree for broadcom IPROC
 boards
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>
References: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e08f2e52-0684-89b7-b1df-f27e4c0d74f2@gmail.com>
Date:   Mon, 7 Mar 2022 11:19:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 10:20 AM, Kuldeep Singh wrote:
> Current git tree for broadcom boards is pretty outdated as it's not
> updated for a long time. Fix the reference.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Applied to maintainers/next. Please use scripts/get_maintainers.pl next
time though, our internal mailing list was not copied, thus our
patchwork instance did not pick up the patch.
--
Florian
