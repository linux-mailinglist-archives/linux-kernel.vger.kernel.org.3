Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35389535CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350553AbiE0JFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351186AbiE0JBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB15131F1D;
        Fri, 27 May 2022 01:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9D761DAA;
        Fri, 27 May 2022 08:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C52C385B8;
        Fri, 27 May 2022 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653641887;
        bh=vtIL1AtMpLcio7YqtKfT6YKBW9nOoxqbyZgQaIm/YHY=;
        h=From:To:Cc:Subject:Date:From;
        b=InbCzu+6Zsz6QSOHa7uUWZigezehIi/o3brESO4ewqp/awp28k46VeWfVvJ8WOq0m
         JrqnW68ZjTfcmG0bPzdlqIcmMW4VYBfI1M2/wTvKd0eHCUm2liPXMiaiFvcm4WmiHq
         dkEVINT9+KJF7ryb2S1rzp77i0SCwJ9gL2bBjY3eHoAw5874iygJrQDXwH+2dtsqix
         UuGMZSOII4v9ostIZdF8ZZs7fA+qyCztGAxlDxqub+Y+b1MVomr40lueTxtqaj4oTk
         th9ed7w9abDZB/M56wM5q3v5WpV1CNHow9rxNw1Zs3aGK+cMLBDsZh21SgVIYr3miJ
         OsrwusV6zZrKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: linux-next: wireless for-next branches
Date:   Fri, 27 May 2022 11:58:03 +0300
Message-ID: <87a6b3qrms.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

We are experimenting how we could take "next-next" patches during merge
windows and avoid accumulation of patches for the period which is in
practice three weeks for wireless patches. To do that could you please
change linux-next to pull from wireless trees for-next branches instead
of main branches? So the new locations are:

git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git for-next

The idea we have is that wireless-next for-next branch is not updated
during the merge window and then the "next-next" patches will not be
included in linux-next until the merge window has closed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
