Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CEB59CF28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiHWDHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbiHWDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:06:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00C05C9EA;
        Mon, 22 Aug 2022 20:04:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f4so9278082pgc.12;
        Mon, 22 Aug 2022 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gmsME/xNmhSqLRUEPqjRkzGKXVlvKjoR1g7dAdDOn3M=;
        b=GJ67RVWTapjI4MKqXYttKtfweWLjlS9bN5zMO5ihhuThwiUuvEhnxd95v6XoiWgzD/
         nxQHA1XA/0yq9ik3Tg9jkWq6/Oh2MjzFaHVMzGeUqjgZJrkMn5x1z5xHX+6aPePM55oz
         y9ezcVhO6aqWftuCmAIqlJxmw7FA6RVx/iLVauaK8MM87fR28GwtJe/CdHIHhhXaIXIG
         8AkV5XPyuJUMyIMS0opfSuBdTRt72SAWPOZ8nbcv/f+fTATu7vBkozOaerX7MP+bwRYA
         TCJ7LNS0SRPosAj+U6UGd6LHe0xaYOPWlalrZmIorPji09gwL9rrRh5K1iPprRfpOTmD
         u7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gmsME/xNmhSqLRUEPqjRkzGKXVlvKjoR1g7dAdDOn3M=;
        b=B59pzk6RCM7fsvxKR++rxHOOQ2WowlUVa/gBI1PThgBrBrfgUnH883IRPUvbV5oIei
         qCmvncNZGtF9Re/HqvzNLX94A/BTson+RP5geT18MVRiRRQk0f0BOIDBidmNsykfZ6je
         dDR9o0HbFI1+uGV4z9gmWpgxwrefYzMoxokcD5NWNYD7buGZvHRK6aGezgbRDnz3X3gt
         jl6Mm1mE9AmUyUT9vNfEDwCIhGiCdiXhxhzKzJG6tYztJ6xN58zu17GAZqCI77P/12mk
         HOT1ZQlaBfwmg03LjkNrCPeQHq391uxwmxyIzcKhgIfV/sDqNn/2b7z+RphRV9ohBj+Y
         R2vg==
X-Gm-Message-State: ACgBeo0019moLkGcMSoxxLWjOUK4PUZll3uMcz3fpPNdd4r8/LB9GmRm
        J9YqQs0NyE68WTPv5CZVgBQp7HNXog0=
X-Google-Smtp-Source: AA6agR6GEJq6gQoy8fravQvklgl5/4GBrpi8DbRN3zbyEw9B5n2/hM3Tkxa5lPRr1lMd3UK4EdyPxQ==
X-Received: by 2002:a63:2bcc:0:b0:40c:95b5:46a4 with SMTP id r195-20020a632bcc000000b0040c95b546a4mr19027549pgr.535.1661223883957;
        Mon, 22 Aug 2022 20:04:43 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id g29-20020aa796bd000000b00535e46171c1sm8714745pfk.117.2022.08.22.20.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 20:04:43 -0700 (PDT)
Message-ID: <a2d5343b-a159-3e6a-67f8-868e85f51222@gmail.com>
Date:   Tue, 23 Aug 2022 10:04:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Content-Language: en-US
To:     alexlzhu@fb.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
References: <20220823021941.4021897-1-alexlzhu@fb.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220823021941.4021897-1-alexlzhu@fb.com>
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

On 8/23/22 09:19, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> Improve grammar on MM concepts documentation.
> 
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> ---
> Changelog: 
> 
> Changes in v4:
> -Adjust changelog to be below the dashes
> 
> Changes in v3:
> -Correct punctuation based on previous comment
> 
> Changes in v2:
> -Correct the subject
> -Adjust the description
> 

Nicely done. LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
