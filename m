Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C657A9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiGSWfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiGSWfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:35:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053311828
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=InNP3Lg1mwdxJmCO/kAaT26D/Sqk+C5617X5IuFCL1c=; b=UmXrm1HrvNXQzIHQ0FMogGL+My
        PO6nJYmUt18vtDvlFFQ92XEOaVwmRVa11izQ+k0QkaQOhSQvYbAXag4J5v+sHtDaUXGgFtdI2T7Bn
        ltEEHITg+paK+Ch3dlXd7+Gll5cxhRvZPfoyBNZoDGXwse7pK2OgYFqTfOUz2mZ7PsH5J862ck0SG
        JSoKDPCMD8R/qxZ79/S9YbRh2JmiYnBDayMa4Gm+OKZJApJqBTd4cpbu9utJiYi8PZ7ehUNiZXk04
        XPWfsQUuuFk3v5K+LqHZ78F2BCn5aeeyJMgF/ItNeGRoOEV44fyqynH5if8KB/37fjF16GrO2MiMp
        kl04xolQ==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oDvo9-006q6o-5a; Wed, 20 Jul 2022 00:35:13 +0200
Message-ID: <599fe506-f075-ca1a-5386-03e48563beaf@igalia.com>
Date:   Tue, 19 Jul 2022 19:34:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/panel-edp: Fix variable typo when saving hpd
 absent delay from DT
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@collabora.com, Sam Ravnborg <sam@ravnborg.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220719203857.1488831-1-nfraprado@collabora.com>
 <20220719203857.1488831-4-nfraprado@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220719203857.1488831-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 17:38 de 19/07/22, Nícolas F. R. A. Prado escreveu:
> The value read from the "hpd-absent-delay-ms" property in DT was being
> saved to the wrong variable, overriding the hpd_reliable delay. Fix the
> typo.
> 
> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>
