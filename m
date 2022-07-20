Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDDE57B1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiGTHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:32:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFE3F333
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:32:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 516446601A8F;
        Wed, 20 Jul 2022 08:32:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658302345;
        bh=nA6qTkA4roJM05MdvmeS/0o+jL/jdbAA6i2U6C/0nfY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JIEI9OGaIuTd3eRxjdfDcy9PNFHpr1KDlOcjkLx/jL62iS3OPtpLPxwCSl6ZzKUB0
         D1uvpEi3Q1rCfjLxwg5vyH02EIh4jVlj6JlkBOQLewfmiMcnBBllQcyGLQ6dd7R4vF
         gxQsW/+8Tva7lhLDeNHRSFgNBsNKoF9zgEjMRHBp+mluTN8uRyrl97qhrar3FlBjmx
         mI1V/sQdMmcnByEM6zW67qq8XmKJaqPOdpsEhPo8r4S1xQTj3JrLYtNjmz1jV+3Oe8
         jkfbAD2YCxwrT/2w2Lns81sJ2NpmJ5SJZIrYgoY9Ncx+QzC6EAjiKz9BBDss0kQx53
         R7CrteoJ5M6eQ==
Message-ID: <c2868779-0a50-0f0b-3562-8bb4b0d5e3d2@collabora.com>
Date:   Wed, 20 Jul 2022 09:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/panel-edp: Fix variable typo when saving hpd
 absent delay from DT
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Douglas Anderson <dianders@chromium.org>
Cc:     kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220719203857.1488831-1-nfraprado@collabora.com>
 <20220719203857.1488831-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220719203857.1488831-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/07/22 22:38, Nícolas F. R. A. Prado ha scritto:
> The value read from the "hpd-absent-delay-ms" property in DT was being
> saved to the wrong variable, overriding the hpd_reliable delay. Fix the
> typo.
> 
> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

I think you should've sent this separately from the rest of the series, especially
because of the questions etc.

In any case, for this commit:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
