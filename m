Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0D49E99E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiA0SFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiA0SFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:05:40 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FEC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:05:40 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p63so3717923iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y6t/HLJoZRMAq0YMzTaHPBGjeHGV6rmgV1hXLsNEaXA=;
        b=LHvGtJfXMpZK44WF9ZY005FpCS0vJoSKvY/Yhz1zaVSMBWug4MxCWXqoeyn6IBVnMe
         A+cT1RvoyL5cCH5d4vEPFVJDcGfznTASOTOh3uiJuWQ7aPAd9prAsIJcSU4dPJhk1sTc
         TZKgn3WDfohEglxJIr40gILapE9RdgW0xW41A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6t/HLJoZRMAq0YMzTaHPBGjeHGV6rmgV1hXLsNEaXA=;
        b=TftaIKQsaAbstlEtLnz8A53I4RYTjq0GzbXgZGOMge+l+Cc0BAdWjkseX4XDmY62nY
         vJYvMKXchbTUTJ5uyzF4EPB3a1f0dSvXqgfdpOyZz9ZQOebAerW4II58zaVrBilMokPP
         MtBwhSepNE540Mam+KpRQcJEQmfcVGSNjz3vM4kw9PEpCvRKUELLnCrZLojQN5e7r1bm
         b4qf6SoEfSKd39yDZEXD/uovPzZEFP+xWHUzSvXCUsO0gcxFjHPxTsoiHP7gSV25wFwK
         0+D2ieySD4vK6tXMoKxje5JVRgqrIsodR3/1UH4wzv7fOVBk0ClO0KWgrtCvWiPSZb7b
         ZNIw==
X-Gm-Message-State: AOAM532lUYL+yS52XJk8twCU+fzCev5lSA0QRRcKKr/VZX94WRpLi4du
        9mR6GqTtbtemCmtDUBFmrY42gg==
X-Google-Smtp-Source: ABdhPJyy3ckcWni8fxqVjws57TQznsXqmVAuFW5XVh2tNilQYn6vCrZg3TBfS5IFonuSZc3+ohw7VQ==
X-Received: by 2002:a02:a519:: with SMTP id e25mr2431138jam.315.1643306740176;
        Thu, 27 Jan 2022 10:05:40 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id w10sm4115625iow.44.2022.01.27.10.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 10:05:39 -0800 (PST)
Subject: Re: [PATCH v2 1/3] selftests/zram: Skip max_comp_streams interface on
 newer kernel
To:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        pvorel@suse.cz, Shuah Khan <skhan@linuxfoundation.org>
References: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
 <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c3410567-7d69-9020-8477-a8ba957505c8@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 11:05:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 2:11 AM, Yang Xu wrote:
> Since commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram
> has switched to per-cpu streams. Even kernel still keep this interface for
> some reasons, but writing to max_comp_stream doesn't take any effect. So
> skip it on newer kernel ie 4.7.
> 
> The code that comparing kernel version is from xfstests testsuite ext4/053.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Thank you. This and the other 2 patches are in linux-kselftest fixes branch
for rc3.

thanks,
-- Shuah
