Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8A46575F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353094AbhLAUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353265AbhLAUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:48:07 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:44:12 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so36984505otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=vSYbfez9sMrWNW9h3VuOAA21Ecw2U6/iY7XbNqz02Nk=;
        b=T6Bfw0WHodAjJ4sJoSiQCgAo/kLrJlrN6GWUKaGtYt4+5k5Olk0VzgU+NqTlym0Vez
         vrGteX71CDNCP5XPjBy762sPp8mZbTEfFnetngYB8ls0GEOZ9rd/CbyjnZ9kMTRWe+DX
         lmdyazfWm2HrXk3exsxNm3ByahD/2pRM4zAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=vSYbfez9sMrWNW9h3VuOAA21Ecw2U6/iY7XbNqz02Nk=;
        b=LkAFcczYGuokQ89p8IJfDlH/cQALR7Aehu8M8GUOOsRSGCRHl3X+t/+WK+9kWrjjEL
         pCsrLamLf/Bg09+dHLEpd9D69iWORlnudGtdCW5spNCoT4iT/9aiF+pPb0M3TEKpR4Pj
         v/UDvkcUWVi0xfEGmvtb8/WSXK2FqwLKEhkIUDPUfcyDKLiPK6mJ9kBO+5JWCBom2u4d
         ED1Gr0PYZU2/RRTBbzZHNaSCsPDu98sDMkc6jO30lDyiwtdQvvNIleWg33r87rULs6vu
         ARsuw0Qs58siIiu61t81jYpoqXtbpFP6Qfce+B6UmUFmrKglYHCl0ikZbIoZ6k2E3OJz
         rtOg==
X-Gm-Message-State: AOAM530f4FLYsxkzp1Qbn7moU+lSw945sSpf2pqi90uLX/RTk1c8dY8e
        rEDHs3cAR8wwxWzJBeH2d31NvwQaUXft0uDdx+fJn0uxqCg=
X-Google-Smtp-Source: ABdhPJzMCiDjOvJFb8RJNO+Eynw/sVkqBb3RfG5pqD9m2EhRa9pizpV5X3javyefoKq8JHFV/UgfqLpph5fucQpcOWA=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr7895696otj.77.1638391451845;
 Wed, 01 Dec 2021 12:44:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Dec 2021 12:44:11 -0800
MIME-Version: 1.0
In-Reply-To: <1637040382-22987-1-git-send-email-rnayak@codeaurora.org>
References: <1637040382-22987-1-git-send-email-rnayak@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 1 Dec 2021 12:44:11 -0800
Message-ID: <CAE-0n50PT6j9zGQQyESp+VkokDo4805zU23rx1EA0eaqf4nMBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: rpmhpd: Rename rpmhpd struct names
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-11-15 21:26:21)
> The rpmhpd structs were named with a SoC-name prefix, but then
> they got reused across multiple SoC families making things confusing.
> Rename all the struct names to remove SoC-name prefixes.
> No other functional change as part of this patch.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
