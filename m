Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA43C4621EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhK2UPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:15:49 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:47004 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhK2UNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:13:49 -0500
Received: by mail-ot1-f44.google.com with SMTP id 98-20020a9d086b000000b0057a403bbd4eso2521828oty.13;
        Mon, 29 Nov 2021 12:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZAXsJSUQjYW1ESouOH/jYv3V0TFgwXgT2iRk93eZU8=;
        b=3X9ZCVnCWpbwg31PoLYS+k1qQ2RouGlEPYibn9DEs/Mqdh+54elA8sUnjY/onpGaeX
         /ePiFNYYQ1MewcVMKiSzajqgaPtF7onHYs3ts3+Q+l7gQIeJrohWMW3+ZfKpmbJ2alSZ
         rwRob1t2uCZ0QTPOQc8hE8QpqvEN1SICjHDGxQ5OxkBgDLwF9NLsXcnyHZLriQbxizSR
         fQGq8ytbexcz+JZYZByjJ4UmhBhdYIuLEGiV2RyCOIdLGtGeUezNY0OpcHy/uS9Yp0WA
         qhanj0JKY0qIm2HqRvLtBBSLBiVFLLoAVsVoVxs2FFoD08CwrIYjTcTXE0LSAmpQ+Wao
         yeoA==
X-Gm-Message-State: AOAM530qLvAJBnLcvdCENPgc9CC9+3LuXEfX8Ifwyn/KgvuSpujC4zrt
        BNXqRQvW7N6yskbneXsIWw==
X-Google-Smtp-Source: ABdhPJzuHSkT6aK0MzKQ+XdJKL442IfwmKnd73aDsFA/r4KNla6O+3VTcXB/4IPqG8A+cIv3BXl2Rg==
X-Received: by 2002:a05:6830:169a:: with SMTP id k26mr47154935otr.64.1638216630690;
        Mon, 29 Nov 2021 12:10:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v12sm2827187ote.9.2021.11.29.12.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:10:30 -0800 (PST)
Received: (nullmailer pid 522769 invoked by uid 1000);
        Mon, 29 Nov 2021 20:10:29 -0000
Date:   Mon, 29 Nov 2021 14:10:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        ~okias/devicetree@lists.sr.ht, Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] dt-bindings: display: sync formats with simplefb.h
Message-ID: <YaUztTzXSRaK9dOB@robh.at.kernel.org>
References: <20211108183322.68192-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108183322.68192-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Nov 2021 19:33:22 +0100, David Heidelberg wrote:
> Sync all formats from simplefb.h into documentation.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/display/simple-framebuffer.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Applied, thanks!
