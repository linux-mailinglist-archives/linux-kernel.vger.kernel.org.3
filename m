Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9232146B892
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhLGKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLGKRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:17:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FBFC061746;
        Tue,  7 Dec 2021 02:14:19 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bi37so32419837lfb.5;
        Tue, 07 Dec 2021 02:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8kee/N0as/hz/cg2sQd2lCPZnQthggdydHn9mrSiqU=;
        b=Vn7zKGINM/TVnj1QqZzCB4RhDZXr5GvFm0DDRUrZ6icbPApcWsfZsMgO3UiLD70BCF
         uOkV0ROYdKwHyS8iLSIkN28MswjzfnkK5zQDX5w224RopqbJPh2c+yUgiSikKsyGin03
         THJ+OPgdAymtIiMRMASPqRzXhZL6jKYBt2KKP6DzuUDGusT7YXjoPRgF0Xq9gcmi2jiJ
         PiEKuxjAGYMU0ndESLlKnF9fIjcWEAYuIQmKAbIaND9+F8vbhETUOZVOY+We4DEiyjzL
         6kOT3gjLdor4/ZjtlRdY3Ue7n6NZ39ksC0xMa7w/Cc5QVbmHESP1CAm2AFRocceomZbv
         FMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8kee/N0as/hz/cg2sQd2lCPZnQthggdydHn9mrSiqU=;
        b=VmVHrNCgJ1/Lq5D1ZwATV4m4aczyJzFDrhOF+yPJgy2pbq/FUrqPCywCliwqTv0/O6
         TKJGvpLVE1io6LAGXhOZx0832SNNQYxESnZHMow66oS9d1V0JYK/Jpyn/bMFtkwl1t5j
         gKef/nFmJQES6vNkIKV56tbGeU9mpr8oOqZQhJEliTHuvld5wkkGAev3Ylo4mjs85Am0
         xmpWj6bxhiKj7qT46FT3DVasHP6riEeY0+u40HBBqf4vkUnXYRUkfBHAq9TjsURHRLre
         QQQr6WbcpcDbbk+vleF76VC/md+kTz7aEbo+lpbzIzpa2I293Y7VC+7U92imr2qmFpfU
         HeFw==
X-Gm-Message-State: AOAM533vgzm6/pR5+/1GCOpMcFtXpD+rUFGRHsTriKvuXZ5muoJdrNPE
        eoYReOzF4sBe68nNg+JiIA03kT4Nt3s=
X-Google-Smtp-Source: ABdhPJzQGDXpxQbq645M+Cx7NqFq4GuTvMkGZHqWfLldEcnTBw1AkZi7CP1LNhMvfB00h76mxuu0Lw==
X-Received: by 2002:a05:6512:39d3:: with SMTP id k19mr39194848lfu.81.1638872057999;
        Tue, 07 Dec 2021 02:14:17 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id i18sm1635047lfu.67.2021.12.07.02.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:14:17 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: sound: tegra: Update HDA resets
To:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com,
        broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, perex@perex.cz
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
 <1638858770-22594-3-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <13d20227-ec6b-03db-01dc-b4b00038a15c@gmail.com>
Date:   Tue, 7 Dec 2021 13:14:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638858770-22594-3-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2021 09:32, Sameer Pujar пишет:
> Tegra194 HDA has only two resets unlike the previous generations of
> Tegra SoCs. Hence update the reset list accordingly.
> 
> Fixes: 2d8f8955fe02 ("dt-bindings: tegra: Convert HDA doc to json-schema")

The original txt binding was already wrong, this "fixes" tag is wrong.
