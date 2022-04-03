Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E274F0918
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357013AbiDCLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiDCLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:42:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C43968F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:40:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d5so12393807lfj.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1nrGQ86+KEfI8lMZHBguNMUxlHPTUJKQmanBNJ/nGq4=;
        b=nrd5SfiyZHt+2ltkwlDZXu2oumrGC+NMBOQ/IBLNU+gIu6YJu8jA19ISD3U+v3LA1S
         9IACzs8SvEQ1WW14Jbta4JwBp/UjPB8fLc1d0zznwG/1w2ddswHs9P0ojyqANVTnTe2z
         Vskxb2BeDp5Cwa/53oGVW8hlucug/+jrM0GzpGJQqt2kuUVP9wNHGH45RUa+39QPNWdD
         WkgniIt7vt+zWelIxTZ9TIOZr6AnG+u3b9SyY0WT8Qf/oiKpXgJZRQgQnDlM/9M78E06
         BWBo6KJXES3KlnqYZKk2IOebIxGYYuSOn1hi5AXuhzCOdD9tvw7k3BM7v1ShjOI4cxxX
         5mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1nrGQ86+KEfI8lMZHBguNMUxlHPTUJKQmanBNJ/nGq4=;
        b=OWkUQOA4ilvrcb0mgA/pVbp6NRPnVdPzpircj7VdV75+0OVdIDpEb3me6v09zNiDMn
         NVU15X2J5sRK9kua6t+lY49HAjz/qzJQIEmioP8zobSpjr5POrqMCsRo9F+SHPBD+Kv7
         8mWnpmu7QlznoMWHwSDdGdQRzzjy3Q/Wjb/+CswZbg6FZ70tM4ye+aR0KpetG8XtfQsw
         5eZuG33mf0AyQ3ztsQhNc/RPWVFHrAT4w+/y/u5REWOHaQJBSN1Wvv2/e8smgiOU3dLM
         WRGfI/O3ynXABZ2Wv9JMsZEklMHeI34+RTd7nLhNLScrUgQUSziH1I+74e75l0Oi7IVc
         7LfQ==
X-Gm-Message-State: AOAM533QgJRR6woTSVSlmWHZnkUsM6b1gR7uBR+UGMRAzLyP23Z8O/3l
        4EaOfBBP8I3G8hKHTsYyXd8=
X-Google-Smtp-Source: ABdhPJwk8/p4WUYEA2KWURqU/C11tiVOeYaTBCJOPUuJRAD9MHy7EXAvT660DPGpD84+WTu8EoQRsQ==
X-Received: by 2002:a05:6512:b83:b0:44a:9fb7:784b with SMTP id b3-20020a0565120b8300b0044a9fb7784bmr19016074lfv.547.1648986035922;
        Sun, 03 Apr 2022 04:40:35 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id f11-20020a0565123b0b00b0044a2809c621sm803729lfv.29.2022.04.03.04.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 04:40:35 -0700 (PDT)
Message-ID: <0107f709-49ad-a0c3-916d-0f7b32991a0d@gmail.com>
Date:   Sun, 3 Apr 2022 14:40:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/7] staging: vt6655: Remove unused macros with CamelCase
 in mac.h
Content-Language: en-US
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
 <646acd285c1239f301692456bd9f46eda449d02b.1648882847.git.philipp.g.hortmann@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <646acd285c1239f301692456bd9f46eda449d02b.1648882847.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 4/2/22 10:29, Philipp Hortmann wrote:
> Remove unused macros with CamelCase variables in mac.h as
> they are not accepted by checkpatch.pl
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---

You can merge 1/7 and 2/7, since you are just removing unused macros in 
same file.





With regards,
Pavel Skripkin
