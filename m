Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7246611E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbhLBKI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbhLBKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:08:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DCC061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:04:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v11so58468772wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q1txYpUSZr7D7uPbcrO25oyFLvtG0YcSl+xSgR678CU=;
        b=s4DG6/X0sOK04u0D7nRFsOCfQL/+jtYSDxqFMxG40EDJ5GuWYXu9WaaowILfkgyn67
         tpytbRin5PwhfPSzENpVbcJkoWuqv7o/sYNS3lSdUMXQTw/Ijycr6ocqgw+ER6iyT4Sv
         fcY969eWHZiK6RecesJ3X6yWxEgPu7x3+gNNUUavMAJT0PaKlShhbiZi2/K3pgobbl6H
         oyZEjOKnYLeazQ+I+4Kvv+ZFLLAgVukJUHoMlGYwb14Swyskhd8d2+E530pOcMiGgrmM
         71TpNzl7Kv2zhq8K7YY9QIGXGifZS5moIgE035IDDdX60qhwJqJjwRRzgEk4klJykMrL
         kt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1txYpUSZr7D7uPbcrO25oyFLvtG0YcSl+xSgR678CU=;
        b=JYIc8Yk3kd11HvKbyQpRP5/ITiy+GI6sjvgZxrnO2rMRkQHXkpgHCHqxEAuCnjpChf
         SyW6jZOURt6vdJjuVTg+HbtMrAm/E6m5yun+jpvkv3yx/8ewPJNp0I5q2kDA+Xrsg/sE
         Aj9U8PU03MFyUkEOdQNnt9XZ8FemC7BWXWNRZjvn2Etnfm7cdUJNaZpP4Gh/VI1v9nwP
         358zU24VxThNVx3CNiruUDMXbsOpMbFo/qx2kuiZBMTgJsw40oMP/kea/5SGAT5qxqY7
         Zea6rgaYXHNqAGiVqMcEt4RTkDiEw7mINk3Ze9C0qPnkS17ONGHdlD/aFw+mQFRl/N3o
         aV3A==
X-Gm-Message-State: AOAM531XOtp3v6ws67idG5Pyg+tl1YaEIDSFqsVaSa3I+GrPrasUJhAy
        pPMOarunP1iWFwDt6Re78aG3/Q==
X-Google-Smtp-Source: ABdhPJyCgBQhRwaqcmFlssyYNHQ8qnwc3j4ps6f61OlYNymOPCs3LjEfvAb7l2WH7H7klJ51hGksHQ==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr12952895wrj.575.1638439487003;
        Thu, 02 Dec 2021 02:04:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564? ([2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564])
        by smtp.googlemail.com with ESMTPSA id n13sm2161632wrt.44.2021.12.02.02.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 02:04:46 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211202102814.793d2f67@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f6e96a47-01a3-96f3-1ed7-e9a42c2b26bf@linaro.org>
Date:   Thu, 2 Dec 2021 11:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202102814.793d2f67@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/12/2021 00:28, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/powercap/dtpm.c: In function 'init_dtpm':
> drivers/powercap/dtpm.c:466:21: error: unused variable 'dtpm_descr' [-Werror=unused-variable]
>   466 |  struct dtpm_descr *dtpm_descr;
>       |                     ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   f751db8adaea ("powercap/drivers/dtpm: Disable DTPM at boot time")

Rafael, will you drop the patch from your tree and I send a new one with
the local variable also, or shall I send a change on top of?

> 
> I have used the pm tree from next-20211201 for today.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
