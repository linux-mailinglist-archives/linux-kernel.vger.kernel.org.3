Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE556478A78
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhLQLzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhLQLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:55:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3CBC061574;
        Fri, 17 Dec 2021 03:55:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l22so4070615lfg.7;
        Fri, 17 Dec 2021 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IVoSwh1vrOcOYMzSFZcBGiekwmrvmnu/yu9ynAy3UtA=;
        b=Gj4M7BgLMNPwhiJBvGzl/JDenwkO7HDujABojJBRvVGLCRYQeHHyruewEpwh6ybCyL
         Av1yUjLdjkR52TDV9592LyZLu1xchFpalL3pBfN/s4J6GTD8OOlofaYsxubHYKVU2D6O
         CbHHedms1cH2t6sC0TTo3ffEOH/fd2BqYI9jaqOIfwtwvVCamaraABKsvlzeRrJ4cZOF
         7tXhjqCqOV+AEwTPnXm7hTyGdi7sLrHvX26MLPYSwDk05X49ikx2cs4YXE2R435mCgYf
         BeB9yakD/M3i6mbNh1aJSrhdCmtLCJpriqea6faSFaKjZhK9ZTwQb/aCz6oBwahpX3C/
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IVoSwh1vrOcOYMzSFZcBGiekwmrvmnu/yu9ynAy3UtA=;
        b=z24fdkHbYLzg7UxrboHqqqZFpGhMnZsCZap+/Mf4c/kGeH1tz3ktwzbICDTakfM88Y
         ejY4YfOqx6lRIz1lXA0npasqZl4ktqNUeQnVbA94fPCi2edYFc1emOyxFgUZMpurKoyO
         A/Hsx1LwNxhvc8M0ZEGRSAZCvVJ0MKD23VqrXtHanAZyRq7+j6LHJboUZJbkdQ1Vhpvj
         AAdtDP+9aq++9gEnDkXNrJPLBDDmeuRpzNUq2RqLBvq78SrXA1fVUw0C9OAnm/dwLIuP
         s88lSWsd5KsfUVjsBSl6xZsIUPMQ4CRvDZbbMF0o+a9pq1WN8bQ4WiMWhLNDEZIUZ8+U
         aBcw==
X-Gm-Message-State: AOAM533c1Y7Efdp5fWbuC/VAUVHz9uD0MuI0CTZDal27D+Ex8tc1s+P2
        yPCc8mRqo+eyRnzgSzDkDCLoSe2kNro=
X-Google-Smtp-Source: ABdhPJzR7F4ntqza5TxeJHdnruw3Sr909Ky7UaeX6gfiS/xaUtY7aJ1DkExo+7MWJU3p6Tpo8cWycQ==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr2508194lfd.177.1639742150078;
        Fri, 17 Dec 2021 03:55:50 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id f10sm1355834lfg.211.2021.12.17.03.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:55:49 -0800 (PST)
Subject: Re: [PATCH v4 04/22] dt-bindings: host1x: Document optional HDMI
 sound-dai-cells
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-5-digetx@gmail.com> <YbtLJeIxXlVyQhd3@orome>
 <Ybxwovlw2GARzqUO@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4edfbff2-ffd9-1c33-de0c-013a29dc286c@gmail.com>
Date:   Fri, 17 Dec 2021 14:55:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybxwovlw2GARzqUO@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2021 14:12, Mark Brown пишет:
> On Thu, Dec 16, 2021 at 03:20:21PM +0100, Thierry Reding wrote:
>> On Sat, Dec 04, 2021 at 05:37:07PM +0300, Dmitry Osipenko wrote:
>>> Document new optional sound-dai-cells property of HDMI node. This node will
>>> be used as endpoint of HDMI sound DAI graph.
> 
>> It's probably best for this to go through ASoC along with the other
>> audio-related bindings.
> 
>> Alternatively, I've just sent out a patch that converts the host1x
>> bindings to json-schema, so I could work this into that as well.
> 
> It doesn't apply to the ASoC tree for whatever reason so probably best
> to roll it in with those JSON updates.
> 

This hos1tx binding patch indeed will conflict with the Thierry's patch.

Thierry, will you be able to take the binding patches into the Tegra
tree and resolve all those hos1tx binding conflicts there?
