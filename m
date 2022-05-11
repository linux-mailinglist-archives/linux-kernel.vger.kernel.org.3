Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02F3522BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiEKFbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbiEKF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D6245633;
        Tue, 10 May 2022 22:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA69BB81F91;
        Wed, 11 May 2022 05:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8D5C385A7;
        Wed, 11 May 2022 05:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652246959;
        bh=O1vlZgX/Q+fmn7zMLlmZBKqQpL3cQWafYQduSNprVfo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fs0PpJhp0dE4BWsP4HniHRMfySMop5IGUrXI1excZQVhD6ibs4EesMjxlK82SlMHb
         nwddZQ9/Mc8hnbfzyWB1pfYC7fVimHdPyzdt6E6/V56GfsvgxpPzvTjcTA1qGRtQZV
         6d9cQaOvCc5s67eQ8ykP6C543xRjHZTZkenQwzPutQUKSStc71ypOtOf4JX/+MTh2y
         hEDOv+8ahqqXuZ8n4jC91eP7fHLS9PEJczFrVfHSdK8fgfmlgTJMUASaXDXWLF7Dqr
         W7WrwiSbGWetx4qlp21khWgF+h+d1cwXOBfGP6SIKudWH56mo9rX6zeizUJRWxhZ0A
         8MLJx6VzUSGxg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: remove unreachable code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506075814.115059-1-jiapeng.chong@linux.alibaba.com>
References: <20220506075814.115059-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165224695602.19198.6432098558984943387.kvalo@kernel.org>
Date:   Wed, 11 May 2022 05:29:18 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Clean up the following smatch warning:
> 
> drivers/ssb/pci.c:917 ssb_pci_sprom_get() warn: ignoring unreachable
> code.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-next.git, thanks.

84dc992e23df ssb: remove unreachable code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506075814.115059-1-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

