Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3C493B90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354927AbiASOBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:01:20 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38658 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiASOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:01:19 -0500
Received: by mail-oi1-f182.google.com with SMTP id g205so4244328oif.5;
        Wed, 19 Jan 2022 06:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ARj/rMuy56bxjprWvVLBFVaJVeVw8x7Y++0Vstg9VtM=;
        b=dc33UQbudIOhkZESVWYjuphLA1HUom/Xt+EVnOqBM2huyGVEa68l4NjYZB7F5Zmkn4
         lAIOsRQIzP/SXZOGbyIXiYJV9R5L/HxuUQ4mp1jF515l436pWbIpMtl9Bt95pjFkPy5V
         9vU1S8SDUSwGnrgG0ABx/Nr8f4JmVNRO1meovvnfIbGytW1wg62dfrYy+yYVAKAlLzCN
         N6vNHGvjOOv1vdS1W37EqD4JjoCplZltIbpz1ph+9wS6X66sDO4DIShZL4AItBsCAa3R
         ztOKGJA3DKSbG348haBZxSz7RrI3WDAsIIWB+QJxYSOAGzlQO8XjRMKusUpBEgch9etx
         LxvQ==
X-Gm-Message-State: AOAM531kBVV5zpVWYCLvrZuq5vpFbMQVFLnxE0+Tj9ow8t7r4+ADilm1
        wirU6+7yR+z7OrAW1IFhfYudGnIjnA==
X-Google-Smtp-Source: ABdhPJyfkEZIsBZOimsuhEvrQhDzihwQnP8qX6b5zgZKTUYkxVTRQhhgi7Xf+lTe4qcR+UB1xFEeog==
X-Received: by 2002:a05:6808:aa7:: with SMTP id r7mr3049862oij.47.1642600878543;
        Wed, 19 Jan 2022 06:01:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t14sm8735342oth.81.2022.01.19.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:01:17 -0800 (PST)
Received: (nullmailer pid 3470881 invoked by uid 1000);
        Wed, 19 Jan 2022 14:01:16 -0000
Date:   Wed, 19 Jan 2022 08:01:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: Add Apple NCO
Message-ID: <YegZrPh0GSSzFZ91@robh.at.kernel.org>
References: <20220118191839.64086-1-povik+lin@protonmail.com>
 <20220118191839.64086-2-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220118191839.64086-2-povik+lin@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:21:03PM +0000, Martin Povišer wrote:
> The NCO block found on Apple SoCs is a programmable clock generator
> performing fractional division of a high frequency input clock.
> 
> Signed-off-by: Martin Povišer <povik+lin@protonmail.com>
> ---
>  .../devicetree/bindings/clock/apple,nco.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml

With the indentation fix,

Reviewed-by: Rob Herring <robh@kernel.org>
