Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9916547C5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhLUSJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:09:04 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:39826 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhLUSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:09:03 -0500
Received: by mail-qv1-f48.google.com with SMTP id g15so8873qvi.6;
        Tue, 21 Dec 2021 10:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbwuGuR9jfAEfWHT8YPJNc9cTjP1HSl8uRhaJJDjW80=;
        b=jWRtbK83gzfd/qBddHl77Dqs6PTRx5rdmQC5j6SmwePWQQQi8hA5Nqi84xPoz/QbOe
         e2b7vy5tuzL507V99emzVjCrDVs1BqOUcAwgEzM4iLYmIpk40L5d5TIMnsPeDXbVUD18
         6975/xjKDR0rt/Q8MTvy0zyabi6OiAtYPoWGDPO1LdFAbr9fQprqvC3McQgqlpVYXeDd
         sR+PgC9WLNr8FudFGOJ++hd8pQwfAfO+qxCWMbNy6kudZRvh4wf15BQnls1x8mApIYQ7
         bUojW5UO3AwFeyR20gdMSsQAsb0pTXqRAeMpCbmPoSNCJVCnTZz8YgxP+8+hPsS222I6
         SKiw==
X-Gm-Message-State: AOAM530EgvrDLNogknc/QW54ddqmzYnnidhPVuStrgDYrRnIbEmikbYo
        P8FU7cLvqZEWHz3wHGoBVQ==
X-Google-Smtp-Source: ABdhPJwQakcHH+jQK4zwEgDoG3F8/3Wzg7wCEt07ZDVyOcZ+SKAixTM0lG4z2HhmqkeTvEtJf+ZGeg==
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr3449666qvb.119.1640110141686;
        Tue, 21 Dec 2021 10:09:01 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id l22sm17069921qtj.68.2021.12.21.10.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:09:01 -0800 (PST)
Received: (nullmailer pid 1513560 invoked by uid 1000);
        Tue, 21 Dec 2021 18:08:58 -0000
Date:   Tue, 21 Dec 2021 14:08:58 -0400
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: atmel,sama5d2-adc: make
 atmel,trigger-edge-type non-mandatory
Message-ID: <YcIYOh6TmtVElt05@robh.at.kernel.org>
References: <20211217095401.583821-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217095401.583821-1-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 11:54:01 +0200, Eugen Hristev wrote:
> The atmel,trigger-edge-type was never imposed by the driver.
> Make things right and remove this property from the mandatory list.
> This will not break existing nodes because according to the binding they
> should have this property.
> However, the driver does not impose it and it works without it, the property
> selects the trigger type, and without it, the driver will have no trigger
> available, which is the case on some boards which do not have access
> to the trigger pin.
> This will avoid generating this warning for example:
> 
> */arch/arm/boot/dts/at91-sama7g5ek.dt.yaml: adc@e1000000: 'atmel,trigger-edge-type' is a required property
> 

Acked-by: Rob Herring <robh@kernel.org>
