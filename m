Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375B65B16B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIHIR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIHIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:17:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC99083A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69FB0B8204A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712DDC433D7;
        Thu,  8 Sep 2022 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662625069;
        bh=4PvggjstF/pbAkbafj3NqDhNEoq3xqiTuJ+aYKO2614=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEHj506YRgTz22lch4kcfAqt55kiyuPOwtBAGpMGhWlzGy2RzB0gTjYW3L6StCWxJ
         3rz06qSEY2ECLpW5g4V9BN1ce8ZTW8KyB3ZMMk54oH4GrllDeXQi02UvxzOy+v/b5m
         m+CnpPPPXO+T3zVHqvIb/AUQF4ruk0XKbgU8ZNbL8NJtD0ht7t7aQbpJYVTVVc98kU
         duA4epTTHtxATQYnqVnAjM9/PfaFIHwiurpTd0tODkb6CmsI9d8UKd6CZ4Ht6aUsGr
         u3RJrF9HuqoSSCY610EbQCBO0x3f+Fs0MIRc0X0HsCZkVy7clss1ErZMyFtp7A1XGz
         WhRcugb2tFnvg==
Date:   Thu, 8 Sep 2022 09:17:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mfd: Drop Robert Jones
Message-ID: <YxmlKQlZVwyUTt/Z@google.com>
References: <20220808111113.71890-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220808111113.71890-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Krzysztof Kozlowski wrote:

> Emails to Robert Jones bounce ("550 5.2.1 The email account that you
> tried to reach is disabled").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> For dt-bindings see:
> https://lore.kernel.org/all/20220808104712.54315-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
