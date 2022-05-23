Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308F2530AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiEWHWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiEWHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B1958F;
        Mon, 23 May 2022 00:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224F161142;
        Mon, 23 May 2022 06:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332FBC385A9;
        Mon, 23 May 2022 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653288604;
        bh=411iL9x0GP85sg8ZbapYzqsOrkMY1Ge9NDYVFgFvP2w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fbczhh8GP2XBOF2IIVRZ3zKk4jCEzq1se/6+mxUx/yeeoeXQY/eMaHV0Sh6adB3ox
         u3w81pNtSEcTo6cptdA2mtRHGYe4thUGxG2wt145EZPjS6ooT3Enm2Xg1EGxTWf+yA
         Uk7y7CxcHPY6/HsNNod4eDzw2MqWWrqj5h3SiiqZeO4NacdaR7stSLy0HD/7nnam1z
         fGmyLJ9OQC/Zp7I8SdRexheWAUXPPLchZ9FS6jRzKfFjxqwnvnBvh7s/34ch2OJFPW
         i5lA+OD6vqhw70YK6aMGeRU1xm7aPOxbgK6uKu99NVbH3NSX+CAYwTsKkV3agP+2xC
         oCVAUhjETV5Ew==
Date:   Mon, 23 May 2022 08:50:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pablo Ceballos <pceballos@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
In-Reply-To: <20220522150546.GA8071@localhost>
Message-ID: <nycvar.YFH.7.76.2205230848490.28985@cbobk.fhfr.pm>
References: <20220405183953.2094007-1-pceballos@google.com> <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm> <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com> <nycvar.YFH.7.76.2205121252090.28985@cbobk.fhfr.pm>
 <CAO9JgFwA5ZhwOOY0cU3HpMOV69CTumQ50zEgU6SPNAF0zDbCGg@mail.gmail.com> <Yn2OlQAa9I++N80B@penguin> <CAO-hwJ+Rs=LYseLP7Vvr00vLvm+fTCRdh8pQ-rEduj4izSyiYA@mail.gmail.com> <20220522150546.GA8071@localhost>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2022, Pavel Machek wrote:

> Is that good idea? eBPF is fairly dangerous thing, so I'd preffer
> basic functionality not depend on it...

Although I understand the concern, that ship has already sailed long time 
ago.

-- 
Jiri Kosina
SUSE Labs

