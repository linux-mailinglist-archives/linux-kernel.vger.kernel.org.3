Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0F495D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349966AbiAUKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiAUKS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:18:28 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDD2C061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 02:18:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d3so32216864lfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ehNPhGfxaSOPMo23fW4dscWuBSl7xXLWdoAmXodSWxs=;
        b=tIPXAizFDXNmK9BLfbRNxtc78Z0opifETvNRyGi5duEZkcRdIqdDMpkmGqVfixsyuK
         vSdLkvhD5fbIRr7DRikEsUcmfX8av0qsfghO3JCebwT22TDLiI99toXREsDInSb5E4uM
         2FwQKJrWrs5jJWxXig9J84Br2Q5njTfa59wtsW7Y2NLyNNNzcJWYtSiGMC14AaBSf2Mh
         YXVI0jv+4NejycBSghvmO/2SDyybD0rJ/TRk6gqgW8GBLLA2j/ktKtdCxSQMkgSqkCrU
         +zCqyikEpo3BYcccFCQZGemJjjGeR7O98s+slduzEIm3lxWlrrmk25YD9lUwc9bOGVjW
         rFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ehNPhGfxaSOPMo23fW4dscWuBSl7xXLWdoAmXodSWxs=;
        b=YJsNorYnAQ43CoWGGSUE6wt/GZC5/hj9rlGjbQQCvbrvu781yTVMuPTLjOGi1U6ede
         j0pcirmaYNrpHFCoL7F8XF7l5ohh1x0nX0OL8htJO2vOAJW4ZUe1XGG4iIgJ/F9MhiVg
         kO9UqhvTopnYlsjN6ZvlqaBNBnNxw+vbtXlWKuqFmdQ0vvEjbkx9SxDP1Dgna3BFGOMA
         CRZHarJpWqXlTOvPrP2zffMAVJD1o1UvuitmT4CpTvJIjd/uiMWqAGZdWYXr7nA7ow/m
         ikBIOGclzNIPiQcYiBal/lMVxHAZaDSAVjCVTPfEvf3kIpWUqWOdjIWg0iHQpuTreERy
         hdGA==
X-Gm-Message-State: AOAM531MZl9t/tgBVXbDF4z+IWN+QqCuvkrly+fYlOVfGDapxW9YfA5q
        nQb030sXCztGTr/zTN7b4Z7OGaMuH/xLyjzY
X-Google-Smtp-Source: ABdhPJy9qoOUlo95bA/WzBYphVdUngC14f5OAGV/yBfMvg1a0u/KUdUyL8IoUK6phvu8xwxNqIT44w==
X-Received: by 2002:a05:6512:3186:: with SMTP id i6mr3077649lfe.557.1642760305961;
        Fri, 21 Jan 2022 02:18:25 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id f24sm204962lfk.297.2022.01.21.02.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 02:18:25 -0800 (PST)
Message-ID: <f49794a0-096a-1f27-a250-5a74a9ed6ba6@cogentembedded.com>
Date:   Fri, 21 Jan 2022 13:18:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add KF HDMI output
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211225115308.2152364-1-nikita.yoush@cogentembedded.com>
 <CAMuHMdXdW=bCxBeEu81bRBwAs5=x_KZmPcXoMe=CmFdWz=rdfQ@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <CAMuHMdXdW=bCxBeEu81bRBwAs5=x_KZmPcXoMe=CmFdWz=rdfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.18 with the sort order fixed.

Thank you.

I have a question regarding defining regulators.

In case when drivers expect regulators to be define, but physically chips are just wired to VCC (or to 
some non-programmable power logic), what is the policy regarding regulator-fixed objects?

Shall we define per-consumer regulator-fixed objects?
Or have a single regulator-fixed for each voltage?
Or not define regulators at all and let the code to create dummy regulators?
Or something else?

Nikita
