Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242514B8CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiBPPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiBPPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:44:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB12944FE;
        Wed, 16 Feb 2022 07:44:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3548B619F9;
        Wed, 16 Feb 2022 15:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAABC004E1;
        Wed, 16 Feb 2022 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026262;
        bh=Zfpjy3NcijSQQBh0gzHtvY0UI3Xlm8k7/C1vlFGWIf8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=e3wgHCZGT7LszljbFj+OEORAUO10+1+htojK+tHivBP4eDBrlSOmfu8gNZRobwtee
         BzKhzAxJCuMjqc52OplWZk9l2guebn8Fd89gnNZuUD1y7EoTgTaCSJwb0zRuwcNH71
         qEBzSQPOsezNQNhmdNLrnEN2/hUzqA8Mg+5eUeCs0aZUPQUFRuRfMGi2d0k0vhuAmi
         k+D+3weDGX0Uw9SQbszaKlWHEy/3ZCkeVzO4p0eBDwhDsBakMkjGVbny8ZmzGVfi0X
         tCfuoHE2C8zN/RKcCRuH+5KSOfuiDSJLYtPbKnl5c6ibH22S/2MMoA2SH+HzkywV03
         zV4f+/ov3QDhw==
Date:   Wed, 16 Feb 2022 16:44:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Stephen Boyd <swboyd@chromium.org>, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sean O'Brien <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v3 1/4] Input: Extract ChromeOS vivaldi physmap show
 function
In-Reply-To: <YgyNScQJNVjJpqEc@google.com>
Message-ID: <nycvar.YFH.7.76.2202161643440.11721@cbobk.fhfr.pm>
References: <20220211012510.1198155-1-swboyd@chromium.org> <20220211012510.1198155-2-swboyd@chromium.org> <YgyNScQJNVjJpqEc@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Dmitry Torokhov wrote:

> Anyway, this makes sense to me. Jiri, Benjamin, do you want to merge
> this or do you want to take it all throgh your tree?

The more substantial changes are happening in generic Input code, so I 
guess it makes more sense for you to take it.

Please feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

to the HID parts.

Thanks!

-- 
Jiri Kosina
SUSE Labs

