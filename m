Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BAC484C0F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiAEBUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:20:46 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44752 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiAEBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:20:45 -0500
Received: by mail-oi1-f177.google.com with SMTP id be32so62010168oib.11;
        Tue, 04 Jan 2022 17:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wkSYIkbTraw8trZfhJN7AlwNGxc0iLFdHFt7r8R+QII=;
        b=01DX6dT8rB512jwgrLlrI7+ctt9UyidkQP+8cwDzWTulRmx0jvF9JiJsL1qvAVGAV1
         CBn25jRHI7sKdmh/8oR+SgXf8NjwQMF1g4GW3iZzwkm07xFYCHpwpbb9bpnGB2ZUngsa
         13JWBCc0QZ1p92oNbo5cRU99yOgylElwWuHMw6x0MqwQRLhBiM+x6JtbWEyVq9wLiMl+
         sUVr0ZNF9ieqSuP5VlAIBy2W2xdX+I6P18bKpwQaUQgDmkKKsQlUrpmpuhXkMxNBAGPU
         hi4fD9PhoN7/9yxdg7O4PeiEJoPMfvUFA3FcCmDUELFZaz3EV5V7kdB3wFpaC1XKvV3f
         kRCw==
X-Gm-Message-State: AOAM530cmwGwWvy43ohjfgA+bbncwN+2RtsPTVEz1ynLDvggsUg2vmvY
        hPzA3wzMuOgALzgJuUmOlA==
X-Google-Smtp-Source: ABdhPJxpmLGYbE2M0UhibGMOpbFztSw7iF9ZNFOrhBur8Oufb6/MHYVShI7BCd/dsZVx4ZnufbqyqQ==
X-Received: by 2002:a54:4693:: with SMTP id k19mr787053oic.125.1641345645175;
        Tue, 04 Jan 2022 17:20:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w14sm7467676oou.24.2022.01.04.17.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:20:44 -0800 (PST)
Received: (nullmailer pid 1839577 invoked by uid 1000);
        Wed, 05 Jan 2022 01:20:43 -0000
Date:   Tue, 4 Jan 2022 19:20:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     erhard_f@mailbox.org, devicetree@vger.kernel.org,
        yinxiujiang@kylinos.cn, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] of: unittest: change references to obsolete overlay
 id
Message-ID: <YdTyaxD0MSFrPpEy@robh.at.kernel.org>
References: <20220101033329.1277779-1-frowand.list@gmail.com>
 <20220101033329.1277779-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101033329.1277779-2-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 21:33:28 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Unittest inconsistently interchanges overlay changeset id and
> overlay id.  Change variable names of overlay id to overlay
> changeset id.
> 
> Do not fix variable names in the overlay tracking functions
> of_unittest_overlay_tracked(), of_unittest_track_overlay(), and
> of_unittest_destroy_tracked_overlays() which will be replaced in
> a following commit.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 54 +++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 

Applied, thanks!
