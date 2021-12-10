Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BF8470C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbhLJUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:52:06 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39441 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhLJUwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:52:05 -0500
Received: by mail-oi1-f172.google.com with SMTP id bf8so14858499oib.6;
        Fri, 10 Dec 2021 12:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2E0eoROtMlHYrOM64XNVU/Pz6pMBw0sqWUR5HdK6OI=;
        b=ncdVzllLKKMZOXj1em/TTaYHT9GdIP6MGvl4A0RLkv0yhlBAiYODw+vHa13aqmzTtM
         l4bJdQFCmktbzZFNVjMtiZngGol1AlgtlJiDK71qQ5jRKBdbRSJg4JzTvgmBpTS9g+0w
         0m4wGtpXxMMEKTql43/6kmeOt+u96qE3z80kb+wzRlspDga+ZJyhAXeklLsaeVO/SgX6
         Bhvg1p7NEYC3b32Qn7D+7k6TOyEeM9eRcpqwjTqbnydlUxjLjyEo1wsxEevdL2iOr7Io
         bdfUAMHxW38AGTK7GvA5BeEMiv+8VxWWxZTR+n0+fL/asGKw7DqcgAKCEnWmlmCkaxAb
         MzqQ==
X-Gm-Message-State: AOAM530uCkeSFjmiFAMZ5lJfpp4Zb5eUkWCyu5H9xmH3Kny+l7G3kP6h
        ByLdTTs5eJLLyPvgLFLtyw==
X-Google-Smtp-Source: ABdhPJwnKhYZ6hek/8jjl49VXD2lxSLgJ0QDj3hTzfQWnyd0uIxJWssGz1tfee52cAOI6QRMilDX2g==
X-Received: by 2002:a05:6808:1210:: with SMTP id a16mr13787827oil.113.1639169310013;
        Fri, 10 Dec 2021 12:48:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w17sm698833oth.17.2021.12.10.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:48:29 -0800 (PST)
Received: (nullmailer pid 1870244 invoked by uid 1000);
        Fri, 10 Dec 2021 20:48:28 -0000
Date:   Fri, 10 Dec 2021 14:48:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 02/14] dt-bindings: arm: airoha: Add binding for
 EN7523 SoC and EVB
Message-ID: <YbO9HFGpo/ZmXXEH@robh.at.kernel.org>
References: <20211203113331.20510-1-nbd@nbd.name>
 <20211203113331.20510-3-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203113331.20510-3-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 12:33:19 +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add devicetree binding for Airoha EN7523 SoC and evaluation board.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../devicetree/bindings/arm/airoha.yaml       | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/airoha.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
