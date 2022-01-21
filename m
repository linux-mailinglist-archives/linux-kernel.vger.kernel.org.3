Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8849677B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiAUVmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:42:01 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46975 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAUVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:41:54 -0500
Received: by mail-oi1-f170.google.com with SMTP id w188so15381128oiw.13;
        Fri, 21 Jan 2022 13:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lF4HMuqkp4VWT3w6r4KvVzp/kzCK6RItYXFgLAX6eAw=;
        b=t5Zb+caejYjpMUATREY71oiosuQaREpQqo9jP9BwpoyYXXksS+BYxAmf4fyGLOUwAL
         rrtRGujQgG/X7e+BwtlrJibtHtK8EHE+TVCkm7/pWNlWg2Qpw5+S5YVmmfPUeIb0fni1
         nCj4tU00tQC1WAJqBOWNZfZzm4TGIDm4IypG4OXaTqrlOHlOMTVcQj/lwZAs30fhTBwQ
         HrUngSJ0bS3QGqkdKOLpBRRYlIoofPpCvWd2bJ28aFCVAkePbIdQLQVfFQhcGzhnXwO5
         7flPqL4Yc64WtFYCpaiiM+JbP8mKNkjGp0+30gwocbin0FS/+qmO1xtexqW1VPYpS2uy
         KSEQ==
X-Gm-Message-State: AOAM532OITv0/gydOEEl3nTt4uK/+xm9HyihROJfl+lGsyq+SDaHVHwK
        nSaZzF0vLKJHCt61POcbHQ==
X-Google-Smtp-Source: ABdhPJwne2XmMOP72QVvxpy/tQX5tuU1+CZHAFmA7X4krgdi7zq0qlm6dht+yhHpDDCx9ZvZomIEsw==
X-Received: by 2002:a05:6808:607:: with SMTP id y7mr2157878oih.131.1642801314203;
        Fri, 21 Jan 2022 13:41:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 124sm1743747oif.7.2022.01.21.13.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:41:53 -0800 (PST)
Received: (nullmailer pid 1638609 invoked by uid 1000);
        Fri, 21 Jan 2022 21:41:52 -0000
Date:   Fri, 21 Jan 2022 15:41:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH] dt-bindings: display: msm: dsi-controller-main:
 distinguish DSI versions
Message-ID: <YesooIWKcypvtBbi@robh.at.kernel.org>
References: <20220108190059.72583-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108190059.72583-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 08:00:58PM +0100, David Heidelberg wrote:
> Update documentation compatible and checking to comprehend
> both V2 and 6G version bindings.
> 
> Following this commit, there will be update for
> compatible string in chipsets dtsi.
> 
> Additional changes:
>  - switch to unevaluatedProperties
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Rob, I know you mentioned using rather chipset names, but since
> meanwhile I coded this, I'll let you decide if should make sense to
> change it or keep it this way.

It all depends on how many chips per version. I'm guessing only 1 or 2 
given how many QCom SoCs I'm aware of.

I think this should probably be split to 2 docs for the v2 and 6g 
versions.

Rob
