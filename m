Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B004895B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiAJJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243278AbiAJJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:51:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B5C061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:51:18 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i31so42152103lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y1r7qcOoxLZVNoNmodA97gVRJbmjeeiduf9oclYMPMY=;
        b=GkNRzS9JnRVDO4SJtw3qITFR6O6XE/EmPXJo7mF4L6zmtmlGM7Kf5tG+e7zmxm5qjM
         oJ6osP1n0iVoKWDDXGO6iKPJS6Md/eY3NT685gXL8tehou/HD2k5FMiM9IDVXFIveK4W
         0UhKnKJCJVc6MgQoIWwORD+ovxepjTg4axf95PaziB6rU14UnhghLkpa2Fzfc7FoN/yV
         pKe/aYi2XxwE/NJmVxh9BvmjLZ5uLPn+hdetoC6v2zj+qHiDx0ZN8VamWq+tx9ZPKNEC
         R4zWSWLIDbCJVnTkKZtDVp+pttHIZd64NdLKcBL8eDIYYLRxKxjBoEDib76Zbdtt6SYX
         gAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y1r7qcOoxLZVNoNmodA97gVRJbmjeeiduf9oclYMPMY=;
        b=sbqPo2erbACZrpq0F403OgFImwBRcr7L/clO+Xp8+jpGybkM2iRADhkpiUY1q6Yowr
         mZvtkVusaVjqHiVyzUdwNh97tFiMyy4v3ZEMAq5EOh6EfVDvnmtxbkH3DW119Q/mC0tF
         GgMIvDo4YW+aLnpAhLhj8LqUwgtfGKnuS/dSSeXRA0oBs5r7Xkj5mW7YS8LCpaTVCkGs
         JLlngb0W0ypsl0anASRMZYLumk6LIHYgYdsGXqCBzBz+eQEeQpbsQqwpzNy36UaafwXJ
         kn2W/Osco9QOLIJfa9v0S5IAAQ9OUYrWDvc/UJWJZFBYFqOIaymBaU4f2ocdlSt8uQ1F
         LeuA==
X-Gm-Message-State: AOAM531zOUaNTWZz4+8nrBbTebOa7+ajl5pLLsuUfYXO3SUrtHYCN8JI
        pIwj7lNhju6Oe2NTrYiYl47ylg==
X-Google-Smtp-Source: ABdhPJx9+x3Kh4QAiAZKohB0Ymdo5sIsdfS73XLp2isfah2UyRZmm/Bmrm23jXAq5hL/eYGESPsaQw==
X-Received: by 2002:a2e:2e18:: with SMTP id u24mr32442126lju.492.1641808277016;
        Mon, 10 Jan 2022 01:51:17 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id z13sm871888lfu.255.2022.01.10.01.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:51:16 -0800 (PST)
Message-ID: <fbabf712-ea2a-5bd4-56d4-70cf4d7f72f6@cogentembedded.com>
Date:   Mon, 10 Jan 2022 12:51:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <CAMuHMdVHMzZipXaUE_SrkHtj6edZATefC908P1ngLrnOry8KCA@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <CAMuHMdVHMzZipXaUE_SrkHtj6edZATefC908P1ngLrnOry8KCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> i.e. will queue in renesas-devel for v5.18.

that is, for current + 2 ?
