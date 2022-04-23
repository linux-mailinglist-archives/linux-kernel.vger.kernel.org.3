Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E750C6A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiDWCiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiDWCiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:38:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6610521E;
        Fri, 22 Apr 2022 19:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD182B8335C;
        Sat, 23 Apr 2022 02:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D4AC385A0;
        Sat, 23 Apr 2022 02:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681310;
        bh=z3CKbmSDeHgI81qNxkGjfjiRlyOED50j3utuXtqoWr4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b9FPiDYY5ggR/JGAgaTTnkafrxtE0nRWpqsv5g5D+UX4Zqlx7ON8QNmha0Y3jQoMC
         HSNVq+MFleNk51GvXw2vkxdkOCvBNFBYI1zXbC1+MCt0UDAiT4uqyVW4mfksusr/9L
         MRFb1Mt/O6G2Qh72unKczc0J94SinZhWdxJb7lIKJ0bJF2g5/ap/cSfB8jjE/kGhDV
         42GcS9Bs7S+dAHsmvxqIc88e9bPwEWy2H05UB/LqEHQMSMIj7hWJ83nopY3tfUQujn
         1j5C7PEWBj2pbJtM5vo1VHFevtOrlwKivPkZIRMy3P4cLOpg4ECyh60oaMREvS0hBp
         umJZrKn8ayTVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-10-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-10-steve@sk2.org>
Subject: Re: [PATCH v2 09/10] clk: si570: use i2c_match_id and simple i2c probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:35:07 -0700
User-Agent: alot/0.10
Message-Id: <20220423023510.87D4AC385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:30)
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
