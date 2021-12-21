Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34B47C6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbhLUSvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:51:44 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:42967 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbhLUSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:51:40 -0500
Received: by mail-qt1-f176.google.com with SMTP id z9so13762308qtj.9;
        Tue, 21 Dec 2021 10:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcvOkeyejOqX6ToX6EI8Mv95Td4ggAWAXcI8vlcyp3U=;
        b=WkKY2tg4+w7AyfOXNVj8xZtIKS4jaGOeT2G1XYKiqx8++xfTQiJNBaCN6D+nqwBB6b
         d+rP3gUL5S/LyX5Kzi5KSD0CD3rIp71irG0V1WZ4ocmu9Oqjohg7H8YiXnEC5E9Kmeep
         rDbCA46mZDaTCmaGXcCW6kiiKuMGaVONiCoriBOzf/0qeW6ZooOrQUEnhUUotuABnNOz
         giitjdoZxUo1YJA8/TkxIa2arRWH/H0E5wkW56RJrfvf7KojAdX+Ox63E2QdPxklf4Jn
         ywc1JxywpVg9046l1erg48CJ4tZg2rOkjkeOGQCSAdDVfpoOEtfO6BPFoattP3BviSN+
         SYAg==
X-Gm-Message-State: AOAM532+uSNPG0hfXzysHL2UOG72mkeN4TLX9wKoU1MhOeRa3Oy4kL6q
        eJaCXT7fTj8pRRrwJ9lXFA==
X-Google-Smtp-Source: ABdhPJzjDIfWuf+N6316FUeTolqiuIdYJz3lQ+Gm0R914ATTzZmJPElI6Bz3GRmz8XY7rDFoKPyMOg==
X-Received: by 2002:ac8:5fc3:: with SMTP id k3mr3535003qta.34.1640112699891;
        Tue, 21 Dec 2021 10:51:39 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id e15sm393446qtq.83.2021.12.21.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:51:39 -0800 (PST)
Received: (nullmailer pid 1561787 invoked by uid 1000);
        Tue, 21 Dec 2021 18:51:37 -0000
Date:   Tue, 21 Dec 2021 14:51:37 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: regulator: tps51632: Convert to
 json-schema
Message-ID: <YcIiOT9vT4f+0GnD@robh.at.kernel.org>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
 <20211217170507.2843568-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170507.2843568-3-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:05:04 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments TPS51632 bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/ti,tps51632.yaml       | 53 +++++++++++++++++++
>  .../bindings/regulator/tps51632-regulator.txt | 27 ----------
>  2 files changed, 53 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps51632.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/tps51632-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
