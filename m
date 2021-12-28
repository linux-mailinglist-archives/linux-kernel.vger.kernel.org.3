Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF848098D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhL1N1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhL1N1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:27:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53397C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:27:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v16so15965873pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gk9FWtuyNYuvWJUQpOrkgSFfOKOr2DlUz3fKN6vSpSA=;
        b=i7TR62PGp8keW84EIsX4LeMipOhUxlwOcd0XO3h1LXaEVMbQlXEnmPFvZRqTFB1mxu
         EHZi0qAr7Q3ce4RxicfOQhjbfpCWAPIgIyceEhvlcOKzYoK5F84CQ1X1OnRhfL8sMSyG
         kTDw/aZvnCImyRAoVF0KcDp8HHajOqfxe02GA84xq+KgcpG2LxsPJ1NEEDW6yye7ay1K
         vxJPOQvCM6x74rSTAszsnb3zf2yd8MPydJU/qCc02HXdNDJVaI6jHbYoY2F5ywmUWUaN
         u+E1Xd4xwuGhiRohF0yN+TAcbb71sDsRFT9YTT6l2kjzl30hUthk9gIM3e0HYBDisLyQ
         8QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Gk9FWtuyNYuvWJUQpOrkgSFfOKOr2DlUz3fKN6vSpSA=;
        b=HuV2HNSpeonBmyruFP3Oj6vQGGXHEeFyYH186yoUj2mUTFSYtXj9DTTEzB6hfntVru
         OiSV/qI7370OkbPO3jJhepKQ3gpeJAsKErf9WWhyeXcosYXNauhK7j0loVQWZk5v3eRJ
         R1xSFvIJPfxxZ3SlgAzClz/hDYDbAxh8FG3wBdU9RdpjKmLlqdIHs00CMnl9nCw8ed/U
         LsOL+nhzumCctwniD0mvM3BVuNl+AU67d0nZiMuNCVbcmKjAmBgZUs+OtCmBAqO4/k29
         RVb+Z3PKGG+aZWTi5sbwFz+ljexAVSmPr+MFCu7wXQvZXo2Jo3ShH+ApjULinI2TyrWZ
         +f4Q==
X-Gm-Message-State: AOAM532LT1jqrmSJVKQ0CzzRx8O0aYdN8PIn+n9lGM2w3TeH1Lgzyvdm
        InLhvjfqQSK7eU/oiWEnLz0ILg==
X-Google-Smtp-Source: ABdhPJy6W4mQXQOtpEeo7p/zZpw+kr1zvE+7qasQ31P02hYukS2EN2q2RNA3CJ8xHkbkqJICI3YkxA==
X-Received: by 2002:a17:902:e805:b0:149:95a:1983 with SMTP id u5-20020a170902e80500b00149095a1983mr21956401plg.9.1640698072887;
        Tue, 28 Dec 2021 05:27:52 -0800 (PST)
Received: from [192.168.1.32] ([122.164.22.119])
        by smtp.gmail.com with ESMTPSA id m3sm16977120pgj.25.2021.12.28.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:27:52 -0800 (PST)
Message-ID: <e48ec1bedf1e02e3b3230f47d8b8a3361cdad992.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.15 000/128] 5.15.12-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org
Date:   Tue, 28 Dec 2021 18:57:46 +0530
In-Reply-To: <20211227151331.502501367@linuxfoundation.org>
References: <20211227151331.502501367@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-27 at 16:29 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.12 release.
> There are 128 patches in this series, all will be posted as a
> response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Wed, 29 Dec 2021 15:13:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 

> greg k-h

hello ,

Compiled and booted  5.15.12-rc1. No errors  from dmesg -l err

Tested by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology - autonomous
