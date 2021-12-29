Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073084815B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbhL2RTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbhL2RTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:19:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10164C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:19:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x21so49386888lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ApBdSAzt+Zwxf/bUdk7J8+5TGYqTMygUtZUxKyiH+JI=;
        b=EczcsHb6QnST7K5tF6xIvkMEWJ6xh0Hh27/S5aGO6Bcrb1qI/3InFft+DwOMQFvXK3
         6Uy2WfYtq7hObIexa3klhXSajsk42jMWpuSaGVGhAaO7WI3b6GZBq/QwC4rHCkJ6VIKn
         CFtkCtOEzLAva5IS4L8sTb7axN0vWGvve9/w5qCJVAQ6fPBdoKu5Wc2tcpWWkmPDhBln
         1YFpP/8VcErYQB+F1ktL7GhmduKce8WdoN22Qs/uHoQ/ETyFKupJ+DCFfukX8o/dEl18
         Kg5kXtLPXaXLbOg7vpOhyFvbSWccgu+MQmSs8wcdZTrfPWTaIey4qvJZzdcwyxUB0a0+
         /tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ApBdSAzt+Zwxf/bUdk7J8+5TGYqTMygUtZUxKyiH+JI=;
        b=bKsMbDKNxCb45QjQfZYQWccwoWg3v3mGKtorPOwNKY6ZnIcOcNs5ohsjBopmpBWnts
         9Zu85qgiTTXCFH+j4cWkKJIxUJCUXBVsdEg3M/CyqYiH7vxPcSFVzKjx+kZ0gVOQKAAZ
         s48n7khQxCjK9kW5mFE2k2KuPFAh3/VFp5ywdv8AhPc2bYDHgCuG0dgn06Sd+OU1orkx
         RUSp8Dz5eK/ERUl5JJtkHu4pUKuyLE3O56r0ge9jFWoW9XyNNwmyjQIli5aTmriZYgFs
         Lr50heMdA+MI/XaqmUDaevg0XmWbd+Dp4LSlmXRfmZYQ4cF1au/KWkakkq+2DESFUs8X
         AlhA==
X-Gm-Message-State: AOAM533BEac4Lqh04yIIW6FHwiJ5tHk0Xxm1WIAzxQoTQMQ1NLSLmcys
        vNasUfWjv27ZgpsLQpcE2vTxim87fM0nA9KwdLY=
X-Google-Smtp-Source: ABdhPJzJ/vs5ia+NXIwRMuT9HMiGYdJGHoTCRb9uX4YNy/amgGcQX361wEa95q8uNE2X1yzH3ss36A==
X-Received: by 2002:a05:6512:15b:: with SMTP id m27mr21949929lfo.218.1640798351957;
        Wed, 29 Dec 2021 09:19:11 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id z18sm2251172lfd.8.2021.12.29.09.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 09:19:11 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
 <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
 <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <39f70781-831e-c86a-ec5f-68f2b4bd3d62@cogentembedded.com>
Date:   Wed, 29 Dec 2021 20:19:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If this approach is not appropriate, then perhaps need to fix it in
>> files for all SoCs, to make it possible for extension board dtsi to be
>> compatible with all of them.
> 
> I'm writing a patch to drop those right now :-) I'll CC you.

Ok.

But, are you sure that empty nodes like these are that bad?

I was going to suggest a movement in opposite direction - adding more such nodes, so they could form a 
sort of API for dts plugins describing e.g. displays connectable to boards based on different SoCs.

Nikita
