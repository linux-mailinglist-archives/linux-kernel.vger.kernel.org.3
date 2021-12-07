Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928FC46C6A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbhLGV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:26:28 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45994 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhLGV0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:26:23 -0500
Received: by mail-ot1-f51.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso526405otf.12;
        Tue, 07 Dec 2021 13:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ig7DUIaTINk89eTPOp4alctzbQOuy3NjV8hk+IyDqn8=;
        b=s6X/UtpAmlSIqqlW3CP4QYkchvYXqP/ecGGQvK5jT1415aHoxqyTNcXJivpXeipGtp
         peuFcJUbRMSRB//MjuQlCr5N5yvpfwq2XZsqBs7vXbzz9RLM8ol09SgdBKMYC3C1BI5q
         hPa24RhvXXtffCENMqwx/zwM9VFmvI2L9DaqGmD+/V/5K0pMRg0E5Qpl4YNWaUwKdEzN
         /kkAuzKMCLktK09WJo7yYg0moPLxsk98+ISvuKsVrXmsK24fmSe4IBnMaKAZDba9A7hG
         rcs1dgTJw5aNjsvlebcxWGYaKKy7ecp0zPpM2xEOLGwUd+cK9swwDYTQ1GZxWiGxWZNE
         6vzA==
X-Gm-Message-State: AOAM530CHWli231cPcyFzk4yoiLBZ2rWDoczHhs+YcUpkgt+y5lOrWIj
        R3JixpXkUI18a7hRo7jpxe4+9CT9XQ==
X-Google-Smtp-Source: ABdhPJx76bE8mVonnxBVtIQzngpSCx5r9LEsv901SZLPWCMQldOXj6xp0hpBWlZgjdPfueRKtuoJ1g==
X-Received: by 2002:a05:6830:2b20:: with SMTP id l32mr20158035otv.333.1638912172543;
        Tue, 07 Dec 2021 13:22:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l24sm160140oou.20.2021.12.07.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:22:51 -0800 (PST)
Received: (nullmailer pid 855332 invoked by uid 1000);
        Tue, 07 Dec 2021 21:22:50 -0000
Date:   Tue, 7 Dec 2021 15:22:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benoit Masson <yahoo@perenite.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [RFC PATCH 4/9] dt-bindings: vendor-prefixes: add cyx prefix
Message-ID: <Ya/Qqql7x/LQPfsQ@robh.at.kernel.org>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-5-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130060523.19161-5-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 06:05:18 +0000, Christian Hewitt wrote:
> Shenzhen CYX Industrial Co., Ltd are a manufacturer of Android
> Set-Top Box devices.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
