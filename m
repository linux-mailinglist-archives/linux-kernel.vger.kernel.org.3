Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52061493E15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356111AbiASQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:11:56 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40618 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356102AbiASQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:11:55 -0500
Received: by mail-ot1-f43.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so3719338otr.7;
        Wed, 19 Jan 2022 08:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxZXWG4kuGkH4QtIGEz0hxzGIdbCQIMxC9U+hYf13os=;
        b=paaMRV1KP9S7/I3CipnqHtEWNj75k8ZmR63QqgswfbOlk1USy40RRmb5hMw1B90Hu5
         FgMbMQAxm4qfOvxKl6+XyQW+HmGGOjvlSqUsXyQKFAtBzRRsla6EvI4v2+TPsz4wXQjY
         9ahwhqCQi4qTGGR2knQ1pWVta05FgpOt4qBcJ+z88TvB/0MMQCBsWCYxoGTaRfuwM3My
         Pk15UbGVxkEksowNhPth/vlRXfNrKI8UQ08m/98wToUUhbTHGzQAGzJ/UmVHL4BWonrj
         o/efaoRsgDgbzTKFc7BN4eXpMKafIR+FqMn9lHx9m48eNJ5SAvoSI5qVhkrLtd7iY9cY
         uSdw==
X-Gm-Message-State: AOAM531eeDN/wAvdbvNnzHhkOZuSDQ2hDLsz9J7R2J8pIl96WHfawdj/
        PcdrYXUUmuivwOgZxxakBg==
X-Google-Smtp-Source: ABdhPJxSboUM1Fj6OIYLvk4siom4gYj2gwH03uAc7NeVEx8IDWPxnKRqWHzYBuv7pwhoEHMGeEkObA==
X-Received: by 2002:a05:6830:418a:: with SMTP id r10mr23507850otu.361.1642608714750;
        Wed, 19 Jan 2022 08:11:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g16sm60885oti.3.2022.01.19.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:11:54 -0800 (PST)
Received: (nullmailer pid 3682300 invoked by uid 1000);
        Wed, 19 Jan 2022 16:11:53 -0000
Date:   Wed, 19 Jan 2022 10:11:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel@lists.infradead.org,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH] dt-bindings: rtc: st,stm32-rtc: Make each example a
 separate entry
Message-ID: <Yeg4Sba3eye24+LG@robh.at.kernel.org>
References: <20220106182518.1435497-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106182518.1435497-7-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 12:25:15 -0600, Rob Herring wrote:
> Each independent example should be a separate entry. This allows for
> 'interrupts' to have different cell sizes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
