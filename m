Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1199B4B8CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiBPPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:50:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiBPPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:50:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628B2A64E8;
        Wed, 16 Feb 2022 07:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321C1B81F39;
        Wed, 16 Feb 2022 15:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3129C004E1;
        Wed, 16 Feb 2022 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026620;
        bh=hY8Ocaeuw/PESJ3cesgcDqgDeuA6MCsn6usv7wvjd4g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uD6ZAIeOPLcnB25OVls2MBk5wsYGG9SoZA+cadA2ftVzFUlDHfaihOdXIjDJBzje3
         ytJdryOS2/Z8EGQkWOD+0PyaP7absZdgH8SXP3qr1dVYRrlTSrhKSb0g/qlmv3ZexK
         TvisfE5HfNDQwb2X4J4+NLKTgHTuG8K9p/hebltZo0tyX48HsH+vO1GwH8MWumvRnW
         rlfuiatTnVYbI/zF6LEeF+98Qxo3q/KBqxxyxT2zeNuTihb7G3yLoocz5i8MTXle5a
         +6jsoBPJdYzxR4vEyeF2sDLs7fTg/2HDnOUV6aRoIxVMDkdQaG9NRzIqRocJPl2rv7
         4IT9DepLHeYNQ==
Date:   Wed, 16 Feb 2022 16:50:17 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Magic Keyboard first generation and 2015 FN key
 mapping
In-Reply-To: <20220208183704.40101-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202161650050.11721@cbobk.fhfr.pm>
References: <20220208183704.40101-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022, José Expósito wrote:

> Hi everyone,
> 
> This patchset adds the missing key mapping for the Magic Keyboard first
> generation and the 2015 models.
> 
> Since the first generation model had numlock emulation in place, I
> decided to fix the bug (described in the patch) and keep it in place
> just because it has been there for so long that people might use it.
> Having said that, there is no indication in the keyboard about which
> keys can be used as numbers or how to enable/disable numlock.
> I think that a patch removing APPLE_NUMLOCK_EMULATION might make sense,
> but I didn't want to remove existing functionality without asking :)
> 
> Thanks a lot,
> José Expósito
> 
> v2: Resolve conflicts

Queued in hid.git#for-5.18/apple. Thanks José,

-- 
Jiri Kosina
SUSE Labs

