Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B247384E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbhLMXOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:14:48 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43884 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbhLMXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:14:43 -0500
Received: by mail-oi1-f182.google.com with SMTP id o4so25186338oia.10;
        Mon, 13 Dec 2021 15:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bLAfAh9FC08OixBLXZmgYU3JjSgM+bSMYrFOMHGCVMY=;
        b=ePvNjPHbamzhUJj7wvMWw0/WzjE7Lbe9afOUR9B/KcmtLCq6fz/h01UaAIN6sB9kG3
         0X00ottMUjPBopfI2k8dTiPrnCFc6WzSDo4iasSnhvFrWpa9nmGzfNtUoKBYANbF4SO9
         Gg/cJd9IPL+G+pOkave7KJltTfYKIosN8DrZDWoepRRyXhp1klduNjBO1PVD+Zas+Xqx
         GoGdhssyVfLw+EJPAEQpr66GqZ3nTXrMIyQs4fzJbRPmzy3Mei9A9L53D054qJP4wYPe
         uPuyHKHxNjQWEZwl6ZKmqA38JpxMuDkl8t9PfoGm57tpXRpfbwcabshkuWWMBPSgSqAH
         x49Q==
X-Gm-Message-State: AOAM531WQtyoTIxH9ZpXcy/dbzAnPKP8FQkm3sKsSTzzujE3BBDO6XSH
        CIIAbij7qMehsY6YXi+oJpw/hT//+g==
X-Google-Smtp-Source: ABdhPJzhIVstVlQiHKJ22Y/dBTTy4tS1cRQWFzwRBa4aQykVlpLu/cTG16pqR221mTaSjFkR29Yo1w==
X-Received: by 2002:a05:6808:14ce:: with SMTP id f14mr29441666oiw.162.1639437282843;
        Mon, 13 Dec 2021 15:14:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v2sm2427566oto.3.2021.12.13.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:14:42 -0800 (PST)
Received: (nullmailer pid 1759258 invoked by uid 1000);
        Mon, 13 Dec 2021 23:14:41 -0000
Date:   Mon, 13 Dec 2021 17:14:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: brcm,cru: fix pin controller nodename
Message-ID: <YbfT4ZBOAmUmUWSZ@robh.at.kernel.org>
References: <20211207075010.9310-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207075010.9310-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 08:50:10 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Replace "pin-controller@" with "pinctrl@" to match new pinctrl binding
> requirement. This will fix:
> Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: cru-bus@1800c100: 'pinctrl@1c0' does not match any of the regexes: '^clock-controller@[a-f0-9]+$', '^phy@[a-f0-9]+$', '^pin-controller@[a-f0-9]+$', '^syscon@[a-f0-9]+$', '^thermal@[a-f0-9]+$', 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/mfd/brcm,cru.yaml
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/mfd/brcm,cru.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
