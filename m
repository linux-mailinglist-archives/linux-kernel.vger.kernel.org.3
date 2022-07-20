Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7521857B5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiGTLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbiGTLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:36:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745827B06
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:36:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so20327982ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8JR2ECyYxmN35RFd5SrCTVxKOdG45EzqZkpsA8QsVdE=;
        b=xOMP2RrsE8ugvnKBFVqwI+ss0ReF6fDz4gcrCWiTIx7XEY9+csz1EByJ+j94LWPvvx
         HXimRsFrQy/FMChogZUZqa8ZpqzweLOX+xWGqVUqV+uQQj1EtuA8Xg6TgHIboRbSaDej
         MEIrd7rknL9TDtEqPpr14bYK3aVHBzVyER1fs17xxgMTEn1TaVFP47m+zzXyKM31HVul
         Swu32R2tcj9gfdABNU938Dd+G1DOj/9Wg8GSZzKqxUI7KSLDvmu7hMhGp4K2ZBxFAuk+
         8hxZ/sZP7uw5yPUR+AJZ4J4N0PphvAzi2sZ+hAH0ldIny8q+dcQnr51elKi950oSORAw
         NqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8JR2ECyYxmN35RFd5SrCTVxKOdG45EzqZkpsA8QsVdE=;
        b=PRFpXfSUS4bbptY1qb/sFeiU5BA/J9mHupKMK0SDLar5qe14T6f5X3Euw9DhzPGRQ9
         Il9RIZSqqqTd0Zz4JDciF2RZ8WgXZJVUZdTMzpRhr2yozeM5/YiSSWolDCUaBPzWQT+Z
         6FWz9dVwUOTazmIt46u6/NSSizI4dbCW2yhDj3dN5xPky4LAXXNRM6qX1gFuOHCraPX5
         lC9bKyBFMOnQ+vT9+Lmdb15syxf0UYwTtYh+HbUAAEqkV4PZyHTrxbA51G3Ygmc7wvuP
         QZIOuWdcavroEUATDpq8fpruBwCHRf4X8vMd538Z8g9jHUqpHbSWOb9CTxggWs4gi9uV
         xWpw==
X-Gm-Message-State: AJIora8YjTtMl3fhfXwLuhKVjl7x2vKRTkY+OdMqZsE4iY92s2ShEHla
        JXDLgPgTjYF67CbWT7kqeiF91A==
X-Google-Smtp-Source: AGRyM1sMbbgJGNG0adjKaDJMPd779FeF8nkPx0z1CN5xoI7Fnf9noacPqxr6kq0Lq4jd0WH/jiqjZw==
X-Received: by 2002:a2e:8182:0:b0:25d:72ad:43a5 with SMTP id e2-20020a2e8182000000b0025d72ad43a5mr15957341ljg.180.1658316964713;
        Wed, 20 Jul 2022 04:36:04 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25c50000000b00489da2806d0sm3739346lfp.131.2022.07.20.04.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 04:36:04 -0700 (PDT)
Message-ID: <b605fc88-a0f7-b914-0d4d-49c8415e1016@linaro.org>
Date:   Wed, 20 Jul 2022 13:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: clock: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, david@lechnology.com,
        nsekhar@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220720113139.17982-1-slark_xiao@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720113139.17982-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 13:31, Slark Xiao wrote:
> Fix typo in the comment
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---

Thanks for the patch, but it's additional effort to handle trivial typo
fixes one by one. Do it for entire subsystem... or help converting TXT
to DT schema.

Best regards,
Krzysztof
