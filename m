Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B134D4D99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiCJPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCJPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D7107D37;
        Thu, 10 Mar 2022 07:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD96EB81EE7;
        Thu, 10 Mar 2022 15:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B66C340EB;
        Thu, 10 Mar 2022 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646927441;
        bh=0BDDvEDbFbApm1Y0BEW+KCJ7iit4OuBwIkrV0n3PGiA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ViaR3J2lwGr14uZz2A6/4ychYpFRPbF2hAigrJMKjwynpmlI6SeNRPmzCoE+syWTq
         qYxWf0dbh997lvlLncUchmVaNKJ4MPukUE4pHyLZMs1vrcPUEc0yoQohub4svf8yu6
         dEmYVuEtJTxiexHUIEPHdzXi+K96iDy3BAgrybUaUSIL/3MdepqA9z8DD348SVdAZk
         sqGEoJq83Xa9DR+6wU4+WqlA4tp2tJ9u/BhKTlkmC8bsL8VbEil7IkhTYacFuJaOm0
         ao+yXe11hw35maVULBbbC54o6KGDhxyQ02083SWZwQ+ooOEdCgY0AC0ZJ8cnroQrof
         zqitzJjpxwuLQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath6kl: add device ID for WLU5150-D81
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220302211436.8746-1-git@apitzsch.eu>
References: <20220302211436.8746-1-git@apitzsch.eu>
To:     =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164692743682.18489.9723411063219672687.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 15:50:40 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

André Apitzsch <git@apitzsch.eu> wrote:

> This device with a male Mini-B USB connector is part of Panasonic TVs.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0ac121b86321 ath6kl: add device ID for WLU5150-D81

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220302211436.8746-1-git@apitzsch.eu/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

