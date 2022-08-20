Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73DF59AC62
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiHTIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiHTID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:03:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A3165BF;
        Sat, 20 Aug 2022 01:03:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y4so5878862plb.2;
        Sat, 20 Aug 2022 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c/T50bv5wpdPtILZzxvqohnY4keOYpr50uC/TDN3ebQ=;
        b=B8N7y9blSkxvD3W9s/UNru23tAUCxcONWOPb8rTTj8Q4KhjwmljQKe16UtQM93V2nP
         TbsZCa6JUHpHCToH5FjpAPugXsk4VBx09oEPuJ+qln5ZYHRkZKVjHzA+0xDocyqyFMJV
         Cmob1V1dmKYFJaN8Q6V2zGvDo457CkFeHFkq4N5lBT2xKT0b2DOHJWMbSmLw9d8kwCQm
         VaYzsN3+fzBp38sH63dMQS7fo/fyBNZDIBPqqiuZ+bWx3kzOveNtiJuAzZadDF4lOmAv
         VUuWuSgB1lwDYX5yFeiP44NhS0vcMobYt7L+Hsu4ZIVBCuk2XP/HR1JVfHpL6ekq2mg8
         ClFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c/T50bv5wpdPtILZzxvqohnY4keOYpr50uC/TDN3ebQ=;
        b=SVbwG+/ZmTr67yN47cFS514OeKBjqYr/tluuAVriO/7vP3vPvyPIjSsT9PNlIhjhPW
         WcV6QiAQNyqCu5PjPozzaWfiScF3bsFELQkZnytCPWMym45eXfiM5d+F8FYXsf+rtB0W
         8ptyyLsNTjstpB8Gi0Qb1bA6zxemceI7whXTk3Xp/HJ0WTE+Qy6h7hqSqN8I1XWsU9dr
         eYExecGxy86ASTObnlmGjdK2WK9+B55NkAxbjL+JtWg3FM9L0wjFNlTCLr5ZVqAPRlRZ
         V9QC/I593+rrOltI3HNcTadEHvgbkAQY5XRHeClSZct3fgxPNUTAXm8cMbhDCrfkw14J
         tjNg==
X-Gm-Message-State: ACgBeo1vTyqhrOnAi4LyDIF/3dOg+97fVNBVdP4uFRVNMKoA457qZfFM
        gAdA1bPYTuzRcrMur4cbLNb7TBxqx8s=
X-Google-Smtp-Source: AA6agR6x6nEO1XVz4OaT6zzmKtH6rMVmORnxVC6juWgptKO819OHmuh5hVq59mKPacvgLCher7UA2Q==
X-Received: by 2002:a17:902:7208:b0:172:a9d6:527 with SMTP id ba8-20020a170902720800b00172a9d60527mr10903537plb.32.1660982605625;
        Sat, 20 Aug 2022 01:03:25 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-78.three.co.id. [180.214.232.78])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b0016dc8932725sm4387488plh.285.2022.08.20.01.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 01:03:25 -0700 (PDT)
Message-ID: <86a26310-eae0-35e8-ede9-e71825db1416@gmail.com>
Date:   Sat, 20 Aug 2022 15:03:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Content-Language: en-US
To:     alexlzhu@fb.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
References: <20220820000024.2494003-1-alexlzhu@fb.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220820000024.2494003-1-alexlzhu@fb.com>
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

On 8/20/22 07:00, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> Improve grammar on MM concepts documentation.
> 
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> 
> Changes in v3:
> -Correct punctuation based on previous comment
> 
> Changes in v2:
> -Correct the subject
> -Adjust the description

The changelog should be below the dashes. Otherwise LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
