Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB93048743F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbiAGIsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiAGIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:48:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3EC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 00:48:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so19663729edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 00:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xQwYgCXBhVcx9Q7TUKVOI86G8epXxK9R2Ct2Vdmiq54=;
        b=jf7eTWM4n1fehBqIExoiNAl6b/IkjGB3Zrso01KQBQ3NoMZ2lqMXXiKTP+aW/r/dho
         4bbrvynjeEuzrmSINg5yww1r4O6mxmcQobvlrrGVUdB6Uuu5d55fQDHyaB6IDl4bwt7i
         RuZloZbADVoe+qwhmYqLfxxoxovaA5w+VG/Yiu+L9WQ3cCle7PiQwLqLcGl0hXxV6/kI
         Pr4+4Scz2OREaqcMbVJJ1T7Xdb3EixoO0TpXrpcDZ9tIv69933KuFvPNQaa4O3Vf57E4
         jPyhBB4iruEbjK1+bJQBGkwyfWEVQ1RViUdEH/o8XedLDGMG35RpyqXNGadm5XMa6sUm
         03ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xQwYgCXBhVcx9Q7TUKVOI86G8epXxK9R2Ct2Vdmiq54=;
        b=NcRVlGaIuQURE/3nvO80vPsup03UlfPAUuNnf+CkjwySYo3iaddieycP6lc8SUXr/J
         zUUctGNv+JAoFFwsyZqU4CL2CIKWgILuRj251Tv6X9iJbyWUZjps3keEJYLZLwvh4roV
         9sRqpA+0ojEWpg34mvTiEEjH6tZjxYk7pPkJrhYZNDxK1Jy4WqhWI0joYH3tDYUjxAk/
         jjrdsrwJkoAAZJ4AxwKhNNXJrVUqa9djt3OXxEkCOdO5fl8hVXDAl/G9s2yZewhNxfdO
         gIzkdejr2gE5uJ6Yo1vpEfK/flwzGxjnzeubYTDBO+l3U0O7wwdn1pw0ZOxeJcz4ohAc
         AwZA==
X-Gm-Message-State: AOAM530ztEybkH9n0OzHNTGODb1/Zl5kYJ+k7bMkGTQJXTPoSo9LPHLr
        kRLPjpHej1XVJ//I6rGWpnQ=
X-Google-Smtp-Source: ABdhPJyfcW0iFZhoFs6TtVnep2FYlZjybsexgdTnjr3M2pDrnHdisvQTxZ+yB91Wid4EMkAngWjtwA==
X-Received: by 2002:a17:906:acd:: with SMTP id z13mr5612271ejf.714.1641545299942;
        Fri, 07 Jan 2022 00:48:19 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::b8a2? ([2a02:8108:96c0:3b88::b8a2])
        by smtp.gmail.com with ESMTPSA id di5sm1204609ejc.45.2022.01.07.00.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 00:48:19 -0800 (PST)
Message-ID: <de835ab4-8565-5f7a-4f11-ee4622c20702@gmail.com>
Date:   Fri, 7 Jan 2022 09:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 20/32] staging: r8188eu: make
 odm_RefreshRateAdaptiveMask() static
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211229205108.26373-1-straube.linux@gmail.com>
 <20211229205108.26373-21-straube.linux@gmail.com>
 <20220106122607.GL7674@kadam>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220106122607.GL7674@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 13:26, Dan Carpenter wrote:
> But, you added a blank line here after the declaration to make checkpatch
> When you're moving functions around could you just leave them
> exactly as-is?

Sure, I'll do.

Thanks,
Michael

