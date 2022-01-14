Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA548EC56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiANPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:11:08 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44612 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbiANPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:11:03 -0500
Received: by mail-ot1-f41.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so10324143oti.11;
        Fri, 14 Jan 2022 07:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4+BddEtRBdq9xvfnQ5SqQUWeGgqZYMZeytjqY4EqU0A=;
        b=S2qLjLPy0/Mn4q4H5XBMvKOUqYdKJFRen5gPbIFL8cAHg3ayCw2vd7L8nP+cylgXQl
         SOpE5f+IqUgsBI1mWsCyaTZD3QpPXomOmwUMTDW4Kk6dYRgJ7MokFVUbNbj/GS/SgjTO
         jlggOx1+0RfWHDzgR+1Ihrzm6me7JZLDkhqqHfqJ1ysLoE6Ak1h6ipWsNS4BEegPhlwl
         MizRAk25SfqJuu83SaNrt8tT3FbGyjC7pV3rjohCd/fbEPdJX52Uh0htPFS96wXH1qPh
         nepaE/wn9gm4UQrCD+ChGPBpiyKc0zUKojoYzQgWNM0X4uhXAgQenB7BSh0tbWWAArCr
         sH+g==
X-Gm-Message-State: AOAM530Y/y20ngYwQc5wh9uO11in+RxSGdv3aAt8pKudSDTj/zJxklXL
        f06bFL98b9ArvVZTef394jKwao0uPA==
X-Google-Smtp-Source: ABdhPJyzlQQq+qXoEP9sFNKQATNFTJxHlrXZRXpZ0bUzMSD7k+Yk7Ce5C5+5F/n7Nt3uALblam5qPw==
X-Received: by 2002:a9d:d67:: with SMTP id 94mr7108551oti.156.1642173062784;
        Fri, 14 Jan 2022 07:11:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h10sm2199934oie.32.2022.01.14.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:11:02 -0800 (PST)
Received: (nullmailer pid 1899481 invoked by uid 1000);
        Fri, 14 Jan 2022 15:11:01 -0000
Date:   Fri, 14 Jan 2022 09:11:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: trivial-devices: fix swapped comments
Message-ID: <YeGShcvg/JkwZayr@robh.at.kernel.org>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
 <7dc6ddb0b042cd243b2875e9aea81cad541d1c6b.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc6ddb0b042cd243b2875e9aea81cad541d1c6b.1642080090.git.stano.jakubek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 14:39:01 +0100, Stanislav Jakubek wrote:
> sparkfun,qwiic-joystick and st,24c256 had their comments incorrectly
> swapped. Swap them to make them correct.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
