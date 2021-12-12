Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB247180B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhLLDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLLDp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:45:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 19:45:28 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x5so12078825pfr.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 19:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ICQWFokAVRWgKxl1s/4Hzdh6Yp2TMsPatXMeKqVc7WE=;
        b=LWGCnGYkF3AUL12ntD3iHIwx8E7r3No6CPLsBFg1WDJU3UNW5QjMgvbfjMIzVETfos
         LhakJ6vXDWSWtFdabDARLi9pmeJ+1dNRk7DdHlxrXTJgcGCx8luTa0szwDFhH0B/ZnNV
         XibM1PruvkoHCWVaJJXSjJ36Hjto2f0gHhYEV35d4SUjoEeNzpKx93p3FIMtHgIn1kGD
         5ZqFcGLEcTP+y+rPm/IWWyBUU/Kd9KX8ksY6+rz5DHZ/CRsVn/GU5MhKOv/GSj2h1DK9
         EjJ0qv09EK34tVYAsF2RJwRZ0pAUbwP5759LuoDQO4/vPTRaPbTIGHHkXlH5sY7udNp6
         k9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ICQWFokAVRWgKxl1s/4Hzdh6Yp2TMsPatXMeKqVc7WE=;
        b=17ZyDqTcN6/H0lDylpsdloRln2YaClwsS1pwtNzSLJwuCTwCm4yb5peeY6ncf/hO7b
         r+xuxLgTsNxV0lT9kQhadC5N+Z7DanKaBTaMSSlxX9vMmV8Q9pUk1GGKBQ2YmnR9D1AT
         nyWdHbsloee+DkxooNm03nUHdTje6pj12c7JPaNK9Xe95B6dzrUMlj3zYRWzP0ziQ5B6
         aeFBIPK56mU+RlVrd5bJiPfpxVg18p3OVq3xp8PqLt82tXM+ZTzyQ7WPj4gfPKJdBaQ1
         /xJNk3sL0luxF1V57KD5Z6ZLdyoPTKQg/nwMrY1XANEzufiCWpza6ULZZIJKbE0OXPwT
         bUPw==
X-Gm-Message-State: AOAM532VRMmnguvw1DVFJE6yHFSvN/1fzXSKPC/w3cp/iX6jqWNVXuhv
        P1B/h4q1RCXHjJsn2GXNJx8=
X-Google-Smtp-Source: ABdhPJxvfRIfM42xpSNkhGX5Ez2NhSI8UlKoID0P6brJuOql7PHvnZL2+Tejb9FiRpWh8codYcoT4Q==
X-Received: by 2002:a63:d49:: with SMTP id 9mr40276867pgn.290.1639280727393;
        Sat, 11 Dec 2021 19:45:27 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:4964:df1f:902d:8530? ([2600:8802:b00:4a48:4964:df1f:902d:8530])
        by smtp.gmail.com with ESMTPSA id m14sm2020589pfh.11.2021.12.11.19.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 19:45:26 -0800 (PST)
Message-ID: <2b0b6412-7ab9-de8e-6f22-253eb039191d@gmail.com>
Date:   Sat, 11 Dec 2021 19:45:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix typo in a comment
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mmayer@broadcom.com, krzysztof.kozlowski@canonical.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211212033347.67921-1-wangborong@cdjrlc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211212033347.67921-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2021 7:33 PM, Jason Wang wrote:
> The double `to' in the comment in line 427 is repeated. Remove it
> from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
