Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADDF48ED1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiANP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:26:10 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:46731 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242722AbiANP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:26:09 -0500
Received: by mail-oo1-f44.google.com with SMTP id b20-20020a4a3414000000b002dda566aba7so2641510ooa.13;
        Fri, 14 Jan 2022 07:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tFhJnE7sUoOEQBH6lC9rY2RtuqE+bsMzpp8lViD3BiQ=;
        b=Dmk1bgUTlYMaczTrs7VfHjsG+ZX7parS7octv0dTqIU9R1IPEOlEwZdwnI6Qgv+kgE
         fTZFKH49liniIumQtA9Ly3MOqJ6Fd7RbBybkTcBDiXE2IOU5YRhEX6yXevqk56afLAAU
         diJ9h1DaZDf8wT3MM1hCLtM7+l9Ypq2KP4T8JWyg9/J9sjxmdDtEqR6A9ak30fTHDTPe
         lCIu/Kp/BVbeCc0sctfywxJpbL1X4z8DPbvDbORcvNxvCWu7AgCjShHQIF7adLydb4Dj
         BwBd1EA+dlNPm5T4tJ4mAPBp2+1kYdZZRBzGoi8ewE7HeihMwb0xZhvuMemUEgDG3S+w
         hpfw==
X-Gm-Message-State: AOAM533SmNeV7HYSbbehJyw+elmZvZztCEANMN0+ZNclcSP0VEkVHaM/
        sHJviGJDFMTHo+nIAMNdniw0PqYi+g==
X-Google-Smtp-Source: ABdhPJxg7Y9rekKNlr/yJ61dE2m5g4xgFSN31WUa1UMcZa5u0uvJ5rFNposBrfMFEBHTiMO1bd3yrg==
X-Received: by 2002:a4a:b14d:: with SMTP id e13mr6781501ooo.67.1642173968474;
        Fri, 14 Jan 2022 07:26:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f18sm1875738oop.9.2022.01.14.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:26:07 -0800 (PST)
Received: (nullmailer pid 1919745 invoked by uid 1000);
        Fri, 14 Jan 2022 15:26:06 -0000
Date:   Fri, 14 Jan 2022 09:26:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/dtc: dtx_diff: remove broken example from
 help text
Message-ID: <YeGWDoobNrjiSEXd@robh.at.kernel.org>
References: <20220113081918.10387-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113081918.10387-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:19:18AM +0100, Matthias Schiffer wrote:
> dtx_diff suggests to use <(...) syntax to pipe two inputs into it, but
> this has never worked: The /proc/self/fds/... paths passed by the shell
> will fail the `[ -f "${dtx}" ] && [ -r "${dtx}" ]` check in compile_to_dts,
> but even with this check removed, the function cannot work: hexdump will
> eat up the DTB magic, making the subsequent dtc call fail, as a pipe
> cannot be rewound.
> 
> Simply remove this broken example, as there is already an alternative one
> that works fine.
> 
> Fixes: 10eadc253ddf ("dtc: create tool to diff device trees")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  scripts/dtc/dtx_diff | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied, thanks.

Rob
