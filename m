Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B5475DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbhLOQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:45:41 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:41543 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhLOQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:45:40 -0500
Received: by mail-oi1-f182.google.com with SMTP id u74so32428037oie.8;
        Wed, 15 Dec 2021 08:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pgBtQMB9xPX/3DFkmhXnuRYiO6OuFLrYCya8nP4iGPc=;
        b=E9SUrLhPVtwsAkzHkFV/5uMDJzeuZsl3SZCvf8GCjtnp/tO6o/aZs5Bm5TxbQcWRLn
         flM+PiAB5S+Kk8OU14Fay07vEOLOHimZd1OJNiiyft9CW1NlSk/9BuH5BGAXa9V3pVQD
         3UA7d0ii1F85dLyeTn5Mlm0BMBJpXGYxNa98UCUlg2him7Fx/sNTKbpR0cAIHwunmiyw
         7S5q0rzROMQ1DOBui+Gp4qa3ZEpkN9Owm8DE80gaTw32Tapdx3YZ5Qb61n5A8bpSWYCM
         8Uuzu3mL2DUAajWrKbntffEiVzmLqWw4hOsWaqA/FVYerWIwUBHC+CUNEqzUxut17cAS
         OZYA==
X-Gm-Message-State: AOAM5318bMUj6Ygz4YUF0n8Novltn5qpmc7UmokzozXw170V1Sjjsdog
        HL/trc7NtOLU6jISPvDbciP7sISU/Q==
X-Google-Smtp-Source: ABdhPJwDrT0+iGuFb+5zdEsjfFg7LoUukjUZcv1xZfloqcMr3qst5Uut9MTWqyYdbkQKs79CVYb3fA==
X-Received: by 2002:a05:6808:3012:: with SMTP id ay18mr618774oib.88.1639586739505;
        Wed, 15 Dec 2021 08:45:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q22sm523415ots.62.2021.12.15.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:45:38 -0800 (PST)
Received: (nullmailer pid 1451270 invoked by uid 1000);
        Wed, 15 Dec 2021 16:45:38 -0000
Date:   Wed, 15 Dec 2021 10:45:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: pwm-vibrator: Convert txt
 bindings to yaml
Message-ID: <YbobsmrryqmsRvyB@robh.at.kernel.org>
References: <20211208183434.98087-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208183434.98087-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 19:34:34 +0100, David Heidelberg wrote:
> Converts txt binding to new YAML format and simplify example.
> 
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - added Sebastian review
>  - replace anyOf with minItems
> 
>  .../bindings/input/pwm-vibrator.txt           | 66 -------------------
>  .../bindings/input/pwm-vibrator.yaml          | 57 ++++++++++++++++
>  2 files changed, 57 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> 

Applied, thanks!
