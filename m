Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268BC473852
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244132AbhLMXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:15:26 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:33689 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbhLMXPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:15:25 -0500
Received: by mail-oo1-f51.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so4576194ooe.0;
        Mon, 13 Dec 2021 15:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1l56J7RWqJa/4smIcM6LtkyNfMj0tPxmLM93iwFOBsc=;
        b=iptG6aNkZlZsrkxUL8cXWFQh+hSJT3a+kxdHTi+f+bvRLLUXcVPErRCK/3n2tUOUvH
         Jwl1hSz2lKqHOjHvnJ2E+7U8o65m6sL6gE5BdCS4odiB7O73hJn4GBXW5ORG3BwkC2ZP
         lXAuL+SuqpeTmEY8EdE8UOFyMrvZyUhUnJw8foYBtrqKekuJt3GP2AXCSI4PbbL6aGVN
         7D6MjfFRUz1Jw5cLaN6sxjJ5K76UkDbhgXDFjH6i3KvLag2C9grEfRBEj5VT1n+wXUXg
         D6vA2MmGbjWVAngdbCVsc1KkFJcEIYDcDxZHwLBa/ktP56PZU7jmmijNYCTUZUp8fCf/
         dvqg==
X-Gm-Message-State: AOAM5326V1eqPVcT6bs5VHXEtg7TRr3p342U15dB7p7pbUmquBtctnyv
        6u4RinAeI5LDqlnFeKXp4Hkjja6R0A==
X-Google-Smtp-Source: ABdhPJxpWotWwKIP3F/YT+JXqvbzjQW04moW/mer39xF+pInPougmGPsqA9jT+cd4tJTNdZz5ZL/tA==
X-Received: by 2002:a4a:8746:: with SMTP id a6mr974137ooi.93.1639437324658;
        Mon, 13 Dec 2021 15:15:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j2sm2433768oor.18.2021.12.13.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:15:23 -0800 (PST)
Received: (nullmailer pid 1760367 invoked by uid 1000);
        Mon, 13 Dec 2021 23:15:22 -0000
Date:   Mon, 13 Dec 2021 17:15:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] dt-bindings: mfd: cirrus,lochnagar: fix pin controller
 nodename
Message-ID: <YbfUCsN2K5RaNgLG@robh.at.kernel.org>
References: <20211207083618.12940-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207083618.12940-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 09:36:18 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Replace custom nodename with a generic "pinctrl" to match new pinctrl
> binding requirement. This will fix:
> Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>         From schema: Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
